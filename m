Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033123AbeCAQ0n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:26:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43970 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1032977AbeCAQYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:24:19 -0500
From: Loic Pallardy <loic.pallardy@st.com>
To: <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v3 08/13] remoteproc: add prepare and unprepare ops
Date: Thu, 1 Mar 2018 17:23:55 +0100
Message-ID: <1519921440-21356-9-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some SoC architecture, it is needed to enable HW like
clock, bus, regulator, memory region... before loading
co-processor firmware.

This patch introduces prepare and unprepare ops to execute
platform specific function before firmware loading and after
stop execution.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 20 +++++++++++++++++++-
 include/linux/remoteproc.h           |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 7a500cb..0ebbc4f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1058,12 +1058,22 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 		return ret;
 	}
 
+	/* Prepare rproc for firmware loading if needed */
+	if (rproc->ops->prepare) {
+		ret = rproc->ops->prepare(rproc);
+		if (ret) {
+			dev_err(dev, "can't prepare rproc %s: %d\n",
+				rproc->name, ret);
+			goto disable_iommu;
+		}
+	}
+
 	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
 
 	/* load resource table */
 	ret = rproc_load_rsc_table(rproc, fw);
 	if (ret)
-		goto disable_iommu;
+		goto unprepare_rproc;
 
 	/* reset max_notifyid */
 	rproc->max_notifyid = -1;
@@ -1086,6 +1096,10 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
 	rproc->table_ptr = NULL;
+unprepare_rproc:
+	/* release HW resources if needed */
+	if (rproc->ops->unprepare)
+		rproc->ops->unprepare(rproc);
 disable_iommu:
 	rproc_disable_iommu(rproc);
 	return ret;
@@ -1331,6 +1345,10 @@ void rproc_shutdown(struct rproc *rproc)
 	/* clean up all acquired resources */
 	rproc_resource_cleanup(rproc);
 
+	/* release HW resources if needed */
+	if (rproc->ops->unprepare)
+		rproc->ops->unprepare(rproc);
+
 	rproc_disable_iommu(rproc);
 
 	/* Free the copy of the resource table */
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 4aa30bd..dcfa601 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -333,6 +333,8 @@ struct rproc_mem_entry {
 
 /**
  * struct rproc_ops - platform-specific device handlers
+ * @prepare:	prepare device for code loading
+ * @unprepare:	unprepare device after stop
  * @start:	power on the device and boot it
  * @stop:	power off the device
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
@@ -345,6 +347,8 @@ struct rproc_mem_entry {
  * @get_boot_addr:	get boot address to entry point specified in firmware
  */
 struct rproc_ops {
+	int (*prepare)(struct rproc *rproc);
+	int (*unprepare)(struct rproc *rproc);
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
-- 
1.9.1
