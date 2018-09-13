Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8F7C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421BE20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421BE20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIMQdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:33:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeIMQdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:33:13 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0PjD-0007xe-L4; Thu, 13 Sep 2018 13:24:07 +0200
Date:   Thu, 13 Sep 2018 13:24:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yi Sun <yi.y.sun@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelly@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1 2/3] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
In-Reply-To: <1536830005-37260-3-git-send-email-yi.y.sun@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1809131307110.1473@nanos.tec.linutronix.de>
References: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com> <1536830005-37260-3-git-send-email-yi.y.sun@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018, Yi Sun wrote:
> +++ b/arch/x86/hyperv/hv_spinlock.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Hyper-V specific spinlock code.
> + *
> + * Copyright (C) 2018, Intel, Inc.
> + *
> + * Author : Yi Sun <yi.y.sun@linux.intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.

Please remove the boilerplate. The SPDX identifier is enough. If in doubt
talk to Intel legal.

> +static bool hv_pvspin = true;

__initdata please.

> +static u32 spin_wait_info = 0;

No need for 0 initialization.

> +
> +static void hv_notify_long_spin_wait(void)
> +{
> +	u64 input = spin_wait_info | 0x00000000ffffffff;

What? The result is always 0x00000000ffffffff .....

> +	spin_wait_info++;
> +	hv_do_fast_hypercall8(HVCALL_NOTIFY_LONG_SPIN_WAIT, input);
> +}
> +
> +static void hv_qlock_kick(int cpu)
> +{
> +	spin_wait_info--;

Looking at the above this is completely pointless and I have no idea what
that variable is supposed to do.

> +	apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
> +}
> +
> +/*
> + * Halt the current CPU & release it back to the host
> + */
> +static void hv_qlock_wait(u8 *byte, u8 val)
> +{
> +	unsigned long msr_val;
> +
> +	if (READ_ONCE(*byte) != val)
> +		return;
> +
> +	hv_notify_long_spin_wait();
> +
> +	rdmsrl(HV_X64_MSR_GUEST_IDLE, msr_val);

Magic rdmsrl(). That wants a comment what this is for.

> +/*
> + * Hyper-V does not support this so far.
> + */
> +bool hv_vcpu_is_preempted(int vcpu)

static ?

> +{
> +	return false;
> +}
> +PV_CALLEE_SAVE_REGS_THUNK(hv_vcpu_is_preempted);
> +
> +void __init hv_init_spinlocks(void)
> +{
> +	if (!hv_pvspin ||
> +	    !apic ||
> +	    !(ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) ||
> +	    !(ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)) {
> +		pr_warn("hv: PV spinlocks disabled\n");

Why does this need to be pr_warn? This is purely informational. Also please
use pr_fmt instead of the 'hv:' prefix.

> +static __init int hv_parse_nopvspin(char *arg)
> +{
> +	hv_pvspin = false;
> +	return 0;
> +}
> +early_param("hv_nopvspin", hv_parse_nopvspin);

That lacks Documentation of the command line parameter. Wants to be in the
same patch.

Thanks,

	tglx
