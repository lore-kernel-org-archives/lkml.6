Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2255UxgeTuzunYrX4MMXIm4gZ4AkSDzKp/Ua4uGVRJaW+X6FY1iGt+DrCoSh8rk+jEO7+Uo/
ARC-Seal: i=1; a=rsa-sha256; t=1518708351; cv=none;
        d=google.com; s=arc-20160816;
        b=O6SlkSKnRN3+h0aC822nycNfcFlMhBKyti/Tk43dYmeVo3PvVlBJ9v/DXOW3DclKRt
         4GD1vnimOoV/RlXhtfemVCdLOZeTp24U6RWkF03BNPTPZwdJx+yvHiT++NRcJuETkF5a
         /tR0HS+HE/pyQkBTmMB6qNOHRDLzqO6nethHT5owKl8NRy8PVI/I64YlqzAYmKr7e+W2
         uFMQBHqocddjjvUNjCeqehhqykaIH2FE05GWrK4qkTVUcn3pDch2K4bhM5NVXfoxExm/
         DGYZmJLBe0OS+6glb5w4KgrgJpzen9Zk+AsPKrde0qu31IMW28COPlFpw2aP798lpoeR
         D2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NPMQkzCOyMEyUlb1cwFpLUiJCdlsKabN7WHnQ2JTdmk=;
        b=oyT2PaPfmXeB9xyMXXgGGw3mQvY1CD7Ker87UwD5Tj1fS5CesJkoijQAm+VnuDWiXY
         ienRJYaJCn+vORrRL7iXRNrPQsvkr9Oiss+6lvQXB4c6pn2oyOEf+nteektBvG8a1pRk
         7Qjz+QzJtBY5gpvQgycuX8oNlnlMPK3s7tr6+2LDTaPKGxmTnKphgeirRC0ztBcnfuj1
         pjwBUBzi8fPx+zzSUKqpMJofVKWlqU8XcZS4HkSEKibaM/8kyjHDmI0AimDmbxYOpDDJ
         9XxYQfXs/mRYoFoU2efKDJjNENPl7YuDvCrc1FHXKUKnhJy6g6fj/hn121PnMpomqpVD
         l9DQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 12/88] media: dvb-usb-v2: lmedm04: Improve logic checking of warm start
Date: Thu, 15 Feb 2018 16:16:39 +0100
Message-Id: <20180215151224.402009234@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480718416650893?=
X-GMAIL-MSGID: =?utf-8?q?1592481128477648132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -504,18 +504,23 @@ static int lme2510_pid_filter(struct dvb
 
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
@@ -1200,6 +1205,7 @@ static int lme2510_get_adapter_count(str
 static int lme2510_identify_state(struct dvb_usb_device *d, const char **name)
 {
 	struct lme2510_state *st = d->priv;
+	int status;
 
 	usb_reset_configuration(d->udev);
 
@@ -1208,12 +1214,16 @@ static int lme2510_identify_state(struct
 
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
