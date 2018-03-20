Date: Tue, 20 Mar 2018 10:49:32 +0100
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
Subject: Re: [RFC PATCH 6/6] drivers: base: arch_topology.c: Enable EAS for
 arm/arm64 platforms
Message-ID: <20180320094932.GA23359@kroah.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-7-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320094312.24081-7-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 09:43:12AM +0000, Dietmar Eggemann wrote:
> From: Quentin Perret <quentin.perret@arm.com>
> 
> Energy Aware Scheduling (EAS) has to be started from the arch code.

Ok, but:

> This commit enables it from the arch topology driver for arm/arm64
> systems, hence enabling a better support for Arm big.LITTLE and future
> DynamIQ architectures.

Why does this have to be in the driver core code just for those specific
types of cpus?



> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/base/arch_topology.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 52ec5174bcb1..e2206ea16538 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/sched/topology.h>
> +#include <linux/sched/energy.h>
>  
>  DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
>  
> @@ -204,6 +205,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>  		free_raw_capacity();
>  		pr_debug("cpu_capacity: parsing done\n");
>  		schedule_work(&parsing_done_work);
> +		init_sched_energy();

This is not arch-specific code only for arm.

Don't you have a ARM cpu bringup code somewhere?  Shouldn't this call be
in there?  It feels odd that this scheduler change is buried way down
here...

thanks,

greg k-h
