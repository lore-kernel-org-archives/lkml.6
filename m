Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeFEVMb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:12:31 -0400
Received: from foss.arm.com ([217.140.101.70]:33434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752396AbeFEVHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:07:39 -0400
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
Subject: [PATCH v4 05/14] coresight: get/put module in coresight_build/release_path
Date: Tue,  5 Jun 2018 16:07:01 -0500
Message-Id: <20180605210710.22227-6-kim.phillips@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180605210710.22227-1-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increment the refcnt for driver modules in current use by calling
module_get in coresight_build_path and module_put in release_path.

This prevents driver modules from being unloaded when they are in use,
either in sysfs or perf mode.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 338f1719641c..1c941351f1d1 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -465,6 +465,12 @@ static int _coresight_build_path(struct coresight_device *csdev,
 
 	node->csdev = csdev;
 	list_add(&node->link, path);
+
+	if (!try_module_get(csdev->dev.parent->driver->owner)) {
+		dev_err(&csdev->dev, "could not get coresight driver module\n");
+		return -ENODEV;
+	}
+
 	pm_runtime_get_sync(csdev->dev.parent);
 
 	return 0;
@@ -510,6 +516,9 @@ void coresight_release_path(struct list_head *path)
 		csdev = nd->csdev;
 
 		pm_runtime_put_sync(csdev->dev.parent);
+
+		module_put(csdev->dev.parent->driver->owner);
+
 		list_del(&nd->link);
 		kfree(nd);
 	}
-- 
2.17.0
