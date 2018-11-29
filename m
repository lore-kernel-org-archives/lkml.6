Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC52C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA952208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1g7fvRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA952208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbeK3BU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbeK3BU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B28208E7;
        Thu, 29 Nov 2018 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500897;
        bh=j7R0jWsyvhjejHgg96jPpaipNhfjxJnyRBffX1KiS+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1g7fvRCYUGqqLwYE2hgrMhiO2szabN5DfXhNPH+RFvahHKAYRnDLwqisWJ5tAwTx
         x6Z2haEhJcVCah7NScP209zXdv/6ninrRHH4SMTPJBaGQ1lUfbDkQtTZUPQgm4eX31
         d4odJif0SOZn0XA2HoGV3TUsL8g1u9i3w5E+90gM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 43/83] Input: xpad - move pending clear to the correct location
Date:   Thu, 29 Nov 2018 15:12:01 +0100
Message-Id: <20181129140140.198523358@linuxfoundation.org>
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

[ Upstream commit 4efc6939a83c54fb3417541be48991afd0290ba3 ]

otherwise we lose ff commands: https://github.com/paroj/xpad/issues/27

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 6e15ce40dbab..c8add0e425b5 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -758,6 +758,7 @@ static bool xpad_prepare_next_out_packet(struct usb_xpad *xpad)
 	if (packet) {
 		memcpy(xpad->odata, packet->data, packet->len);
 		xpad->irq_out->transfer_buffer_length = packet->len;
+		packet->pending = false;
 		return true;
 	}
 
@@ -799,7 +800,6 @@ static void xpad_irq_out(struct urb *urb)
 	switch (status) {
 	case 0:
 		/* success */
-		xpad->out_packets[xpad->last_out_packet].pending = false;
 		xpad->irq_out_active = xpad_prepare_next_out_packet(xpad);
 		break;
 
-- 
2.17.1



