Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeFEVHw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:07:52 -0400
Received: from foss.arm.com ([217.140.101.70]:33700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752665AbeFEVHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:07:49 -0400
From: Kim Phillips <kim.phillips@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH v4 14/14] coresight: allow the coresight core driver to be built as a module
Date: Tue,  5 Jun 2018 16:07:10 -0500
Message-Id: <20180605210710.22227-15-kim.phillips@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180605210710.22227-1-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to build coresight as a module.  This enhances
coresight developer efficiency by allowing the development to
take place exclusively on the target, and without needing to
reboot in between changes.

- Kconfig becomes a tristate, to allow =m
- append -core to source file name to allow module to
  be called coresight by the Makefile
- modules can have only one init/exit, so we add the core bus
  register/unregister function calls to the etm_perf init/exit
  functions, since coresight.c does not have etm_pmu defined.
- add a MODULE_DEVICE_TABLE for autoloading on boot

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/Kconfig             |  5 ++++-
 drivers/hwtracing/coresight/Makefile            |  7 +++++--
 .../coresight/{coresight.c => coresight-core.c} |  6 ------
 .../hwtracing/coresight/coresight-etm-perf.c    | 17 ++++++++++++++++-
 4 files changed, 25 insertions(+), 10 deletions(-)
 rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c} (99%)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 181a44ea2d61..c05b265f7731 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -2,7 +2,7 @@
 # Coresight configuration
 #
 menuconfig CORESIGHT
-	bool "CoreSight Tracing Support"
+	tristate "CoreSight Tracing Support"
 	select ARM_AMBA
 	select PERF_EVENTS
 	help
@@ -12,6 +12,9 @@ menuconfig CORESIGHT
 	  specification and configure the right series of components when a
 	  trace source gets enabled.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight.
+
 if CORESIGHT
 config CORESIGHT_LINKS_AND_SINKS
 	tristate "CoreSight Link and Sink drivers"
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 45d7a0f34170..ed2d4bcb017b 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -2,8 +2,11 @@
 #
 # Makefile for CoreSight drivers.
 #
-obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o
-obj-$(CONFIG_OF) += of_coresight.o
+obj-$(CONFIG_CORESIGHT) += coresight.o
+coresight-objs := coresight-core.o  coresight-etm-perf.o
+ifeq ($(CONFIG_OF), y)
+coresight-objs += of_coresight.o
+endif
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-objs := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight-core.c
similarity index 99%
rename from drivers/hwtracing/coresight/coresight.c
rename to drivers/hwtracing/coresight/coresight-core.c
index 1c941351f1d1..f96258de1e9b 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -948,12 +948,6 @@ struct bus_type coresight_bustype = {
 	.name	= "coresight",
 };
 
-static int __init coresight_init(void)
-{
-	return bus_register(&coresight_bustype);
-}
-postcore_initcall(coresight_init);
-
 struct coresight_device *coresight_register(struct coresight_desc *desc)
 {
 	int i;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 0fe7e43ea1c4..ceac9aee4a82 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -472,6 +472,10 @@ static int __init etm_perf_init(void)
 {
 	int ret;
 
+	ret = bus_register(&coresight_bustype);
+	if (ret)
+		return ret;
+
 	etm_pmu.capabilities		= PERF_PMU_CAP_EXCLUSIVE;
 
 	etm_pmu.attr_groups		= etm_pmu_attr_groups;
@@ -494,4 +498,15 @@ static int __init etm_perf_init(void)
 
 	return ret;
 }
-device_initcall(etm_perf_init);
+postcore_initcall(etm_perf_init);
+
+static void __exit etm_perf_exit(void)
+{
+	perf_pmu_unregister(&etm_pmu);
+	bus_unregister(&coresight_bustype);
+}
+module_exit(etm_perf_exit);
+
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight tracer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
