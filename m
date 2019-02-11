Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9101CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC312075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895428;
	bh=+BRbOeCpB2lP6IwibabmLjxeqWytazCjeZkE461rQKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C6XfAbiM7NYKOhX8bYDmXvA6gIfhqQUA1SlutioRYm4bUZnhARDLDXXdR8uo++2gE
	 U2rzqpsyhbmmtbpcaxxJO5kYjKV9a+NrQN1/ipu66aHeLZ8FODhjDbbvYW7FBjRW76
	 DZodCmgaERnJZOyAeXPRced/VV4Vo+dnws/viKe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfBKOa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbfBKOaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DE4A20675;
        Mon, 11 Feb 2019 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895424;
        bh=+BRbOeCpB2lP6IwibabmLjxeqWytazCjeZkE461rQKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLUWLho5o/N/eA42oh2ZIk2SFJZ7wvelRuy5ac3R2O12MU46rDy/3QU/KNZUS1FYH
         3yFdffX/QEhyEhoPH7c7t1Ca54qU/iFCr8RT9AiRQbh8/4DZIJ7zyGcU4FR3aNM3+v
         KrLkJrVLexY52SBS5ZxVWc8ynNlJYce61/G4T9l4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Bin Liu <b-liu@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 200/352] usb: musb: dsps: fix runtime pm for peripheral mode
Date:   Mon, 11 Feb 2019 15:17:07 +0100
Message-Id: <20190211141859.865905118@linuxfoundation.org>
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



