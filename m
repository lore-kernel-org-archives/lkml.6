Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeDIHHU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:07:20 -0400
Received: from exmail.andestech.com ([59.124.169.137]:27704 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDIHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:07:19 -0400
Date: Mon, 9 Apr 2018 15:07:11 +0800
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>
CC: <albert@sifive.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <sols@sifive.com>,
        <corbet@lwn.net>, <linux-riscv@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nickhu@andestech.com>, <greentime@andestech.com>
Subject: Re: [PATCH 1/2] perf: riscv: preliminary RISC-V support
Message-ID: <20180409070710.GA3844@andestech.com>
References: <1522051075-6442-2-git-send-email-alankao@andestech.com>
 <mhng-c22f4be6-e89e-42b6-a776-bf4e035c10d4@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-c22f4be6-e89e-42b6-a776-bf4e035c10d4@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w3971XTH047779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 09:47:50AM -0700, Palmer Dabbelt wrote:
> On Mon, 26 Mar 2018 00:57:54 PDT (-0700), alankao@andestech.com wrote:
> >This patch provide a basic PMU, riscv_base_pmu, which supports two
> >general hardware event, instructions and cycles.  Furthermore, this
> >PMU serves as a reference implementation to ease the portings in
> >the future.
> >
> >riscv_base_pmu should be able to run on any RISC-V machine that
> >conforms to the Priv-Spec.  Note that the latest qemu model hasn't
> >fully support a proper behavior of Priv-Spec 1.10 yet, but work
> >around should be easy with very small fixes.  Please check
> >https://github.com/riscv/riscv-qemu/pull/115 for future updates.
> >
> >Cc: Nick Hu <nickhu@andestech.com>
> >Cc: Greentime Hu <greentime@andestech.com>
> >Signed-off-by: Alan Kao <alankao@andestech.com>
> 
> We should really be able to detect PMU types at runtime (via a device tree
> entry) rather than requiring that a single PMU is built in to the kernel.
> This will require a handful of modifications to how this patch works, which
> I'll try to list below.

> >+menu "PMU type"
> >+	depends on PERF_EVENTS
> >+
> >+config RISCV_BASE_PMU
> >+	bool "Base Performance Monitoring Unit"
> >+	def_bool y
> >+	help
> >+	  A base PMU that serves as a reference implementation and has limited
> >+	  feature of perf.
> >+
> >+endmenu
> >+
> 
> Rather than a menu where a single PMU can be selected, there should be
> options to enable or disable support for each PMU type -- this is just like
> how all our other drivers work.
> 

I see.  Sure.  The descriptions and implementation will be refined in v3.

> >+struct pmu * __weak __init riscv_init_platform_pmu(void)
> >+{
> >+	riscv_pmu = &riscv_base_pmu;
> >+	return riscv_pmu->pmu;
> >+}
> 
> Rather than relying on a weak symbol that gets overridden by other PMU
> types, this should look through the device tree for a compatible PMU (in the
> case of just the base PMU it could be any RISC-V hart) and install a PMU
> handler for it.  There'd probably be some sort of priority scheme here, like
> there are for other driver subsystems, where we'd pick the best PMU driver
> that's compatible with the PMUs on every hart.
> 
> >+
> >+int __init init_hw_perf_events(void)
> >+{
> >+	struct pmu *pmu = riscv_init_platform_pmu();
> >+
> >+	perf_irq = NULL;
> >+	perf_pmu_register(pmu, "cpu", PERF_TYPE_RAW);
> >+	return 0;
> >+}
> >+arch_initcall(init_hw_perf_events);
> 
> Since we only have a single PMU type right now this isn't critical to handle
> right away, but we will have to refactor this before adding another PMU.

I see.  My rough plan is to do the device tree parsing here, and if no specific
PMU string is found then just register the base PMU proposed in this patch.
How about this idea?

Thanks.
