Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C69C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1551A2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1551A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeH3PNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:13:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:36558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728261AbeH3PNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:13:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D6DEACC6;
        Thu, 30 Aug 2018 11:12:09 +0000 (UTC)
Date:   Thu, 30 Aug 2018 13:12:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
Message-ID: <20180830111207.GE2656@dhcp22.suse.cz>
References: <20180830090319.985-1-feng.tang@intel.com>
 <20180830104401.GZ24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830104401.GZ24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-08-18 12:44:02, Peter Zijlstra wrote:
> On Thu, Aug 30, 2018 at 05:03:19PM +0800, Feng Tang wrote:
> > We hit a kernel panic when enabling earlycon for a platform, the
> > call trace is:
> > 
> > 	  panic+0xd2/0x220
> > 	  __alloc_bootmem+0x31/0x34
> > 	  spp_getpage+0x60/0x8a
> > 	  fill_pte+0x71/0x130
> > 	  __set_pte_vaddr+0x1d/0x50
> > 	  set_pte_vaddr+0x3c/0x60
> > 	  __native_set_fixmap+0x23/0x30
> > 	  native_set_fixmap+0x30/0x40
> > 	  setup_earlycon+0x1e0/0x32f
> > 	  param_setup_earlycon+0x13/0x22
> > 	  do_early_param+0x5b/0x90
> > 	  parse_args+0x1f7/0x300
> > 	  parse_early_options+0x24/0x28
> > 	  parse_early_param+0x65/0x73
> > 	  setup_arch+0x31e/0x9f1
> > 	  start_kernel+0x58/0x44e
> > 
> > The root cause is that when CONFIG_NO_BOOTMEM=y,  before
> > e820__memblock_setup() is called there is no memory for bootmem
> > to allocate,
> 
> Which you bloody well asked for by using NO_BOOTMEM=y.
> 
> Going down this route; adding hacks for every little thing that does
> want bootmem, completely defeats the purpose.
> 
> If anything, make the earlycon thing depend on NO_BOOTMEM=n. That also
> solves your problem. No earlycon, no panic.

Well, there is endeavor to remove bootmem allocator altogether. So
making earlycon depend on NO_BOOTMEM=n doesn't sound like a good fit to
me. I am not familiar with this code path but why cannot we postpone the
allocation to later or use a statically allocated storage?

-- 
Michal Hocko
SUSE Labs
