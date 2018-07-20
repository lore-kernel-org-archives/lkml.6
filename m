Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D4CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B53220833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B53220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbeGTNXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:23:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42638 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729837AbeGTNXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:23:03 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D353DBD8;
        Fri, 20 Jul 2018 12:32:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 38/92] qed: Fix setting of incorrect eswitch mode.
Date:   Fri, 20 Jul 2018 14:13:42 +0200
Message-Id: <20180720121420.273029838@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit 538f8d00ba8bb417c4d9e76c61dee59d812d8287 ]

By default, driver sets the eswitch mode incorrectly as VEB (virtual
Ethernet bridging).
Need to set VEB eswitch mode only when sriov is enabled, and it should be
to set NONE by default. The patch incorporates this change.

Fixes: 0fefbfbaa ("qed*: Management firmware - notifications and defaults")
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c   |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c |   19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -1782,7 +1782,7 @@ int qed_hw_init(struct qed_dev *cdev, st
 			DP_INFO(p_hwfn, "Failed to update driver state\n");
 
 		rc = qed_mcp_ov_update_eswitch(p_hwfn, p_hwfn->p_main_ptt,
-					       QED_OV_ESWITCH_VEB);
+					       QED_OV_ESWITCH_NONE);
 		if (rc)
 			DP_INFO(p_hwfn, "Failed to update eswitch mode\n");
 	}
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -4396,6 +4396,8 @@ static void qed_sriov_enable_qid_config(
 static int qed_sriov_enable(struct qed_dev *cdev, int num)
 {
 	struct qed_iov_vf_init_params params;
+	struct qed_hwfn *hwfn;
+	struct qed_ptt *ptt;
 	int i, j, rc;
 
 	if (num >= RESC_NUM(&cdev->hwfns[0], QED_VPORT)) {
@@ -4408,8 +4410,8 @@ static int qed_sriov_enable(struct qed_d
 
 	/* Initialize HW for VF access */
 	for_each_hwfn(cdev, j) {
-		struct qed_hwfn *hwfn = &cdev->hwfns[j];
-		struct qed_ptt *ptt = qed_ptt_acquire(hwfn);
+		hwfn = &cdev->hwfns[j];
+		ptt = qed_ptt_acquire(hwfn);
 
 		/* Make sure not to use more than 16 queues per VF */
 		params.num_queues = min_t(int,
@@ -4445,6 +4447,19 @@ static int qed_sriov_enable(struct qed_d
 		goto err;
 	}
 
+	hwfn = QED_LEADING_HWFN(cdev);
+	ptt = qed_ptt_acquire(hwfn);
+	if (!ptt) {
+		DP_ERR(hwfn, "Failed to acquire ptt\n");
+		rc = -EBUSY;
+		goto err;
+	}
+
+	rc = qed_mcp_ov_update_eswitch(hwfn, ptt, QED_OV_ESWITCH_VEB);
+	if (rc)
+		DP_INFO(cdev, "Failed to update eswitch mode\n");
+	qed_ptt_release(hwfn, ptt);
+
 	return num;
 
 err:


