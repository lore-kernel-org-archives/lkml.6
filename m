Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B40FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE6920831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoU40P5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE6920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbeKTEWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731799AbeKTDCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B868A208E4;
        Mon, 19 Nov 2018 16:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645485;
        bh=ugqi7NL9LiGTkPFZruTwhmONbpArqB7FKgMeJFaJyd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZoU40P5XS38ccb7OFItPC+0u4ce9Amdj0NS3NCcoY+LdA+8gzR+eGVCoyGKp4vzZs
         84U3VEvO/WKAXSbRHgt/HwqEzvxBRPfEr2Fww0WuSQV/czbq5xQK8ACew+np00m+mE
         mwNj4KhTk17Arj+z8pp/pTas7swM/qF6iVCg4K0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Akshu Agrawal <akshu.agrawal@amd.com>,
        Satyajit Sahu <satyajit.sahu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 179/205] drm/amd/powerplay: Enable/Disable NBPSTATE on On/OFF of UVD
Date:   Mon, 19 Nov 2018 17:28:06 +0100
Message-Id: <20181119162641.096448309@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akshu Agrawal <akshu.agrawal@amd.com>

commit 51ef434a15b450bfbef1e06cc87ee4e98a224486 upstream.

We observe black lines (underflow) on display when playing a
4K video with UVD. On Disabling Low memory P state this issue is
not seen.
Multiple runs of power measurement shows no imapct.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
@@ -1222,14 +1222,17 @@ static int smu8_dpm_force_dpm_level(stru
 
 static int smu8_dpm_powerdown_uvd(struct pp_hwmgr *hwmgr)
 {
-	if (PP_CAP(PHM_PlatformCaps_UVDPowerGating))
+	if (PP_CAP(PHM_PlatformCaps_UVDPowerGating)) {
+		smu8_nbdpm_pstate_enable_disable(hwmgr, true, true);
 		return smum_send_msg_to_smc(hwmgr, PPSMC_MSG_UVDPowerOFF);
+	}
 	return 0;
 }
 
 static int smu8_dpm_powerup_uvd(struct pp_hwmgr *hwmgr)
 {
 	if (PP_CAP(PHM_PlatformCaps_UVDPowerGating)) {
+		smu8_nbdpm_pstate_enable_disable(hwmgr, false, true);
 		return smum_send_msg_to_smc_with_parameter(
 			hwmgr,
 			PPSMC_MSG_UVDPowerON,


