Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527025151; cv=none;
        d=google.com; s=arc-20160816;
        b=dhaxPm0jMv9988CCeNvSJJ4yOuXDtoccGK2GZS2O2j6CssUlt5a8LVPg159o164NH3
         Msoz7I1NLYZUkvqFqXYysOEcy0eWjT/xsW9+b2eJF26m2vYHzUAclJSaCRV7+BQcoyPJ
         HWntmSc0cK231fVrFyXfRXQZbpT1cNiJCGW0oegkF5T1sD3Kj/OzIK0rRcO2swvZm7kM
         T1zwBWLSkOMjQ3aUaidDep83o8jnhG0v4MNlbO5A1DXI44Kt8N8cdEt+eGigV7eaqqbX
         NkfFJiCwJmD4UacFq27qoJYieSHZJR8p2pY1XyclNMoAqhc/339oAPgGwmfNqCwRI7yi
         fQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=pGCW/lt5aitJ/kizw70NfMSdQdJNCv2BKMSSc3qX/Ko=;
        b=LRULykvUoeICvsrPmIAw2bJdVF5vCI1dKn/yDmLfMU84622gJ6969knYcuulNNwffu
         DFTqmXZ+SDDmqEq9MuWcyQRY67zKu0sREDmLZo0iEWarGRMrqZwK8ZghF40ik3BXA8zX
         AUp18r2qK0kWz9sjDyX5bT1Xhy5qck5CxyqsqKCa9eiTTJhCpFAvXcQalufZYFppb/Y4
         5u4hdmbusq5/DzX6aRkpvQ0+n+GYXReWplEapcQWZ+PSmmnGXJq/HSHomRn/6sLtWHLU
         cVLBXPpd7NkOFuVBAqug1cv2kzMNK5DCvrLIzcK3eHFptZGr/+jjoSKmdOclXQhDpqJG
         /pcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=g3Fgjr0I;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=g3Fgjr0I;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZp8rZCX+v1Slih2LAx1Sz2Qv7zU2XXLfRqfDiSLT1lMsfHUh7jWZnXAZUtgbILM6IOgwVVDcw==
Date: Tue, 22 May 2018 15:39:06 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] coresight: allow to build as modules
Message-ID: <20180522213906.GC25658@xps15>
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
 <20180518012024.22645-6-kim.phillips@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518012024.22645-6-kim.phillips@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600762906689593651?=
X-GMAIL-MSGID: =?utf-8?q?1601201924810172705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 08:20:24PM -0500, Kim Phillips wrote:
> Allow to build coresight as modules.  This greatly enhances developer
> efficiency by allowing the development to take place exclusively on the
> target, and without needing to reboot in between changes.
> 
> - Kconfig bools become tristates, to allow =m
> 
> - use -objs to denote merge object directives in Makefile, adds a
>   coresight-core nomenclature for the base module.
> 
> - Export core functions so as to be able to be used by
>   non-core modules.
> 
> - add a coresight_exit() that unregisters the coresight bus, add
>   remove fns for most others.
> 
> - fix up modules with ID tables for autoloading on boot
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  drivers/hwtracing/coresight/Kconfig           | 48 +++++++++++++++----
>  drivers/hwtracing/coresight/Makefile          | 28 +++++++----
>  .../hwtracing/coresight/coresight-cpu-debug.c |  2 +
>  .../coresight/coresight-dynamic-replicator.c  | 26 ++++++++--
>  drivers/hwtracing/coresight/coresight-etb10.c | 27 +++++++++--
>  .../hwtracing/coresight/coresight-etm-perf.c  |  9 +++-
>  .../coresight/coresight-etm3x-sysfs.c         |  1 +
>  drivers/hwtracing/coresight/coresight-etm3x.c | 32 +++++++++++--
>  .../coresight/coresight-etm4x-sysfs.c         |  1 +
>  drivers/hwtracing/coresight/coresight-etm4x.c | 33 +++++++++++--
>  .../hwtracing/coresight/coresight-funnel.c    | 26 ++++++++--
>  drivers/hwtracing/coresight/coresight-priv.h  |  1 -
>  .../coresight/coresight-replicator.c          | 28 +++++++++--
>  drivers/hwtracing/coresight/coresight-stm.c   | 23 ++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.c   | 18 ++++++-
>  drivers/hwtracing/coresight/coresight-tpiu.c  | 26 ++++++++--
>  drivers/hwtracing/coresight/coresight.c       | 14 ++++++
>  17 files changed, 299 insertions(+), 44 deletions(-)

