Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BE9C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E645A2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E645A2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbeGZVIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:08:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731629AbeGZVIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:08:36 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F996CEE;
        Thu, 26 Jul 2018 19:50:14 +0000 (UTC)
Date:   Thu, 26 Jul 2018 12:50:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v1 0/2] mm/kdump: exclude reserved pages in dumps
Message-Id: <20180726125013.ea82bfa3194386733b3943ab@linux-foundation.org>
In-Reply-To: <21c31952-7632-b8e1-aa33-d124ce96b88e@redhat.com>
References: <20180720123422.10127-1-david@redhat.com>
        <9f46f0ed-e34c-73be-60ca-c892fb19ed08@suse.cz>
        <f8d7b5f9-e5ee-0625-f53d-50d1841e1388@redhat.com>
        <20180724072237.GA28386@dhcp22.suse.cz>
        <e5264f8e-2bb5-7a9b-6352-ad18f04d49c2@redhat.com>
        <20180726083042.GC28386@dhcp22.suse.cz>
        <21c31952-7632-b8e1-aa33-d124ce96b88e@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 10:45:54 +0200 David Hildenbrand <david@redhat.com> wrote:

> > Does each user of PG_balloon check for PG_reserved? If this is the case
> > then yes this would be OK.
> > 
> 
> I can only spot one user of PageBalloon() at all (fs/proc/page.c) ,
> which makes me wonder if this bit is actually still relevant. I think
> the last "real" user was removed with
> 
> commit b1123ea6d3b3da25af5c8a9d843bd07ab63213f4
> Author: Minchan Kim <minchan@kernel.org>
> Date:   Tue Jul 26 15:23:09 2016 -0700
> 
>     mm: balloon: use general non-lru movable page feature
> 
>     Now, VM has a feature to migrate non-lru movable pages so balloon
>     doesn't need custom migration hooks in migrate.c and compaction.c.
> 
> 
> The only user of PG_balloon in general is
> "include/linux/balloon_compaction.h", used effectively only by
> virtio_balloon.
> 
> All such pages are allocated via balloon_page_alloc() and never set
> reserved.
> 
> So to me it looks like PG_balloon could be easily reused, especially to
> also exclude virtio-balloon pages from dumps.

Agree.  Maintaining a thingy for page-types.c which hardly anyone uses
(surely) isn't sufficient justification for consuming a page flag.  We
should check with the virtio developers first, but this does seem to be
begging to be reclaimed.


