Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96673C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F6021A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901270;
	bh=zbthlmLHn6UCmSmb/4OId1b+s8xeZslpmzE7xrOVZEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xPp1O6MUHKjqgnUPH9oAlzToReHYViGaoi7OtpbKK4If4f2y1WT4gFHeB09Az/H1i
	 59K432i1QcoCB7c8apQ/VvxhyUBJfeR8w/xdUPAU1ziBmwtEqVuHEx4wiLuqxojT9Q
	 8OuZqILH1+JpNj4KiugYNNZjD2N9x+XJoqDvwPWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfBKQHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:07:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbfBKO0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:26:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B8220844;
        Mon, 11 Feb 2019 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895178;
        bh=zbthlmLHn6UCmSmb/4OId1b+s8xeZslpmzE7xrOVZEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PKYrlvu93aJtPKesn8oAUa6Nm+dIA0te9Dfr05mykImtmZv2oeLWSa939ABMZK0fm
         VBUEKawokGyILUaSQNtE5v3fKGoQMgsrzbb2snmU3eCUwvzEHAsw1zBrnDUHRQUVcL
         dbM6GY5aISaklHdv6lx8npvHCevcMOAjl50yTiTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junwei Zhang <Jerry.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 120/352] drm/amdgpu/powerplay: fix clock stretcher limits on polaris (v2)
Date:   Mon, 11 Feb 2019 15:15:47 +0100
Message-Id: <20190211141853.723157899@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



