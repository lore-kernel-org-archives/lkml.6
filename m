Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE924C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD092147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690581;
	bh=gZa6UeXQHFwi6vSETxcA+9BdDbuST0+PhsiaVqFdxAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R7qxhVCo0paRlvpgEkaWTw6h0wpi7WOQbu34mw5FC0sQY95sDVlDH8bo9JQfbLWDr
	 qX3yOB/uEeC0lUZogjhhRSdtesYyrOJvBP1azetupW2Vwseqx1zCsC65wOrhNwrFqB
	 qXICooiZRTaYW6NoHrKL3PEDA6bwiMz/QNtNVwqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfA1Ptk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfA1Pth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2150C2147A;
        Mon, 28 Jan 2019 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690577;
        bh=gZa6UeXQHFwi6vSETxcA+9BdDbuST0+PhsiaVqFdxAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aj8HMnhBIl1ym9lZ9+uDPJsgZovVxy+DslzoDTCqH32g9xEnvg921efpDrk9a2sHB
         9Awt5yt47zkha1EzifVWx4qIEz/7M3Vy8pNRCIjdotQztS2MRbl7d4uGqkD3ZlZyqE
         spzCufNMQoVP/j/hTFz34fb0J3B8pph8vaJXMELA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 129/304] drm/amdgpu/powerplay: fix clock stretcher limits on polaris (v2)
Date:   Mon, 28 Jan 2019 10:40:46 -0500
Message-Id: <20190128154341.47195-129-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit de4aaab5cc9770a8c4dc13d9bfb6a83b06bba57e ]

Adjust limits for newer polaris variants.

v2: fix polaris11 kicker (Jerry)

Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index a1e0ac9ae248..90c1215c6f5e 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -1529,8 +1529,21 @@ static int polaris10_populate_clock_stretcher_data_table(struct pp_hwmgr *hwmgr)
 	efuse = efuse >> 24;
 
 	if (hwmgr->chip_id == CHIP_POLARIS10) {
-		min = 1000;
-		max = 2300;
+		if (hwmgr->is_kicker) {
+			min = 1200;
+			max = 2500;
+		} else {
+			min = 1000;
+			max = 2300;
+		}
+	} else if (hwmgr->chip_id == CHIP_POLARIS11) {
+		if (hwmgr->is_kicker) {
+			min = 900;
+			max = 2100;
+		} else {
+			min = 1100;
+			max = 2100;
+		}
 	} else {
 		min = 1100;
 		max = 2100;
-- 
2.19.1

