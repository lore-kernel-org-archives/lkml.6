Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZqcVSQgFVvNeMx7KgxWEc5Mbd8nuZsA5qce/GHprEYb5zktoOlqePKZPQT9j7Xb1Olm8ZXQ
ARC-Seal: i=1; a=rsa-sha256; t=1525806412; cv=none;
        d=google.com; s=arc-20160816;
        b=IE774RuzXNuV+6Gt4uX6JfTS3crA7Ab11Pcx09TOfhWe9x/8npGNoW3vrVyCHDlvMn
         7L8Hjh5P8PVvX/XSU4va3hMhElCTwlCkujtkmmRDggv45upDgQE0DxAEZpKdcSwd0wPm
         U1ODNCzUUa7108o/7atnISeqy219cidiGYMIcpZRffReoX6yyoZ2V43F1q0ge179onqq
         v4GYPc3fRnXY7I9Hztt8cPvCvEVKp2oNc8iQZ9oINZ3/i0W+BzAZyN9VWluy0tU0D/Ib
         kiT1Q87KKxpArMzugs9TWKUj/iTVt+i9IvWFKOS4vingmUzGkcenN/sVnRTSZ08V2/9F
         Y5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=Tqr6cgGvWWeY4u5Mg5XlQvSoUblZzPWCSCsjI5ui+vU=;
        b=dfQrgsDYiH3GJbgHCvWJHMPRjhZsJTrkH0TAQKOwnILYiwdFMJx5DxDkPeTh5gZoWB
         fNn8bZ0xbXGvYkMmmjD+nvAv/VDv6Tcme4y6qvNJxoQDYSd5I5PFVDrOoDEmCD3LQ4Eo
         C+pAozxzqpI/hLGqiR2lMB2yTrOICRQIoyQ9SuNjwxS/JRY0/ptpTkS8eqMokXesKF/G
         bFVV/QnZo1i2hVW5wmGVZzbEwSbw+aD2Tx1nhpYWAYaye/6l2h/DzH9sGLLCyUaByCQ8
         jBsTJ6iSYWex4r37+LWA14FjwgDcv+AGaazTzlpLLQG/hTBLa5mlzYThWm7SCBye/3ag
         9TfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Date: Tue, 8 May 2018 14:06:50 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Kim
 Phillips <kim.phillips@arm.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, Mike
 Rapoport <rppt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Pavel
 Tatashin <pasha.tatashin@oracle.com>, Rik van Riel <riel@redhat.com>, Robin
 Murphy <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>,
 Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] coresight: allow to build as modules
Message-Id: <20180508140650.c070e6aa0eb1a6690e6d9607@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923984942793999?=
X-GMAIL-MSGID: =?utf-8?q?1599923984942793999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Allow to build coresight as modules.  This greatly enhances developer
efficiency by allowing the development to take place exclusively on the
target, and without needing to reboot in between changes.

- Kconfig bools become tristates, to allow =m

- MODULE_* macros added:  Please correct me if I'm wrong:
  - assume LICENSE is "GPL v2"
  - tried to get as close to original authors for MODULE_AUTHOR

- The 'select' Kconfig statements are replaced with 'depends on'
  clauses, to specify the dependencies between the modules including
  other fixes, e.g., coresight-stm unconditionally calls
  stm_register_device, it therefore depends on STM.

- use -objs to denote merge object directives in Makefile, adds a
  coresight-core nomenclature for the base module.

- add a coresight_exit() that unregisters the coresight bus, add remove
  fns for most others.

- fix up modules with ID tables for autoloading on boot, add missing
  __exit attributes

- move coresight_vpid_to_pid to an externed, single instance in
  coresight-core, to be used by all submodules.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
