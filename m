Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CC8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DFD21780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DFD21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbeKOBQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:16:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:42790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732823AbeKOBQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:16:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB91CB00C;
        Wed, 14 Nov 2018 15:12:34 +0000 (UTC)
Date:   Wed, 14 Nov 2018 16:12:29 +0100
From:   Borislav Petkov <bp@suse.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:master 22/22]
 arch/x86//kernel/cpu/mcheck/therm_throt.c:394:39: error: conflicting types
 for 'smp_thermal_interrupt'
Message-ID: <20181114151229.GA13183@zn.tnic>
References: <201811142348.uUmuZUqI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201811142348.uUmuZUqI%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 11:00:52PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> head:   449637df6faa8cd9a7f9cdf25589445f0dab2371
> commit: 449637df6faa8cd9a7f9cdf25589445f0dab2371 [22/22] Merge branch 'x86/cleanups'
> config: x86_64-lkp (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 449637df6faa8cd9a7f9cdf25589445f0dab2371
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/x86//kernel/cpu/mcheck/therm_throt.c:394:39: error: conflicting types for 'smp_thermal_interrupt'
>     asmlinkage __visible void __irq_entry smp_thermal_interrupt(void)
>                                           ^~~~~~~~~~~~~~~~~~~~~
>    In file included from arch/x86//kernel/cpu/mcheck/therm_throt.c:28:0:
>    arch/x86/include/asm/traps.h:107:17: note: previous declaration of 'smp_thermal_interrupt' was here
>     asmlinkage void smp_thermal_interrupt(struct pt_regs *regs);
>                     ^~~~~~~~~~~~~~~~~~~~~
> 
> vim +/smp_thermal_interrupt +394 arch/x86//kernel/cpu/mcheck/therm_throt.c
> 
> a65c88dd Hidetoshi Seto  2009-06-15  393  
> d813dfb2 Borislav Petkov 2018-11-09 @394  asmlinkage __visible void __irq_entry smp_thermal_interrupt(void)
> cf910e83 Seiji Aguchi    2013-06-20  395  {
> cf910e83 Seiji Aguchi    2013-06-20  396  	entering_irq();
> cf910e83 Seiji Aguchi    2013-06-20  397  	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
> 0f42ae28 Thomas Gleixner 2017-08-28  398  	inc_irq_stat(irq_thermal_count);
> 0f42ae28 Thomas Gleixner 2017-08-28  399  	smp_thermal_vector();
> cf910e83 Seiji Aguchi    2013-06-20  400  	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
> cf910e83 Seiji Aguchi    2013-06-20  401  	exiting_ack_irq();
> cf910e83 Seiji Aguchi    2013-06-20  402  }
> cf910e83 Seiji Aguchi    2013-06-20  403  
> 
> :::::: The code at line 394 was first introduced by commit
> :::::: d813dfb28641306f66cf1e2c3586f39ab4f84b27 x86/mce: Fix -Wmissing-prototypes warnings

Already fixed:

https://git.kernel.org/tip/68b5e4326e4b8ac9080835005d8254fed0fb3c56

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
