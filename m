Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C470BC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F8220835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F8220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbeJNXNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:13:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36404 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728259AbeJNXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:07 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLu-0004cJ-8Q; Sun, 14 Oct 2018 16:30:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000UC-Cp; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steve Wise" <swise@opengridcomputing.com>,
        "Raju Rangoju" <rajur@chelsio.com>,
        "Doug Ledford" <dledford@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.430864709@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 240/366] RDMA/cxgb4: release hw resources on device
 removal
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Raju Rangoju <rajur@chelsio.com>

commit 26bff1bd74a4f7417509a83295614e9dab995b2a upstream.

The c4iw_rdev_close() logic was not releasing all the hw
resources (PBL and RQT memory) during the device removal
event (driver unload / system reboot). This can cause panic
in gen_pool_destroy().

The module remove function will wait for all the hw
resources to be released during the device removal event.

Fixes c12a67fe(iw_cxgb4: free EQ queue memory on last deref)
Signed-off-by: Raju Rangoju <rajur@chelsio.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -698,6 +698,12 @@ static int c4iw_rdev_open(struct c4iw_rd
 		goto err4;
 	}
 	rdev->status_page->db_off = 0;
+
+	init_completion(&rdev->rqt_compl);
+	init_completion(&rdev->pbl_compl);
+	kref_init(&rdev->rqt_kref);
+	kref_init(&rdev->pbl_kref);
+
 	return 0;
 err4:
 	c4iw_rqtpool_destroy(rdev);
@@ -714,6 +720,8 @@ static void c4iw_rdev_close(struct c4iw_
 	free_page((unsigned long)rdev->status_page);
 	c4iw_pblpool_destroy(rdev);
 	c4iw_rqtpool_destroy(rdev);
+	wait_for_completion(&rdev->pbl_compl);
+	wait_for_completion(&rdev->rqt_compl);
 	c4iw_destroy_resource(&rdev->resource);
 }
 
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -157,6 +157,10 @@ struct c4iw_rdev {
 	void __iomem *oc_mw_kva;
 	struct c4iw_stats stats;
 	struct t4_dev_status_page *status_page;
+	struct completion rqt_compl;
+	struct completion pbl_compl;
+	struct kref rqt_kref;
+	struct kref pbl_kref;
 };
 
 static inline int c4iw_fatal_error(struct c4iw_rdev *rdev)
--- a/drivers/infiniband/hw/cxgb4/resource.c
+++ b/drivers/infiniband/hw/cxgb4/resource.c
@@ -260,12 +260,22 @@ u32 c4iw_pblpool_alloc(struct c4iw_rdev
 		rdev->stats.pbl.cur += roundup(size, 1 << MIN_PBL_SHIFT);
 		if (rdev->stats.pbl.cur > rdev->stats.pbl.max)
 			rdev->stats.pbl.max = rdev->stats.pbl.cur;
+		kref_get(&rdev->pbl_kref);
 	} else
 		rdev->stats.pbl.fail++;
 	mutex_unlock(&rdev->stats.lock);
 	return (u32)addr;
 }
 
+static void destroy_pblpool(struct kref *kref)
+{
+	struct c4iw_rdev *rdev;
+
+	rdev = container_of(kref, struct c4iw_rdev, pbl_kref);
+	gen_pool_destroy(rdev->pbl_pool);
+	complete(&rdev->pbl_compl);
+}
+
 void c4iw_pblpool_free(struct c4iw_rdev *rdev, u32 addr, int size)
 {
 	PDBG("%s addr 0x%x size %d\n", __func__, addr, size);
@@ -273,6 +283,7 @@ void c4iw_pblpool_free(struct c4iw_rdev
 	rdev->stats.pbl.cur -= roundup(size, 1 << MIN_PBL_SHIFT);
 	mutex_unlock(&rdev->stats.lock);
 	gen_pool_free(rdev->pbl_pool, (unsigned long)addr, size);
+	kref_put(&rdev->pbl_kref, destroy_pblpool);
 }
 
 int c4iw_pblpool_create(struct c4iw_rdev *rdev)
@@ -312,7 +323,7 @@ int c4iw_pblpool_create(struct c4iw_rdev
 
 void c4iw_pblpool_destroy(struct c4iw_rdev *rdev)
 {
-	gen_pool_destroy(rdev->pbl_pool);
+	kref_put(&rdev->pbl_kref, destroy_pblpool);
 }
 
 /*
@@ -333,12 +344,22 @@ u32 c4iw_rqtpool_alloc(struct c4iw_rdev
 		rdev->stats.rqt.cur += roundup(size << 6, 1 << MIN_RQT_SHIFT);
 		if (rdev->stats.rqt.cur > rdev->stats.rqt.max)
 			rdev->stats.rqt.max = rdev->stats.rqt.cur;
+		kref_get(&rdev->rqt_kref);
 	} else
 		rdev->stats.rqt.fail++;
 	mutex_unlock(&rdev->stats.lock);
 	return (u32)addr;
 }
 
+static void destroy_rqtpool(struct kref *kref)
+{
+	struct c4iw_rdev *rdev;
+
+	rdev = container_of(kref, struct c4iw_rdev, rqt_kref);
+	gen_pool_destroy(rdev->rqt_pool);
+	complete(&rdev->rqt_compl);
+}
+
 void c4iw_rqtpool_free(struct c4iw_rdev *rdev, u32 addr, int size)
 {
 	PDBG("%s addr 0x%x size %d\n", __func__, addr, size << 6);
@@ -346,6 +367,7 @@ void c4iw_rqtpool_free(struct c4iw_rdev
 	rdev->stats.rqt.cur -= roundup(size << 6, 1 << MIN_RQT_SHIFT);
 	mutex_unlock(&rdev->stats.lock);
 	gen_pool_free(rdev->rqt_pool, (unsigned long)addr, size << 6);
+	kref_put(&rdev->rqt_kref, destroy_rqtpool);
 }
 
 int c4iw_rqtpool_create(struct c4iw_rdev *rdev)
@@ -383,7 +405,7 @@ int c4iw_rqtpool_create(struct c4iw_rdev
 
 void c4iw_rqtpool_destroy(struct c4iw_rdev *rdev)
 {
-	gen_pool_destroy(rdev->rqt_pool);
+	kref_put(&rdev->rqt_kref, destroy_rqtpool);
 }
 
 /*

