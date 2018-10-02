Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D072BC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEFB2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEFB2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbeJBUOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeJBUOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:07 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51A9DC4D;
        Tue,  2 Oct 2018 13:30:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Tony Brelinski <tonyx.brelinski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 198/228] ice: Fix bugs in control queue processing
Date:   Tue,  2 Oct 2018 06:24:55 -0700
Message-Id: <20181002132511.332485495@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

[ Upstream commit 3d6b640efcc1b07709b42dd2e9609401c6f88633 ]

This patch is a consolidation of multiple bug fixes for control queue
processing.

1)  In ice_clean_adminq_subtask() remove unnecessary reads/writes to
    registers. The bits PFINT_FW_CTL, PFINT_MBX_CTL and PFINT_SB_CTL
    are not set when an interrupt arrives, which means that clearing them
    again can be omitted.

2)  Get an accurate value in "pending" by re-reading the control queue
    head register from the hardware.

3)  Fix a corner case involving lost control queue messages by checking
    for new control messages (using ice_ctrlq_pending) before exiting the
    cleanup routine.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c |    5 ++++-
 drivers/net/ethernet/intel/ice/ice_main.c     |   26 ++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -1065,8 +1065,11 @@ ice_clean_rq_elem(struct ice_hw *hw, str
 
 clean_rq_elem_out:
 	/* Set pending if needed, unlock and return */
-	if (pending)
+	if (pending) {
+		/* re-read HW head to calculate actual pending messages */
+		ntu = (u16)(rd32(hw, cq->rq.head) & cq->rq.head_mask);
 		*pending = (u16)((ntc > ntu ? cq->rq.count : 0) + (ntu - ntc));
+	}
 clean_rq_elem_err:
 	mutex_unlock(&cq->rq_lock);
 
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -917,13 +917,27 @@ static int __ice_clean_ctrlq(struct ice_
 }
 
 /**
+ * ice_ctrlq_pending - check if there is a difference between ntc and ntu
+ * @hw: pointer to hardware info
+ * @cq: control queue information
+ *
+ * returns true if there are pending messages in a queue, false if there aren't
+ */
+static bool ice_ctrlq_pending(struct ice_hw *hw, struct ice_ctl_q_info *cq)
+{
+	u16 ntu;
+
+	ntu = (u16)(rd32(hw, cq->rq.head) & cq->rq.head_mask);
+	return cq->rq.next_to_clean != ntu;
+}
+
+/**
  * ice_clean_adminq_subtask - clean the AdminQ rings
  * @pf: board private structure
  */
 static void ice_clean_adminq_subtask(struct ice_pf *pf)
 {
 	struct ice_hw *hw = &pf->hw;
-	u32 val;
 
 	if (!test_bit(__ICE_ADMINQ_EVENT_PENDING, pf->state))
 		return;
@@ -933,9 +947,13 @@ static void ice_clean_adminq_subtask(str
 
 	clear_bit(__ICE_ADMINQ_EVENT_PENDING, pf->state);
 
-	/* re-enable Admin queue interrupt causes */
-	val = rd32(hw, PFINT_FW_CTL);
-	wr32(hw, PFINT_FW_CTL, (val | PFINT_FW_CTL_CAUSE_ENA_M));
+	/* There might be a situation where new messages arrive to a control
+	 * queue between processing the last message and clearing the
+	 * EVENT_PENDING bit. So before exiting, check queue head again (using
+	 * ice_ctrlq_pending) and process new messages if any.
+	 */
+	if (ice_ctrlq_pending(hw, &hw->adminq))
+		__ice_clean_ctrlq(pf, ICE_CTL_Q_ADMIN);
 
 	ice_flush(hw);
 }


