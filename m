Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471A9C04EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1008F22549
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS3sYY2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1008F22549
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbeKOIa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:30:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbeKOIa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:30:56 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 381DE22549;
        Wed, 14 Nov 2018 22:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234351;
        bh=qtVBB3itH/IqJpl9eBJ3M+3QWXwWCIOLTWA/qPsRB38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cS3sYY2VpeOQR2rNBlkrDj2YFB2y7k5xYVQypNQPlTh3LuMAEZfq+C2YYWSnpXVHq
         D7AtfrTUY7SaLpY4G7Hv6xMUdr0Emg7UOkx+fBmz8ZCn3VIy27YfCXMD1gWmlVzDEt
         Bz8BYHCwfIjkqrwwSzSTvPvwZJu+bNm7cPA+dJN4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 23/27] qed: Fix blocking/unlimited SPQ entries leak
Date:   Wed, 14 Nov 2018 17:25:12 -0500
Message-Id: <20181114222520.99926-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222520.99926-1-sashal@kernel.org>
References: <20181114222520.99926-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Bolotin <denis.bolotin@cavium.com>

[ Upstream commit 2632f22ebd08da249c2017962a199a0cfb2324bf ]

When there are no SPQ entries left in the free_pool, new entries are
allocated and are added to the unlimited list. When an entry in the pool
is available, the content is copied from the original entry, and the new
entry is sent to the device. qed_spq_post() is not aware of that, so the
additional entry is stored in the original entry as p_post_ent, which can
later be returned to the pool.

Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_sp.h  |  3 ++
 drivers/net/ethernet/qlogic/qed/qed_spq.c | 57 ++++++++++++-----------
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sp.h b/drivers/net/ethernet/qlogic/qed/qed_sp.h
index ab4ad8a1e2a5..01a213d4ee9c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_sp.h
@@ -167,6 +167,9 @@ struct qed_spq_entry {
 	enum spq_mode			comp_mode;
 	struct qed_spq_comp_cb		comp_cb;
 	struct qed_spq_comp_done	comp_done; /* SPQ_MODE_EBLOCK */
+
+	/* Posted entry for unlimited list entry in EBLOCK mode */
+	struct qed_spq_entry		*post_ent;
 };
 
 struct qed_eq {
diff --git a/drivers/net/ethernet/qlogic/qed/qed_spq.c b/drivers/net/ethernet/qlogic/qed/qed_spq.c
index be48d9abd001..0313e9c46979 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_spq.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_spq.c
@@ -687,6 +687,8 @@ static int qed_spq_add_entry(struct qed_hwfn *p_hwfn,
 			/* EBLOCK responsible to free the allocated p_ent */
 			if (p_ent->comp_mode != QED_SPQ_MODE_EBLOCK)
 				kfree(p_ent);
+			else
+				p_ent->post_ent = p_en2;
 
 			p_ent = p_en2;
 		}
@@ -770,6 +772,25 @@ static int qed_spq_pend_post(struct qed_hwfn *p_hwfn)
 				 SPQ_HIGH_PRI_RESERVE_DEFAULT);
 }
 
+/* Avoid overriding of SPQ entries when getting out-of-order completions, by
+ * marking the completions in a bitmap and increasing the chain consumer only
+ * for the first successive completed entries.
+ */
+static void qed_spq_comp_bmap_update(struct qed_hwfn *p_hwfn, __le16 echo)
+{
+	u16 pos = le16_to_cpu(echo) % SPQ_RING_SIZE;
+	struct qed_spq *p_spq = p_hwfn->p_spq;
+
+	__set_bit(pos, p_spq->p_comp_bitmap);
+	while (test_bit(p_spq->comp_bitmap_idx,
+			p_spq->p_comp_bitmap)) {
+		__clear_bit(p_spq->comp_bitmap_idx,
+			    p_spq->p_comp_bitmap);
+		p_spq->comp_bitmap_idx++;
+		qed_chain_return_produced(&p_spq->chain);
+	}
+}
+
 int qed_spq_post(struct qed_hwfn *p_hwfn,
 		 struct qed_spq_entry *p_ent, u8 *fw_return_code)
 {
@@ -821,11 +842,12 @@ int qed_spq_post(struct qed_hwfn *p_hwfn,
 				   p_ent->queue == &p_spq->unlimited_pending);
 
 		if (p_ent->queue == &p_spq->unlimited_pending) {
-			/* This is an allocated p_ent which does not need to
-			 * return to pool.
-			 */
+			struct qed_spq_entry *p_post_ent = p_ent->post_ent;
+
 			kfree(p_ent);
-			return rc;
+
+			/* Return the entry which was actually posted */
+			p_ent = p_post_ent;
 		}
 
 		if (rc)
@@ -839,7 +861,7 @@ int qed_spq_post(struct qed_hwfn *p_hwfn,
 spq_post_fail2:
 	spin_lock_bh(&p_spq->lock);
 	list_del(&p_ent->list);
-	qed_chain_return_produced(&p_spq->chain);
+	qed_spq_comp_bmap_update(p_hwfn, p_ent->elem.hdr.echo);
 
 spq_post_fail:
 	/* return to the free pool */
@@ -871,25 +893,8 @@ int qed_spq_completion(struct qed_hwfn *p_hwfn,
 	spin_lock_bh(&p_spq->lock);
 	list_for_each_entry_safe(p_ent, tmp, &p_spq->completion_pending, list) {
 		if (p_ent->elem.hdr.echo == echo) {
-			u16 pos = le16_to_cpu(echo) % SPQ_RING_SIZE;
-
 			list_del(&p_ent->list);
-
-			/* Avoid overriding of SPQ entries when getting
-			 * out-of-order completions, by marking the completions
-			 * in a bitmap and increasing the chain consumer only
-			 * for the first successive completed entries.
-			 */
-			__set_bit(pos, p_spq->p_comp_bitmap);
-
-			while (test_bit(p_spq->comp_bitmap_idx,
-					p_spq->p_comp_bitmap)) {
-				__clear_bit(p_spq->comp_bitmap_idx,
-					    p_spq->p_comp_bitmap);
-				p_spq->comp_bitmap_idx++;
-				qed_chain_return_produced(&p_spq->chain);
-			}
-
+			qed_spq_comp_bmap_update(p_hwfn, echo);
 			p_spq->comp_count++;
 			found = p_ent;
 			break;
@@ -928,11 +933,9 @@ int qed_spq_completion(struct qed_hwfn *p_hwfn,
 			   QED_MSG_SPQ,
 			   "Got a completion without a callback function\n");
 
-	if ((found->comp_mode != QED_SPQ_MODE_EBLOCK) ||
-	    (found->queue == &p_spq->unlimited_pending))
+	if (found->comp_mode != QED_SPQ_MODE_EBLOCK)
 		/* EBLOCK  is responsible for returning its own entry into the
-		 * free list, unless it originally added the entry into the
-		 * unlimited pending list.
+		 * free list.
 		 */
 		qed_spq_return_entry(p_hwfn, found);
 
-- 
2.17.1

