Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F977C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7C921741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690567;
	bh=IBnwImcFtqKNkFnZZ64n4xfnWiSj+QBfdGkK8Yp+g2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CopUvSvFVXxP3VFrX2o3r8Jy7B4nqjsxywHGDmIUGHL2dxLIfOjy4OqfdShNReUej
	 qoyKMwWLd6HTgDCPMgzPURE4s4c+E45Yv9W+oO6+lVwCyqLBDZ3oMYsCrooAjhnYvn
	 VusHDzNyiokUnGE8YQ5ukfFd0azxERMteZw4x+Tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfA1PtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbfA1PtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3ACA20880;
        Mon, 28 Jan 2019 15:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690557;
        bh=IBnwImcFtqKNkFnZZ64n4xfnWiSj+QBfdGkK8Yp+g2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARFGEYH5FUD3slp68xLbCFtnzSLlS+pkz3D+kbu9erpbj34v2djLBUBcL/GbgT2W2
         OPFvwfYWETbzHdIT9T90bRimrP3/2uIQxEyCSzX6ZbTFJkU06mxFLCr1xGMwJJr7AG
         jgHbB0bqVnoMYUnIkrtmwjNv0HXozpaIGDfLet7o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 124/304] usb: mtu3: fix the issue about SetFeature(U1/U2_Enable)
Date:   Mon, 28 Jan 2019 10:40:41 -0500
Message-Id: <20190128154341.47195-124-sashal@kernel.org>
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

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

[ Upstream commit a0678e2eed41e81004308693ac84ea95614b0920 ]

Fix the issue: device doesn't accept LGO_U1/U2:
1. set SW_U1/U2_ACCEPT_ENABLE to eanble controller to accept LGO_U1/U2
    by default;
2. enable/disable controller to initiate requests for transition into
    U1/U2 by SW_U1/U2_REQUEST_ENABLE instead of SW_U1/U2_ACCEPT_ENABLE;

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/mtu3/mtu3_core.c       | 4 +++-
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index ae70b9bfd797..860693520132 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -578,8 +578,10 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 	if (mtu->is_u3_ip) {
 		/* disable LGO_U1/U2 by default */
 		mtu3_clrbits(mbase, U3D_LINK_POWER_CONTROL,
-				SW_U1_ACCEPT_ENABLE | SW_U2_ACCEPT_ENABLE |
 				SW_U1_REQUEST_ENABLE | SW_U2_REQUEST_ENABLE);
+		/* enable accept LGO_U1/U2 link command from host */
+		mtu3_setbits(mbase, U3D_LINK_POWER_CONTROL,
+				SW_U1_ACCEPT_ENABLE | SW_U2_ACCEPT_ENABLE);
 		/* device responses to u3_exit from host automatically */
 		mtu3_clrbits(mbase, U3D_LTSSM_CTRL, SOFT_U3_EXIT_EN);
 		/* automatically build U2 link when U3 detect fail */
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 25216e79cd6e..3c464d8ae023 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -336,9 +336,9 @@ static int ep0_handle_feature_dev(struct mtu3 *mtu,
 
 		lpc = mtu3_readl(mbase, U3D_LINK_POWER_CONTROL);
 		if (set)
-			lpc |= SW_U1_ACCEPT_ENABLE;
+			lpc |= SW_U1_REQUEST_ENABLE;
 		else
-			lpc &= ~SW_U1_ACCEPT_ENABLE;
+			lpc &= ~SW_U1_REQUEST_ENABLE;
 		mtu3_writel(mbase, U3D_LINK_POWER_CONTROL, lpc);
 
 		mtu->u1_enable = !!set;
@@ -351,9 +351,9 @@ static int ep0_handle_feature_dev(struct mtu3 *mtu,
 
 		lpc = mtu3_readl(mbase, U3D_LINK_POWER_CONTROL);
 		if (set)
-			lpc |= SW_U2_ACCEPT_ENABLE;
+			lpc |= SW_U2_REQUEST_ENABLE;
 		else
-			lpc &= ~SW_U2_ACCEPT_ENABLE;
+			lpc &= ~SW_U2_REQUEST_ENABLE;
 		mtu3_writel(mbase, U3D_LINK_POWER_CONTROL, lpc);
 
 		mtu->u2_enable = !!set;
-- 
2.19.1

