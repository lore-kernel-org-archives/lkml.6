Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43113C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F5E2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550731064;
	bh=fj23SnDguJJuL6/3QRFcEN6zGzu4fXzbDigy+0oXpyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oBP0uyfq2Fq3k6NdtBZncriVR/GZIpu9m60i+9YFOOBTdsShHr1SNtVkV2qxAlIuX
	 E8gMJZHcJVZp9XgawM+P8FlU/IulRJybh7BroNKJt5QMfiv+AcDdmk8lbhgKfM5gEF
	 NL17KNTLeFIOIiAKyUc3lpDKydgFL0O9eAbykDBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfBUGhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:37:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfBUGhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:37:42 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 469312084F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550731060;
        bh=fj23SnDguJJuL6/3QRFcEN6zGzu4fXzbDigy+0oXpyE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=meztQji3RQfq+lK4opehfij9oGMp95blwCSrKoyzzoCwPUEB/nqrQouOi0R1pwFqv
         wPC0NbuP2CJ7bHtUb+RNUK8SEDSuJ03jXoylLvFVy1XIYRIiaGkib2kculmkFw+/5q
         4H8t/eRCKuA6sXzXlQhcG4+8NB6WZNiVGoaOky4A=
Received: by mail-wr1-f53.google.com with SMTP id r5so15261839wrg.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 22:37:40 -0800 (PST)
X-Gm-Message-State: AHQUAua5gL4v+ZdWbeEKAJq8uAGP3tK2pOLTk5u6RPKRdMh2vQChjsZC
        7Z/vtaRt/80dHTj6YRdOL9g/6gwxBlJxbA1vl1cuBQ==
X-Google-Smtp-Source: AHgI3Ib3TYdZ39jE2kUQLvn20qF96UXmkGoGu40Ne3MkAWrk/QI/NEKKtzytfWVwC4UU+d4+rtuq1v0leMmqgLPIdPE=
X-Received: by 2002:adf:9dc4:: with SMTP id q4mr12052540wre.330.1550731058747;
 Wed, 20 Feb 2019 22:37:38 -0800 (PST)
MIME-Version: 1.0
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com> <1547673522-226408-6-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1547673522-226408-6-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 Feb 2019 22:37:27 -0800
X-Gmail-Original-Message-ID: <CALCETrWCJAzRj7BUBX=O2qdHXucNWz=z0uEQ5asskTbw8CGW5w@mail.gmail.com>
Message-ID: <CALCETrWCJAzRj7BUBX=O2qdHXucNWz=z0uEQ5asskTbw8CGW5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/cpufeatures: Enumerate user wait instructions
To:     Tao Xu <tao3.xu@intel.com>
Cc:     jingqi.liu@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 7:44 PM Tao Xu <tao3.xu@intel.com> wrote:
>
> From: Fenghua Yu <fenghua.yu@intel.com>

>
> From patchwork Wed Jan 16 21:18:41 2019
> Content-Type: text/plain; charset="utf-8"

[snipped more stuff like this]

What happened here?

> +/* Return value that will be used to set umwait control MSR */
> +static inline u32 umwait_control_val(void)
> +{
> +       /*
> +        * Enable or disable C0.2 (bit 0) based on global setting on all CPUs.
> +        * When bit 0 is 1, C0.2 is disabled. Otherwise, C0.2 is enabled.
> +        * So value in bit 0 is opposite of umwait_enable_c0_2.
> +        */
> +       return ~umwait_enable_c0_2 & UMWAIT_CONTROL_C02_MASK;
> +}

This function is horribly named.  How about something like
umwait_compute_msr_value() or something liek that?  Also, what
happened to the maximum wait time?

