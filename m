Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494CFC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191E720661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191E720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeLIWK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:10:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37552 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727125AbeLIWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:10:28 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002ih-1Y; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003IT-Vz; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "Akihiro Tsukada" <tskd08@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.73992011@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 079/328] media: dvb-usb-v2/gl861: ensure USB message
 buffers DMA'able
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

From: Akihiro Tsukada <tskd08@gmail.com>

commit 86f65c218123c4e36fd855fbbc38147ffaf29974 upstream.

i2c message buf might be on stack.

Signed-off-by: Akihiro Tsukada <tskd08@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/dvb-usb-v2/gl861.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/media/usb/dvb-usb-v2/gl861.c
+++ b/drivers/media/usb/dvb-usb-v2/gl861.c
@@ -20,6 +20,8 @@ static int gl861_i2c_msg(struct dvb_usb_
 	u16 value = addr << (8 + 1);
 	int wo = (rbuf == NULL || rlen == 0); /* write-only */
 	u8 req, type;
+	u8 *buf;
+	int ret;
 
 	if (wo) {
 		req = GL861_REQ_I2C_WRITE;
@@ -42,11 +44,23 @@ static int gl861_i2c_msg(struct dvb_usb_
 				KBUILD_MODNAME, wlen);
 		return -EINVAL;
 	}
-
+	buf = NULL;
+	if (rlen > 0) {
+		buf = kmalloc(rlen, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+	}
 	msleep(1); /* avoid I2C errors */
 
-	return usb_control_msg(d->udev, usb_rcvctrlpipe(d->udev, 0), req, type,
-			       value, index, rbuf, rlen, 2000);
+	ret = usb_control_msg(d->udev, usb_rcvctrlpipe(d->udev, 0), req, type,
+			      value, index, buf, rlen, 2000);
+	if (rlen > 0) {
+		if (ret > 0)
+			memcpy(rbuf, buf, rlen);
+		kfree(buf);
+	}
+
+	return ret;
 }
 
 /* I2C */

