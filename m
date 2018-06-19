Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9C0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F658208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F658208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965551AbeFSJDi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:03:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56621 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937229AbeFSJDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:03:36 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVCXq-0002lA-UR; Tue, 19 Jun 2018 11:03:23 +0200
Date:   Tue, 19 Jun 2018 11:03:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 4/8] cpuidle: Set up maximum umwait time and umwait
 states
In-Reply-To: <1529118375-90191-5-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1806191059040.1692@nanos.tec.linutronix.de>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com> <1529118375-90191-5-git-send-email-fenghua.yu@intel.com>
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

On Fri, 15 Jun 2018, Fenghua Yu wrote:
> By default C0.2 is enabled so user wait can save more power but wakeup
> time is slower. In some cases e.g. real time, user wants to disable C0.2
> so that user wait saves less power but wakeup time is faster.

Why is this default enabled?

> A new "/sys/devices/system/cpu/cpuidle/umwait_disable_c0_2" file is
> created to allow user to check if C0.2 is enabled or disabled and also
> allow user to enable or disable C0.2. Value "1" in the file means C0.2 is
> disabled. Value "0" means C0.2 is enabled.

Can we please use straight forward positive logic and have a enable file?

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * umwait.c - control user wait

Please remove these pointless file references. They get stale before its merged.

> + *
> + * Copyright (c) 2018, Intel Corporation.
> + * Fenghua Yu <fenghua.yu@intel.com>
> + */
> +/*
> + * umwait.c adds control of user wait states that user enters through user wait
> + * instructions umwait or tpause.

umwait.c adds something?

> + */
> +#include <linux/cpu.h>
> +#include <asm/msr.h>
> +
> +static int umwait_disable_c0_2;
> +static DEFINE_MUTEX(umwait_lock);
> +
> +static ssize_t umwait_disable_c0_2_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	return sprintf(buf, "%d\n", umwait_disable_c0_2);
> +}
> +
> +static ssize_t umwait_disable_c0_2_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	int disable_c0_2, cpu, ret;
> +	u32 msr_val;
> +
> +	ret = kstrtou32(buf, 10, &disable_c0_2);
> +	if (ret)
> +		return ret;
> +	if (disable_c0_2 != 1 && disable_c0_2 != 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&umwait_lock);
> +	umwait_disable_c0_2 = disable_c0_2;
> +	/*
> +	 * No global umwait maximum time limit (0 in bits 31-0).
> +	 * Enable or disable C0.2 based on global setting (bit 0) on all CPUs.
> +	 */
> +	msr_val = umwait_disable_c0_2 & UMWAIT_CONTROL_C02_MASK;

That mask is there because the variable can only have 0 and 1 as content....

> +	for_each_online_cpu(cpu)
> +		wrmsr_on_cpu(cpu, MSR_IA32_UMWAIT_CONTROL, msr_val, 0);

This lacks protection against CPU hotplug.

> +	mutex_unlock(&umwait_lock);
> +
> +	return count;

Thanks,

	tglx
