Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3CDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F257E2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697114;
	bh=iSfAMUiCuC9aWufMmuPoIFfGGmQeKUJiinfqa4JLUHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ovcUTJgvLrLCSrAYR6APWzeTH1oilIHYgwfUrHswOEQcxWDJX/WEtr43GBtTEHgJG
	 UPLk5mvHm1j+9ec624c88bTsFsE07O5qtM1erpRnBzXRfthd8sNwqpfgh2D0QZSmyr
	 VNMQ7jVZEb41773qwwVfTcX+tpt2P+O1VkfKMLLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfA1PyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:54:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfA1PyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:54:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 320FE20855;
        Mon, 28 Jan 2019 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690844;
        bh=iSfAMUiCuC9aWufMmuPoIFfGGmQeKUJiinfqa4JLUHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uydbcxn6wDk02IzJHpFj2dyN/GIoa9rrWGm7LTPXN6CARQ7XP9dyQE6LMlqt+MaQo
         6j/cbSLqz4S8G47/JiuB1ZyeX+ytdnzqIbPX54ik+Dbuz4S1KSybR8zkxE1DQqDZJf
         jheioeJmxTP94M4uYrJr8fnDcu7J2ZF/MpunICHw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 211/304] usb: musb: dsps: fix runtime pm for peripheral mode
Date:   Mon, 28 Jan 2019 10:42:08 -0500
Message-Id: <20190128154341.47195-211-sashal@kernel.org>
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

From: Bin Liu <b-liu@ti.com>

[ Upstream commit 54578ee883e34d2d1c518d48f1c1e2dd3f387188 ]

Since the runtime PM support was added in musb, dsps relies on the timer
calling otg_timer() to activate the usb subsystem. However the driver
doesn't enable the timer for peripheral port, then the peripheral port is
unable to be enumerated by a host if the other usb port is disabled or in
peripheral mode too.

So let's start the timer for peripheral port too.

Fixes: ea2f35c01d5e ("usb: musb: Fix sleeping function called from invalid context for hdrc glue")
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/musb_dsps.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 1e6d78b1334e..403eb97915f8 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -181,9 +181,11 @@ static void dsps_musb_enable(struct musb *musb)
 
 	musb_writel(reg_base, wrp->epintr_set, epmask);
 	musb_writel(reg_base, wrp->coreintr_set, coremask);
-	/* start polling for ID change in dual-role idle mode */
-	if (musb->xceiv->otg->state == OTG_STATE_B_IDLE &&
-			musb->port_mode == MUSB_OTG)
+	/*
+	 * start polling for runtime PM active and idle,
+	 * and for ID change in dual-role idle mode.
+	 */
+	if (musb->xceiv->otg->state == OTG_STATE_B_IDLE)
 		dsps_mod_timer(glue, -1);
 }
 
@@ -254,6 +256,10 @@ static int dsps_check_status(struct musb *musb, void *unused)
 				musb->xceiv->otg->state = OTG_STATE_A_IDLE;
 				MUSB_HST_MODE(musb);
 			}
+
+			if (musb->port_mode == MUSB_PERIPHERAL)
+				skip_session = 1;
+
 			if (!(devctl & MUSB_DEVCTL_SESSION) && !skip_session)
 				musb_writeb(mregs, MUSB_DEVCTL,
 					    MUSB_DEVCTL_SESSION);
-- 
2.19.1

