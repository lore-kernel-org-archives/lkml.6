Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA86BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE452156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YdoxSQce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE452156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeI0PTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:19:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeI0PTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wjNvAHC8bsJR7C0XneYvLGD76OYbf4+M+0r4B1H+C74=; b=YdoxSQceecfqWg8yPO4RJ0OD5
        HrVo8DhAJa72UiPN7DdOzUgVbrEm+9bRWG7g2FzKVepYBoEt6tG4cUxXEYh9iHsON8mRY61hyqWZE
        7eWPK+qBdYrg26usdxDrfiKILuiyrtYPn9P9Ef2ybkhXq8kzclbIi5sZ1nPy8y3UHvlN767e9YCkT
        nvzdT92mUUbpj+7x+H7pDnqagzTAjECwasWwAXDa3vdsTFv6AuMdh+AO5mvYqvlu4SIDQUl+iEvpn
        9OrartNyr2BArpnwOfKNsyn31iCNKb/2/0h07NMNkeL4qeJ71pZB62WjWCRORb+4CtLYlaqgoHJeO
        L3M7yk1sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5SAy-000546-CJ; Thu, 27 Sep 2018 09:01:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E9F6202C1A0E; Thu, 27 Sep 2018 11:01:34 +0200 (CEST)
Date:   Thu, 27 Sep 2018 11:01:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh@kernel.org, robh+dt@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        green.hu@gmail.com, palmer@sifive.com
Subject: Re: [PATCH V5 06/30] csky: Cache and TLB routines
Message-ID: <20180927090134.GG5254@hirez.programming.kicks-ass.net>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <7cd7abcd2acf5c61435589338ff80a75a13173ca.1537789737.git.ren_guo@c-sky.com>
 <20180925072407.GA6999@hirez.programming.kicks-ass.net>
 <20180927052737.GA28407@guoren>
 <20180927070859.GC5254@hirez.programming.kicks-ass.net>
 <20180927081138.GA308@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927081138.GA308@guoren>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 04:11:42PM +0800, Guo Ren wrote:
> On Thu, Sep 27, 2018 at 09:08:59AM +0200, Peter Zijlstra wrote:

> > That's not what I meant; I meant you need something like:
> > 
> > #define flush_cache_range(vma, start, end) cache_wbinv_range(start, end)
> If you remove the tlb_start_vma in my tlb.h, I want to use cache_wbinv_all() is
> more safe. And I'll improve it in future.
> 
> My cache_wbinv_range(start, end) won't care vma->mm's asid and they just use current
> asid in mmu reg. If current_mm != vma->mm, then flush_cache_range will be broken.
> Perhaps, I need improve flush_cache_range first ...

Ah, ok. In that case I'll leave it to you to either use
cache_wbinv_all() or improve the range flush. My only request would to
stick on a comment to explain the reason you're not using
cache_wbinv_range() if you choose to use cache_wbinv_all() for
flush_cache_range().

Thanks!
