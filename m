Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B27C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD832082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T7pu6AXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD832082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbeH3Opj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:45:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbeH3Opi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HMaV9aV35at75yfGy91egTbg5GqQTmnRPaJBHgDSt2I=; b=T7pu6AXtvQ+edG8jhsQSy0GGE
        pO/rGkc6k+ncvrUImTTQZ1MCsXXU/jKqSRJ/Q2tnJcv23SmegPRYvFss2Y0v7RNtTdUxmu9SfAK1R
        gnePjuh0DAAVGlWl5TsogsDJpJZG53b5zDw6Ah/CKcBqQjDwPorse4kbD80h/FJg7d9HfBYyt4jFI
        Z7ukRABs+s8eGHp/NTrlmkUljZEtHt19SN3L7mayuDvhIaZqPJO679f/SFgXa6ixzOUaOB+7nH8Iw
        dJiHFJOhXsN+nWvq/P4GUG7RjWedK+pwQ4vSRqdSE8g2qxcZuiAMTp5ZtT9YtBfCW8Q8YBfVn2igd
        DYxTQte5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvKQl-0007MC-G5; Thu, 30 Aug 2018 10:44:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AE6B2024D444; Thu, 30 Aug 2018 12:44:02 +0200 (CEST)
Date:   Thu, 30 Aug 2018 12:44:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
Message-ID: <20180830104401.GZ24124@hirez.programming.kicks-ass.net>
References: <20180830090319.985-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830090319.985-1-feng.tang@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 05:03:19PM +0800, Feng Tang wrote:
> We hit a kernel panic when enabling earlycon for a platform, the
> call trace is:
> 
> 	  panic+0xd2/0x220
> 	  __alloc_bootmem+0x31/0x34
> 	  spp_getpage+0x60/0x8a
> 	  fill_pte+0x71/0x130
> 	  __set_pte_vaddr+0x1d/0x50
> 	  set_pte_vaddr+0x3c/0x60
> 	  __native_set_fixmap+0x23/0x30
> 	  native_set_fixmap+0x30/0x40
> 	  setup_earlycon+0x1e0/0x32f
> 	  param_setup_earlycon+0x13/0x22
> 	  do_early_param+0x5b/0x90
> 	  parse_args+0x1f7/0x300
> 	  parse_early_options+0x24/0x28
> 	  parse_early_param+0x65/0x73
> 	  setup_arch+0x31e/0x9f1
> 	  start_kernel+0x58/0x44e
> 
> The root cause is that when CONFIG_NO_BOOTMEM=y,  before
> e820__memblock_setup() is called there is no memory for bootmem
> to allocate,

Which you bloody well asked for by using NO_BOOTMEM=y.

Going down this route; adding hacks for every little thing that does
want bootmem, completely defeats the purpose.

If anything, make the earlycon thing depend on NO_BOOTMEM=n. That also
solves your problem. No earlycon, no panic.
