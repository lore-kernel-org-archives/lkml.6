Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7347C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD656218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfBKMqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:46:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:44460 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfBKMqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:46:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 04:46:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="143268694"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2019 04:46:08 -0800
Received: from [10.125.252.196] (abudanko-mobl.ccr.corp.intel.com [10.125.252.196])
        by linux.intel.com (Postfix) with ESMTP id 538D75800C6;
        Mon, 11 Feb 2019 04:46:04 -0800 (PST)
Subject: Re: [PATCH v2 1/4] perf-security: document perf_events/Perf resource
 control
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jonatan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
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
References: <fd896eec-7833-f23a-ad2f-95005dca5fff@linux.intel.com>
 <a108c800-d6c1-fac1-b73b-e390e579e6ef@linux.intel.com>
 <alpine.DEB.2.21.1902102300210.8784@nanos.tec.linutronix.de>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <969b6ea5-a5bf-70b7-7031-38b07538f744@linux.intel.com>
Date:   Mon, 11 Feb 2019 15:46:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902102300210.8784@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.02.2019 1:34, Thomas Gleixner wrote:
> On Thu, 7 Feb 2019, Alexey Budankov wrote:
> 
> General note: Please stay in the 80 char limit for all of the text.

Yes, sure. [PATCH v2 4/4] implements wrapping at 72 columns.

> 
>> +The perf_events system call API [2]_ allocates file descriptors for every configured
>> +PMU event. Open file descriptors are a per-process accountable resource governed
>> +by the RLIMIT_NOFILE [11]_ limit (ulimit -n), which is usually derived from the login
>> +shell process. When configuring Perf collection for a long list of events on a
>> +large server system, this limit can be easily hit preventing required monitoring
>> +configuration.
> 
> I'd move this sentence into a different paragraph and keep those related to
> RLIMIT_NOFILE together.

Makes sense. Let's have these two paragraphs:

Open file descriptors
+++++++++++++++++++++

Memory allocation
+++++++++++++++++

> 
>> ... RLIMIT_NOFILE limit can be increased on per-user basis modifying
>> +content of the limits.conf file [12]_ on some systems.
> 
> On some systems?

Well, let's avoid this subtlety and have it like:

'RLIMIT_NOFILE limit can be increased on per-user basis 
 modifying content of the limits.conf file [12]_ .'

> 
>> Ordinarily, a Perf sampling session
>> +(perf record) requires an amount of open perf_event file descriptors that is not
>> +less than a number of monitored events multiplied by a number of monitored CPUs.
> 
>   s/a number of/the number of/

Accepted.

> 
> The ordinary use case is:
> 
>     perf CMD pile-of-events PROCESS
> 
> which does not specify the monitored CPUs at all. Then the number of file
> descriptors is NR_EVENTS * NR_ONLINE_CPUS.
> 
>> +An amount of memory available to user processes for capturing performance monitoring
> 
> The amount ...

Accepted.

> 
>> +data is governed by the perf_event_mlock_kb [2]_ setting. This perf_event specific
>> +resource setting defines overall per-cpu limits of memory allowed for mapping
>> +by the user processes to execute performance monitoring. The setting essentially
>> +extends the RLIMIT_MEMLOCK [11]_ limit, but only for memory regions mapped specially
> 
> s/specially/specifically/

Accepted.

> 
>> +for capturing monitored performance events and related data.
>> +
>> +For example, if a machine has eight cores and perf_event_mlock_kb limit is set
>> +to 516 KiB, then a user process is provided with 516 KiB * 8 = 4128 KiB of memory
>> +above the RLIMIT_MEMLOCK limit (ulimit -l) for perf_event mmap buffers. In particular,
>> +this means that, if the user wants to start two or more performance monitoring
>> +processes, the user is required to manually distribute available 4128 KiB between the
> 
> distribute the available

Accepted.

> 
>> +monitoring processes, for example, using the --mmap-pages Perf record mode option.
>> +Otherwise, the first started performance monitoring process allocates all available
>> +4128 KiB and the other processes will fail to proceed due to the lack of memory.
>> +
>> +RLIMIT_MEMLOCK and perf_event_mlock_kb resource costraints are ignored for
> 
> constraints.

Accepted.

> 
>> +processes with the CAP_IPC_LOCK capability. Thus, perf_events/Perf privileged users
> 
> what means perf_events/Perf ?

'perf_events/Perf privileged users' refers to the paragraph about privileged users.
'perf_events/Perf' means exact combination of the kernel subsystem (perf_events) and 
the privileged Perf tool (Perf) executable that enables certain group of users with
performance monitoring capabilities without scope limit.

> 
>> +can be provided with memory above the constraints for perf_events/Perf performance
>> +monitoring purpose by providing the Perf executable with CAP_IPC_LOCK capability.
> 
> Thanks,
> 
> 	tglx
> 

Thanks,
Alexey
