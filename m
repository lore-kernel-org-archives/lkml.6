Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59797C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A6D20659
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A6D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeJKGF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:05:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKGF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:05:27 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 238F88D4;
        Wed, 10 Oct 2018 22:41:12 +0000 (UTC)
Date:   Wed, 10 Oct 2018 15:41:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/6] mm/gup_benchmark: Time put_page
Message-Id: <20181010154111.e3b37422f31dcf3d6b73ebe0@linux-foundation.org>
In-Reply-To: <20181010222843.GA11034@localhost.localdomain>
References: <20181010195605.10689-1-keith.busch@intel.com>
        <20181010152655.8510270e5db753f6666f12d3@linux-foundation.org>
        <20181010222843.GA11034@localhost.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 16:28:43 -0600 Keith Busch <keith.busch@intel.com> wrote:

> > >  struct gup_benchmark {
> > > -	__u64 delta_usec;
> > > +	__u64 get_delta_usec;
> > > +	__u64 put_delta_usec;
> > >  	__u64 addr;
> > >  	__u64 size;
> > >  	__u32 nr_pages_per_call;
> > 
> > If we move put_delta_usec to the end of this struct, the ABI remains
> > back-compatible?
> 
> If the kernel writes to a new value appended to the end of the struct,
> and the application allocated the older sized struct, wouldn't that
> corrupt the user memory?

Looks like it.  How about we do this while we're breaking it?

--- a/mm/gup_benchmark.c~mm-gup_benchmark-time-put_page-fix
+++ a/mm/gup_benchmark.c
@@ -14,6 +14,7 @@ struct gup_benchmark {
 	__u64 size;
 	__u32 nr_pages_per_call;
 	__u32 flags;
+	__u64 expansion[10];	/* For future use */
 };
 
 static int __gup_benchmark_ioctl(unsigned int cmd,

