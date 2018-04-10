Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeDJSPq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:15:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41589 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeDJSPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:15:43 -0400
X-Google-Smtp-Source: AIpwx49/zlFfgPGx/c5Q6yj7535K+NkleARdxovX5r0aBGqSxD8vgO1w+kMNi9mncQQJiM7nZFmWc8yqQEBnbYYgNBA=
MIME-Version: 1.0
In-Reply-To: <20180409070710.GA3844@andestech.com>
References: <1522051075-6442-2-git-send-email-alankao@andestech.com>
 <mhng-c22f4be6-e89e-42b6-a776-bf4e035c10d4@palmer-si-x1c4> <20180409070710.GA3844@andestech.com>
From: Alex Solomatnikov <sols@sifive.com>
Date: Tue, 10 Apr 2018 11:15:41 -0700
Message-ID: <CAJ2AOiNcqpenYd74LSwa++X_1G_JbgqrJ=YiUpofEof1BWGgrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf: riscv: preliminary RISC-V support
To: Alan Kao <alankao@andestech.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Hu <nickhu@andestech.com>, Greentime Hu <greentime@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I merged SBI emulation for perf counters and config:
https://github.com/riscv/riscv-pk/pull/98

You should be able to write these CSRs.

Thanks,
Alex

On Mon, Apr 9, 2018 at 12:07 AM, Alan Kao <alankao@andestech.com> wrote:
> On Thu, Apr 05, 2018 at 09:47:50AM -0700, Palmer Dabbelt wrote:
>> On Mon, 26 Mar 2018 00:57:54 PDT (-0700), alankao@andestech.com wrote:
>> >This patch provide a basic PMU, riscv_base_pmu, which supports two
>> >general hardware event, instructions and cycles.  Furthermore, this
>> >PMU serves as a reference implementation to ease the portings in
>> >the future.
>> >
>> >riscv_base_pmu should be able to run on any RISC-V machine that
>> >conforms to the Priv-Spec.  Note that the latest qemu model hasn't
>> >fully support a proper behavior of Priv-Spec 1.10 yet, but work
>> >around should be easy with very small fixes.  Please check
>> >https://github.com/riscv/riscv-qemu/pull/115 for future updates.
>> >
>> >Cc: Nick Hu <nickhu@andestech.com>
>> >Cc: Greentime Hu <greentime@andestech.com>
>> >Signed-off-by: Alan Kao <alankao@andestech.com>
>>
>> We should really be able to detect PMU types at runtime (via a device tree
>> entry) rather than requiring that a single PMU is built in to the kernel.
>> This will require a handful of modifications to how this patch works, which
>> I'll try to list below.
>
>> >+menu "PMU type"
>> >+    depends on PERF_EVENTS
>> >+
>> >+config RISCV_BASE_PMU
>> >+    bool "Base Performance Monitoring Unit"
>> >+    def_bool y
>> >+    help
>> >+      A base PMU that serves as a reference implementation and has limited
>> >+      feature of perf.
>> >+
>> >+endmenu
>> >+
>>
>> Rather than a menu where a single PMU can be selected, there should be
>> options to enable or disable support for each PMU type -- this is just like
>> how all our other drivers work.
>>
>
> I see.  Sure.  The descriptions and implementation will be refined in v3.
>
>> >+struct pmu * __weak __init riscv_init_platform_pmu(void)
>> >+{
>> >+    riscv_pmu = &riscv_base_pmu;
>> >+    return riscv_pmu->pmu;
>> >+}
>>
>> Rather than relying on a weak symbol that gets overridden by other PMU
>> types, this should look through the device tree for a compatible PMU (in the
>> case of just the base PMU it could be any RISC-V hart) and install a PMU
>> handler for it.  There'd probably be some sort of priority scheme here, like
>> there are for other driver subsystems, where we'd pick the best PMU driver
>> that's compatible with the PMUs on every hart.
>>
>> >+
>> >+int __init init_hw_perf_events(void)
>> >+{
>> >+    struct pmu *pmu = riscv_init_platform_pmu();
>> >+
>> >+    perf_irq = NULL;
>> >+    perf_pmu_register(pmu, "cpu", PERF_TYPE_RAW);
>> >+    return 0;
>> >+}
>> >+arch_initcall(init_hw_perf_events);
>>
>> Since we only have a single PMU type right now this isn't critical to handle
>> right away, but we will have to refactor this before adding another PMU.
>
> I see.  My rough plan is to do the device tree parsing here, and if no specific
> PMU string is found then just register the base PMU proposed in this patch.
> How about this idea?
>
> Thanks.
