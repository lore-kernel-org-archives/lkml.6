Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB19FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E35C208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E35C208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966860AbeFSPqy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:46:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:1924 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966650AbeFSPqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:46:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 08:46:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="58527201"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2018 08:46:52 -0700
Date:   Tue, 19 Jun 2018 08:46:27 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 4/8] cpuidle: Set up maximum umwait time and umwait
 states
Message-ID: <20180619154627.GB112652@romley-ivt3.sc.intel.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
 <1529118375-90191-5-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1806191059040.1692@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806191059040.1692@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:03:22AM +0200, Thomas Gleixner wrote:
> On Fri, 15 Jun 2018, Fenghua Yu wrote:
> > By default C0.2 is enabled so user wait can save more power but wakeup
> > time is slower. In some cases e.g. real time, user wants to disable C0.2
> > so that user wait saves less power but wakeup time is faster.
> 
> Why is this default enabled?

Current hardware implementation enables C0.2 by default. But I'm
not sure future every hardware always enables it by default.

In kernel, init code enforces to enable C0.2 globally by default.
Each umwait or tpause instruction will specify which state (C0.1 or C0.2)
to use during wait depending on user's decision. And a sysfs interface
allows user to disable C0.2 globally during run time.

Is this right arrangement?

> 
> > A new "/sys/devices/system/cpu/cpuidle/umwait_disable_c0_2" file is
> > created to allow user to check if C0.2 is enabled or disabled and also
> > allow user to enable or disable C0.2. Value "1" in the file means C0.2 is
> > disabled. Value "0" means C0.2 is enabled.
> 
> Can we please use straight forward positive logic and have a enable file?

Sure. I will do that.

> 
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * umwait.c - control user wait
> 
> Please remove these pointless file references. They get stale before its merged.
Sure. I will remove these.

> 
> > + *
> > + * Copyright (c) 2018, Intel Corporation.
> > + * Fenghua Yu <fenghua.yu@intel.com>
> > + */
> > +/*
> > + * umwait.c adds control of user wait states that user enters through user wait
> > + * instructions umwait or tpause.
> 
> umwait.c adds something?

I will change to "umwait.c controls user wait states that user enters..."?

> 
> > + */
> > +#include <linux/cpu.h>
> > +#include <asm/msr.h>
> > +
> > +static int umwait_disable_c0_2;
> > +static DEFINE_MUTEX(umwait_lock);
> > +
> > +static ssize_t umwait_disable_c0_2_show(struct device *dev,
> > +					struct device_attribute *attr,
> > +					char *buf)
> > +{
> > +	return sprintf(buf, "%d\n", umwait_disable_c0_2);
> > +}
> > +
> > +static ssize_t umwait_disable_c0_2_store(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 const char *buf, size_t count)
> > +{
> > +	int disable_c0_2, cpu, ret;
> > +	u32 msr_val;
> > +
> > +	ret = kstrtou32(buf, 10, &disable_c0_2);
> > +	if (ret)
> > +		return ret;
> > +	if (disable_c0_2 != 1 && disable_c0_2 != 0)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&umwait_lock);
> > +	umwait_disable_c0_2 = disable_c0_2;
> > +	/*
> > +	 * No global umwait maximum time limit (0 in bits 31-0).
> > +	 * Enable or disable C0.2 based on global setting (bit 0) on all CPUs.
> > +	 */
> > +	msr_val = umwait_disable_c0_2 & UMWAIT_CONTROL_C02_MASK;
> 
> That mask is there because the variable can only have 0 and 1 as content....

You are right, the variable can only have 0 or 1. Is it ok to have the mask?

> 
> > +	for_each_online_cpu(cpu)
> > +		wrmsr_on_cpu(cpu, MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
> 
> This lacks protection against CPU hotplug.

You are right. I will add protection.

> 
> > +	mutex_unlock(&umwait_lock);
> > +
> > +	return count;
> 
> Thanks,
> 
> 	tglx

Thanks.

-Fenghua
