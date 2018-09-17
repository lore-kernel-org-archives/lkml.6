Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70313ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3358D2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3358D2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbeIREnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:43:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbeIREnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:43:42 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DCCEFC49;
        Mon, 17 Sep 2018 23:14:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anthony Koo <Anthony.Koo@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 136/158] drm/amd/display: Prevent PSR from being enabled if initialization fails
Date:   Tue, 18 Sep 2018 00:42:46 +0200
Message-Id: <20180917211717.439825379@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Anthony Koo <Anthony.Koo@amd.com>

[ Upstream commit 9907704174e0ad4ed02766fac4049971e583323d ]

[Why]
PSR_SET command is sent to the microcontroller in order to initialize
parameters needed for PSR feature, such as telling the microcontroller
which pipe is driving the PSR supported panel. When this command is
skipped or fails, the microcontroller may program the wrong thing if
driver tries to enable PSR.

[How]
If PSR_SET fails, do not set psr_enable flag to indicate the feature is
not yet initialized.

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   38 +++++++++++++++-----------
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |    2 -
 2 files changed, 24 insertions(+), 16 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -150,7 +150,7 @@ static void dce_dmcu_set_psr_enable(stru
 	}
 }
 
-static void dce_dmcu_setup_psr(struct dmcu *dmcu,
+static bool dce_dmcu_setup_psr(struct dmcu *dmcu,
 		struct dc_link *link,
 		struct psr_context *psr_context)
 {
@@ -261,6 +261,8 @@ static void dce_dmcu_setup_psr(struct dm
 
 	/* notifyDMCUMsg */
 	REG_UPDATE(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 1);
+
+	return true;
 }
 
 static bool dce_is_dmcu_initialized(struct dmcu *dmcu)
@@ -545,24 +547,25 @@ static void dcn10_dmcu_set_psr_enable(st
 	 *  least a few frames. Should never hit the max retry assert below.
 	 */
 	if (wait == true) {
-	for (retryCount = 0; retryCount <= 1000; retryCount++) {
-		dcn10_get_dmcu_psr_state(dmcu, &psr_state);
-		if (enable) {
-			if (psr_state != 0)
-				break;
-		} else {
-			if (psr_state == 0)
-				break;
+		for (retryCount = 0; retryCount <= 1000; retryCount++) {
+			dcn10_get_dmcu_psr_state(dmcu, &psr_state);
+			if (enable) {
+				if (psr_state != 0)
+					break;
+			} else {
+				if (psr_state == 0)
+					break;
+			}
+			udelay(500);
 		}
-		udelay(500);
-	}
 
-	/* assert if max retry hit */
-	ASSERT(retryCount <= 1000);
+		/* assert if max retry hit */
+		if (retryCount >= 1000)
+			ASSERT(0);
 	}
 }
 
-static void dcn10_dmcu_setup_psr(struct dmcu *dmcu,
+static bool dcn10_dmcu_setup_psr(struct dmcu *dmcu,
 		struct dc_link *link,
 		struct psr_context *psr_context)
 {
@@ -577,7 +580,7 @@ static void dcn10_dmcu_setup_psr(struct
 
 	/* If microcontroller is not running, do nothing */
 	if (dmcu->dmcu_state != DMCU_RUNNING)
-		return;
+		return false;
 
 	link->link_enc->funcs->psr_program_dp_dphy_fast_training(link->link_enc,
 			psr_context->psrExitLinkTrainingRequired);
@@ -677,6 +680,11 @@ static void dcn10_dmcu_setup_psr(struct
 
 	/* notifyDMCUMsg */
 	REG_UPDATE(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 1);
+
+	/* waitDMCUReadyForCmd */
+	REG_WAIT(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 0, 1, 10000);
+
+	return true;
 }
 
 static void dcn10_psr_wait_loop(
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
@@ -48,7 +48,7 @@ struct dmcu_funcs {
 			const char *src,
 			unsigned int bytes);
 	void (*set_psr_enable)(struct dmcu *dmcu, bool enable, bool wait);
-	void (*setup_psr)(struct dmcu *dmcu,
+	bool (*setup_psr)(struct dmcu *dmcu,
 			struct dc_link *link,
 			struct psr_context *psr_context);
 	void (*get_psr_state)(struct dmcu *dmcu, uint32_t *psr_state);


