Date: Tue, 20 Mar 2018 10:52:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Message-ID: <20180320095215.GB23359@kroah.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320094312.24081-3-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 09:43:08AM +0000, Dietmar Eggemann wrote:
> From: Quentin Perret <quentin.perret@arm.com>
> 
> The energy consumption of each CPU in the system is modeled with a list
> of values representing its dissipated power and compute capacity at each
> available Operating Performance Point (OPP). These values are derived
> from existing information in the kernel (currently used by the thermal
> subsystem) and don't require the introduction of new platform-specific
> tunables. The energy model is also provided with a simple representation
> of all frequency domains as cpumasks, hence enabling the scheduler to be
> aware of dependencies between CPUs. The data required to build the energy
> model is provided by the OPP library which enables an abstract view of
> the platform from the scheduler. The new data structures holding these
> models and the routines to populate them are stored in
> kernel/sched/energy.c.
> 
> For the sake of simplicity, it is assumed in the energy model that all
> CPUs in a frequency domain share the same micro-architecture. As long as
> this assumption is correct, the energy models of different CPUs belonging
> to the same frequency domain are equal. Hence, this commit builds only one
> energy model per frequency domain, and links all relevant CPUs to it in
> order to save time and memory. If needed for future hardware platforms,
> relaxing this assumption should imply relatively simple modifications in
> the code but a significantly higher algorithmic complexity.
> 
> As it appears that energy-aware scheduling really makes a difference on
> heterogeneous systems (e.g. big.LITTLE platforms), it is restricted to
> systems having:
> 
>    1. SD_ASYM_CPUCAPACITY flag set
>    2. Dynamic Voltage and Frequency Scaling (DVFS) is enabled
>    3. Available power estimates for the OPPs of all possible CPUs
> 
> Moreover, the scheduler is notified of the energy model availability
> using a static key in order to minimize the overhead on non-energy-aware
> systems.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> ---
> This patch depends on additional infrastructure being merged in the OPP
> core. As this infrastructure can also be useful for other clients, the
> related patches have been posted separately [1].
> 
> [1] https://marc.info/?l=linux-pm&m=151635516419249&w=2
> ---
>  include/linux/sched/energy.h |  31 +++++++
>  kernel/sched/Makefile        |   2 +-
>  kernel/sched/energy.c        | 190 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 222 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/sched/energy.h
>  create mode 100644 kernel/sched/energy.c
> 
> diff --git a/include/linux/sched/energy.h b/include/linux/sched/energy.h
> new file mode 100644
> index 000000000000..b4f43564ffe4
> --- /dev/null
> +++ b/include/linux/sched/energy.h
> @@ -0,0 +1,31 @@
> +#ifndef _LINUX_SCHED_ENERGY_H
> +#define _LINUX_SCHED_ENERGY_H

No copyright or license info?  Not good :(

> --- /dev/null
> +++ b/kernel/sched/energy.c
> @@ -0,0 +1,190 @@
> +/*
> + * Released under the GPLv2 only.
> + * SPDX-License-Identifier: GPL-2.0

Please read the documentation for the SPDX lines on how to do them
correctly.  Newer versions of checkpatch.pl will catch this, but that is
in linux-next for the moment.

And once you have the SPDX line, the "Released under..." line is not
needed.


> + *
> + * Energy-aware scheduling models
> + *
> + * Copyright (C) 2018, Arm Ltd.
> + * Written by: Quentin Perret, Arm Ltd.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.

This paragraph is not needed at all.

> + */
> +
> +#define pr_fmt(fmt) "sched-energy: " fmt
> +
> +#include <linux/sched/topology.h>
> +#include <linux/sched/energy.h>
> +#include <linux/pm_opp.h>
> +
> +#include "sched.h"
> +
> +DEFINE_STATIC_KEY_FALSE(sched_energy_present);
> +struct sched_energy_model ** __percpu energy_model;
> +
> +/*
> + * A copy of the cpumasks representing the frequency domains is kept private
> + * to the scheduler. They are stacked in a dynamically allocated linked list
> + * as we don't know how many frequency domains the system has.
> + */
> +LIST_HEAD(freq_domains);

global variable?  If so, please prefix it with something more unique
than "freq_".

> +#ifdef CONFIG_PM_OPP

#ifdefs go in .h files, not .c files, right?

thanks,

greg k-h
