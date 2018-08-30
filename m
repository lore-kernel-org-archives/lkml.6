Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B84AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C757205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nWDTKcRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C757205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeH3QLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:11:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeH3QLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oRGaHXS+Aj2z/5xkbJLDj7TIN0E29j8WQ83Y6yUU2z4=; b=nWDTKcRe5z2HrHdD6YkTCCbJ1
        dCXg22DCHgRLQFMBfYM6gBp0zDnm/8atXqkeNEvMP355r1H2Jbik1yI444sNCm7icICWwadMjLtEh
        YoqBuzvJu5P38AwaUvN19g02sCewaaWpak3pLt5CaxPKMAYZZsXI+uZbbuef5Tl/epP1OEsEx5+jg
        w/DsEzLV6pvPnhF9C1fsXP4nZzrdBd0g+VzU9B8BU93J5ykNk9jHRvqJComqchPJq65KxDZ/lKswp
        nWiAQvAJzsv+7NL+Rzep/a85apuVq3wrBmY7dB33F1ZJcJFrVAUELE/feOlhNBoRiWO8Tq87hxz9J
        C0050So8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvLlQ-0004p4-To; Thu, 30 Aug 2018 12:09:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B32D92024D73F; Thu, 30 Aug 2018 14:09:26 +0200 (CEST)
Date:   Thu, 30 Aug 2018 14:09:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
Message-ID: <20180830120926.GL24082@hirez.programming.kicks-ass.net>
References: <20180830090319.985-1-feng.tang@intel.com>
 <20180830104401.GZ24124@hirez.programming.kicks-ass.net>
 <20180830111207.GE2656@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830111207.GE2656@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 01:12:07PM +0200, Michal Hocko wrote:
> On Thu 30-08-18 12:44:02, Peter Zijlstra wrote:
> > On Thu, Aug 30, 2018 at 05:03:19PM +0800, Feng Tang wrote:
> > > We hit a kernel panic when enabling earlycon for a platform, the
> > > call trace is:
> > > 
> > > 	  panic+0xd2/0x220
> > > 	  __alloc_bootmem+0x31/0x34
> > > 	  spp_getpage+0x60/0x8a
> > > 	  fill_pte+0x71/0x130
> > > 	  __set_pte_vaddr+0x1d/0x50
> > > 	  set_pte_vaddr+0x3c/0x60
> > > 	  __native_set_fixmap+0x23/0x30
> > > 	  native_set_fixmap+0x30/0x40
> > > 	  setup_earlycon+0x1e0/0x32f
> > > 	  param_setup_earlycon+0x13/0x22
> > > 	  do_early_param+0x5b/0x90
> > > 	  parse_args+0x1f7/0x300
> > > 	  parse_early_options+0x24/0x28
> > > 	  parse_early_param+0x65/0x73
> > > 	  setup_arch+0x31e/0x9f1
> > > 	  start_kernel+0x58/0x44e
> > > 
> > > The root cause is that when CONFIG_NO_BOOTMEM=y,  before
> > > e820__memblock_setup() is called there is no memory for bootmem
> > > to allocate,
> > 
> > Which you bloody well asked for by using NO_BOOTMEM=y.
> > 
> > Going down this route; adding hacks for every little thing that does
> > want bootmem, completely defeats the purpose.
> > 
> > If anything, make the earlycon thing depend on NO_BOOTMEM=n. That also
> > solves your problem. No earlycon, no panic.
> 
> Well, there is endeavor to remove bootmem allocator altogether. So

wasn't aware of that. why?

> making earlycon depend on NO_BOOTMEM=n doesn't sound like a good fit to
> me. I am not familiar with this code path but why cannot we postpone the
> allocation to later or use a statically allocated storage?

because 'early'... I suppose. Youu really want the early con up and
running asap.
