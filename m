Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeFEVMA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:12:00 -0400
Received: from foss.arm.com ([217.140.101.70]:33492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752486AbeFEVHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:07:41 -0400
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
Subject: [PATCH v4 07/14] coresight: allow dynamic-replicator to be built as a module
Date: Tue,  5 Jun 2018 16:07:03 -0500
Message-Id: <20180605210710.22227-8-kim.phillips@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180605210710.22227-1-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to build coresight-dynamic-replicator as a module,
for ease of development.

- Kconfig becomes a tristate, to allow =m
- add a replicator_remove function, for module unload
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
 drivers/hwtracing/coresight/Kconfig           |  5 ++++-
 .../coresight/coresight-dynamic-replicator.c  | 19 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 8c5e5407b7dd..945b17ca2eed 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -71,13 +71,16 @@ config CORESIGHT_SOURCE_ETM4X
 	  data tracing may also be available.
 
 config CORESIGHT_DYNAMIC_REPLICATOR
-	bool "CoreSight Programmable Replicator driver"
+	tristate "CoreSight Programmable Replicator driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for dynamic CoreSight replicator link driver.
 	  The programmable ATB replicator allows independent filtering of the
 	  trace data based on the traceid.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-dynamic-replicator.
+
 config CORESIGHT_STM
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
 	tristate "CoreSight System Trace Macrocell driver"
diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index f6d0571ab9dd..b59055097436 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -159,6 +159,15 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
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
@@ -200,13 +209,21 @@ static const struct amba_id replicator_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, replicator_ids);
+
 static struct amba_driver replicator_driver = {
 	.drv = {
 		.name	= "coresight-dynamic-replicator",
+		.owner	= THIS_MODULE,
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 	.probe		= replicator_probe,
+	.remove         = replicator_remove,
 	.id_table	= replicator_ids,
 };
-builtin_amba_driver(replicator_driver);
+module_amba_driver(replicator_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight Dynamic Replicator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
