Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4864AC282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212A0214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBJWeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 17:34:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37466 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfBJWeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 17:34:46 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gsxg6-0001iM-KO; Sun, 10 Feb 2019 23:34:22 +0100
Date:   Sun, 10 Feb 2019 23:34:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
cc:     Jonatan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] perf-security: document perf_events/Perf resource
 control
In-Reply-To: <a108c800-d6c1-fac1-b73b-e390e579e6ef@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1902102300210.8784@nanos.tec.linutronix.de>
References: <fd896eec-7833-f23a-ad2f-95005dca5fff@linux.intel.com> <a108c800-d6c1-fac1-b73b-e390e579e6ef@linux.intel.com>
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

On Thu, 7 Feb 2019, Alexey Budankov wrote:

General note: Please stay in the 80 char limit for all of the text.

> +The perf_events system call API [2]_ allocates file descriptors for every configured
> +PMU event. Open file descriptors are a per-process accountable resource governed
> +by the RLIMIT_NOFILE [11]_ limit (ulimit -n), which is usually derived from the login
> +shell process. When configuring Perf collection for a long list of events on a
> +large server system, this limit can be easily hit preventing required monitoring
> +configuration.

I'd move this sentence into a different paragraph and keep those related to
RLIMIT_NOFILE together.

> ... RLIMIT_NOFILE limit can be increased on per-user basis modifying
> +content of the limits.conf file [12]_ on some systems.

On some systems?

> Ordinarily, a Perf sampling session
> +(perf record) requires an amount of open perf_event file descriptors that is not
> +less than a number of monitored events multiplied by a number of monitored CPUs.

  s/a number of/the number of/

The ordinary use case is:

    perf CMD pile-of-events PROCESS

which does not specify the monitored CPUs at all. Then the number of file
descriptors is NR_EVENTS * NR_ONLINE_CPUS.

> +An amount of memory available to user processes for capturing performance monitoring

The amount ...

> +data is governed by the perf_event_mlock_kb [2]_ setting. This perf_event specific
> +resource setting defines overall per-cpu limits of memory allowed for mapping
> +by the user processes to execute performance monitoring. The setting essentially
> +extends the RLIMIT_MEMLOCK [11]_ limit, but only for memory regions mapped specially

s/specially/specifically/

> +for capturing monitored performance events and related data.
> +
> +For example, if a machine has eight cores and perf_event_mlock_kb limit is set
> +to 516 KiB, then a user process is provided with 516 KiB * 8 = 4128 KiB of memory
> +above the RLIMIT_MEMLOCK limit (ulimit -l) for perf_event mmap buffers. In particular,
> +this means that, if the user wants to start two or more performance monitoring
> +processes, the user is required to manually distribute available 4128 KiB between the

distribute the available

> +monitoring processes, for example, using the --mmap-pages Perf record mode option.
> +Otherwise, the first started performance monitoring process allocates all available
> +4128 KiB and the other processes will fail to proceed due to the lack of memory.
> +
> +RLIMIT_MEMLOCK and perf_event_mlock_kb resource costraints are ignored for

constraints.

> +processes with the CAP_IPC_LOCK capability. Thus, perf_events/Perf privileged users

what means perf_events/Perf ?

> +can be provided with memory above the constraints for perf_events/Perf performance
> +monitoring purpose by providing the Perf executable with CAP_IPC_LOCK capability.

Thanks,

	tglx
