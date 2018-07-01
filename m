Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A73C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537C8254BD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537C8254BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbeGAQxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:53:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38240 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeGAQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:45:34 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6E6CA73;
        Sun,  1 Jul 2018 16:45:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.17 197/220] Input: psmouse - fix button reporting for basic protocols
Date:   Sun,  1 Jul 2018 18:23:41 +0200
Message-Id: <20180701160916.415186666@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 03ae3a9caf4a59edd32b65c89c375a98ce3ea1ef upstream.

The commit ba667650c568 ("Input: psmouse - clean up code") was pretty
brain-dead and broke extra buttons reporting for variety of PS/2 mice:
Genius, Thinkmouse and Intellimouse Explorer. We need to actually inspect
the data coming from the device when reporting events.

Fixes: ba667650c568 ("Input: psmouse - clean up code")
Reported-by: Jiri Slaby <jslaby@suse.cz>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/psmouse-base.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -192,8 +192,8 @@ psmouse_ret_t psmouse_process_byte(struc
 			else
 				input_report_rel(dev, REL_WHEEL, -wheel);
 
-			input_report_key(dev, BTN_SIDE,  BIT(4));
-			input_report_key(dev, BTN_EXTRA, BIT(5));
+			input_report_key(dev, BTN_SIDE,  packet[3] & BIT(4));
+			input_report_key(dev, BTN_EXTRA, packet[3] & BIT(5));
 			break;
 		}
 		break;
@@ -203,13 +203,13 @@ psmouse_ret_t psmouse_process_byte(struc
 		input_report_rel(dev, REL_WHEEL, -(s8) packet[3]);
 
 		/* Extra buttons on Genius NewNet 3D */
-		input_report_key(dev, BTN_SIDE,  BIT(6));
-		input_report_key(dev, BTN_EXTRA, BIT(7));
+		input_report_key(dev, BTN_SIDE,  packet[0] & BIT(6));
+		input_report_key(dev, BTN_EXTRA, packet[0] & BIT(7));
 		break;
 
 	case PSMOUSE_THINKPS:
 		/* Extra button on ThinkingMouse */
-		input_report_key(dev, BTN_EXTRA, BIT(3));
+		input_report_key(dev, BTN_EXTRA, packet[0] & BIT(3));
 
 		/*
 		 * Without this bit of weirdness moving up gives wildly
@@ -223,7 +223,7 @@ psmouse_ret_t psmouse_process_byte(struc
 		 * Cortron PS2 Trackball reports SIDE button in the
 		 * 4th bit of the first byte.
 		 */
-		input_report_key(dev, BTN_SIDE, BIT(3));
+		input_report_key(dev, BTN_SIDE, packet[0] & BIT(3));
 		packet[0] |= BIT(3);
 		break;
 