Changes from versions previously sent to coresight mailing list:

 - tmc_remove: free buffer used by TMC-ETR and TMC-ETF by calling
   tmc_read_unprepare()
 - fixed an unbalanced pm_runtime_enable in coresight-replicator
 - etm[4]_remove():  call cpuhp_remove_state_nocalls() and
   etm_perf_symlink(.., false) to clear up cpuhp and symlink state
 - add module parent checks for all enable/disable functions, source
   and sink modules
   - refactored device ptr dereferences by introducing a new parent_dev
     variable
 - corrected replicator author
 - whitespace fix in funnel driver

 - added user Kconfig help text with the names of the modules.
 - Addressed Mathieu's comments:
   - renamed coresight-link-sink-tmc coresight-tmc-core
   - prevent ability to crash the system by removing drivers from an
     active path by adding try_module_get() and module_put() calls in
     funnel and replicator drivers' enable and disable functions (thanks for
     figuring that out, Mathieu).

 - Addressed most of Mathieu's comments:
   - rm __inits causing linker section mismatch errors
   - barrier_pkt made static, moved to coresight_priv.h
   - rm unnecessary tmc_* EXPORT_SYMBOL leftovers
   - add some missing MODULE_AUTHORs

 drivers/hwtracing/coresight/Kconfig           | 63 +++++++++++++------
 drivers/hwtracing/coresight/Makefile          | 28 ++++++---
 .../hwtracing/coresight/coresight-cpu-debug.c |  2 +
 .../coresight/coresight-dynamic-replicator.c  | 30 ++++++++-
 drivers/hwtracing/coresight/coresight-etb10.c | 32 +++++++++-
 .../hwtracing/coresight/coresight-etm-cp14.c  |  4 ++
 .../hwtracing/coresight/coresight-etm-perf.c  | 13 +++-
 .../hwtracing/coresight/coresight-etm-perf.h  |  2 +-
 .../coresight/coresight-etm3x-sysfs.c         |  6 ++
 drivers/hwtracing/coresight/coresight-etm3x.c | 37 ++++++++++-
 .../coresight/coresight-etm4x-sysfs.c         |  6 ++
 drivers/hwtracing/coresight/coresight-etm4x.c | 38 ++++++++++-
 .../hwtracing/coresight/coresight-funnel.c    | 30 ++++++++-
 drivers/hwtracing/coresight/coresight-priv.h  | 10 ++-
 .../coresight/coresight-replicator.c          | 33 +++++++++-
 drivers/hwtracing/coresight/coresight-stm.c   | 27 +++++++-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  2 +
 .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +
 drivers/hwtracing/coresight/coresight-tmc.c   | 34 +++++++++-
 drivers/hwtracing/coresight/coresight-tpiu.c  | 31 ++++++++-
 drivers/hwtracing/coresight/coresight.c       | 49 ++++++++++++---
 include/linux/coresight.h                     | 23 +------
 22 files changed, 418 insertions(+), 84 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index ef9cb3c164e1..09a682013ea2 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -2,8 +2,8 @@
 # Coresight configuration
 #
 menuconfig CORESIGHT
-	bool "CoreSight Tracing Support"
-	select ARM_AMBA
+	tristate "CoreSight Tracing Support"
+	depends on ARM_AMBA
 	select PERF_EVENTS
 	help
 	  This framework provides a kernel interface for the CoreSight debug
@@ -12,17 +12,24 @@ menuconfig CORESIGHT
 	  specification and configure the right series of components when a
 	  trace source gets enabled.
 
+	  To compile this code as a module, choose M here: the
+	  module will be called coresight-core.
+
 if CORESIGHT
 config CORESIGHT_LINKS_AND_SINKS
-	bool "CoreSight Link and Sink drivers"
+	tristate "CoreSight Link and Sink drivers"
+	depends on CORESIGHT
 	help
 	  This enables support for CoreSight link and sink drivers that are
 	  responsible for transporting and collecting the trace data
 	  respectively.  Link and sinks are dynamically aggregated with a trace
 	  entity at run time to form a complete trace path.
 
+	  To compile this code as modules, choose M here: the
+	  modules will be called coresight-funnel and coresight-replicator.
+
 config CORESIGHT_LINK_AND_SINK_TMC
-	bool "Coresight generic TMC driver"
+	tristate "Coresight generic TMC driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Trace Memory Controller driver.
@@ -31,8 +38,11 @@ config CORESIGHT_LINK_AND_SINK_TMC
 	  complies with the generic implementation of the component without
 	  special enhancement or added features.
 
+	  To compile this code as a module, choose M here: the
+	  module will be called coresight-tmc-core.
+
 config CORESIGHT_SINK_TPIU
-	bool "Coresight generic TPIU driver"
+	tristate "Coresight generic TPIU driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Trace Port Interface Unit driver,
@@ -42,57 +52,71 @@ config CORESIGHT_SINK_TPIU
 	  connected to an external host for use case capturing more traces than
 	  the on-board coresight memory can handle.
 
+	  To compile this code as a module, choose M here: the
+	  module will be called coresight-tpiu.
+
 config CORESIGHT_SINK_ETBV10
-	bool "Coresight ETBv1.0 driver"
+	tristate "Coresight ETBv1.0 driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Embedded Trace Buffer version 1.0 driver
 	  that complies with the generic implementation of the component without
 	  special enhancement or added features.
 
