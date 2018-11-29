Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB23BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7168E213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGAko2uX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7168E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbeK3BXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbeK3BXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5BA21104;
        Thu, 29 Nov 2018 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501099;
        bh=x8RJ9D1Ee3KHc8nITP5nVwYiuz1hSBvkVJT2NToQVr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGAko2uXkfwtkQnkWlaDCF388n8u0E/sMI17y8pqktKS+jAlioV5h3kwwQwh8bXFl
         lNCLPY9URqQY6Hp3ro8FJIOLunYw9XoNegYa4QwVyz4Q5TmlDiXfNr4fVkd0Vu5REd
         0/bqHXZaq0cheymmF+SuQUq6O9SeLam0w+F3lVOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 43/86] Input: xpad - fix rumble on Xbox One controllers with 2015 firmware
Date:   Thu, 29 Nov 2018 15:12:08 +0100
Message-Id: <20181129140113.852510046@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 540c26087bfbad6ea72758b76b16ae6282a73fea ]

Xbox One controllers that shipped with or were upgraded to the 2015
firmware discard the current rumble packets we send. This patch changes
the Xbox One rumble packet to a form that both the newer and older
firmware will accept.

It is based on changes made to support newer Xbox One controllers in
the SteamOS brewmaster-4.1 kernel branch.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index dcf9053a801e..82c98e5b23ab 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1033,17 +1033,17 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 
 	case XTYPE_XBOXONE:
 		packet->data[0] = 0x09; /* activate rumble */
-		packet->data[1] = 0x08;
+		packet->data[1] = 0x00;
 		packet->data[2] = xpad->odata_serial++;
-		packet->data[3] = 0x08; /* continuous effect */
-		packet->data[4] = 0x00; /* simple rumble mode */
-		packet->data[5] = 0x03; /* L and R actuator only */
-		packet->data[6] = 0x00; /* TODO: LT actuator */
-		packet->data[7] = 0x00; /* TODO: RT actuator */
+		packet->data[3] = 0x09;
+		packet->data[4] = 0x00;
+		packet->data[5] = 0x0F;
+		packet->data[6] = 0x00;
+		packet->data[7] = 0x00;
 		packet->data[8] = strong / 512;	/* left actuator */
 		packet->data[9] = weak / 512;	/* right actuator */
-		packet->data[10] = 0x80;	/* length of pulse */
-		packet->data[11] = 0x00;	/* stop period of pulse */
+		packet->data[10] = 0xFF;
+		packet->data[11] = 0x00;
 		packet->data[12] = 0x00;
 		packet->len = 13;
 		packet->pending = true;
-- 
2.17.1



