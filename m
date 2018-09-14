Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14019FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3C420866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3C420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeINOUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:20:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:53964 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbeINOUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:20:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 02:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="85980025"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2018 02:07:12 -0700
Date:   Fri, 14 Sep 2018 17:04:40 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelly@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1 2/3] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
Message-ID: <20180914090440.GB11769@yi.y.sun>
References: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com>
 <1536830005-37260-3-git-send-email-yi.y.sun@linux.intel.com>
 <alpine.DEB.2.21.1809131307110.1473@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1809131307110.1473@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-09-13 13:24:07, Thomas Gleixner wrote:
> On Thu, 13 Sep 2018, Yi Sun wrote:
> > +++ b/arch/x86/hyperv/hv_spinlock.c
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Hyper-V specific spinlock code.
> > + *
> > + * Copyright (C) 2018, Intel, Inc.
> > + *
> > + * Author : Yi Sun <yi.y.sun@linux.intel.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published
> > + * by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> > + * NON INFRINGEMENT.  See the GNU General Public License for more
> > + * details.
> 
> Please remove the boilerplate. The SPDX identifier is enough. If in doubt
> talk to Intel legal.
> 
I will check this. Thanks!

> > +static bool hv_pvspin = true;
> 
> __initdata please.
> 
> > +static u32 spin_wait_info = 0;
> 
> No need for 0 initialization.
> 
Will modify them.

> > +
> > +static void hv_notify_long_spin_wait(void)
> > +{
> > +	u64 input = spin_wait_info | 0x00000000ffffffff;
> 
> What? The result is always 0x00000000ffffffff .....
> 
Oh, sorry for such error.

> > +	spin_wait_info++;
> > +	hv_do_fast_hypercall8(HVCALL_NOTIFY_LONG_SPIN_WAIT, input);
> > +}
> > +
> > +static void hv_qlock_kick(int cpu)
> > +{
> > +	spin_wait_info--;
> 
> Looking at the above this is completely pointless and I have no idea what
> that variable is supposed to do.
> 
Per Microsoft Hypervisor Top Level Functional Specification, the input
parameter of HVCALL_NOTIFY_LONG_SPIN_WAIT is defined as below:

SpinwaitInfo – Specifies the accumulated count the guest was spinning.

So, it is increased when guest is spinning and reduced when spinlock is
released.

I may add comments to explain it.

> > +	apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
> > +}
> > +
> > +/*
> > + * Halt the current CPU & release it back to the host
> > + */
> > +static void hv_qlock_wait(u8 *byte, u8 val)
> > +{
> > +	unsigned long msr_val;
> > +
> > +	if (READ_ONCE(*byte) != val)
> > +		return;
> > +
> > +	hv_notify_long_spin_wait();
> > +
> > +	rdmsrl(HV_X64_MSR_GUEST_IDLE, msr_val);
> 
> Magic rdmsrl(). That wants a comment what this is for.
> 
Per above spec, reading HV_X64_MSR_GUEST_IDLE can make guest idle.

I will add comment here.

> > +/*
> > + * Hyper-V does not support this so far.
> > + */
> > +bool hv_vcpu_is_preempted(int vcpu)
> 
> static ?
> 
PV_CALLEE_SAVE_REGS_THUNK definition is below. 

#define PV_CALLEE_SAVE_REGS_THUNK(func) \
        extern typeof(func) __raw_callee_save_##func; \
        ......

So, the hv_vcpu_is_preempted cannot be declared as 'static'. Otherwise,
the make fails with below info.

arch/x86/hyperv/hv_spinlock.o: In function `__raw_callee_save_hv_vcpu_is_preempted':
hv_spinlock.c:(.text+0xd): undefined reference to `hv_vcpu_is_preempted'

> > +{
> > +	return false;
> > +}
> > +PV_CALLEE_SAVE_REGS_THUNK(hv_vcpu_is_preempted);
> > +
> > +void __init hv_init_spinlocks(void)
> > +{
> > +	if (!hv_pvspin ||
> > +	    !apic ||
> > +	    !(ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) ||
> > +	    !(ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)) {
> > +		pr_warn("hv: PV spinlocks disabled\n");
> 
> Why does this need to be pr_warn? This is purely informational. Also please
> use pr_fmt instead of the 'hv:' prefix.
> 
Got it. Thanks!

> > +static __init int hv_parse_nopvspin(char *arg)
> > +{
> > +	hv_pvspin = false;
> > +	return 0;
> > +}
> > +early_param("hv_nopvspin", hv_parse_nopvspin);
> 
> That lacks Documentation of the command line parameter. Wants to be in the
> same patch.
> 
Will merge patch 3 into 2. Thanks!

> Thanks,
> 
> 	tglx