+	  To compile this code as a module, choose M here: the
+	  module will be called coresight-etb10.
+
 config CORESIGHT_SOURCE_ETM3X
-	bool "CoreSight Embedded Trace Macrocell 3.x driver"
-	depends on !ARM64
-	select CORESIGHT_LINKS_AND_SINKS
+	tristate "CoreSight Embedded Trace Macrocell 3.x driver"
+	depends on !ARM64 && CORESIGHT_LINKS_AND_SINKS
 	help
 	  This driver provides support for processor ETM3.x and PTM1.x modules,
 	  which allows tracing the instructions that a processor is executing
 	  This is primarily useful for instruction level tracing.  Depending
 	  the ETM version data tracing may also be available.
 
+	  To compile this code as a module, choose M here: the
+	  module will be called coresight-etm3x-core.
+
 config CORESIGHT_SOURCE_ETM4X
-	bool "CoreSight Embedded Trace Macrocell 4.x driver"
-	depends on ARM64
-	select CORESIGHT_LINKS_AND_SINKS
+	tristate "CoreSight Embedded Trace Macrocell 4.x driver"
+	depends on ARM64 && CORESIGHT_LINKS_AND_SINKS
 	help
 	  This driver provides support for the ETM4.x tracer module, tracing the
 	  instructions that a processor is executing. This is primarily useful
 	  for instruction level tracing. Depending on the implemented version
 	  data tracing may also be available.
 
+	  To compile this code as a module, choose M here: the
+	  module will be called coresight-etm4x-core.
+
 config CORESIGHT_DYNAMIC_REPLICATOR
-	bool "CoreSight Programmable Replicator driver"
+	tristate "CoreSight Programmable Replicator driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for dynamic CoreSight replicator link driver.
 	  The programmable ATB replicator allows independent filtering of the
 	  trace data based on the traceid.
 
+	  To compile this code as a module, choose M here: the
+	  module will be called coresight-dynamic-replicator.
+
 config CORESIGHT_STM
-	bool "CoreSight System Trace Macrocell driver"
+	tristate "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
-	select CORESIGHT_LINKS_AND_SINKS
-	select STM
+	depends on STM && CORESIGHT_LINKS_AND_SINKS
 	help
 	  This driver provides support for hardware assisted software
 	  instrumentation based tracing. This is primarily used for
 	  logging useful software events or data coming from various entities
 	  in the system, possibly running different OSs
 
+	  To compile this code as a module, choose M here: the
+	  module will be called coresight-stm.
+
 config CORESIGHT_CPU_DEBUG
 	tristate "CoreSight CPU Debug driver"
-	depends on ARM || ARM64
-	depends on DEBUG_FS
+	depends on CORESIGHT && DEBUG_FS
 	help
 	  This driver provides support for coresight debugging module. This
 	  is primarily used to dump sample-based profiling registers when
@@ -103,4 +127,7 @@ config CORESIGHT_CPU_DEBUG
 	  properly, please refer Documentation/trace/coresight-cpu-debug.txt
 	  for detailed description and the example for usage.
 
+	  To compile this code as a module, choose M here: the
+	  module will be called coresight-cpu-debug.
+
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 61db9dd0d571..5990710289c2 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -2,19 +2,29 @@
 #
 # Makefile for CoreSight drivers.
 #
-obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o
-obj-$(CONFIG_OF) += of_coresight.o
-obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o \
-					     coresight-tmc-etf.o \
-					     coresight-tmc-etr.o
+obj-$(CONFIG_CORESIGHT) += coresight-core.o
+coresight-core-objs := coresight.o \
+		       of_coresight.o
+
+obj-$(CONFIG_CORESIGHT) += coresight-etm-perf.o
+
+obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc-core.o
+coresight-tmc-core-objs :=  coresight-tmc.o \
+				 coresight-tmc-etf.o \
+				 coresight-tmc-etr.o
 obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
 obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
 obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
 					   coresight-replicator.o
-obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o \
-					coresight-etm3x-sysfs.o
-obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
-					coresight-etm4x-sysfs.o
+
+obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x-core.o
+coresight-etm3x-core-objs := coresight-etm3x.o \
+			     coresight-etm-cp14.o \
+			     coresight-etm3x-sysfs.o
+
+obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x-core.o
+coresight-etm4x-core-objs := coresight-etm4x.o coresight-etm4x-sysfs.o
+
 obj-$(CONFIG_CORESIGHT_DYNAMIC_REPLICATOR) += coresight-dynamic-replicator.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 9cdb3fbc8c1f..ff6d3be1b13c 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -683,6 +683,8 @@ static const struct amba_id debug_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, debug_ids);