> +
> +static ssize_t umwait_enable_c0_2_show(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      char *buf)
> +{
> +       return sprintf(buf, "%d\n", umwait_enable_c0_2);

I realize that it's traditional to totally ignore races in sysfs and
such, but it's a bad tradition.  Please either READ_ONCE it with a
comment or take the mutex.

> +static ssize_t umwait_enable_c0_2_store(struct device *dev,
> +                                       struct device_attribute *attr,
> +                                       const char *buf, size_t count)
> +{
> +       int enable_c0_2, cpu, ret;
> +       u32 msr_val;
> +
> +       ret = kstrtou32(buf, 10, &enable_c0_2);
> +       if (ret)
> +               return ret;
> +
> +       if (enable_c0_2 != 1 && enable_c0_2 != 0)
> +               return -EINVAL;

How about if (enable_c0_2 > 1)?

> +
> +       mutex_lock(&umwait_lock);
> +
> +       umwait_enable_c0_2 = enable_c0_2;
> +       msr_val = umwait_control_val();
> +       get_online_cpus();
> +       /* All CPUs have same umwait control setting */
> +       for_each_online_cpu(cpu)
> +               wrmsr_on_cpu(cpu, MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
> +       put_online_cpus();
> +
> +       mutex_unlock(&umwait_lock);

Please factor this thing out into a helper like
umwait_update_all_cpus().  That helper can assert that the lock is
held.

> +/* Set up umwait control MSR on this CPU using the current global setting. */
> +static int umwait_cpu_online(unsigned int cpu)
> +{
> +       u32 msr_val;
> +
> +       mutex_lock(&umwait_lock);
> +
> +       msr_val = umwait_control_val();
> +       wrmsr(MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
> +
> +       mutex_unlock(&umwait_lock);
> +
> +       return 0;
> +}
> +
> +static int __init umwait_init(void)
> +{
> +       struct device *dev;
> +       int ret;
> +
> +       if (!boot_cpu_has(X86_FEATURE_WAITPKG))
> +               return -ENODEV;
> +
> +       /* Add CPU global user wait interface to control umwait. */
> +       dev = cpu_subsys.dev_root;
> +       ret = sysfs_create_group(&dev->kobj, &umwait_attr_group);
> +       if (ret)
> +               return ret;
> +
> +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait/intel:online",
> +                               umwait_cpu_online, NULL);

This hotplug notifier thing is awful.  Thomas, do we have a function
that gets called every time a CPU is brought up (via BSP boot, AP
boot, hotplug, hibernation resume, etc) where we can just put all
these things?  cpu_init() is almost appropriate, except that it's
called at somewhat erratic times (quite different for BSP and AP IIRC)
and it's not called AFAICT during hibernation restore.  I suppose we
could add a new thing that is called by cpu_init() and
restore_processor_state().

Also, surely you should actually write the MSR in this function, too.

>
>  static int umwait_enable_c0_2 = 1; /* 0: disable C0.2. 1: enable C0.2. */
> +static u32 umwait_max_time; /* In TSC-quanta. Only bits [31:2] are used. */

I still think the default should be some reasonable nonzero value.  It
should be long enough that we get decent C0.2 residency and short
enough that UMWAIT never gives the impression that it is anything
other than a fancy way to save a bit of power and SMT resources when
spinning.  I don't want to see a situation where some library uses
UMWAIT under the expectation that it genuinely waits for an event,
appears to work well on bare metal on an otherwise idle system, and
falls apart when it's run in a VM guest or with other software
running.  IOW, programs more or less must be written to expect many
spurious wakeups, so I think we should pick a default value so that
there are essentially always many spurious wakeups.

As a guess, I think that the default wait time should be well under 1
ms but at least 20x the C0.2 entry+exit latency.

--Andy
>  static ssize_t umwait_enable_c0_2_show(struct device *dev,
> @@ -61,8 +63,46 @@ static ssize_t umwait_enable_c0_2_store(struct device *dev,
>
>  static DEVICE_ATTR_RW(umwait_enable_c0_2);
>
> +static ssize_t umwait_max_time_show(struct device *kobj,
> +                                   struct device_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%u\n", umwait_max_time);
> +}
> +
> +static ssize_t umwait_max_time_store(struct device *kobj,
> +                                    struct device_attribute *attr,
> +                                    const char *buf, size_t count)
> +{
> +       u32 msr_val, max_time;
> +       int cpu, ret;
> +
> +       ret = kstrtou32(buf, 10, &max_time);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&umwait_lock);
> +
> +       /* Only get max time value from bits [31:2] */
> +       max_time &= UMWAIT_CONTROL_MAX_TIME_MASK;
> +       /* Update the max time value in memory */
> +       umwait_max_time = max_time;
> +       msr_val = umwait_control_val();
> +       get_online_cpus();
> +       /* All CPUs have same umwait max time */
> +       for_each_online_cpu(cpu)
> +               wrmsr_on_cpu(cpu, MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
> +       put_online_cpus();
> +
> +       mutex_unlock(&umwait_lock);
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR_RW(umwait_max_time);
> +
>  static struct attribute *umwait_attrs[] = {
>         &dev_attr_umwait_enable_c0_2.attr,
> +       &dev_attr_umwait_max_time.attr,
>         NULL
>  };
>
