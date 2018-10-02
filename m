Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59C2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE0A208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE0A208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbeJBUOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbeJBUOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:05 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4543AC47;
        Tue,  2 Oct 2018 13:30:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Preethi Banala <preethi.banala@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Tony Brelinski <tonyx.brelinski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 197/228] ice: Clean control queues only when they are initialized
Date:   Tue,  2 Oct 2018 06:24:54 -0700
Message-Id: <20181002132511.280220637@linuxfoundation.org>
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

From: Preethi Banala <preethi.banala@intel.com>

[ Upstream commit b29bc220e2c7bd494a4605defcd93b18d5a8cf86 ]

Clean control queues only when they are initialized. One of the ways to
validate if the basic initialization is done is by checking value of
cq->sq.head and cq->rq.head variables that specify the register address.
This patch adds a check to avoid NULL pointer dereference crash when tried
to shutdown uninitialized control queue.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -597,10 +597,14 @@ static enum ice_status ice_init_check_ad
 	return 0;
 
 init_ctrlq_free_rq:
-	ice_shutdown_rq(hw, cq);
-	ice_shutdown_sq(hw, cq);
-	mutex_destroy(&cq->sq_lock);
-	mutex_destroy(&cq->rq_lock);
+	if (cq->rq.head) {
+		ice_shutdown_rq(hw, cq);
+		mutex_destroy(&cq->rq_lock);
+	}
+	if (cq->sq.head) {
+		ice_shutdown_sq(hw, cq);
+		mutex_destroy(&cq->sq_lock);
+	}
 	return status;
 }
 
@@ -706,10 +710,14 @@ static void ice_shutdown_ctrlq(struct ic
 		return;
 	}
 
-	ice_shutdown_sq(hw, cq);
-	ice_shutdown_rq(hw, cq);
-	mutex_destroy(&cq->sq_lock);
-	mutex_destroy(&cq->rq_lock);
+	if (cq->sq.head) {
+		ice_shutdown_sq(hw, cq);
+		mutex_destroy(&cq->sq_lock);
+	}
+	if (cq->rq.head) {
+		ice_shutdown_rq(hw, cq);
+		mutex_destroy(&cq->rq_lock);
+	}
 }
 
 /**


