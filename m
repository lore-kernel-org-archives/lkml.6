Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22EDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9255F20821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895262;
	bh=+NRQya5fWAYBHwrZMGSKb6r941a1uDjni8mFFtAq3mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bGcV0abn2oUUJLMTVhBk+/8oUWFE+wf9N9nFmWLef/S3IMsbfuzjUil1rn/PhU/aS
	 nQkeXsMSQHJ58Eko1beQV98hiyPjUA9Gw/h182zVfm9LBwYZHaObY9RRJxlaGf6OGc
	 nP6EB1tvZFonkDh0QRdsljKmU2psgCkKG2a5E7K0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfBKO1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:27:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729743AbfBKO1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:27:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474E921855;
        Mon, 11 Feb 2019 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895256;
        bh=+NRQya5fWAYBHwrZMGSKb6r941a1uDjni8mFFtAq3mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mv1CFARDjBC56B3my9+5MetUS48YaWB7nGIjntNwXiyOz9rqN79TsmGBHjKMSHKgM
         Y0fpQLFwSzjkZ0vi+TvMzyr5c14+eG0dCy2K0Wf8YfF+jWpDwRQKavfKmGIaUXLzAP
         c4rsgZ9qXWsM/B4QA/RZ5DDveOsos7XWkm5m6V7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 115/352] usb: mtu3: fix the issue about SetFeature(U1/U2_Enable)
Date:   Mon, 11 Feb 2019 15:15:42 +0100
Message-Id: <20190211141853.172799857@linuxfoundation.org>
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



