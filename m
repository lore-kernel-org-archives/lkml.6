Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeERXyQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 19:54:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53849 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbeERXyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 19:54:10 -0400
X-Google-Smtp-Source: AB8JxZos294+e2kuDkmMoRDEk4FYGzlJOOmB1RAHegHzSgnje+wHVkGC92TLx92l4rjhelMzUSPR1w==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] gpu: host1x: Utilize IOMMU mapping for firewall-copied buffers
Date: Sat, 19 May 2018 02:52:31 +0300
Message-Id: <20180518235231.9274-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map firewall-copied buffers into Host1x's IOVA space, otherwise Host1x
CDMA can't access the command buffers and all submitted jobs fail if IOMMU
and Host1x firewall are enabled in the kernels config.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/job.c | 58 +++++++++++++++++++++++++++++++++++-----
 include/linux/host1x.h   |  4 ++-
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index e2f4a4d93d20..57384a5b5059 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -449,10 +449,13 @@ static int validate(struct host1x_firewall *fw, struct host1x_job_gather *g)
 
 static inline int copy_gathers(struct host1x_job *job, struct device *dev)
 {
+	struct host1x *host = dev_get_drvdata(job->channel->dev->parent);
 	struct host1x_firewall fw;
+	dma_addr_t dma_addr;
 	size_t size = 0;
 	size_t offset = 0;
 	unsigned int i;
+	int err;
 
 	fw.job = job;
 	fw.dev = dev;
@@ -466,23 +469,55 @@ static inline int copy_gathers(struct host1x_job *job, struct device *dev)
 		size += g->words * sizeof(u32);
 	}
 
+	if (host->domain)
+		size = iova_align(&host->iova, size);
+
 	/*
 	 * Try a non-blocking allocation from a higher priority pools first,
 	 * as awaiting for the allocation here is a major performance hit.
 	 */
-	job->gather_copy_mapped = dma_alloc_wc(dev, size, &job->gather_copy,
-					       GFP_NOWAIT);
+	job->gather_copy_mapped = dma_alloc_wc(dev, size,
+					       &job->gather_copy_phys,
+ 					       GFP_NOWAIT);
 
 	/* the higher priority allocation failed, try the generic-blocking */
 	if (!job->gather_copy_mapped)
 		job->gather_copy_mapped = dma_alloc_wc(dev, size,
-						       &job->gather_copy,
+						       &job->gather_copy_phys,
 						       GFP_KERNEL);
 	if (!job->gather_copy_mapped)
 		return -ENOMEM;
 
 	job->gather_copy_size = size;
 
+	if (host->domain) {
+		unsigned long shift;
+
+		shift = iova_shift(&host->iova);
+		job->gather_copy_iova_alloc = alloc_iova(
+					&host->iova, size >> shift,
+					host->iova_end >> shift, true);
+		if (!job->gather_copy_iova_alloc)
+			return -ENOMEM;
+
+		job->gather_copy_iova = iova_dma_addr(
+				&host->iova, job->gather_copy_iova_alloc);
+
+		err = iommu_map(host->domain,
+				job->gather_copy_iova,
+				job->gather_copy_phys,
+				size, IOMMU_READ);
+		if (err) {
+			__free_iova(&host->iova, job->gather_copy_iova_alloc);
+			job->gather_copy_iova_alloc = NULL;
+			return err;
+		}
+
+		dma_addr = job->gather_copy_iova;
+	} else {
+		dma_addr = job->gather_copy_phys;
+	}
+
 	for (i = 0; i < job->num_gathers; i++) {
 		struct host1x_job_gather *g = &job->gathers[i];
 		void *gather;
@@ -494,7 +529,7 @@ static inline int copy_gathers(struct host1x_job *job, struct device *dev)
 		host1x_bo_munmap(g->bo, gather);
 
 		/* Store the location in the buffer */
-		g->base = job->gather_copy;
+		g->base = dma_addr;
 		g->offset = offset;
 
 		/* Validate the job */
@@ -582,9 +617,20 @@ void host1x_job_unpin(struct host1x_job *job)
 
 	job->num_unpins = 0;
 
-	if (job->gather_copy_size)
+	if (job->gather_copy_size) {
 		dma_free_wc(job->channel->dev, job->gather_copy_size,
-			    job->gather_copy_mapped, job->gather_copy);
+			    job->gather_copy_mapped, job->gather_copy_phys);
+
+		if (job->gather_copy_iova_alloc) {
+			iommu_unmap(host->domain,
+				    job->gather_copy_iova,
+				    job->gather_copy_size);
+
+			__free_iova(&host->iova, job->gather_copy_iova_alloc);
+
+			job->gather_copy_iova_alloc = NULL;
+		}
+	}
 }
 EXPORT_SYMBOL(host1x_job_unpin);
 
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index 57d26406bdfd..536a678f81d4 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -235,8 +235,10 @@ struct host1x_job {
 	unsigned int num_slots;
 
 	/* Copy of gathers */
+	struct iova *gather_copy_iova_alloc;
 	size_t gather_copy_size;
-	dma_addr_t gather_copy;
+	dma_addr_t gather_copy_iova;
+	dma_addr_t gather_copy_phys;
 	u8 *gather_copy_mapped;
 
 	/* Check if register is marked as an address reg */
-- 
2.17.0