For the next revision please split the work based on files.

> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index f9abdef5b0d9..4512885f7a3e 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -2,7 +2,7 @@
>  # Coresight configuration
>  #
>  menuconfig CORESIGHT
> -	bool "CoreSight Tracing Support"
> +	tristate "CoreSight Tracing Support"
>  	select ARM_AMBA
>  	select PERF_EVENTS
>  	help
> @@ -12,17 +12,23 @@ menuconfig CORESIGHT
>  	  specification and configure the right series of components when a
>  	  trace source gets enabled.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-core.
> +
>  if CORESIGHT
>  config CORESIGHT_LINKS_AND_SINKS
> -	bool "CoreSight Link and Sink drivers"
> +	tristate "CoreSight Link and Sink drivers"
>  	help
>  	  This enables support for CoreSight link and sink drivers that are
>  	  responsible for transporting and collecting the trace data
>  	  respectively.  Link and sinks are dynamically aggregated with a trace
>  	  entity at run time to form a complete trace path.
>  
> +	  To compile this code as modules, choose M here: the
> +	  modules will be called coresight-funnel and coresight-replicator.
> +
>  config CORESIGHT_LINK_AND_SINK_TMC
> -	bool "Coresight generic TMC driver"
> +	tristate "Coresight generic TMC driver"
>  	help
>  	  This enables support for the Trace Memory Controller driver.
>  	  Depending on its configuration the device can act as a link (embedded
> @@ -30,8 +36,11 @@ config CORESIGHT_LINK_AND_SINK_TMC
>  	  complies with the generic implementation of the component without
>  	  special enhancement or added features.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-tmc-core.
> +
>  config CORESIGHT_SINK_TPIU
> -	bool "Coresight generic TPIU driver"
> +	tristate "Coresight generic TPIU driver"
>  	help
>  	  This enables support for the Trace Port Interface Unit driver,
>  	  responsible for bridging the gap between the on-chip coresight
> @@ -40,15 +49,21 @@ config CORESIGHT_SINK_TPIU
>  	  connected to an external host for use case capturing more traces than
>  	  the on-board coresight memory can handle.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-tpiu.
> +
>  config CORESIGHT_SINK_ETBV10
> -	bool "Coresight ETBv1.0 driver"
> +	tristate "Coresight ETBv1.0 driver"
>  	help
>  	  This enables support for the Embedded Trace Buffer version 1.0 driver
>  	  that complies with the generic implementation of the component without
>  	  special enhancement or added features.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-etb10.
> +
>  config CORESIGHT_SOURCE_ETM3X
> -	bool "CoreSight Embedded Trace Macrocell 3.x driver"
> +	tristate "CoreSight Embedded Trace Macrocell 3.x driver"
>  	depends on !ARM64
>  	help
>  	  This driver provides support for processor ETM3.x and PTM1.x modules,
> @@ -56,8 +71,11 @@ config CORESIGHT_SOURCE_ETM3X
>  	  This is primarily useful for instruction level tracing.  Depending
>  	  the ETM version data tracing may also be available.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-etm3x-core.
> +
>  config CORESIGHT_SOURCE_ETM4X
> -	bool "CoreSight Embedded Trace Macrocell 4.x driver"
> +	tristate "CoreSight Embedded Trace Macrocell 4.x driver"
>  	depends on ARM64
>  	help
>  	  This driver provides support for the ETM4.x tracer module, tracing the
> @@ -65,15 +83,21 @@ config CORESIGHT_SOURCE_ETM4X
>  	  for instruction level tracing. Depending on the implemented version
>  	  data tracing may also be available.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-etm4x-core.
> +
>  config CORESIGHT_DYNAMIC_REPLICATOR
> -	bool "CoreSight Programmable Replicator driver"
> +	tristate "CoreSight Programmable Replicator driver"
>  	help
>  	  This enables support for dynamic CoreSight replicator link driver.
>  	  The programmable ATB replicator allows independent filtering of the
>  	  trace data based on the traceid.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-dynamic-replicator.
> +
>  config CORESIGHT_STM
> -	bool "CoreSight System Trace Macrocell driver"
> +	tristate "CoreSight System Trace Macrocell driver"
>  	depends on STM && ((ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64)
>  	help
>  	  This driver provides support for hardware assisted software
> @@ -81,6 +105,9 @@ config CORESIGHT_STM
>  	  logging useful software events or data coming from various entities
>  	  in the system, possibly running different OSs
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-stm.
> +
>  config CORESIGHT_CPU_DEBUG
>  	tristate "CoreSight CPU Debug driver"
>  	depends on ARM || ARM64
> @@ -95,4 +122,7 @@ config CORESIGHT_CPU_DEBUG
>  	  properly, please refer Documentation/trace/coresight-cpu-debug.txt
>  	  for detailed description and the example for usage.
>  
> +	  To compile this code as a module, choose M here: the
> +	  module will be called coresight-cpu-debug.
> +
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 61db9dd0d571..5990710289c2 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -2,19 +2,29 @@
>  #
>  # Makefile for CoreSight drivers.
>  #
> -obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o
> -obj-$(CONFIG_OF) += of_coresight.o
> -obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o \
> -					     coresight-tmc-etf.o \
> -					     coresight-tmc-etr.o
> +obj-$(CONFIG_CORESIGHT) += coresight-core.o
> +coresight-core-objs := coresight.o \
> +		       of_coresight.o
> +
> +obj-$(CONFIG_CORESIGHT) += coresight-etm-perf.o
> +
> +obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc-core.o
> +coresight-tmc-core-objs :=  coresight-tmc.o \
> +				 coresight-tmc-etf.o \
> +				 coresight-tmc-etr.o
>  obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
>  obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
>  obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
>  					   coresight-replicator.o
> -obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o \
> -					coresight-etm3x-sysfs.o
> -obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
> -					coresight-etm4x-sysfs.o
> +
> +obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x-core.o
> +coresight-etm3x-core-objs := coresight-etm3x.o \
> +			     coresight-etm-cp14.o \
> +			     coresight-etm3x-sysfs.o
> +
> +obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x-core.o
> +coresight-etm4x-core-objs := coresight-etm4x.o coresight-etm4x-sysfs.o
> +
>  obj-$(CONFIG_CORESIGHT_DYNAMIC_REPLICATOR) += coresight-dynamic-replicator.o
>  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>  obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 45b2460f3166..1efe9626eb6c 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -671,6 +671,8 @@ static const struct amba_id debug_ids[] = {
>  	{ 0, 0 },
>  };
>  
> +MODULE_DEVICE_TABLE(amba, debug_ids);
> +
>  static struct amba_driver debug_driver = {
>  	.drv = {
>  		.name   = "coresight-cpu-debug",
> diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> index fc742215ab05..bc42b8022556 100644
> --- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> @@ -37,7 +37,12 @@ struct replicator_state {
>  static int replicator_enable(struct coresight_device *csdev, int inport,
>  			      int outport)
>  {
> -	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct replicator_state *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
> +
> +	if (!try_module_get(module))
> +		return -ENODEV;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -63,7 +68,9 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
>  static void replicator_disable(struct coresight_device *csdev, int inport,
>  				int outport)
>  {
> -	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct replicator_state *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -75,6 +82,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
>  
>  	CS_LOCK(drvdata->base);
>  
> +	module_put(module);
>  	dev_info(drvdata->dev, "REPLICATOR disabled\n");
>  }
>  
> @@ -159,6 +167,15 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
>  	return PTR_ERR_OR_ZERO(drvdata->csdev);
>  }
>  
> +static int __exit replicator_remove(struct amba_device *adev)
> +{
> +	struct replicator_state *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	coresight_unregister(drvdata->csdev);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM
>  static int replicator_runtime_suspend(struct device *dev)
>  {
> @@ -200,6 +217,8 @@ static const struct amba_id replicator_ids[] = {
>  	{ 0, 0 },
>  };
>  
> +MODULE_DEVICE_TABLE(amba, replicator_ids);
> +
>  static struct amba_driver replicator_driver = {
>  	.drv = {
>  		.name	= "coresight-dynamic-replicator",
> @@ -207,9 +226,10 @@ static struct amba_driver replicator_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe		= replicator_probe,
> +	.remove		= replicator_remove,
>  	.id_table	= replicator_ids,
>  };
> -builtin_amba_driver(replicator_driver);
> +module_amba_driver(replicator_driver);
>  
>  MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>  MODULE_DESCRIPTION("ARM Coresight Dynamic Replicator Driver");
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index a3dac5a8b37c..8825a3e4e47a 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -135,7 +135,12 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
>  {
>  	u32 val;
>  	unsigned long flags;
> -	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct etb_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
> +
> +	if (!try_module_get(module))
> +		return -ENODEV;
>  
>  	val = local_cmpxchg(&drvdata->mode,
>  			    CS_MODE_DISABLED, mode);
> @@ -256,7 +261,9 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
>  
>  static void etb_disable(struct coresight_device *csdev)
>  {
> -	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct etb_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> @@ -266,6 +273,7 @@ static void etb_disable(struct coresight_device *csdev)
>  
>  	local_set(&drvdata->mode, CS_MODE_DISABLED);
>  
> +	module_put(module);
>  	dev_info(drvdata->dev, "ETB disabled\n");
>  }
>  
> @@ -712,6 +720,16 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	return ret;
>  }
>  
> +static int __exit etb_remove(struct amba_device *adev)
> +{
> +	struct etb_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	misc_deregister(&drvdata->miscdev);
> +	coresight_unregister(drvdata->csdev);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM
>  static int etb_runtime_suspend(struct device *dev)
>  {
> @@ -746,6 +764,8 @@ static const struct amba_id etb_ids[] = {
>  	{ 0, 0},
>  };
>  
> +MODULE_DEVICE_TABLE(amba, etb_ids);
> +
>  static struct amba_driver etb_driver = {
>  	.drv = {
>  		.name	= "coresight-etb10",
> @@ -755,9 +775,10 @@ static struct amba_driver etb_driver = {
>  
>  	},
>  	.probe		= etb_probe,
> +	.remove		= etb_remove,
>  	.id_table	= etb_ids,
>  };
> -builtin_amba_driver(etb_driver);
> +module_amba_driver(etb_driver);
>  
>  MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>  MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index ad0ef8d27111..feb287083ba5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -466,6 +466,7 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(etm_perf_symlink);
>  
>  static int __init etm_perf_init(void)
>  {
> @@ -493,7 +494,13 @@ static int __init etm_perf_init(void)
>  
>  	return ret;
>  }
> -device_initcall(etm_perf_init);
> +module_init(etm_perf_init);
> +
> +static void __exit etm_perf_exit(void)
> +{
> +	perf_pmu_unregister(&etm_pmu);
> +}
> +module_exit(etm_perf_exit);
>  
>  MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
>  MODULE_DESCRIPTION("Arm CoreSight tracer perf driver");
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 91a2a23143d8..84fa5e0fe07b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -7,6 +7,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/sysfs.h>
> +#include <linux/coresight.h>

Why do we need this?

>  #include "coresight-etm.h"
>  #include "coresight-priv.h"
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 7ca73a15c735..a2357b26b3a2 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -514,7 +514,12 @@ static int etm_enable(struct coresight_device *csdev,
>  {
>  	int ret;
>  	u32 val;
> -	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct etm_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
> +
> +	if (!try_module_get(module))
> +		return -ENODEV;
>  
>  	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
>  
> @@ -611,7 +616,9 @@ static void etm_disable(struct coresight_device *csdev,
>  			struct perf_event *event)
>  {
>  	u32 mode;
> -	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct etm_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
>  
>  	/*
>  	 * For as long as the tracer isn't disabled another entity can't
> @@ -636,6 +643,8 @@ static void etm_disable(struct coresight_device *csdev,
>  
>  	if (mode)
>  		local_set(&drvdata->mode, CS_MODE_DISABLED);
> +
> +	module_put(module);
>  }
>  
>  static const struct coresight_ops_source etm_source_ops = {
> @@ -864,6 +873,20 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  	return ret;
>  }
>  
> +static int __exit etm_remove(struct amba_device *adev)
> +{
> +	struct etm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	etm_perf_symlink(drvdata->csdev, false);
> +
> +	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
> +	cpuhp_remove_state_nocalls(hp_online);
> +
> +	coresight_unregister(drvdata->csdev);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM
>  static int etm_runtime_suspend(struct device *dev)
>  {
> @@ -924,6 +947,8 @@ static const struct amba_id etm_ids[] = {
>  	{ 0, 0},
>  };
>  
> +MODULE_DEVICE_TABLE(amba, etm_ids);
> +
>  static struct amba_driver etm_driver = {
>  	.drv = {
>  		.name	= "coresight-etm3x",
> @@ -932,9 +957,10 @@ static struct amba_driver etm_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe		= etm_probe,
> +	.remove		= etm_remove,
>  	.id_table	= etm_ids,
>  };
> -builtin_amba_driver(etm_driver);
> +module_amba_driver(etm_driver);
>  
>  MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>  MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 577a38673444..ee0cbada45d6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2173,6 +2173,7 @@ const struct attribute_group *coresight_etmv4_groups[] = {
>  	&coresight_etmv4_trcidr_group,
>  	NULL,
>  };
> +EXPORT_SYMBOL_GPL(coresight_etmv4_groups);

>From where I stand this is not needed.

>  
>  MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
>  MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace v4 sysfs driver");
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index ba10f5302a55..a6ff152ab61d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -280,7 +280,12 @@ static int etm4_enable(struct coresight_device *csdev,
>  {
>  	int ret;
>  	u32 val;
> -	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
> +
> +	if (!try_module_get(module))
> +		return -ENODEV;
>  
>  	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
>  
> @@ -387,7 +392,9 @@ static void etm4_disable(struct coresight_device *csdev,
>  			 struct perf_event *event)
>  {
>  	u32 mode;
> -	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
>  
>  	/*
>  	 * For as long as the tracer isn't disabled another entity can't
> @@ -409,6 +416,8 @@ static void etm4_disable(struct coresight_device *csdev,
>  
>  	if (mode)
>  		local_set(&drvdata->mode, CS_MODE_DISABLED);
> +
> +	module_put(module);
>  }
>  
>  static const struct coresight_ops_source etm4_source_ops = {
> @@ -1045,6 +1054,20 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	return ret;
>  }
>  
> +static int __exit etm4_remove(struct amba_device *adev)
> +{
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	etm_perf_symlink(drvdata->csdev, false);
> +
> +	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
> +	cpuhp_remove_state_nocalls(hp_online);
> +
> +	coresight_unregister(drvdata->csdev);
> +
> +	return 0;
> +}
> +
>  static const struct amba_id etm4_ids[] = {
>  	{       /* ETM 4.0 - Cortex-A53  */
>  		.id	= 0x000bb95d,
> @@ -1064,15 +1087,19 @@ static const struct amba_id etm4_ids[] = {
>  	{ 0, 0},
>  };
>  
> +MODULE_DEVICE_TABLE(amba, etm4_ids);
> +
>  static struct amba_driver etm4x_driver = {
>  	.drv = {
>  		.name   = "coresight-etm4x",
> +		.owner  = THIS_MODULE,
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe		= etm4_probe,
> +	.remove		= etm4_remove,
>  	.id_table	= etm4_ids,
>  };
> -builtin_amba_driver(etm4x_driver);
> +module_amba_driver(etm4x_driver);
>  
>  MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>  MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 1e497a75b956..c355a66bcc51 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -61,7 +61,12 @@ static void funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
>  static int funnel_enable(struct coresight_device *csdev, int inport,
>  			 int outport)
>  {
> -	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct funnel_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
> +
> +	if (!try_module_get(module))
> +		return -ENODEV;
>  
>  	funnel_enable_hw(drvdata, inport);
>  
> @@ -85,10 +90,13 @@ static void funnel_disable_hw(struct funnel_drvdata *drvdata, int inport)
>  static void funnel_disable(struct coresight_device *csdev, int inport,
>  			   int outport)
>  {
> -	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct funnel_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
>  
>  	funnel_disable_hw(drvdata, inport);
>  
> +	module_put(module);
>  	dev_info(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
>  }
>  
> @@ -211,6 +219,15 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
>  	return PTR_ERR_OR_ZERO(drvdata->csdev);
>  }
>  
> +static int __exit funnel_remove(struct amba_device *adev)
> +{
> +	struct funnel_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	coresight_unregister(drvdata->csdev);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM
>  static int funnel_runtime_suspend(struct device *dev)
>  {
> @@ -250,6 +267,8 @@ static const struct amba_id funnel_ids[] = {
>  	{ 0, 0},
>  };
>  
> +MODULE_DEVICE_TABLE(amba, funnel_ids);
> +
>  static struct amba_driver funnel_driver = {
>  	.drv = {
>  		.name	= "coresight-funnel",
> @@ -258,9 +277,10 @@ static struct amba_driver funnel_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe		= funnel_probe,
> +	.remove		= funnel_remove,
>  	.id_table	= funnel_ids,
>  };
> -builtin_amba_driver(funnel_driver);
> +module_amba_driver(funnel_driver);
>  
>  MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
>  MODULE_DESCRIPTION("ARM Coresight Funnel Driver");
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 45de8c15b687..896958c2dd44 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -65,7 +65,6 @@ static DEVICE_ATTR_RO(name)
>  static const u32 barrier_pkt[5] = {0x7fffffff, 0x7fffffff,
>  				   0x7fffffff, 0x7fffffff, 0x0};
>  
> -

No need for that.

>  enum etm_addr_type {
>  	ETM_ADDR_TYPE_NONE,
>  	ETM_ADDR_TYPE_SINGLE,
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 9ef539893eaa..6f16dcd7e107 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -33,7 +33,12 @@ struct replicator_drvdata {
>  static int replicator_enable(struct coresight_device *csdev, int inport,
>  			     int outport)
>  {
> -	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct replicator_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
> +
> +	if (!try_module_get(module))
> +		return -ENODEV;
>  
>  	dev_info(drvdata->dev, "REPLICATOR enabled\n");
>  	return 0;
> @@ -42,8 +47,11 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
>  static void replicator_disable(struct coresight_device *csdev, int inport,
>  			       int outport)
>  {
> -	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct replicator_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
>  
> +	module_put(module);
>  	dev_info(drvdata->dev, "REPLICATOR disabled\n");
>  }
>  
> @@ -112,6 +120,17 @@ static int replicator_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int __exit replicator_remove(struct platform_device *pdev)
> +{
> +	struct replicator_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
> +
> +	coresight_unregister(drvdata->csdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM
>  static int replicator_runtime_suspend(struct device *dev)
>  {
> @@ -144,8 +163,11 @@ static const struct of_device_id replicator_match[] = {
>  	{}
>  };
>  
> +MODULE_DEVICE_TABLE(of, replicator_match);
> +
>  static struct platform_driver replicator_driver = {
>  	.probe          = replicator_probe,
> +	.remove         = replicator_remove,
>  	.driver         = {
>  		.name   = "coresight-replicator",
>  		.of_match_table = replicator_match,
> @@ -153,7 +175,7 @@ static struct platform_driver replicator_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  };
> -builtin_platform_driver(replicator_driver);
> +module_platform_driver(replicator_driver);
>  
>  MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>  MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 30eae52a8757..9997ba0dbd54 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -194,7 +194,12 @@ static int stm_enable(struct coresight_device *csdev,
>  		      struct perf_event *event, u32 mode)
>  {
>  	u32 val;
> -	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct stm_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
> +
> +	if (!try_module_get(module))
> +		return -ENODEV;
>  
>  	if (mode != CS_MODE_SYSFS)
>  		return -EINVAL;


Function stm_disable() would likely benefit from a module_put().  

> @@ -882,6 +887,17 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	return ret;
>  }
>  
> +static int __exit stm_remove(struct amba_device *adev)
> +{
> +	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	coresight_unregister(drvdata->csdev);
> +
> +	stm_unregister_device(&drvdata->stm);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM
>  static int stm_runtime_suspend(struct device *dev)
>  {
> @@ -922,6 +938,8 @@ static const struct amba_id stm_ids[] = {
>  	{ 0, 0},
>  };
>  
> +MODULE_DEVICE_TABLE(amba, stm_ids);
> +
>  static struct amba_driver stm_driver = {
>  	.drv = {
>  		.name   = "coresight-stm",
> @@ -930,10 +948,11 @@ static struct amba_driver stm_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe          = stm_probe,
> +	.remove         = stm_remove,
>  	.id_table	= stm_ids,
>  };
>  
> -builtin_amba_driver(stm_driver);
> +module_amba_driver(stm_driver);
>  
>  MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>  MODULE_DESCRIPTION("Arm CoreSight System Trace Macrocell driver");
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 176a5aeab20e..eb3cdb832f84 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -429,6 +429,19 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  	return ret;
>  }
>  
> +static int __exit tmc_remove(struct amba_device *adev)
> +{
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	/* free ETB/ETF or ETR memory */
> +	tmc_read_unprepare(drvdata);
> +
> +	misc_deregister(&drvdata->miscdev);
> +	coresight_unregister(drvdata->csdev);
> +
> +	return 0;
> +}
> +

Right now I can remove the module for a TMC link or sink when part of an active
session, something I pointed out during an earlier revision.

I also think we need to deal with driver removal cases when the TMC buffer
(ETR or ETF) is being read from sysFS.

>  static const struct amba_id tmc_ids[] = {
>  	{
>  		.id     = 0x000bb961,
> @@ -453,6 +466,8 @@ static const struct amba_id tmc_ids[] = {
>  	{ 0, 0},
>  };
>  
> +MODULE_DEVICE_TABLE(amba, tmc_ids);
> +
>  static struct amba_driver tmc_driver = {
>  	.drv = {
>  		.name   = "coresight-tmc",
> @@ -460,9 +475,10 @@ static struct amba_driver tmc_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe		= tmc_probe,
> +	.remove		= tmc_remove,
>  	.id_table	= tmc_ids,
>  };
> -builtin_amba_driver(tmc_driver);
> +module_amba_driver(tmc_driver);
>  
>  MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>  MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller driver");
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index f3b154e150b3..9622f2a5a451 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -69,7 +69,12 @@ static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
>  
>  static int tpiu_enable(struct coresight_device *csdev, u32 mode)
>  {
> -	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct tpiu_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
> +
> +	if (!try_module_get(module))
> +		return -ENODEV;
>  
>  	tpiu_enable_hw(drvdata);
>  
> @@ -95,10 +100,13 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
>  
>  static void tpiu_disable(struct coresight_device *csdev)
>  {
> -	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct device *parent_dev = csdev->dev.parent;
> +	struct tpiu_drvdata *drvdata = dev_get_drvdata(parent_dev);
> +	struct module *module = parent_dev->driver->owner;
>  
>  	tpiu_disable_hw(drvdata);
>  
> +	module_put(module);
>  	dev_info(drvdata->dev, "TPIU disabled\n");
>  }
>  
> @@ -164,6 +172,15 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	return PTR_ERR_OR_ZERO(drvdata->csdev);
>  }
>  
> +static int __exit tpiu_remove(struct amba_device *adev)
> +{
> +	struct tpiu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	coresight_unregister(drvdata->csdev);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM
>  static int tpiu_runtime_suspend(struct device *dev)
>  {
> @@ -207,6 +224,8 @@ static const struct amba_id tpiu_ids[] = {
>  	{ 0, 0},
>  };
>  
> +MODULE_DEVICE_TABLE(amba, tpiu_ids);
> +
>  static struct amba_driver tpiu_driver = {
>  	.drv = {
>  		.name	= "coresight-tpiu",
> @@ -215,9 +234,10 @@ static struct amba_driver tpiu_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe		= tpiu_probe,
> +	.remove		= tpiu_remove,
>  	.id_table	= tpiu_ids,
>  };
> -builtin_amba_driver(tpiu_driver);
> +module_amba_driver(tpiu_driver);
>  
>  MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>  MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 406899f316e4..c00229b0db52 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -302,6 +302,7 @@ void coresight_disable_path(struct list_head *path)
>  		}
>  	}
>  }
> +EXPORT_SYMBOL_GPL(coresight_disable_path);
>  
>  int coresight_enable_path(struct list_head *path, u32 mode)
>  {
> @@ -353,6 +354,7 @@ int coresight_enable_path(struct list_head *path, u32 mode)
>  	coresight_disable_path(path);
>  	goto out;
>  }
> +EXPORT_SYMBOL_GPL(coresight_enable_path);
>  
>  struct coresight_device *coresight_get_sink(struct list_head *path)
>  {
> @@ -368,6 +370,7 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
>  
>  	return csdev;
>  }
> +EXPORT_SYMBOL_GPL(coresight_get_sink);
>  
>  static int coresight_enabled_sink(struct device *dev, void *data)
>  {
> @@ -392,6 +395,7 @@ static int coresight_enabled_sink(struct device *dev, void *data)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(coresight_enabled_sink);
>  
>  /**
>   * coresight_get_enabled_sink - returns the first enabled sink found on the bus
> @@ -414,6 +418,7 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
>  
>  	return dev ? to_coresight_device(dev) : NULL;
>  }
> +EXPORT_SYMBOL_GPL(coresight_get_enabled_sink);
>  
>  /**
>   * _coresight_build_path - recursively build a path from a @csdev to a sink.
> @@ -493,6 +498,7 @@ struct list_head *coresight_build_path(struct coresight_device *source,
>  
>  	return path;
>  }
> +EXPORT_SYMBOL_GPL(coresight_build_path);
>  
>  /**
>   * coresight_release_path - release a previously built path.
> @@ -517,6 +523,7 @@ void coresight_release_path(struct list_head *path)
>  	kfree(path);
>  	path = NULL;
>  }
> +EXPORT_SYMBOL_GPL(coresight_release_path);
>  
>  /** coresight_validate_source - make sure a source has the right credentials
>   *  @csdev:	the device structure for a source.
> @@ -933,6 +940,7 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
>  
>  	return -EAGAIN;
>  }
> +EXPORT_SYMBOL_GPL(coresight_timeout);
>  
>  struct bus_type coresight_bustype = {
>  	.name	= "coresight",
> @@ -944,6 +952,12 @@ static int __init coresight_init(void)
>  }
>  postcore_initcall(coresight_init);
>  
> +static void __exit coresight_exit(void)
> +{
> +	bus_unregister(&coresight_bustype);
> +}
> +module_exit(coresight_exit);
> +
>  struct coresight_device *coresight_register(struct coresight_desc *desc)
>  {
>  	int i;
> -- 
> 2.17.0
> 