+
 static struct amba_driver debug_driver = {
 	.drv = {
 		.name   = "coresight-cpu-debug",
diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index 043da86b0fe9..a4ee744ca12b 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -45,7 +45,12 @@ struct replicator_state {
 static int replicator_enable(struct coresight_device *csdev, int inport,
 			      int outport)
 {
-	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct replicator_state *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
+
+	if (!try_module_get(module))
+		return -ENODEV;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -71,7 +76,9 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 static void replicator_disable(struct coresight_device *csdev, int inport,
 				int outport)
 {
-	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct replicator_state *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -83,6 +90,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 
 	CS_LOCK(drvdata->base);
 
+	module_put(module);
 	dev_info(drvdata->dev, "REPLICATOR disabled\n");
 }
 
@@ -167,6 +175,15 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	return PTR_ERR_OR_ZERO(drvdata->csdev);
 }
 
+static int __exit replicator_remove(struct amba_device *adev)
+{
+	struct replicator_state *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int replicator_runtime_suspend(struct device *dev)
 {
@@ -208,6 +225,8 @@ static const struct amba_id replicator_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, replicator_ids);
+
 static struct amba_driver replicator_driver = {
 	.drv = {
 		.name	= "coresight-dynamic-replicator",
@@ -215,6 +234,11 @@ static struct amba_driver replicator_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= replicator_probe,
+	.remove		= replicator_remove,
 	.id_table	= replicator_ids,
 };
-builtin_amba_driver(replicator_driver);
+module_amba_driver(replicator_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("ARM Coresight Dynamic Replicator Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 580cd381adf3..b64d616b301f 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -142,7 +142,12 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
 {
 	u32 val;
 	unsigned long flags;
-	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct etb_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
+
+	if (!try_module_get(module))
+		return -ENODEV;
 
 	val = local_cmpxchg(&drvdata->mode,
 			    CS_MODE_DISABLED, mode);
@@ -263,7 +268,9 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 
 static void etb_disable(struct coresight_device *csdev)
 {
-	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct etb_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
@@ -273,6 +280,7 @@ static void etb_disable(struct coresight_device *csdev)
 
 	local_set(&drvdata->mode, CS_MODE_DISABLED);
 
+	module_put(module);
 	dev_info(drvdata->dev, "ETB disabled\n");
 }
 
@@ -719,6 +727,16 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int __exit etb_remove(struct amba_device *adev)
+{
+	struct etb_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	misc_deregister(&drvdata->miscdev);
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int etb_runtime_suspend(struct device *dev)
 {
@@ -753,6 +771,8 @@ static const struct amba_id etb_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, etb_ids);
+
 static struct amba_driver etb_driver = {
 	.drv = {
 		.name	= "coresight-etb10",
@@ -762,6 +782,12 @@ static struct amba_driver etb_driver = {
 
 	},
 	.probe		= etb_probe,
+	.remove		= etb_remove,
 	.id_table	= etb_ids,
 };
-builtin_amba_driver(etb_driver);
+module_amba_driver(etb_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Embedded Trace Buffer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm-cp14.c b/drivers/hwtracing/coresight/coresight-etm-cp14.c
index 12a220682117..1e16a6358364 100644
--- a/drivers/hwtracing/coresight/coresight-etm-cp14.c
+++ b/drivers/hwtracing/coresight/coresight-etm-cp14.c
@@ -589,3 +589,7 @@ int etm_writel_cp14(u32 reg, u32 val)
 
 	return 0;
 }
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight ETM CP14 driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 4e5ed6597f2f..152f2ae49665 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -477,6 +477,7 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(etm_perf_symlink);
 
 static int __init etm_perf_init(void)
 {
@@ -504,4 +505,14 @@ static int __init etm_perf_init(void)
 
 	return ret;
 }
-device_initcall(etm_perf_init);
+module_init(etm_perf_init);
+
+static void __exit etm_perf_exit(void)
+{
+	perf_pmu_unregister(&etm_pmu);
+}
+module_exit(etm_perf_exit);
+
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight tracer perf driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 3ffc9feb2d64..8c49c7b82d84 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -54,7 +54,7 @@ struct etm_filters {
 };
 
 
-#ifdef CONFIG_CORESIGHT
+#if IS_ENABLED(CONFIG_CORESIGHT)
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
 
 #else
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 6e547ec6fead..65cfec6e1749 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -17,6 +17,7 @@
 
 #include <linux/pm_runtime.h>
 #include <linux/sysfs.h>
+#include <linux/coresight.h>
 #include "coresight-etm.h"
 #include "coresight-priv.h"
 
@@ -1274,3 +1275,8 @@ const struct attribute_group *coresight_etm_groups[] = {
 	&coresight_etm_mgmt_group,
 	NULL,
 };
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace sysfs driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 39f42fdd503d..419dd17115ed 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -523,7 +523,12 @@ static int etm_enable(struct coresight_device *csdev,
 {
 	int ret;
 	u32 val;
-	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct etm_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
+
+	if (!try_module_get(module))
+		return -ENODEV;
 
 	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
 
@@ -620,7 +625,9 @@ static void etm_disable(struct coresight_device *csdev,
 			struct perf_event *event)
 {
 	u32 mode;
-	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct etm_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
 
 	/*
 	 * For as long as the tracer isn't disabled another entity can't
@@ -645,6 +652,8 @@ static void etm_disable(struct coresight_device *csdev,
 
 	if (mode)
 		local_set(&drvdata->mode, CS_MODE_DISABLED);
+
+	module_put(module);
 }
 
 static const struct coresight_ops_source etm_source_ops = {
@@ -873,6 +882,20 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int __exit etm_remove(struct amba_device *adev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	etm_perf_symlink(drvdata->csdev, false);
+
+	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
+	cpuhp_remove_state_nocalls(hp_online);
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int etm_runtime_suspend(struct device *dev)
 {
@@ -933,6 +956,8 @@ static const struct amba_id etm_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, etm_ids);
+
 static struct amba_driver etm_driver = {
 	.drv = {
 		.name	= "coresight-etm3x",
@@ -941,6 +966,12 @@ static struct amba_driver etm_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= etm_probe,
+	.remove		= etm_remove,
 	.id_table	= etm_ids,
 };
-builtin_amba_driver(etm_driver);
+module_amba_driver(etm_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index d21961710713..04119b963454 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -17,6 +17,7 @@
 
 #include <linux/pm_runtime.h>
 #include <linux/sysfs.h>
+#include <linux/coresight.h>
 #include "coresight-etm4x.h"
 #include "coresight-priv.h"
 
@@ -2155,3 +2156,8 @@ const struct attribute_group *coresight_etmv4_groups[] = {
 	&coresight_etmv4_trcidr_group,
 	NULL,
 };
+EXPORT_SYMBOL_GPL(coresight_etmv4_groups);
+
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace v4 sysfs driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index cf364a514c12..24e50f430e59 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -287,7 +287,12 @@ static int etm4_enable(struct coresight_device *csdev,
 {
 	int ret;
 	u32 val;
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
+
+	if (!try_module_get(module))
+		return -ENODEV;
 
 	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
 
@@ -394,7 +399,9 @@ static void etm4_disable(struct coresight_device *csdev,
 			 struct perf_event *event)
 {
 	u32 mode;
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
 
 	/*
 	 * For as long as the tracer isn't disabled another entity can't
@@ -416,6 +423,8 @@ static void etm4_disable(struct coresight_device *csdev,
 
 	if (mode)
 		local_set(&drvdata->mode, CS_MODE_DISABLED);
+
+	module_put(module);
 }
 
 static const struct coresight_ops_source etm4_source_ops = {
@@ -1052,6 +1061,20 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int __exit etm4_remove(struct amba_device *adev)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	etm_perf_symlink(drvdata->csdev, false);
+
+	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
+	cpuhp_remove_state_nocalls(hp_online);
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 static const struct amba_id etm4_ids[] = {
 	{       /* ETM 4.0 - Cortex-A53  */
 		.id	= 0x000bb95d,
@@ -1071,12 +1094,21 @@ static const struct amba_id etm4_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, etm4_ids);
+
 static struct amba_driver etm4x_driver = {
 	.drv = {
 		.name   = "coresight-etm4x",
+		.owner  = THIS_MODULE,
 		.suppress_bind_attrs = true,
 	},
 	.probe		= etm4_probe,
+	.remove		= etm4_remove,
 	.id_table	= etm4_ids,
 };
-builtin_amba_driver(etm4x_driver);
+module_amba_driver(etm4x_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace v4 driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 9f8ac0bef853..8909c3b60719 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -68,7 +68,12 @@ static void funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
 static int funnel_enable(struct coresight_device *csdev, int inport,
 			 int outport)
 {
-	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct funnel_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
+
+	if (!try_module_get(module))
+		return -ENODEV;
 
 	funnel_enable_hw(drvdata, inport);
 
@@ -92,10 +97,13 @@ static void funnel_disable_hw(struct funnel_drvdata *drvdata, int inport)
 static void funnel_disable(struct coresight_device *csdev, int inport,
 			   int outport)
 {
-	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct funnel_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
 
 	funnel_disable_hw(drvdata, inport);
 
+	module_put(module);
 	dev_info(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
 }
 
@@ -218,6 +226,15 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 	return PTR_ERR_OR_ZERO(drvdata->csdev);
 }
 
+static int __exit funnel_remove(struct amba_device *adev)
+{
+	struct funnel_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int funnel_runtime_suspend(struct device *dev)
 {
@@ -257,6 +274,8 @@ static const struct amba_id funnel_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, funnel_ids);
+
 static struct amba_driver funnel_driver = {
 	.drv = {
 		.name	= "coresight-funnel",
@@ -265,6 +284,11 @@ static struct amba_driver funnel_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= funnel_probe,
+	.remove		= funnel_remove,
 	.id_table	= funnel_ids,
 };
-builtin_amba_driver(funnel_driver);
+module_amba_driver(funnel_driver);
+
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("ARM Coresight Funnel Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index f1d0e21d8cab..335bca44b42d 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -64,7 +64,13 @@ static DEVICE_ATTR_RO(name)
 #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
 	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
 
-extern const u32 barrier_pkt[5];
+/*
+ * When losing synchronisation a new barrier packet needs to be inserted at the
+ * beginning of the data collected in a buffer.  That way the decoder knows that
+ * it needs to look for another sync sequence.
+ */
+static const u32 barrier_pkt[5] = {0x7fffffff, 0x7fffffff,
+				   0x7fffffff, 0x7fffffff, 0x0};
 
 enum etm_addr_type {
 	ETM_ADDR_TYPE_NONE,
@@ -143,7 +149,7 @@ struct list_head *coresight_build_path(struct coresight_device *csdev,
 				       struct coresight_device *sink);
 void coresight_release_path(struct list_head *path);
 
-#ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 extern int etm_readl_cp14(u32 off, unsigned int *val);
 extern int etm_writel_cp14(u32 off, u32 val);
 #else
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 3756e71cb8f5..2a2514fb9c95 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -40,7 +40,12 @@ struct replicator_drvdata {
 static int replicator_enable(struct coresight_device *csdev, int inport,
 			     int outport)
 {
-	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct replicator_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
+
+	if (!try_module_get(module))
+		return -ENODEV;
 
 	dev_info(drvdata->dev, "REPLICATOR enabled\n");
 	return 0;
@@ -49,8 +54,11 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 static void replicator_disable(struct coresight_device *csdev, int inport,
 			       int outport)
 {
-	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct replicator_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
 
+	module_put(module);
 	dev_info(drvdata->dev, "REPLICATOR disabled\n");
 }
 
@@ -119,6 +127,17 @@ static int replicator_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __exit replicator_remove(struct platform_device *pdev)
+{
+	struct replicator_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	coresight_unregister(drvdata->csdev);
+
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int replicator_runtime_suspend(struct device *dev)
 {
@@ -151,8 +170,11 @@ static const struct of_device_id replicator_match[] = {
 	{}
 };
 
+MODULE_DEVICE_TABLE(of, replicator_match);
+
 static struct platform_driver replicator_driver = {
 	.probe          = replicator_probe,
+	.remove         = replicator_remove,
 	.driver         = {
 		.name   = "coresight-replicator",
 		.of_match_table = replicator_match,
@@ -160,4 +182,9 @@ static struct platform_driver replicator_driver = {
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(replicator_driver);
+module_platform_driver(replicator_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("ARM Coresight Replicator Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 15e7ef3891f5..6e7c7c4f22cd 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -201,7 +201,12 @@ static int stm_enable(struct coresight_device *csdev,
 		      struct perf_event *event, u32 mode)
 {
 	u32 val;
-	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct stm_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
+
+	if (!try_module_get(module))
+		return -ENODEV;
 
 	if (mode != CS_MODE_SYSFS)
 		return -EINVAL;
@@ -889,6 +894,17 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int __exit stm_remove(struct amba_device *adev)
+{
+	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+
+	stm_unregister_device(&drvdata->stm);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int stm_runtime_suspend(struct device *dev)
 {
@@ -929,6 +945,8 @@ static const struct amba_id stm_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, stm_ids);
+
 static struct amba_driver stm_driver = {
 	.drv = {
 		.name   = "coresight-stm",
@@ -937,7 +955,12 @@ static struct amba_driver stm_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe          = stm_probe,
+	.remove         = stm_remove,
 	.id_table	= stm_ids,
 };
 
-builtin_amba_driver(stm_driver);
+module_amba_driver(stm_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight System Trace Macrocell driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index e2513b786242..971f04d1a5b4 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -628,3 +628,5 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 
 	return 0;
 }
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 027d7f237ab2..5f00ef3c8627 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -341,3 +341,5 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 
 	return 0;
 }
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 0ea04f588de0..3fe0fccb7367 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -437,6 +437,31 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int __exit tmc_remove(struct amba_device *adev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	/* free ETB/ETF or ETR buffer allocations */
+	switch (drvdata->config_type) {
+	case TMC_CONFIG_TYPE_ETB:
+	case TMC_CONFIG_TYPE_ETF:
+		kfree(drvdata->buf);
+		break;
+	case TMC_CONFIG_TYPE_ETR:
+		if (drvdata->vaddr)
+			dma_free_coherent(drvdata->dev, drvdata->size,
+					  drvdata->vaddr, drvdata->paddr);
+		break;
+	default:
+		break;
+	}
+
+	misc_deregister(&drvdata->miscdev);
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 static const struct amba_id tmc_ids[] = {
 	{
 		.id     = 0x000bb961,
@@ -461,6 +486,8 @@ static const struct amba_id tmc_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, tmc_ids);
+
 static struct amba_driver tmc_driver = {
 	.drv = {
 		.name   = "coresight-tmc",
@@ -468,6 +495,11 @@ static struct amba_driver tmc_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= tmc_probe,
+	.remove		= tmc_remove,
 	.id_table	= tmc_ids,
 };
-builtin_amba_driver(tmc_driver);
+module_amba_driver(tmc_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 805f7c2210fe..3fc208cca3a3 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -76,7 +76,12 @@ static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
 
 static int tpiu_enable(struct coresight_device *csdev, u32 mode)
 {
-	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct tpiu_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
+
+	if (!try_module_get(module))
+		return -ENODEV;
 
 	tpiu_enable_hw(drvdata);
 
@@ -102,10 +107,13 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
 
 static void tpiu_disable(struct coresight_device *csdev)
 {
-	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *parent_dev = csdev->dev.parent;
+	struct tpiu_drvdata *drvdata = dev_get_drvdata(parent_dev);
+	struct module *module = parent_dev->driver->owner;
 
 	tpiu_disable_hw(drvdata);
 
+	module_put(module);
 	dev_info(drvdata->dev, "TPIU disabled\n");
 }
 
@@ -171,6 +179,15 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	return PTR_ERR_OR_ZERO(drvdata->csdev);
 }
 
+static int __exit tpiu_remove(struct amba_device *adev)
+{
+	struct tpiu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int tpiu_runtime_suspend(struct device *dev)
 {
@@ -214,6 +231,8 @@ static const struct amba_id tpiu_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, tpiu_ids);
+
 static struct amba_driver tpiu_driver = {
 	.drv = {
 		.name	= "coresight-tpiu",
@@ -222,6 +241,12 @@ static struct amba_driver tpiu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= tpiu_probe,
+	.remove		= tpiu_remove,
 	.id_table	= tpiu_ids,
 };
-builtin_amba_driver(tpiu_driver);
+module_amba_driver(tpiu_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight TPIU (Trace Port Interface Unit) driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 389c4baeca9d..5da8c3daba95 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -24,9 +24,32 @@
 #include <linux/of_platform.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched.h>
 
 #include "coresight-priv.h"
 
+#ifdef CONFIG_PID_NS
+unsigned long coresight_vpid_to_pid(unsigned long vpid)
+{
+	struct task_struct *task = NULL;
+	unsigned long pid = 0;
+
+	rcu_read_lock();
+	task = find_task_by_vpid(vpid);
+	if (task)
+		pid = task_pid_nr(task);
+	rcu_read_unlock();
+
+	return pid;
+}
+#else
+unsigned long coresight_vpid_to_pid(unsigned long vpid)
+{
+	return vpid;
+}
+#endif
+EXPORT_SYMBOL_GPL(coresight_vpid_to_pid);
+
 static DEFINE_MUTEX(coresight_mutex);
 
 /**
@@ -53,14 +76,6 @@ static DEFINE_PER_CPU(struct list_head *, tracer_path);
  */
 static struct list_head *stm_path;
 
-/*
- * When losing synchronisation a new barrier packet needs to be inserted at the
- * beginning of the data collected in a buffer.  That way the decoder knows that
- * it needs to look for another sync sequence.
- */
-const u32 barrier_pkt[5] = {0x7fffffff, 0x7fffffff,
-			    0x7fffffff, 0x7fffffff, 0x0};
-
 static int coresight_id_match(struct device *dev, void *data)
 {
 	int trace_id, i_trace_id;
@@ -317,6 +332,7 @@ void coresight_disable_path(struct list_head *path)
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(coresight_disable_path);
 
 int coresight_enable_path(struct list_head *path, u32 mode)
 {
@@ -368,6 +384,7 @@ int coresight_enable_path(struct list_head *path, u32 mode)
 	coresight_disable_path(path);
 	goto out;
 }
+EXPORT_SYMBOL_GPL(coresight_enable_path);
 
 struct coresight_device *coresight_get_sink(struct list_head *path)
 {
@@ -383,6 +400,7 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
 
 	return csdev;
 }
+EXPORT_SYMBOL_GPL(coresight_get_sink);
 
 static int coresight_enabled_sink(struct device *dev, void *data)
 {
@@ -407,6 +425,7 @@ static int coresight_enabled_sink(struct device *dev, void *data)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(coresight_enabled_sink);
 
 /**
  * coresight_get_enabled_sink - returns the first enabled sink found on the bus
@@ -429,6 +448,7 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
 
 	return dev ? to_coresight_device(dev) : NULL;
 }
+EXPORT_SYMBOL_GPL(coresight_get_enabled_sink);
 
 /**
  * _coresight_build_path - recursively build a path from a @csdev to a sink.
@@ -508,6 +528,7 @@ struct list_head *coresight_build_path(struct coresight_device *source,
 
 	return path;
 }
+EXPORT_SYMBOL_GPL(coresight_build_path);
 
 /**
  * coresight_release_path - release a previously built path.
@@ -532,6 +553,7 @@ void coresight_release_path(struct list_head *path)
 	kfree(path);
 	path = NULL;
 }
+EXPORT_SYMBOL_GPL(coresight_release_path);
 
 /** coresight_validate_source - make sure a source has the right credentials
  *  @csdev:	the device structure for a source.
@@ -948,6 +970,7 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
 
 	return -EAGAIN;
 }
+EXPORT_SYMBOL_GPL(coresight_timeout);
 
 struct bus_type coresight_bustype = {
 	.name	= "coresight",
@@ -959,6 +982,12 @@ static int __init coresight_init(void)
 }
 postcore_initcall(coresight_init);
 
+static void __exit coresight_exit(void)
+{
+	bus_unregister(&coresight_bustype);
+}
+module_exit(coresight_exit);
+
 struct coresight_device *coresight_register(struct coresight_desc *desc)
 {
 	int i;
@@ -1056,3 +1085,7 @@ void coresight_unregister(struct coresight_device *csdev)
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
+
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("ARM Coresight Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d950dad5056a..5863eb1a7335 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -243,7 +243,7 @@ struct coresight_ops {
 	const struct coresight_ops_source *source_ops;
 };
 
-#ifdef CONFIG_CORESIGHT
+#if IS_ENABLED(CONFIG_CORESIGHT)
 extern struct coresight_device *
 coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
@@ -274,24 +274,5 @@ static inline struct coresight_platform_data *of_get_coresight_platform_data(
 	struct device *dev, const struct device_node *node) { return NULL; }
 #endif
 
-#ifdef CONFIG_PID_NS
-static inline unsigned long
-coresight_vpid_to_pid(unsigned long vpid)
-{
-	struct task_struct *task = NULL;
-	unsigned long pid = 0;
-
-	rcu_read_lock();
-	task = find_task_by_vpid(vpid);
-	if (task)
-		pid = task_pid_nr(task);
-	rcu_read_unlock();
-
-	return pid;
-}
-#else
-static inline unsigned long
-coresight_vpid_to_pid(unsigned long vpid) { return vpid; }
-#endif
-
+extern unsigned long coresight_vpid_to_pid(unsigned long vpid);
 #endif
-- 
2.17.0
