Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF225C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D298255DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNZYzsm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D298255DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbeFYI2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:28:05 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40674 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753274AbeFYI2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:28:03 -0400
Received: by mail-ot0-f195.google.com with SMTP id w9-v6so14133412otj.7;
        Mon, 25 Jun 2018 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2ixDhwYHQnqdP3egs3USYqM72inpAjpB/V6+/DH9gCc=;
        b=VNZYzsm9T+2zCqFBrVYG6XduEtaOOyHJhw3x/8TJxfvnOAqlk2/QT+OiB0KWHLFHl2
         njluDjjimHpiYlWPri+NeOKUAjrIeqgwypW+0v+vxAM5/oEMPWO9X4SL2nIHmeYk+XdW
         UWKvIbzm098a6dRFczSoCL85oWykPoKWyPgYnX6skGw0zZE7h/79+mHmaeO0EVJyr3jc
         jSfpmphHZP9eetQNgX8IiW13UpPvmwI2+RYC/xcPtvh1FVG/kPt+EiI6LAYfGmydlR2D
         8SalhG1u2BSN+yuyhsrzRReRwkLE9oET2sfIv5IimRp6piFAv1BpDPmBbNWdrT7JVfJz
         Wc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2ixDhwYHQnqdP3egs3USYqM72inpAjpB/V6+/DH9gCc=;
        b=jKVSvAVbwRWgGjv8N+YQVc4sf1h81lWkR+hOgMx7FOL+aY/iExGQFyMVDte8iHf7/l
         FPUi5uCpLwiarGHaYdkl+iMGgtXQFAKoBpYGlLGdnU9oGf7j8zLVN2N4PIoLLFB0v0Ra
         J5lakjlKhfsHFZh+eVvrTAj3OEqwO7c3qh5eACohpjz7bKcZlbfJXLEvmqpJZJMeKu0Y
         D+pwnf4p/6tEpxotj9oVHfiURvmAIbbubJ9THCSCfvdPIbPMKo8gguENSnV/Uxl7ehXf
         wNgY8idpPE7n+MvkDP+vjExbnRWqfZnPBSdYwunJ2ke4PKHekVNt0Xkr+bp6K2h5qlxB
         S5RA==
X-Gm-Message-State: APt69E2M7hv0WM/Ynh/xsURRbkwndNIuIj0G4OC0AYs9zcii6/28/9cC
        7JAkKqfedMSrfLOEbf+eljhhEW1Cnw7v9e4BkZk=
X-Google-Smtp-Source: AAOMgpeBGuTU7RDLJZrVijacjrGeNkh+vsvwMIayVCJSfyKlXcz3mXhBQp/jxEDKr4yFz2KrTRBD+E4Ohyvh8MdIQj8=
X-Received: by 2002:a9d:1012:: with SMTP id h18-v6mr6390219ote.364.1529915282925;
 Mon, 25 Jun 2018 01:28:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 01:28:02
 -0700 (PDT)
