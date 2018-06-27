Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03D3C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DAD250A8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DAD250A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965793AbeF0VOP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:14:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933133AbeF0VOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:14:14 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6668C9D;
        Wed, 27 Jun 2018 21:14:13 +0000 (UTC)
Date:   Wed, 27 Jun 2018 14:14:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        JianKang Chen <chenjiankang1@huawei.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xieyisheng1@huawei.com,
        guohanjun@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] mm: drop VM_BUG_ON from __get_free_pages
Message-Id: <20180627141412.00c0b23d2eb5f9475a76d833@linux-foundation.org>
In-Reply-To: <e0f4426d-1b7c-e590-aae0-e8f7ae3bb948@suse.cz>
References: <20180622162841.25114-1-mhocko@kernel.org>
        <6886dee0-3ac4-ef5d-3597-073196c81d88@suse.cz>
        <20180626100416.a3ff53f5c4aac9fae954e3f6@linux-foundation.org>
        <20180627073420.GD32348@dhcp22.suse.cz>
        <e0f4426d-1b7c-e590-aae0-e8f7ae3bb948@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2018 09:50:01 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 06/27/2018 09:34 AM, Michal Hocko wrote:
> > On Tue 26-06-18 10:04:16, Andrew Morton wrote:
> > 
> > And as I've argued before the code would be wrong regardless. We would
> > leak the memory or worse touch somebody's else kmap without knowing
> > that.  So we have a choice between a mem leak, data corruption k or a
> > silent fixup. I would prefer the last option. And blowing up on a BUG
> > is not much better on something that is easily fixable. I am not really
> > convinced that & ~__GFP_HIGHMEM is something to lose sleep over.
> 
> Maybe put the fixup into a "#ifdef CONFIG_HIGHMEM" block and then modern
> systems won't care? In that case it could even be if (WARN_ON_ONCE(...))
> so future cases with wrong expectations would become known.
> 

The more I think about it, the more I like the VM_BUG_ON.

Look, if I was reviewing code which did

	page = alloc_page(__GFP_HIGHMEM);
	addr = page_to_virt(page);

I would say "that's a bug, you forgot to kmap the page".

And any code which does __get_free_pages(__GFP_HIGHMEM) is just as
buggy: it's requesting the virtual address of a high page without
having kmapped it.  Core MM shouldn't be silently kludging around the
bug by restricting the caller to using lowmem pages.

Maybe the caller really does want to use highmem, in which case the caller
should be using alloc_page(__GFP_HIGHMEM) and kmap().  Because core MM
detects and reports this bug, the developer will fix it.
