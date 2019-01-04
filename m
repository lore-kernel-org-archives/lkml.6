Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE308C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB42218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nFXsufir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfADSDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:03:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADSDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mJRV7jVfDLaxwY0zARwuNu0AHwAUD0/lAvC2ATmreL4=; b=nFXsufirW3L/u7O3OtQNPGUce
        MvmJhKMv4sguysRyY72nh1/g+yDny7jJY1qTQa5LQyQyJvOl/EAW/oMKpEfT5YH+EZEgEZ6f5Uaqh
        DXGW0DnRad9w7KRCmfKrFYGmGVG/hQ+xu2eFn1s0MK8ZynePoNp7bnhXw+/Z6jL0KiAsZd7S0IchM
        kajOW6YlB2TIva0C38cYdcqvC0s443TYtAqpaAOYngIHgP7bh6zFvlD6XFcw5FpxZbowQpheED1Ml
        bwzVNpNFeHpmPKOKbZNl2MdzVVavBRZ0CRZ6oG3z5kBkaFKCoXtclv6+WiIoFTzeTS/31YclcVnTl
        KN0NWCUYg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gfToi-000157-ET; Fri, 04 Jan 2019 18:03:32 +0000
Date:   Fri, 4 Jan 2019 10:03:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     vdumpa@nvidia.com, mcgrof@kernel.org, keescook@chromium.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Snikam@nvidia.com
Subject: Re: [PATCH] mm: Expose lazy vfree pages to control via sysctl
Message-ID: <20190104180332.GV6310@bombadil.infradead.org>
References: <1546616141-486-1-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546616141-486-1-git-send-email-amhetre@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 09:05:41PM +0530, Ashish Mhetre wrote:
> From: Hiroshi Doyu <hdoyu@nvidia.com>
> 
> The purpose of lazy_max_pages is to gather virtual address space till it
> reaches the lazy_max_pages limit and then purge with a TLB flush and hence
> reduce the number of global TLB flushes.
> The default value of lazy_max_pages with one CPU is 32MB and with 4 CPUs it
> is 96MB i.e. for 4 cores, 96MB of vmalloc space will be gathered before it
> is purged with a TLB flush.
> This feature has shown random latency issues. For example, we have seen
> that the kernel thread for some camera application spent 30ms in
> __purge_vmap_area_lazy() with 4 CPUs.

You're not the first to report something like this.  Looking through the
kernel logs, I see:

commit 763b218ddfaf56761c19923beb7e16656f66ec62
Author: Joel Fernandes <joelaf@google.com>
Date:   Mon Dec 12 16:44:26 2016 -0800

    mm: add preempt points into __purge_vmap_area_lazy()

commit f9e09977671b618aeb25ddc0d4c9a84d5b5cde9d
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Dec 12 16:44:23 2016 -0800

    mm: turn vmap_purge_lock into a mutex

commit 80c4bd7a5e4368b680e0aeb57050a1b06eb573d8
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Fri May 20 16:57:38 2016 -0700

    mm/vmalloc: keep a separate lazy-free list

So the first thing I want to do is to confirm that you see this problem
on a modern kernel.  We've had trouble with NVidia before reporting
historical problems as if they were new.
