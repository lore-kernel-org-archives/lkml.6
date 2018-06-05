Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeFEVLA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:11:00 -0400
Received: from foss.arm.com ([217.140.101.70]:33672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752658AbeFEVHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:07:48 -0400
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
Subject: [PATCH v4 13/14] coresight: allow funnel and replicator drivers to be built as modules
Date: Tue,  5 Jun 2018 16:07:09 -0500
Message-Id: <20180605210710.22227-14-kim.phillips@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180605210710.22227-1-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to build coresight-funnel and coresight-replicator as modules,
for ease of development.

- Kconfig becomes a tristate, to allow =m
- add funnel_remove and replicator_remove functions,
  for module unload
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
 .../hwtracing/coresight/coresight-funnel.c    | 18 ++++++++++++++-
 .../coresight/coresight-replicator.c          | 22 ++++++++++++++++++-
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index ae05b4b89ff9..181a44ea2d61 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -14,13 +14,16 @@ menuconfig CORESIGHT
 
 if CORESIGHT
 config CORESIGHT_LINKS_AND_SINKS
-	bool "CoreSight Link and Sink drivers"
+	tristate "CoreSight Link and Sink drivers"
 	help
 	  This enables support for CoreSight link and sink drivers that are
 	  responsible for transporting and collecting the trace data
 	  respectively.  Link and sinks are dynamically aggregated with a trace
 	  entity at run time to form a complete trace path.
 
+	  To compile these drivers as modules, choose M here: the
+	  modules will be called coresight-funnel and coresight-replicator.
+
 config CORESIGHT_LINK_AND_SINK_TMC
 	tristate "Coresight generic TMC driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 448145a36675..861ac641a716 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -211,6 +211,15 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
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
@@ -250,6 +259,8 @@ static const struct amba_id funnel_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, funnel_ids);
+
 static struct amba_driver funnel_driver = {
 	.drv = {
 		.name	= "coresight-funnel",
@@ -258,6 +269,11 @@ static struct amba_driver funnel_driver = {
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
+MODULE_DESCRIPTION("Arm CoreSight Funnel Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 8d2eaaab6c2f..1fb469d7cf50 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -112,6 +112,17 @@ static int replicator_probe(struct platform_device *pdev)
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
@@ -144,13 +155,22 @@ static const struct of_device_id replicator_match[] = {
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
+		.owner	= THIS_MODULE,
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(replicator_driver);
+module_platform_driver(replicator_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Replicator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
