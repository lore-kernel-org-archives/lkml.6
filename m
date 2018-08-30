Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34356C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FAF205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FAF205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeH3QlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:41:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:55181 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728849AbeH3QlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:41:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 05:39:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="86236124"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2018 05:39:16 -0700
Date:   Thu, 30 Aug 2018 20:43:42 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
Message-ID: <20180830124342.ehtv7v4xszvmgpia@shbuild888>
References: <20180830090319.985-1-feng.tang@intel.com>
 <20180830104401.GZ24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830104401.GZ24124@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Aug 30, 2018 at 12:44:02PM +0200, Peter Zijlstra wrote:
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

In current x86, the NO_BOOTMEM is "y" by default, and almost all the
servers/desktops I could access have CONFIG_BOOTMEM=y, while earlycon
is important for enabling new platforms, as well as kernel debugging.
IMHO, it's better to keep earlycon capability. Also any alloc_bootmem()
call in that time window will trigger panic.

Thanks,
Feng

