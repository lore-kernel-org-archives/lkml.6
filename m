Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6E9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8345A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+GbL7DD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8345A21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbeK3BVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:21:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbeK3BVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:21:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DDC7205C9;
        Thu, 29 Nov 2018 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500933;
        bh=W2rUXkB/EilINWN5Dmi/mSvFZvXVeRLRMXO62HTh3j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+GbL7DDeZ858CYthbiBoR/UCpd3mrLcrzCpLRYfGmdJsEzTTNhV0PAsmyI576iut
         4h0LTSsFdZNz5JV2cAq5O0vu3czP7De+CzgkH47kTW2yhorARw5qCNHarbHZ7vUKwV
         ImSOFpH1Ft7wNG1ejcPFliQJuxEE7zhY9YUTHDgE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 57/83] Input: xpad - fix stuck mode button on Xbox One S pad
Date:   Thu, 29 Nov 2018 15:12:15 +0100
Message-Id: <20181129140140.885462283@linuxfoundation.org>
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

[ Upstream commit 57b8443d3e5bd046a519ff714ca31c64c7f04309 ]

The Xbox One S requires an ack to its mode button report, otherwise it
continuously retransmits the report. This makes the mode button appear to
be stuck down after it is pressed for the first time.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index dd0503562b1c..14da79ead653 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -391,6 +391,7 @@ struct usb_xpad {
 
 static int xpad_init_input(struct usb_xpad *xpad);
 static void xpad_deinit_input(struct usb_xpad *xpad);
+static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
 
 /*
  *	xpad_process_packet
@@ -624,6 +625,14 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 
 	/* the xbox button has its own special report */
 	if (data[0] == 0X07) {
+		/*
+		 * The Xbox One S controller requires these reports to be
+		 * acked otherwise it continues sending them forever and
+		 * won't report further mode button events.
+		 */
+		if (data[1] == 0x30)
+			xpadone_ack_mode_report(xpad, data[2]);
+
 		input_report_key(dev, BTN_MODE, data[4] & 0x01);
 		input_sync(dev);
 		return;
@@ -956,6 +965,30 @@ static int xpad_start_xbox_one(struct usb_xpad *xpad)
 	return retval;
 }
 
+static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num)
+{
+	unsigned long flags;
+	struct xpad_output_packet *packet =
+			&xpad->out_packets[XPAD_OUT_CMD_IDX];
+	static const u8 mode_report_ack[] = {
+		0x01, 0x20, 0x00, 0x09, 0x00, 0x07, 0x20, 0x02,
+		0x00, 0x00, 0x00, 0x00, 0x00
+	};
+
+	spin_lock_irqsave(&xpad->odata_lock, flags);
+
+	packet->len = sizeof(mode_report_ack);
+	memcpy(packet->data, mode_report_ack, packet->len);
+	packet->data[2] = seq_num;
+	packet->pending = true;
+
+	/* Reset the sequence so we send out the ack now */
+	xpad->last_out_packet = -1;
+	xpad_try_sending_next_out_packet(xpad);
+
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
+}
+
 #ifdef CONFIG_JOYSTICK_XPAD_FF
 static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
 {
-- 
2.17.1



