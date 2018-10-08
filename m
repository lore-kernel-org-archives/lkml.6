Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544EDC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D87B20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D87B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJHSVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:21:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54060 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbeJHSVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:21:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B4F01A0045;
        Mon,  8 Oct 2018 13:10:38 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E9F11A0026;
        Mon,  8 Oct 2018 13:10:38 +0200 (CEST)
Received: from enigma.ea.freescale.net (enigma.ea.freescale.net [10.171.81.110])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id ADA3C205D0;
        Mon,  8 Oct 2018 13:10:37 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: caam/qi - simplify CGR allocation, freeing
Date:   Mon,  8 Oct 2018 14:09:37 +0300
Message-Id: <20181008110937.29198-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20181005125443.dfhd2asqktm22ney@linutronix.de>
References: <20181005125443.dfhd2asqktm22ney@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CGRs (Congestion Groups) have to be freed by the same CPU that
initialized them.
This is why currently the driver takes special measures; however, using
set_cpus_allowed_ptr() is incorrect - as reported by Sebastian.

Instead of the generic solution of replacing set_cpus_allowed_ptr() with
work_on_cpu_safe(), we use the qman_delete_cgr_safe() QBMan API instead
of qman_delete_cgr() - which internally takes care of proper CGR
deletion.

Link: https://lkml.kernel.org/r/20181005125443.dfhd2asqktm22ney@linutronix.de
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/qi.c | 43 ++++---------------------------------------
 drivers/crypto/caam/qi.h |  2 +-
 2 files changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
index 67f7f8c42c93..b84e6c8b1e13 100644
--- a/drivers/crypto/caam/qi.c
+++ b/drivers/crypto/caam/qi.c
@@ -83,13 +83,6 @@ EXPORT_SYMBOL(caam_congested);
 static u64 times_congested;
 #endif
 
-/*
- * CPU from where the module initialised. This is required because QMan driver
- * requires CGRs to be removed from same CPU from where they were originally
- * allocated.
- */
-static int mod_init_cpu;
-
 /*
  * This is a a cache of buffers, from which the users of CAAM QI driver
  * can allocate short (CAAM_QI_MEMCACHE_SIZE) buffers. It's faster than
@@ -492,12 +485,11 @@ void caam_drv_ctx_rel(struct caam_drv_ctx *drv_ctx)
 }
 EXPORT_SYMBOL(caam_drv_ctx_rel);
 
-int caam_qi_shutdown(struct device *qidev)
+void caam_qi_shutdown(struct device *qidev)
 {
-	int i, ret;
+	int i;
 	struct caam_qi_priv *priv = dev_get_drvdata(qidev);
 	const cpumask_t *cpus = qman_affine_cpus();
-	struct cpumask old_cpumask = current->cpus_allowed;
 
 	for_each_cpu(i, cpus) {
 		struct napi_struct *irqtask;
@@ -510,26 +502,12 @@ int caam_qi_shutdown(struct device *qidev)
 			dev_err(qidev, "Rsp FQ kill failed, cpu: %d\n", i);
 	}
 
-	/*
-	 * QMan driver requires CGRs to be deleted from same CPU from where they
-	 * were instantiated. Hence we get the module removal execute from the
-	 * same CPU from where it was originally inserted.
-	 */
-	set_cpus_allowed_ptr(current, get_cpu_mask(mod_init_cpu));
-
-	ret = qman_delete_cgr(&priv->cgr);
-	if (ret)
-		dev_err(qidev, "Deletion of CGR failed: %d\n", ret);
-	else
-		qman_release_cgrid(priv->cgr.cgrid);
+	qman_delete_cgr_safe(&priv->cgr);
+	qman_release_cgrid(priv->cgr.cgrid);
 
 	kmem_cache_destroy(qi_cache);
 
-	/* Now that we're done with the CGRs, restore the cpus allowed mask */
-	set_cpus_allowed_ptr(current, &old_cpumask);
-
 	platform_device_unregister(priv->qi_pdev);
-	return ret;
 }
 
 static void cgr_cb(struct qman_portal *qm, struct qman_cgr *cgr, int congested)
@@ -718,22 +696,11 @@ int caam_qi_init(struct platform_device *caam_pdev)
 	struct device *ctrldev = &caam_pdev->dev, *qidev;
 	struct caam_drv_private *ctrlpriv;
 	const cpumask_t *cpus = qman_affine_cpus();
-	struct cpumask old_cpumask = current->cpus_allowed;
 	static struct platform_device_info qi_pdev_info = {
 		.name = "caam_qi",
 		.id = PLATFORM_DEVID_NONE
 	};
 
-	/*
-	 * QMAN requires CGRs to be removed from same CPU+portal from where it
-	 * was originally allocated. Hence we need to note down the
-	 * initialisation CPU and use the same CPU for module exit.
-	 * We select the first CPU to from the list of portal owning CPUs.
-	 * Then we pin module init to this CPU.
-	 */
-	mod_init_cpu = cpumask_first(cpus);
-	set_cpus_allowed_ptr(current, get_cpu_mask(mod_init_cpu));
-
 	qi_pdev_info.parent = ctrldev;
 	qi_pdev_info.dma_mask = dma_get_mask(ctrldev);
 	qi_pdev = platform_device_register_full(&qi_pdev_info);
@@ -795,8 +762,6 @@ int caam_qi_init(struct platform_device *caam_pdev)
 		return -ENOMEM;
 	}
 
-	/* Done with the CGRs; restore the cpus allowed mask */
-	set_cpus_allowed_ptr(current, &old_cpumask);
 #ifdef CONFIG_DEBUG_FS
 	debugfs_create_file("qi_congested", 0444, ctrlpriv->ctl,
 			    &times_congested, &caam_fops_u64_ro);
diff --git a/drivers/crypto/caam/qi.h b/drivers/crypto/caam/qi.h
index bc421da5ad8b..f93c9c7ed430 100644
--- a/drivers/crypto/caam/qi.h
+++ b/drivers/crypto/caam/qi.h
@@ -173,7 +173,7 @@ int caam_drv_ctx_update(struct caam_drv_ctx *drv_ctx, u32 *sh_desc);
 void caam_drv_ctx_rel(struct caam_drv_ctx *drv_ctx);
 
 int caam_qi_init(struct platform_device *pdev);
-int caam_qi_shutdown(struct device *dev);
+void caam_qi_shutdown(struct device *dev);
 
 /**
  * qi_cache_alloc - Allocate buffers from CAAM-QI cache
-- 
2.16.2

