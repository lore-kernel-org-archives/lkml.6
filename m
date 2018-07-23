Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69755ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288A120854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288A120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbeGWN1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:27:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387882AbeGWN1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:27:32 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EFB37C03;
        Mon, 23 Jul 2018 12:26:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.17 31/63] Revert "drm/amd/display: Dont return ddc result and read_bytes in same return value"
Date:   Mon, 23 Jul 2018 14:24:37 +0200
Message-Id: <20180723122447.551452211@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 5292221d6ddfed75e5b46cd42237a677094b99f3 upstream.

This reverts commit 018d82e5f02ef3583411bcaa4e00c69786f46f19.

This breaks DDC in certain cases.  Revert for 4.18 and previous kernels.
For 4.19, this is fixed with the following more extensive patches:
drm/amd/display: Serialize is_dp_sink_present
drm/amd/display: Break out function to simply read aux reply
drm/amd/display: Return aux replies directly to DRM
drm/amd/display: Right shift AUX reply value sooner than later
drm/amd/display: Read AUX channel even if only status byte is returned

Link: https://lists.freedesktop.org/archives/amd-gfx/2018-July/023788.html
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |   20 ++++--------
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c           |   10 +-----
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h            |    5 +--
 3 files changed, 13 insertions(+), 22 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -83,22 +83,21 @@ static ssize_t dm_dp_aux_transfer(struct
 	enum i2c_mot_mode mot = (msg->request & DP_AUX_I2C_MOT) ?
 		I2C_MOT_TRUE : I2C_MOT_FALSE;
 	enum ddc_result res;
-	uint32_t read_bytes = msg->size;
+	ssize_t read_bytes;
 
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
 
 	switch (msg->request & ~DP_AUX_I2C_MOT) {
 	case DP_AUX_NATIVE_READ:
-		res = dal_ddc_service_read_dpcd_data(
+		read_bytes = dal_ddc_service_read_dpcd_data(
 				TO_DM_AUX(aux)->ddc_service,
 				false,
 				I2C_MOT_UNDEF,
 				msg->address,
 				msg->buffer,
-				msg->size,
-				&read_bytes);
-		break;
+				msg->size);
+		return read_bytes;
 	case DP_AUX_NATIVE_WRITE:
 		res = dal_ddc_service_write_dpcd_data(
 				TO_DM_AUX(aux)->ddc_service,
@@ -109,15 +108,14 @@ static ssize_t dm_dp_aux_transfer(struct
 				msg->size);
 		break;
 	case DP_AUX_I2C_READ:
-		res = dal_ddc_service_read_dpcd_data(
+		read_bytes = dal_ddc_service_read_dpcd_data(
 				TO_DM_AUX(aux)->ddc_service,
 				true,
 				mot,
 				msg->address,
 				msg->buffer,
-				msg->size,
-				&read_bytes);
-		break;
+				msg->size);
+		return read_bytes;
 	case DP_AUX_I2C_WRITE:
 		res = dal_ddc_service_write_dpcd_data(
 				TO_DM_AUX(aux)->ddc_service,
@@ -139,9 +137,7 @@ static ssize_t dm_dp_aux_transfer(struct
 		 r == DDC_RESULT_SUCESSFULL);
 #endif
 
-	if (res != DDC_RESULT_SUCESSFULL)
-		return -EIO;
-	return read_bytes;
+	return msg->size;
 }
 
 static enum drm_connector_status
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -629,14 +629,13 @@ bool dal_ddc_service_query_ddc_data(
 	return ret;
 }
 
-enum ddc_result dal_ddc_service_read_dpcd_data(
+ssize_t dal_ddc_service_read_dpcd_data(
 	struct ddc_service *ddc,
 	bool i2c,
 	enum i2c_mot_mode mot,
 	uint32_t address,
 	uint8_t *data,
-	uint32_t len,
-	uint32_t *read)
+	uint32_t len)
 {
 	struct aux_payload read_payload = {
 		.i2c_over_aux = i2c,
@@ -653,8 +652,6 @@ enum ddc_result dal_ddc_service_read_dpc
 		.mot = mot
 	};
 
-	*read = 0;
-
 	if (len > DEFAULT_AUX_MAX_DATA_SIZE) {
 		BREAK_TO_DEBUGGER();
 		return DDC_RESULT_FAILED_INVALID_OPERATION;
@@ -664,8 +661,7 @@ enum ddc_result dal_ddc_service_read_dpc
 		ddc->ctx->i2caux,
 		ddc->ddc_pin,
 		&command)) {
-		*read = command.payloads->length;
-		return DDC_RESULT_SUCESSFULL;
+		return (ssize_t)command.payloads->length;
 	}
 
 	return DDC_RESULT_FAILED_OPERATION;
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
@@ -102,14 +102,13 @@ bool dal_ddc_service_query_ddc_data(
 		uint8_t *read_buf,
 		uint32_t read_size);
 
-enum ddc_result dal_ddc_service_read_dpcd_data(
+ssize_t dal_ddc_service_read_dpcd_data(
 		struct ddc_service *ddc,
 		bool i2c,
 		enum i2c_mot_mode mot,
 		uint32_t address,
 		uint8_t *data,
-		uint32_t len,
-		uint32_t *read);
+		uint32_t len);
 
 enum ddc_result dal_ddc_service_write_dpcd_data(
 		struct ddc_service *ddc,


