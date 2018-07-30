Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9DEC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C398920892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWBb0Zsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C398920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeG3ItZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:49:25 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40284 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeG3ItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:49:24 -0400
Received: by mail-oi0-f67.google.com with SMTP id w126-v6so19402366oie.7;
        Mon, 30 Jul 2018 00:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fBZq5xqqdJ9iVan/RgdtR8F1cEIIVx7/Ptb8gzHzsv4=;
        b=lWBb0ZsklY4RuNom23rcpY6AHtuXa5VfoFrBYculAXsQnHBdZ2jrM8sbIzSBDRSE2S
         W42s4Emkip/TRxzRQMvijpYJQBY0FmnwXwxuwl1fOR+RZAzrRsQYzPtnVoh3+aU3Gq+X
         odBJzgDDrPyMDNYEn0vo6TnZ7I3RzRurRZ6uvgQmeCe3MfBD+0npwAq8BfxxIFMvNbF4
         1PjQqpswY7s0OrfQ4uegiFp2qaDiIG+fUFvEYovMW5KzjEWrnOlQeQ3o2YJIoILChdV8
         J8FxYfstRbQUH8nouLK7Q9lxuoDhzLgFIDsrFMcyXV1RxdIrXdYgRgDTJ448uteQ8SI/
         ZFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fBZq5xqqdJ9iVan/RgdtR8F1cEIIVx7/Ptb8gzHzsv4=;
        b=ofolQkcxCWHKEk8olN2vFtR1ER8S3LrlCVT2d7ZUuywua4rsYfhhi6hc3hg5ukZDyt
         PH6bwmR/nL3Fmd+VWmtnNWn5gzB8cVB2zIvvHVl7YVMjpjHDRQp7SpEqBvW0tE5E93eE
         djm1pw3OxUxwIGObT+lXj6C0MizMdtj8Ll4MVuwVQC5RwHTo2xSNfZzY3v+vIG2XVQxN
         /y+CE0ewwLGrCsgGAVUeB7yspjueGbXK0pRXFzVRNEQUvl3+KQNtP9yk4KQpVvNo4me8
         jjRHCe7+u7rcaVVykA4EkcO8BzPAUDndIQTmC6w59l12Z2ABtd12trNQR5r74WGjZrVp
         OOYQ==
X-Gm-Message-State: AOUpUlEIfZWK5+QeO4QUAbiNDLQjO270VsbudmVPV/zC4/yrsIHcBx0D
        c3AwTNSONyeqVQqDLEzc76NRt9pshoOvRf/MI54=
X-Google-Smtp-Source: AAOMgpeqtJMyLGAIt1RpBPZbkvmFNoPiw262nYfd8ie05L2nEj7tH6W+OkmMr6tRWnbqQkOdGsZxjgqukt5On4SW2Gg=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr15298592oia.154.1532934949289;
 Mon, 30 Jul 2018 00:15:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 00:15:48
 -0700 (PDT)
In-Reply-To: <20180726155656.14873-1-eduval@amazon.com>
References: <20180726155656.14873-1-eduval@amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Jul 2018 09:15:48 +0200
X-Google-Sender-Auth: gK4PVM63lcDgeKkg7k03fI_oxBo
Message-ID: <CAJZ5v0gFQebGMpS0jzJOi7Ft+C7JTTKyiKgDhNj39BrCuQdH1g@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/1] x86: tsc: avoid system instability in hibernation
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 5:56 PM, Eduardo Valentin <eduval@amazon.com> wrote:
> System instability are seen during resume from hibernation when system
> is under heavy CPU load. This is due to the lack of update of sched
> clock data,

Isn't that the actual bug?

> and the scheduler would then think that heavy CPU hog
> tasks need more time in CPU, causing the system to freeze
> during the unfreezing of tasks. For example, threaded irqs,
> and kernel processes servicing network interface may be delayed
> for several tens of seconds, causing the system to be unreachable.
>
> Situation like this can be reported by using lockup detectors
> such as workqueue lockup detectors:
>
> [root@ip-172-31-67-114 ec2-user]# echo disk > /sys/power/state
>
> Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
>  kernel:BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 57s!
>
> Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
>  kernel:BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 57s!
>
> Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
>  kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 57s!
>
> Message from syslogd@ip-172-31-67-114 at May  7 18:29:06 ...
>  kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 403s!
>
> The fix for this situation is to mark the sched clock as unstable
> as early as possible in the resume path, leaving it unstable
> for the duration of the resume process.

I would rather call it a workaround.

> This will force the
> scheduler to attempt to align the sched clock across CPUs using
> the delta with time of day, updating sched clock data. In a post
> hibernation event, we can then mark the sched clock as stable
> again, avoiding unnecessary syncs with time of day on systems
> in which TSC is reliable.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Eduardo Valentin <eduval@amazon.com>
> Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
> Cc: Rajvi Jingar <rajvi.jingar@intel.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> ---
>
> Hey,
>
> No changes from first attempt, no pressure on resending. The RESEND
> tag is just because I missed linux-pm in the first attempt.
>
> BR,
>
>  arch/x86/kernel/tsc.c       | 29 +++++++++++++++++++++++++++++
>  include/linux/sched/clock.h |  5 +++++
>  kernel/sched/clock.c        |  4 ++--
>  3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 8ea117f8142e..f197c9742fef 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -13,6 +13,7 @@
>  #include <linux/percpu.h>
>  #include <linux/timex.h>
>  #include <linux/static_key.h>
> +#include <linux/suspend.h>
>
>  #include <asm/hpet.h>
>  #include <asm/timer.h>
> @@ -1377,3 +1378,31 @@ unsigned long calibrate_delay_is_known(void)
>         return 0;
>  }
>  #endif
> +
> +static int tsc_pm_notifier(struct notifier_block *notifier,
> +                          unsigned long pm_event, void *unused)
> +{
> +       switch (pm_event) {
> +       case PM_HIBERNATION_PREPARE:
> +               clear_sched_clock_stable();
> +               break;

This is too early IMO.  This happens before hibernation starts, even
before the image is created.

> +       case PM_POST_HIBERNATION:
> +               /* Set back to the default */
> +               if (!check_tsc_unstable())
> +                       set_sched_clock_stable();
> +               break;
> +       }
> +
> +       return 0;
> +};

If anything like this is the way to go, which honestly I doubt, I
would prefer it to be done in hibernate() in the !in_suspend case.

But why does it only affect hibernation?  Do we do something extra for
system-wide suspend/resume that is not done for hibernation?
