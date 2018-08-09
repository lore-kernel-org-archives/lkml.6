Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226C6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C736022392
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C736022392
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeHJAVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:21:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60800 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeHJAVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:21:22 -0400
Received: from 79.184.254.16.ipv4.supernova.orange.pl (79.184.254.16) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id f48a915c3216af44; Thu, 9 Aug 2018 23:54:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v5 03/14] PM: Introduce an Energy Model management framework
Date:   Thu, 09 Aug 2018 23:52:29 +0200
Message-ID: <1598998.9rBByrtVSM@aspire.rjw.lan>
In-Reply-To: <20180724122521.22109-4-quentin.perret@arm.com>
References: <20180724122521.22109-1-quentin.perret@arm.com> <20180724122521.22109-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 24, 2018 2:25:10 PM CEST Quentin Perret wrote:
> Several subsystems in the kernel (task scheduler and/or thermal at the
> time of writing) can benefit from knowing about the energy consumed by
> CPUs. Yet, this information can come from different sources (DT or
> firmware for example), in different formats, hence making it hard to
> exploit without a standard API.
> 
> As an attempt to address this, introduce a centralized Energy Model
> (EM) management framework which aggregates the power values provided
> by drivers into a table for each frequency domain in the system. The
> power cost tables are made available to interested clients (e.g. task
> scheduler or thermal) via platform-agnostic APIs. The overall design
> is represented by the diagram below (focused on Arm-related drivers as
> an example, but applicable to any architecture):
> 
>      +---------------+  +-----------------+  +-------------+
>      | Thermal (IPA) |  | Scheduler (EAS) |  |    Other    |
>      +---------------+  +-----------------+  +-------------+
>              |                 | em_fd_energy()     |
>              |                 | em_cpu_get()       |
>              +-----------+     |         +----------+
>                          |     |         |
>                          v     v         v
>                       +---------------------+
>                       |                     |
>                       |    Energy Model     |
>                       |                     |
>                       |     Framework       |
>                       |                     |
>                       +---------------------+
>                          ^       ^       ^
>                          |       |       | em_register_freq_domain()
>               +----------+       |       +---------+
>               |                  |                 |
>       +---------------+  +---------------+  +--------------+
>       |  cpufreq-dt   |  |   arm_scmi    |  |    Other     |
>       +---------------+  +---------------+  +--------------+
>               ^                  ^                 ^
>               |                  |                 |
>       +--------------+   +---------------+  +--------------+
>       | Device Tree  |   |   Firmware    |  |      ?       |
>       +--------------+   +---------------+  +--------------+
> 
> Drivers (typically, but not limited to, CPUFreq drivers) can register
> data in the EM framework using the em_register_freq_domain() API. The
> calling driver must provide a callback function with a standardized
> signature that will be used by the EM framework to build the power
> cost tables of the frequency domain. This design should offer a lot of
> flexibility to calling drivers which are free of reading information
> from any location and to use any technique to compute power costs.
> Moreover, the capacity states registered by drivers in the EM framework
> are not required to match real performance states of the target. This
> is particularly important on targets where the performance states are
> not known by the OS.
> 
> On the client side, the EM framework offers APIs to access the power
> cost tables of a CPU (em_cpu_get()), and to estimate the energy
> consumed by the CPUs of a frequency domain (em_fd_energy()). Clients
> such as the task scheduler can then use these APIs to access the shared
> data structures holding the Energy Model of CPUs.

I'm a bit concerned that the code here appears to be designed around the
frequency domains concept which seems to be a limitation and which probably
is related to the properties of the current generation of hardware.

Assumptions like that tend to get tangled into the code tightly over time
and they may be hard to untangle from it when new use cases arise later.

For example, there probably will be more firmware involvement in future
systems and the firmware may not be willing to expose "raw" frequency
domains to the OS.  That already is the case with P-states on Intel HW and
with ACPI CPPC in general.

IMO, frequency domains in your current code could be replaced with something
more general, like "performance domains" providing the scheduler with the
(relative) cost of running a task on a busy (non-idle) CPU (and, analogously,
"idle domains" that would provide the scheduler with the - relative - cost
of waking up an idle CPU to run a task on it or, the other way around, the
possible relative gain from taking all tasks away from a CPU in order to make
it go idle).

Also bear in mind that the CPUs the scheduler deals with are logical ones,
so they may be like hardware threads within a single core, for example.

Thanks,
Rafael