In-Reply-To: <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org> <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jun 2018 10:28:02 +0200
X-Google-Sender-Auth: 1uPCZwUVBwcRD1jDbv-pv4M6QQk
Message-ID: <CAJZ5v0h167FajNB7rvzaRSFcpLBWTj-MXUmN0vjXqSCpuM5m+Q@mail.gmail.com>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 10:23 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> Initially, the cpu_cooling device for ARM was changed by adding a new
>> policy inserting idle cycles. The intel_powerclamp driver does a
>> similar action.
>>
>> Instead of implementing idle injections privately in the cpu_cooling
>> device, move the idle injection code in a dedicated framework and give
>> the opportunity to other frameworks to make use of it.
>>
>> The framework relies on the smpboot kthreads which handles via its
>> main loop the common code for hotplugging and [un]parking.
>>
>> This code was previously tested with the cpu cooling device and went
>> through several iterations. It results now in split code and API
>> exported in the header file. It was tested with the cpu cooling device
>> with success.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Javi Merino <javi.merino@kernel.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Rui Zhang <rui.zhang@intel.com>
>> Cc: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
>> ---
>>
>> V9:
>>    - Unconditionnally reset the should_run flag for all kthreads
>>      belonging to the cpumask and remove the park() callback (Viresh Kumar)
>>    - Fix up the typos in the comments (Viresh Kumar)
>>
>> V8:
>>    - Rollback only what was modified
>>    - Add the park() callback to reset the should_run flag
>>
>> V7:
>>    - Replace count approach by htimer_forward and restart (Peter Zijlstra)
>>    - Wait for task inactive when stopping the idle injections
>>    - Changed the comments and description
>>
>> V6:
>>    - Move count to wake up function (Viresh Kumar)
>>    - Split atomic/non-atomic context to wake up tasks
>>    - Add the park callback to handle unplug/inject race
>>    - Replace atomic by READ_ONCE and WRITE_ONCE (Peter Zijlstra)
>>
>> V5:
>>    - Move init_completion in the init function (Viresh Kumar)
>>    - Increment task count in the wakeup function (Viresh Kumar)
>>    - Remove rollback at init time (Viresh Kumar)
>>
>> V4:
>>    - Wait for completion when stopping (Viresh Kumar)
>>    - Check init already done and rollback (Viresh Kumar)
>>
>> V3:
>>    - Fixed typos (Viresh Kumar)
>>    - Removed extra blank line (Viresh Kumar)
>>    - Added full stop (Viresh Kumar)
>>    - Fixed Return kerneldoc format (Viresh Kumar)
>>    - Fixed multiple kthreads initialization (Viresh Kumar)
>>    - Fixed rollbacking the actions in the unregister function (Viresh Kumar)
>>    - Make idle injection kthreads name hardcoded
>>    - Kthreads are created in the initcall process
>>
>>  V2: Fixed checkpatch warnings
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/powercap/Kconfig          |  10 ++
>>  drivers/powercap/Makefile         |   1 +
>>  drivers/powercap/idle_injection.c | 362 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/idle_injection.h    |  29 +++
>>  4 files changed, 402 insertions(+)
>>  create mode 100644 drivers/powercap/idle_injection.c
>>  create mode 100644 include/linux/idle_injection.h
>>
>> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
>> index 85727ef..a767ef2 100644
>> --- a/drivers/powercap/Kconfig
>> +++ b/drivers/powercap/Kconfig
>> @@ -29,4 +29,14 @@ config INTEL_RAPL
>>           controller, CPU core (Power Plance 0), graphics uncore (Power Plane
>>           1), etc.
>>
>> +config IDLE_INJECTION
>> +       bool "Idle injection framework"
>> +       depends on CPU_IDLE
>> +       default n
>> +       help
>> +         This enables support for the idle injection framework. It
>> +         provides a way to force idle periods on a set of specified
>> +         CPUs for power capping. Idle period can be injected
>> +         synchronously on a set of specified CPUs or alternatively
>> +         on a per CPU basis.
>>  endif
>> diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
>> index 0a21ef3..c3bbfee 100644
>> --- a/drivers/powercap/Makefile
>> +++ b/drivers/powercap/Makefile
>> @@ -1,2 +1,3 @@
>>  obj-$(CONFIG_POWERCAP) += powercap_sys.o
>>  obj-$(CONFIG_INTEL_RAPL) += intel_rapl.o
>> +obj-$(CONFIG_IDLE_INJECTION) += idle_injection.o
>> diff --git a/drivers/powercap/idle_injection.c b/drivers/powercap/idle_injection.c
>> new file mode 100644
>> index 0000000..50ce348
>> --- /dev/null
>> +++ b/drivers/powercap/idle_injection.c
>> @@ -0,0 +1,362 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2018 Linaro Limited
>> + *
>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + *
>> + * The idle injection framework proposes a way to force a cpu to enter
>> + * an idle state during a specified amount of time for a specified
>> + * period.
>> + *
>> + * It relies on the smpboot kthreads which handles, via its main loop,
>> + * the common code for hotplugging and [un]parking.
>> + *
>> + * At init time, all the kthreads are created.
>> + *
>> + * A cpumask is specified as parameter for the idle injection
>> + * registering function. The kthreads will be synchronized regarding
>> + * this cpumask.
>> + *
>> + * The idle + run duration is specified via the helpers and then the
>> + * idle injection can be started at this point.
>> + *
>> + * A kthread will call play_idle() with the specified idle duration
>> + * from above.
>> + *
>> + * A timer is set after waking up all the tasks, to the next idle
>> + * injection cycle.
>> + *
>> + * The task handling the timer interrupt will wakeup all the kthreads
>> + * belonging to the cpumask.
>> + *
>> + * Stopping the idle injection is synchronous, when the function
>> + * returns, there is the guarantee there is no more idle injection
>> + * kthread in activity.
>> + *
>> + * It is up to the user of this framework to provide a lock at an
>> + * upper level to prevent stupid things to happen, like starting while
>> + * we are unregistering.
>> + */
>
> The English above and elsewhere needs some polishing IMO, but I can
> take care of that. :-)
>
>> +#define pr_fmt(fmt) "ii_dev: " fmt
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/freezer.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/kthread.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/smpboot.h>
>> +
>> +#include <uapi/linux/sched/types.h>
>> +
>> +/**
>> + * struct idle_injection_thread - task on/off switch structure
>> + * @tsk: a pointer to a task_struct injecting the idle cycles
>> + * @should_run: a integer used as a boolean by the smpboot kthread API
>> + */
>> +struct idle_injection_thread {
>> +       struct task_struct *tsk;
>> +       int should_run;
>> +};

Besides, if you don't mind, I would shorten idle_injection_ prefix
everywhere to idle_inject_ which is shorter and carries the same
information IMO.
