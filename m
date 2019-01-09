Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2766C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BC820859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfAIS4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:56:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfAIS4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:56:54 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 707F6C79;
        Wed,  9 Jan 2019 18:56:53 +0000 (UTC)
Date:   Wed, 9 Jan 2019 10:56:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        arunks.linux@gmail.com, vbabka@suse.cz, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        getarunks@gmail.com
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as
 higher order
Message-Id: <20190109105652.40e24fa969a2bb7a58e097a8@linux-foundation.org>
In-Reply-To: <2efb06e91d9af48bf3d1d38bd50e0458@codeaurora.org>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
        <fb6465c99b3ada2c6af587a7eb00016d96d56f77.camel@linux.intel.com>
        <20190108181352.GI31793@dhcp22.suse.cz>
        <bfb543b6e343c21c3e263a110f234e08@codeaurora.org>
        <20190109073718.GM31793@dhcp22.suse.cz>
        <a053bd9b93e71baae042cdfc3432f945@codeaurora.org>
        <20190109084031.GN31793@dhcp22.suse.cz>
        <e005e71b125b9b8ddee668d1df9ad5ec@codeaurora.org>
        <20190109105754.GR31793@dhcp22.suse.cz>
        <2efb06e91d9af48bf3d1d38bd50e0458@codeaurora.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jan 2019 16:36:36 +0530 Arun KS <arunks@codeaurora.org> wrote:

> On 2019-01-09 16:27, Michal Hocko wrote:
> > On Wed 09-01-19 16:12:48, Arun KS wrote:
> > [...]
> >> It will be called once per online of a section and the arg value is 
> >> always
> >> set to 0 while entering online_pages_range.
> > 
> > You rare right that this will be the case in the most simple scenario.
> > But the point is that the callback can be called several times from
> > walk_system_ram_range and then your current code wouldn't work 
> > properly.
> 
> Thanks. Will use +=

The v8 patch
https://lore.kernel.org/lkml/1547032395-24582-1-git-send-email-arunks@codeaurora.org/T/#u

(which you apparently sent 7 minutes after typing the above) still has

 static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
 			void *arg)
 {
-	unsigned long i;
 	unsigned long onlined_pages = *(unsigned long *)arg;
-	struct page *page;
 
 	if (PageReserved(pfn_to_page(start_pfn)))
-		for (i = 0; i < nr_pages; i++) {
-			page = pfn_to_page(start_pfn + i);
-			(*online_page_callback)(page);
-			onlined_pages++;
-		}
+		onlined_pages = online_pages_blocks(start_pfn, nr_pages);


Even then the code makes no sense.

static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
			void *arg)
{
	unsigned long onlined_pages = *(unsigned long *)arg;

	if (PageReserved(pfn_to_page(start_pfn)))
		onlined_pages += online_pages_blocks(start_pfn, nr_pages);

	online_mem_sections(start_pfn, start_pfn + nr_pages);

	*(unsigned long *)arg += onlined_pages;
	return 0;
}

Either the final assignment should be

	*(unsigned long *)arg = onlined_pages;

or the initialization should be

	unsigned long onlined_pages = 0;



This is becoming a tad tiresome and I'd prefer not to have to check up
on such things.  Can we please get this right?  
