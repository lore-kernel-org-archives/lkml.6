Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A74C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7497F2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547683246;
	bh=6GXAVV0Hf4c0UmDO8U8Rk7qsoiz9If8sPlY95CfVxuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BXWV3RzVsDdev1xgafdBGnSmd6Xv4BxiNawILs+L1ML4lODLBHoDrXbkPE9+cK35I
	 Gy1+AowcFQziIVkV0IYen+7cqAAXHJu+1iHOvo2eXjtsK7dTCk/AORshSZyxHrUQfQ
	 +evUEdPUGZUg73h6jozpiAPJkuNbUfeT9GsdEzY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfAQAAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:00:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfAQAAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:00:44 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E59E2086D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547683242;
        bh=6GXAVV0Hf4c0UmDO8U8Rk7qsoiz9If8sPlY95CfVxuI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a5y3kYDiBbD3ApaHGPF66y27vrWh0wlD135Jd1qC0/Jlhyn1zuc+ZGVPgrro37GrX
         F1FzZuteGlec7JexdlA5RV21Lz6BHGWp7ZMPQWmlIAYN5rVT0qWJxc1PJ9ACkIhsMM
         pvznhh4sptMkelH3bh1SsZVHwXabqCg0+PcwVBN4=
Received: by mail-wr1-f48.google.com with SMTP id v13so9007530wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 16:00:42 -0800 (PST)
X-Gm-Message-State: AJcUukc9UnFJZCo9y7hqSYcEq3kqZ5vYz7Q7N8HpbdT8L3G6NcToIs/P
        5IpSz2IYLPda4EoUoNiSr7VlKGaYgTIYH+UJDBGSaw==
X-Google-Smtp-Source: ALg8bN7FozahMmjGXVc0cJlGYjqFZX5YUfIiHtreb/tQukThKebHckHgYMSnaJsRG8LeSxEf1ELKWicMr24s150Qaz0=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr9123044wri.199.1547683240918;
 Wed, 16 Jan 2019 16:00:40 -0800 (PST)
MIME-Version: 1.0
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com> <1547673522-226408-4-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1547673522-226408-4-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 16 Jan 2019 16:00:29 -0800
X-Gmail-Original-Message-ID: <CALCETrVenEpKH5O=Z6J+faWTcdZpa1xx4-dYwdWu1OSEDyiUWw@mail.gmail.com>
Message-ID: <CALCETrVenEpKH5O=Z6J+faWTcdZpa1xx4-dYwdWu1OSEDyiUWw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/umwait: Control umwait maximum time
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 1:24 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> IA32_UMWAIT_CONTROL[31:2] determines the maximum time in TSC-quanta
> that processor can stay in C0.1 or C0.2.
>
> The maximum time value in IA32_UMWAIT_CONTROL[31-2] is set as zero which
> means there is no global time limit for UMWAIT and TPAUSE instructions.
> Each process sets its own umwait maximum time as the instructions operand.
>
> User can specify global umwait maximum time through interface:
> /sys/devices/system/cpu/umwait_control/umwait_max_time
> The value in the interface is in decimal in TSC-quanta. Bits[1:0]
> are cleared when the value is stored.
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h |  2 ++
>  arch/x86/power/umwait.c          | 42 +++++++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index b56bfecae0de..42b9104fc15b 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -62,6 +62,8 @@
>  #define MSR_IA32_UMWAIT_CONTROL                0xe1
>  #define UMWAIT_CONTROL_C02_BIT         0x0
>  #define UMWAIT_CONTROL_C02_MASK                0x00000001
> +#define UMWAIT_CONTROL_MAX_TIME_BIT    0x2
> +#define UMWAIT_CONTROL_MAX_TIME_MASK   0xfffffffc
>
>  #define MSR_PKG_CST_CONFIG_CONTROL     0x000000e2
>  #define NHM_C3_AUTO_DEMOTE             (1UL << 25)
> diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
> index 95b3867aac1e..4a1a507d3bb7 100644
> --- a/arch/x86/power/umwait.c
> +++ b/arch/x86/power/umwait.c
> @@ -10,6 +10,7 @@
>  #include <asm/msr.h>
>
>  static int umwait_enable_c0_2 = 1; /* 0: disable C0.2. 1: enable C0.2. */
> +static u32 umwait_max_time; /* In TSC-quanta. Only bits [31:2] are used. */
>  static DEFINE_MUTEX(umwait_lock);
>
>  /* Return value that will be used to set umwait control MSR */
> @@ -20,7 +21,8 @@ static inline u32 umwait_control_val(void)
>          * When bit 0 is 1, C0.2 is disabled. Otherwise, C0.2 is enabled.
>          * So value in bit 0 is opposite of umwait_enable_c0_2.
>          */
> -       return ~umwait_enable_c0_2 & UMWAIT_CONTROL_C02_MASK;
> +       return (~umwait_enable_c0_2 & UMWAIT_CONTROL_C02_MASK) |
> +              umwait_max_time;
>  }
>
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

You need something to make sure that newly onlined CPUs get the right
value in the MSR.  You also need to make sure you restore it on resume
from suspend.  Something like cpu_init() might be the right place.

Also, as previously discussed, I think we should set the default to
something quite small, maybe 100 microseconds.  IMO the goal is to
pick a value that is a high enough multiple of the C0.2 entry+exit
latency that we get most of the power and SMT resource savings while
being small enough that no one things that UMWAIT is more than a
glorified, slightly improved, and far more misleading version of REP
NOP.

Andrew, would having Linux default to a small value do much to
mitigate your concerns that UMWAIT is problematic for hypervisors?

Also, can someone who understands the hardware clarify just how
dangerous UMWAIT is from a perspective of making speculation attacks
more dangerous than they already are?  I'm wondering what events will
wake up a UMONITOR.  I bet that CLFLUSH does.  I wonder if a faulting
write to a read-only page also does.  Or a load from a remote node.
Or a speculative store that does not subsequently retire.  This
instruction seems quite delightful as a tool to create a
highish-bandwidth covert channel, and it's possibly quite nice to
agument Spectre-like attacks.  If it ends up being bad enough, we
might need to set the default timeout to the absolute minimum value
and possibly ask Intel to give us a way to turn it off entirely.
