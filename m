Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA425C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9DF208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hloE5PA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9DF208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeK3BUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbeK3BUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF29D21019;
        Thu, 29 Nov 2018 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500892;
        bh=P6pV1tY1ko1+nu1unYHfr5oPTWS+C6eTvxM/3oNXOxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hloE5PA4q5ib6d7QGJjTitTVjOqvU3CllKFFBdAVIOC/X/1Bs20JLDVrTypqKXOmF
         7AQ3OuM7vkrpM/8J+Fvya18/XYWkiHn211W/BDxsaKDO/1eism1LOOqFDKVGtEMci8
         ODDp1UshGeHILYwaxzgUgZISRFZeJ0tOj4Ajz/Cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 33/83] Input: xpad - fix clash of presence handling with LED setting
Date:   Thu, 29 Nov 2018 15:11:51 +0100
Message-Id: <20181129140139.784365011@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fbe6a3114471cccaeaeabfa56937731503ece545 ]

Do not call xpad_identify_controller at init with wireless devices: it
conflicts with the already sent presence packet and will be called by
xpad360w_process_packet as needed anyway.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index ff368860a5f9..1a66443f3cd5 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1003,8 +1003,15 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (error)
 		goto err_free_id;
 
-	/* Light up the segment corresponding to controller number */
-	xpad_identify_controller(xpad);
+	if (xpad->xtype == XTYPE_XBOX360) {
+		/*
+		 * Light up the segment corresponding to controller
+		 * number on wired devices. On wireless we'll do that
+		 * when they respond to "presence" packet.
+		 */
+		xpad_identify_controller(xpad);
+	}
+
 	return 0;
 
 err_free_id:
-- 
2.17.1



