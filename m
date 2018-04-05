Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeDEFJu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 01:09:50 -0400
Received: from exmail.andestech.com ([59.124.169.137]:61089 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeDEFJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 01:09:49 -0400
Date: Thu, 5 Apr 2018 13:09:39 +0800
From: Alan Kao <alankao@andestech.com>
To: Alex Solomatnikov <sols@sifive.com>
CC: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, "Namhyung Kim" <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-riscv@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>, Greentime Hu <greentime@andestech.com>
Subject: Re: [PATCH v2 2/2] perf: riscv: Add Document for Future Porting Guide
Message-ID: <20180405050938.GB24451@andestech.com>
References: <1522672284-29593-1-git-send-email-alankao@andestech.com>
 <1522672284-29593-3-git-send-email-alankao@andestech.com>
 <CAJ2AOiM34QyHPZkpz3DEpkyWB2TJ-gK9qPM3rKc2dNDQXCRXiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ2AOiM34QyHPZkpz3DEpkyWB2TJ-gK9qPM3rKc2dNDQXCRXiw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w3554N20028533
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Tue, Apr 03, 2018 at 07:08:43PM -0700, Alex Solomatnikov wrote:
> Doc fixes:
> 
>

Thanks for these fixes.  I'll edit this patch and send a v3 once I am done
with the PMU patch.

I suppose a "Reviewed-by: Alex Solomatnikov" appending at the end of the
commit will be great, right?

Alan

> diff --git a/Documentation/riscv/pmu.txt b/Documentation/riscv/pmu.txt
> index a3e930e..ae90a5e 100644
> --- a/Documentation/riscv/pmu.txt
> +++ b/Documentation/riscv/pmu.txt
> @@ -20,7 +20,7 @@ the lack of the following general architectural
> performance monitoring features:
>  * Enabling/Disabling counters
>    Counters are just free-running all the time in our case.
>  * Interrupt caused by counter overflow
> -  No such design in the spec.
> +  No such feature in the spec.
>  * Interrupt indicator
>    It is not possible to have many interrupt ports for all counters, so an
>    interrupt indicator is required for software to tell which counter has
> @@ -159,14 +159,14 @@ interrupt for perf, so the details are to be
> completed in the future.
> 
>  They seem symmetric but perf treats them quite differently.  For reading, there
>  is a *read* interface in *struct pmu*, but it serves more than just reading.
> -According to the context, the *read* function not only read the content of the
> -counter (event->count), but also update the left period to the next interrupt
> +According to the context, the *read* function not only reads the content of the
> +counter (event->count), but also updates the left period for the next interrupt
>  (event->hw.period_left).
> 
>  But the core of perf does not need direct write to counters.  Writing counters
> -hides behind the abstraction of 1) *pmu->start*, literally start
> counting so one
> +is hidden behind the abstraction of 1) *pmu->start*, literally start
> counting so one
>  has to set the counter to a good value for the next interrupt; 2)
> inside the IRQ
> -it should set the counter with the same reason.
> +it should set the counter to the same reasonable value.
> 
>  Reading is not a problem in RISC-V but writing would need some effort, since
>  counters are not allowed to be written by S-mode.
> @@ -190,37 +190,37 @@ Three states (event->hw.state) are defined:
>  A normal flow of these state transitions are as follows:
> 
>  * A user launches a perf event, resulting in calling to *event_init*.
> -* When being context-switched in, *add* is called by the perf core, with flag
> -  PERF_EF_START, which mean that the event should be started after it is added.
> -  In this stage, an general event is binded to a physical counter, if any.
> +* When being context-switched in, *add* is called by the perf core, with a flag
> +  PERF_EF_START, which means that the event should be started after
> it is added.
> +  At this stage, a general event is bound to a physical counter, if any.
>    The state changes to PERF_HES_STOPPED and PERF_HES_UPTODATE,
> because it is now
>    stopped, and the (software) event count does not need updating.
>  ** *start* is then called, and the counter is enabled.
> -   With flag PERF_EF_RELOAD, it write the counter to an appropriate
> value (check
> -   previous section for detail).
> -   No writing is made if the flag does not contain PERF_EF_RELOAD.
> -   The state now is reset to none, because it is neither stopped nor update
> -   (the counting already starts)
> -* When being context-switched out, *del* is called.  It then checkout all the
> -  events in the PMU and call *stop* to update their counts.
> +   With flag PERF_EF_RELOAD, it writes an appropriate value to the
> counter (check
> +   the previous section for details).
> +   Nothing is written if the flag does not contain PERF_EF_RELOAD.
> +   The state now is reset to none, because it is neither stopped nor updated
> +   (the counting already started)
> +* When being context-switched out, *del* is called.  It then checks out all the
> +  events in the PMU and calls *stop* to update their counts.
>  ** *stop* is called by *del*
>     and the perf core with flag PERF_EF_UPDATE, and it often shares the same
>     subroutine as *read* with the same logic.
>     The state changes to PERF_HES_STOPPED and PERF_HES_UPTODATE, again.
> 
> -** Life cycles of these two pairs: *add* and *del* are called repeatedly as
> +** Life cycle of these two pairs: *add* and *del* are called repeatedly as
>    tasks switch in-and-out; *start* and *stop* is also called when the perf core
>    needs a quick stop-and-start, for instance, when the interrupt
> period is being
>    adjusted.
> 
> -Current implementation is sufficient for now and can be easily extend to
> +Current implementation is sufficient for now and can be easily
> extended with new
>  features in the future.
> 
>  A. Related Structures
>  ---------------------
> 
> -* struct pmu: include/linux/perf_events.h
> -* struct riscv_pmu: arch/riscv/include/asm/perf_events.h
> +* struct pmu: include/linux/perf_event.h
> +* struct riscv_pmu: arch/riscv/include/asm/perf_event.h
> 
>    Both structures are designed to be read-only.
> 
> @@ -231,13 +231,13 @@ perf's internal state machine (check
> kernel/events/core.c for details).
>    *struct riscv_pmu* defines PMU-specific parameters.  The naming follows the
>  convention of all other architectures.
> 
> -* struct perf_event: include/linux/perf_events.h
> +* struct perf_event: include/linux/perf_event.h
>  * struct hw_perf_event
> 
>    The generic structure that represents perf events, and the hardware-related
>  details.
> 
> -* struct riscv_hw_events: arch/riscv/include/asm/perf_events.h
> +* struct riscv_hw_events: arch/riscv/include/asm/perf_event.h
> 
>    The structure that holds the status of events, has two fixed members:
>  the number of events and the array of the events.
> 
> 
