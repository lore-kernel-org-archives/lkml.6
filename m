Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B1EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933BE205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xE4pIhK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933BE205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbeK3BX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbeK3BX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1BD2205C9;
        Thu, 29 Nov 2018 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501107;
        bh=HryfOlS5AEHzQed8ci782kS8CL293NrGL5ErhHC6KYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xE4pIhK4uJKx49S/vWim1mZ//WD+01Lh2Hl8rw7h8xNvkfU7Q6/ItSadukWEwSEDn
         DQIwxcjazToHBDlJvmyp7+VdJoUk1nOrzue6/u8XTdtslxGugGAdDElnEoI2zroUC6
         f31c6riwjg8Ovi/mR0cbkCN4n5YZ7Es/YSMmam0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 46/86] Input: xpad - fix Xbox One rumble stopping after 2.5 secs
Date:   Thu, 29 Nov 2018 15:12:11 +0100
Message-Id: <20181129140114.111315924@linuxfoundation.org>
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

[ Upstream commit ae3b4469dbcd3b842a9fd20940946e4d092d8731 ]

Unlike previous Xbox pads, the Xbox One pad doesn't have "sticky" rumble
packets. The duration is encoded into the command and expiration is handled
by the pad firmware.

ff-memless needs pseudo-sticky behavior for rumble effects to behave
properly for long duration effects. We already specify the maximum rumble
on duration in the command packets, but it's still only good for about 2.5
seconds of rumble. This is easily reproducible running fftest's sine
vibration test.

It turns out there's a repeat count encoded in the rumble command. We can
abuse that to get the pseudo-sticky behavior needed for rumble to behave as
expected for effects with long duration.

By my math, this change should allow a single ff_effect to rumble for 10
minutes straight, which should be more than enough for most needs.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 4dc8befc92e4..b9f48d4e155a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1047,9 +1047,9 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 		packet->data[7] = 0x00;
 		packet->data[8] = strong / 512;	/* left actuator */
 		packet->data[9] = weak / 512;	/* right actuator */
-		packet->data[10] = 0xFF;
-		packet->data[11] = 0x00;
-		packet->data[12] = 0x00;
+		packet->data[10] = 0xFF; /* on period */
+		packet->data[11] = 0x00; /* off period */
+		packet->data[12] = 0xFF; /* repeat count */
 		packet->len = 13;
 		packet->pending = true;
 		break;
-- 
2.17.1



