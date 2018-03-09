Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932139AbeCIPGc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:06:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751122AbeCIPGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:06:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228BF205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 9 Mar 2018 12:06:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kim Phillips <kim.phillips@arm.com>,
        Jean Pihet <jean.pihet@linaro.org>
Cc: "Christian Hansen (chansen3)" <chansen3@cisco.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools arm64: Add libdw DWARF post unwind support
 for ARM64
Message-ID: <20180309150627.GB8347@kernel.org>
References: <A5E405FE-1BA3-46FC-9A43-CF19A4B369C5@cisco.com>
 <20180226142726.cd413c792d0782f77b60a23e@arm.com>
 <20180226174040.6998bd3c0a79b2f19c491e4d@arm.com>
 <9B701F46-6AEA-48D8-9103-71D35C83776D@cisco.com>
 <20180308211030.4ee4a0d6ff6dc5cda1b567d4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308211030.4ee4a0d6ff6dc5cda1b567d4@arm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 08, 2018 at 09:10:30PM -0600, Kim Phillips escreveu:
> Based on prior work:
> 
> https://lkml.org/lkml/2014/5/6/395

Thanks, looks good, applying.

Jean, is everything ok with you on this?

- Arnaldo
 
> and how other arches add libdw unwind support.  Includes support for
> running the unwind test, e.g., on a system with only elfutils' libdw
> 0.170, the test now runs, and successfully:
> 
> $ ./perf test unwind
> 56: Test dwarf unwind                                     : Ok
> 
> Reported-by: Christian Hansen <chansen3@cisco.com>
> Originally-by: Jean Pihet <jean.pihet@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  tools/perf/Makefile.config                 |  2 +-
>  tools/perf/arch/arm64/include/arch-tests.h | 12 ++++++
>  tools/perf/arch/arm64/tests/Build          |  3 ++
>  tools/perf/arch/arm64/tests/arch-tests.c   | 16 ++++++++
>  tools/perf/arch/arm64/util/Build           |  1 +
>  tools/perf/arch/arm64/util/unwind-libdw.c  | 60 ++++++++++++++++++++++++++++++
>  6 files changed, 93 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/arch/arm64/include/arch-tests.h
>  create mode 100644 tools/perf/arch/arm64/tests/arch-tests.c
>  create mode 100644 tools/perf/arch/arm64/util/unwind-libdw.c
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 89cb2a36b8ff..98ff73648b51 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -75,7 +75,7 @@ endif
>  # Disable it on all other architectures in case libdw unwind
>  # support is detected in system. Add supported architectures
>  # to the check.
> -ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm powerpc s390))
> +ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390))
>    NO_LIBDW_DWARF_UNWIND := 1
>  endif
>  
> diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
> new file mode 100644
> index 000000000000..90ec4c8cb880
> --- /dev/null
> +++ b/tools/perf/arch/arm64/include/arch-tests.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef ARCH_TESTS_H
> +#define ARCH_TESTS_H
> +
> +#ifdef HAVE_DWARF_UNWIND_SUPPORT
> +struct thread;
> +struct perf_sample;
> +#endif
> +
> +extern struct test arch_tests[];
> +
> +#endif
> diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
> index b30eff9bcc83..ca5630e73474 100644
> --- a/tools/perf/arch/arm64/tests/Build
> +++ b/tools/perf/arch/arm64/tests/Build
> @@ -1,2 +1,5 @@
>  libperf-y += regs_load.o
>  libperf-y += dwarf-unwind.o
> +
> +libperf-y += arch-tests.o
> +
> diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
> new file mode 100644
> index 000000000000..5b1543c98022
> --- /dev/null
> +++ b/tools/perf/arch/arm64/tests/arch-tests.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <string.h>
> +#include "tests/tests.h"
> +#include "arch-tests.h"
> +
> +struct test arch_tests[] = {
> +#ifdef HAVE_DWARF_UNWIND_SUPPORT
> +	{
> +		.desc = "DWARF unwind",
> +		.func = test__dwarf_unwind,
> +	},
> +#endif
> +	{
> +		.func = NULL,
> +	},
> +};
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index c0b8dfef98ba..68f8a8eb3ad0 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -2,6 +2,7 @@ libperf-y += header.o
>  libperf-y += sym-handling.o
>  libperf-$(CONFIG_DWARF)     += dwarf-regs.o
>  libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
> +libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>  
>  libperf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
>  			      ../../arm/util/auxtrace.o \
> diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/arch/arm64/util/unwind-libdw.c
> new file mode 100644
> index 000000000000..7623d85e77f3
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/unwind-libdw.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <elfutils/libdwfl.h>
> +#include "../../util/unwind-libdw.h"
> +#include "../../util/perf_regs.h"
> +#include "../../util/event.h"
> +
> +bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +{
> +	struct unwind_info *ui = arg;
> +	struct regs_dump *user_regs = &ui->sample->user_regs;
> +	Dwarf_Word dwarf_regs[PERF_REG_ARM64_MAX], dwarf_pc;
> +
> +#define REG(r) ({						\
> +	Dwarf_Word val = 0;					\
> +	perf_reg_value(&val, user_regs, PERF_REG_ARM64_##r);	\
> +	val;							\
> +})
> +
> +	dwarf_regs[0]  = REG(X0);
> +	dwarf_regs[1]  = REG(X1);
> +	dwarf_regs[2]  = REG(X2);
> +	dwarf_regs[3]  = REG(X3);
> +	dwarf_regs[4]  = REG(X4);
> +	dwarf_regs[5]  = REG(X5);
> +	dwarf_regs[6]  = REG(X6);
> +	dwarf_regs[7]  = REG(X7);
> +	dwarf_regs[8]  = REG(X8);
> +	dwarf_regs[9]  = REG(X9);
> +	dwarf_regs[10] = REG(X10);
> +	dwarf_regs[11] = REG(X11);
> +	dwarf_regs[12] = REG(X12);
> +	dwarf_regs[13] = REG(X13);
> +	dwarf_regs[14] = REG(X14);
> +	dwarf_regs[15] = REG(X15);
> +	dwarf_regs[16] = REG(X16);
> +	dwarf_regs[17] = REG(X17);
> +	dwarf_regs[18] = REG(X18);
> +	dwarf_regs[19] = REG(X19);
> +	dwarf_regs[20] = REG(X20);
> +	dwarf_regs[21] = REG(X21);
> +	dwarf_regs[22] = REG(X22);
> +	dwarf_regs[23] = REG(X23);
> +	dwarf_regs[24] = REG(X24);
> +	dwarf_regs[25] = REG(X25);
> +	dwarf_regs[26] = REG(X26);
> +	dwarf_regs[27] = REG(X27);
> +	dwarf_regs[28] = REG(X28);
> +	dwarf_regs[29] = REG(X29);
> +	dwarf_regs[30] = REG(LR);
> +	dwarf_regs[31] = REG(SP);
> +
> +	if (!dwfl_thread_state_registers(thread, 0, PERF_REG_ARM64_MAX,
> +					 dwarf_regs))
> +		return false;
> +
> +	dwarf_pc = REG(PC);
> +	dwfl_thread_state_register_pc(thread, dwarf_pc);
> +
> +	return true;
> +}
> -- 
> 2.16.2
