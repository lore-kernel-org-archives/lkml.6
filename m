Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD4BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540E62086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZsRbWAGn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FEHbmJ5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfBUMSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:18:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:18:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 04B32608EA; Thu, 21 Feb 2019 12:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550751524;
        bh=ag5jbffPBURqwFzN6r4PVGK9Nh/rEWNzRySoJE7rNsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZsRbWAGnm3auKxDr3HkCukQGtcsEI4hHKcREgWg8EZXeMwqiEp/b1mKdFVRGdGcCY
         ZeiRWJfyMXpHyJu8CldCnqKB8gU4R+vzW/Gy2HyCjmafXjk7fkLH3mleUBtIM0c83L
         uLNaYspSCY4nAMOPtJYJr9UJVYROnQOc3stZ7100=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94D2E6074F;
        Thu, 21 Feb 2019 12:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550751521;
        bh=ag5jbffPBURqwFzN6r4PVGK9Nh/rEWNzRySoJE7rNsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEHbmJ5Bf+QfHSmgk1cbfn93cyeENgT1OOUJmSRGJYTxdetF+RJXR5ShqFUZLjCun
         YlLa11t4OdlBGIvYpPXdIFf9q7PsNNmGF6gjjU2xwhSDtHbBXOIzYxCMsBwn27L8/Q
         CzCvg394nmHLuV0uC1f/bi2xMBj9AbISu06/6Czg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94D2E6074F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RESEND v3 1/3] drivers: qcom: rpmh-rsc: simplify TCS locking
Date:   Thu, 21 Feb 2019 17:48:25 +0530
Message-Id: <20190221121827.32427-2-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221121827.32427-1-rplsssn@codeaurora.org>
References: <20190221121827.32427-1-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcs->lock was introduced to serialize access with in TCS group. But
even without tcs->lock, drv->lock is serving the same purpose. So
use single drv->lock.

Other optimizations include -
 - Remove locking around clear_bit() in IRQ handler. clear_bit() is
   atomic.
 - Remove redundant read of TCS registers.
 - Use spin_lock instead of _irq variants as the locks are not held
   in interrupt context

Suggested-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  2 --
 drivers/soc/qcom/rpmh-rsc.c      | 37 +++++++++++---------------------
 drivers/soc/qcom/rpmh.c          | 20 +++++++----------
 3 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 8c316b4d36dc..2e3ffcdf220e 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -28,7 +28,6 @@ struct rsc_drv;
  * @offset:    start of the TCS group relative to the TCSes in the RSC
  * @num_tcs:   number of TCSes in this type
  * @ncpt:      number of commands in each TCS
- * @lock:      lock for synchronizing this TCS writes
  * @req:       requests that are sent from the TCS
  * @cmd_cache: flattened cache of cmds in sleep/wake TCS
  * @slots:     indicates which of @cmd_addr are occupied
@@ -40,7 +39,6 @@ struct tcs_group {
 	u32 offset;
 	int num_tcs;
 	int ncpt;
-	spinlock_t lock;
 	const struct tcs_request *req[MAX_TCS_PER_TYPE];
 	u32 *cmd_cache;
 	DECLARE_BITMAP(slots, MAX_TCS_SLOTS);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 73d5b9802a29..d6b834eeeb37 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -98,8 +98,7 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
 
 static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
 {
-	return !test_bit(tcs_id, drv->tcs_in_use) &&
-	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id, 0);
+	return !test_bit(tcs_id, drv->tcs_in_use);
 }
 
 static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
@@ -109,29 +108,28 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
 
 static int tcs_invalidate(struct rsc_drv *drv, int type)
 {
-	int m;
+	int m, ret = 0;
 	struct tcs_group *tcs;
 
 	tcs = get_tcs_of_type(drv, type);
 
-	spin_lock(&tcs->lock);
-	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
-		spin_unlock(&tcs->lock);
-		return 0;
-	}
+	spin_lock(&drv->lock);
+	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS))
+		goto done;
 
 	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
 		if (!tcs_is_free(drv, m)) {
-			spin_unlock(&tcs->lock);
-			return -EAGAIN;
+			ret = -EAGAIN;
+			goto done;
 		}
 		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
 		write_tcs_reg_sync(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
 	}
 	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
-	spin_unlock(&tcs->lock);
 
