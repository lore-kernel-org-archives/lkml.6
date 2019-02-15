Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CCBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8C121B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196777;
	bh=/GWT4jgN3rvf9edSXC1BEXFFLPAcqWmwDlW2IFTUYaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fsCfNzvcaL2OOAkp6od7k+CoW/oQPV3O+XGupRsSHe/2cjTASgxTvbD2OZQ7TqiOk
	 ptTj1VxSPKfjdSsE5MZxc66TfR0bqMdXYDWIv7zy4Xqr2F8qlBf9/dETKOxTFr9CCG
	 iNPBEGdyBqaalVUL2uY7eIFVFtvoGZB242Jr3ljc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391239AbfBOCMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:12:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388645AbfBOCMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 561C2206BA;
        Fri, 15 Feb 2019 02:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196772;
        bh=/GWT4jgN3rvf9edSXC1BEXFFLPAcqWmwDlW2IFTUYaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmDzzi2919LVVwt/SzIWbVX4OPGTWK+UpArtzLHslZJ9GHORUnYx3oiU03SwwT0+6
         T1lQ1KcWuEHjtBvPha1BegXLjqWcKzg7MstVzpQIwIUTMgXcyYgCQJE1vE6HewsnUC
         CWRVGOw0SrJetqgVLrD85rZLVd5ll+ebtiBxwqno=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 54/65] drm/msm: Fix A6XX support for opp-level
Date:   Thu, 14 Feb 2019 21:11:10 -0500
Message-Id: <20190215021121.177674-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit a3c5e2cd79753121f49a8662c1e0a60ddb5486ca ]

The bindings for Qualcomm opp levels changed after being Acked but
before landing.  Thus the code in the GPU driver that was relying on
the old bindings is now broken.

Let's change the code to match the new bindings by adjusting the old
string 'qcom,level' to the new string 'opp-level'.  See the patch
("dt-bindings: opp: Introduce opp-level bindings").

NOTE: we will do additional cleanup to totally remove the string from
the code and use the new dev_pm_opp_get_level() but we'll do it in a
future patch.  This will facilitate getting the important code fix in
sooner without having to deal with cross-maintainer dependencies.

This patch needs to land before the patch ("arm64: dts: sdm845: Add
gpu and gmu device nodes") since if a tree contains the device tree
patch but not this one you'll get a crash at bootup.

Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index bbb8126ec5c5..9acb9dfaf57e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -896,7 +896,7 @@ static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
 	np = dev_pm_opp_get_of_node(opp);
 
 	if (np) {
-		of_property_read_u32(np, "qcom,level", &val);
+		of_property_read_u32(np, "opp-level", &val);
 		of_node_put(np);
 	}
 
-- 
2.19.1

