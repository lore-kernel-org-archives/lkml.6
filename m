Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EC0C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E253F20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E253F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeLIWKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:10:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37522 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726337AbeLIWKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:10:14 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73K-0002pr-9J; Sun, 09 Dec 2018 21:55:54 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003IY-17; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "=?UTF-8?q?Mika=20B=C3=A5tsman?=" <mika.batsman@gmail.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.369471447@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 080/328] media: gl861: fix probe of dvb_usb_gl861
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Båtsman <mika.batsman@gmail.com>

commit 48db0089bff6f9154f6bd98ce7a6ae3786fa8ebe upstream.

Probe of dvb_usb_gl861 was working at least with v4.4. Noticed the issue
with v4.13 but according to similar issues the problem started with v4.9.

[   15.288065] transfer buffer not dma capable
[   15.288090] WARNING: CPU: 2 PID: 493 at drivers/usb/core/hcd.c:1595 usb_hcd_map_urb_for_dma+0x4e2/0x640
...CUT...
[   15.288791] dvb_usb_gl861: probe of 3-7:1.0 failed with error -5

Tested with MSI Mega Sky 580 DVB-T Tuner [GL861]

[mchehab+samsung@kernel.org: rebased on the top of upstream]
Signed-off-by: Mika Båtsman <mika.batsman@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/dvb-usb-v2/gl861.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/drivers/media/usb/dvb-usb-v2/gl861.c
+++ b/drivers/media/usb/dvb-usb-v2/gl861.c
@@ -26,10 +26,14 @@ static int gl861_i2c_msg(struct dvb_usb_
 	if (wo) {
 		req = GL861_REQ_I2C_WRITE;
 		type = GL861_WRITE;
+		buf = kmemdup(wbuf, wlen, GFP_KERNEL);
 	} else { /* rw */
 		req = GL861_REQ_I2C_READ;
 		type = GL861_READ;
+		buf = kmalloc(rlen, GFP_KERNEL);
 	}
+	if (!buf)
+		return -ENOMEM;
 
 	switch (wlen) {
 	case 1:
@@ -42,24 +46,19 @@ static int gl861_i2c_msg(struct dvb_usb_
 	default:
 		dev_err(&d->udev->dev, "%s: wlen=%d, aborting\n",
 				KBUILD_MODNAME, wlen);
+		kfree(buf);
 		return -EINVAL;
 	}
-	buf = NULL;
-	if (rlen > 0) {
-		buf = kmalloc(rlen, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-	}
+
 	msleep(1); /* avoid I2C errors */
 
 	ret = usb_control_msg(d->udev, usb_rcvctrlpipe(d->udev, 0), req, type,
 			      value, index, buf, rlen, 2000);
-	if (rlen > 0) {
-		if (ret > 0)
-			memcpy(rbuf, buf, rlen);
-		kfree(buf);
-	}
 
+	if (!wo && ret > 0)
+		memcpy(rbuf, buf, rlen);
+
+	kfree(buf);
 	return ret;
 }
 