-	return 0;
+done:
+	spin_unlock(&drv->lock);
+	return ret;
 }
 
 /**
@@ -298,9 +296,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
 		write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, i, 0);
 		write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, BIT(i));
-		spin_lock(&drv->lock);
 		clear_bit(i, drv->tcs_in_use);
-		spin_unlock(&drv->lock);
 		if (req)
 			rpmh_tx_done(req, err);
 	}
@@ -383,14 +379,12 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
 {
 	struct tcs_group *tcs;
 	int tcs_id;
-	unsigned long flags;
 	int ret;
 
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
 		return PTR_ERR(tcs);
 
-	spin_lock_irqsave(&tcs->lock, flags);
 	spin_lock(&drv->lock);
 	/*
 	 * The h/w does not like if we send a request to the same address,
@@ -398,14 +392,12 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
 	 */
 	ret = check_for_req_inflight(drv, tcs, msg);
 	if (ret) {
-		spin_unlock(&drv->lock);
 		goto done_write;
 	}
 
 	tcs_id = find_free_tcs(tcs);
 	if (tcs_id < 0) {
 		ret = tcs_id;
-		spin_unlock(&drv->lock);
 		goto done_write;
 	}
 
@@ -413,13 +405,12 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
 	set_bit(tcs_id, drv->tcs_in_use);
 	if (msg->state == RPMH_ACTIVE_ONLY_STATE && tcs->type != ACTIVE_TCS)
 		enable_tcs_irq(drv, tcs_id, true);
-	spin_unlock(&drv->lock);
 
 	__tcs_buffer_write(drv, tcs_id, 0, msg);
 	__tcs_trigger(drv, tcs_id, true);
 
 done_write:
-	spin_unlock_irqrestore(&tcs->lock, flags);
+	spin_unlock(&drv->lock);
 	return ret;
 }
 
@@ -517,19 +508,18 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
 {
 	struct tcs_group *tcs;
 	int tcs_id = 0, cmd_id = 0;
-	unsigned long flags;
 	int ret;
 
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
 		return PTR_ERR(tcs);
 
-	spin_lock_irqsave(&tcs->lock, flags);
+	spin_lock(&drv->lock);
 	/* find the TCS id and the command in the TCS to write to */
 	ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
 	if (!ret)
 		__tcs_buffer_write(drv, tcs_id, cmd_id, msg);
-	spin_unlock_irqrestore(&tcs->lock, flags);
+	spin_unlock(&drv->lock);
 
 	return ret;
 }
@@ -638,7 +628,6 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 		tcs->type = tcs_cfg[i].type;
 		tcs->num_tcs = tcs_cfg[i].n;
 		tcs->ncpt = ncpt;
-		spin_lock_init(&tcs->lock);
 
 		if (!tcs->num_tcs || tcs->type == CONTROL_TCS)
 			continue;
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 71a76eaa4b63..297d6cc4e395 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -117,9 +117,8 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 					   struct tcs_cmd *cmd)
 {
 	struct cache_req *req;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	spin_lock(&ctrlr->cache_lock);
 	req = __find_req(ctrlr, cmd->addr);
 	if (req)
 		goto existing;
@@ -153,7 +152,7 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 
 	ctrlr->dirty = true;
 unlock:
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+	spin_unlock(&ctrlr->cache_lock);
 
 	return req;
 }
@@ -283,23 +282,21 @@ EXPORT_SYMBOL(rpmh_write);
 
 static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
 {
-	unsigned long flags;
 
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	spin_lock(&ctrlr->cache_lock);
 	list_add_tail(&req->list, &ctrlr->batch_cache);
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+	spin_unlock(&ctrlr->cache_lock);
 }
 
 static int flush_batch(struct rpmh_ctrlr *ctrlr)
 {
 	struct batch_cache_req *req;
 	const struct rpmh_request *rpm_msg;
-	unsigned long flags;
 	int ret = 0;
 	int i;
 
 	/* Send Sleep/Wake requests to the controller, expect no response */
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	spin_lock(&ctrlr->cache_lock);
 	list_for_each_entry(req, &ctrlr->batch_cache, list) {
 		for (i = 0; i < req->count; i++) {
 			rpm_msg = req->rpm_msgs + i;
@@ -309,7 +306,7 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
 				break;
 		}
 	}
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+	spin_unlock(&ctrlr->cache_lock);
 
 	return ret;
 }
@@ -317,13 +314,12 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
 static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
 {
 	struct batch_cache_req *req, *tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	spin_lock(&ctrlr->cache_lock);
 	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
 		kfree(req);
 	INIT_LIST_HEAD(&ctrlr->batch_cache);
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+	spin_unlock(&ctrlr->cache_lock);
 }
 
 /**
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

