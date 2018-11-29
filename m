Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0629CC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F502145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWphspNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F502145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbeK3BVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbeK3BVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:21:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D2E205C9;
        Thu, 29 Nov 2018 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500974;
        bh=AmrOUqZlihjYPkrsjkaocJfVohphG05VcdSuGJiYPzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWphspNMDAfXFrTGEzyJRKUGT2BkPKhEwGL1I26Dm+fvFGUAOEP/LPuqqeYXqbtId
         jEfoRB5hA6xK+fWF3pQLbCrOsTPXZVGS/3KehUw9TOqz2xre3m6OagjTrmss+8GIQG
         Q6s8MJg7MmVmOG4yCUHB0249We7yhFSBbMEGLoAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 39/83] Input: xpad - use LED API when identifying wireless controllers
Date:   Thu, 29 Nov 2018 15:11:57 +0100
Message-Id: <20181129140140.034717996@linuxfoundation.org>
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

[ Upstream commit d9be398afb2c3333716324352d062c50112e4e86 ]

When lighting up the segment identifying wireless controller, Instead of
sending command directly to the controller, let's do it via LED API (usinf
led_set_brightness) so that LED object state is in sync with controller
state and we'll light up the correct segment on resume as well.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 41db1f2ed122..c196141f3735 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1142,7 +1142,7 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
  */
 static void xpad_identify_controller(struct usb_xpad *xpad)
 {
-	xpad_send_led_command(xpad, (xpad->pad_nr % 4) + 2);
+	led_set_brightness(&xpad->led->led_cdev, (xpad->pad_nr % 4) + 2);
 }
 
 static void xpad_led_set(struct led_classdev *led_cdev,
-- 
2.17.1



