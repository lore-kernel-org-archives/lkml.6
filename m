Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709251-2-4460067489859026371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518709251; b=aY2/Y4Zdm8KTAS/EEQnoFIdqdHouV7qFsZmcJHKniv84BPo
    sRRqclcgpS1UpJfYr2lbcou9JBQ9SVx32f7iljJIPQhA9cqE1TpD82xBliHbGQN0
    keR9kGT1YVWYesbhykiLnYG5/NctgINOtg3nWAa0nmXZWjzYhaeVTR5rK/g/HjW9
    TY2jUozGQhj3DIiajO0WELV3SYL1Mn5AZV8cWgSjzpu3LoKkHrTJb1OKZb7AVxrq
    SxEax1tiGxUk9nm2K/A8YvUUh+n5DeEDyGITeCQZ5ms8mlo5yDuKcCCwc9pJ97iE
    2iqS0rsdbrehc7WyOIVPCzIvwrPqP/hX98fYa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709251; bh=25BgAbMr1kCLBW3JcPFXcNJq1g
    n8s4ajEmtQmUOfZc4=; b=SLm+UhQkxLRr7WvULqLQ3Ic350cYRiREtZnBjnjRGq
    +eu9ScscQXaXSbERacfYnPlwTVtSQlpF6PdxZz0PpjkgQm7P05MpFmUg/FvkIb+U
    RTv4B1M/i1kdufiJQHh0G5DoLdMbGth6/WTk89g0KRW6YyDaEPAqO5pHOlFL6Mls
    6lL+67KINzUSckWLUxwEM4U6qFZ2tl5sAnrSJicCUooB62TtJFLEOMNIU8idPHxC
    pgJfyRmlKQ4rnr+MhBc5nS23wnWKp7wAMHLSegyZlkmrV6x56otVTEenHmGXPI1n
    6OLXt/TJki30xijj82pJlx6G+tl0ZMv9/IFiyzx3Rq7w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423786AbeBOPks (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:40:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423764AbeBOPkp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:40:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.15 012/202] media: dvb-usb-v2: lmedm04: Improve logic checking of warm start
Date: Thu, 15 Feb 2018 16:15:12 +0100
Message-Id: <20180215151713.469334722@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb-v2/lmedm04.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -494,18 +494,23 @@ static int lme2510_pid_filter(struct dvb
 
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
@@ -1189,6 +1194,7 @@ static int lme2510_get_adapter_count(str
 static int lme2510_identify_state(struct dvb_usb_device *d, const char **name)
 {
 	struct lme2510_state *st = d->priv;
+	int status;
 
 	usb_reset_configuration(d->udev);
 
@@ -1197,12 +1203,16 @@ static int lme2510_identify_state(struct
 
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
