Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B14C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4300F20652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4300F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeIMTMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:12:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeIMTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:12:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2497D35;
        Thu, 13 Sep 2018 14:02:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>
Subject: [PATCH 4.18 159/197] drm/amd/pp: Convert voltage unit in mV*4 to mV on CZ/ST
Date:   Thu, 13 Sep 2018 15:31:48 +0200
Message-Id: <20180913131847.915638091@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Rex Zhu <rex.zhu@amd.com>

commit 8a50bb47a863c3cb8950a2e810448c9a82a9d446 upstream.

the voltage showed in debugfs and hwmon should be in mV

Reviewed-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
@@ -244,6 +244,7 @@ static int smu8_initialize_dpm_defaults(
 	return 0;
 }
 
+/* convert form 8bit vid to real voltage in mV*4 */
 static uint32_t smu8_convert_8Bit_index_to_voltage(
 			struct pp_hwmgr *hwmgr, uint16_t voltage)
 {
@@ -1702,13 +1703,13 @@ static int smu8_read_sensor(struct pp_hw
 	case AMDGPU_PP_SENSOR_VDDNB:
 		tmp = (cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixSMUSVI_NB_CURRENTVID) &
 			CURRENT_NB_VID_MASK) >> CURRENT_NB_VID__SHIFT;
-		vddnb = smu8_convert_8Bit_index_to_voltage(hwmgr, tmp);
+		vddnb = smu8_convert_8Bit_index_to_voltage(hwmgr, tmp) / 4;
 		*((uint32_t *)value) = vddnb;
 		return 0;
 	case AMDGPU_PP_SENSOR_VDDGFX:
 		tmp = (cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixSMUSVI_GFX_CURRENTVID) &
 			CURRENT_GFX_VID_MASK) >> CURRENT_GFX_VID__SHIFT;
-		vddgfx = smu8_convert_8Bit_index_to_voltage(hwmgr, (u16)tmp);
+		vddgfx = smu8_convert_8Bit_index_to_voltage(hwmgr, (u16)tmp) / 4;
 		*((uint32_t *)value) = vddgfx;
 		return 0;
 	case AMDGPU_PP_SENSOR_UVD_VCLK:


