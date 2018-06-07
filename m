Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MtuwCIE8GVt9NAAAmS7hNA
	; Thu, 07 Jun 2018 14:09:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 10635608B8; Thu,  7 Jun 2018 14:09:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8E46D6063F;
	Thu,  7 Jun 2018 14:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E46D6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932987AbeFGOJB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:09:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39098 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932872AbeFGOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:58 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zp-85; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002gY-5w; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Malcolm Priestley" <tvboxspy@gmail.com>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Andrey Konovalov" <andreyknvl@google.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.577136295@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 007/410] media: dvb-usb-v2: lmedm04: Improve logic
 checking of warm  start
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 3d932ee27e852e4904647f15b64dedca51187ad7 upstream.

Warm start has no check as whether a genuine device has
connected and proceeds to next execution path.

Check device should read 0x47 at offset of 2 on USB descriptor read
and it is the amount requested of 6 bytes.

Fix for
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access as

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/dvb-usb-v2/lmedm04.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -434,18 +434,23 @@ static int lme2510_pid_filter(struct dvb
 
 static int lme2510_return_status(struct dvb_usb_device *d)
 {
-	int ret = 0;
+	int ret;
 	u8 *data;
 
-	data = kzalloc(10, GFP_KERNEL);
+	data = kzalloc(6, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	ret |= usb_control_msg(d->udev, usb_rcvctrlpipe(d->udev, 0),
-			0x06, 0x80, 0x0302, 0x00, data, 0x0006, 200);
-	info("Firmware Status: %x (%x)", ret , data[2]);
+	ret = usb_control_msg(d->udev, usb_rcvctrlpipe(d->udev, 0),
+			      0x06, 0x80, 0x0302, 0x00,
+			      data, 0x6, 200);
+	if (ret != 6)
+		ret = -EINVAL;
+	else
+		ret = data[2];
+
+	info("Firmware Status: %6ph", data);
 
-	ret = (ret < 0) ? -ENODEV : data[2];
 	kfree(data);
 	return ret;
 }
@@ -1228,6 +1233,7 @@ static int lme2510_get_adapter_count(str
 static int lme2510_identify_state(struct dvb_usb_device *d, const char **name)
 {
 	struct lme2510_state *st = d->priv;
+	int status;
 
 	usb_reset_configuration(d->udev);
 
@@ -1236,12 +1242,16 @@ static int lme2510_identify_state(struct
 
 	st->dvb_usb_lme2510_firmware = dvb_usb_lme2510_firmware;
 
-	if (lme2510_return_status(d) == 0x44) {
+	status = lme2510_return_status(d);
+	if (status == 0x44) {
 		*name = lme_firmware_switch(d, 0);
 		return COLD;
 	}
 
-	return 0;
+	if (status != 0x47)
+		return -EINVAL;
+
+	return WARM;
 }
 
 static int lme2510_get_stream_config(struct dvb_frontend *fe, u8 *ts_type,
