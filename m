Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226T8Sf/mCFNURG9/omMrkvHv31M/pA5Wy5npkLcb7IOrF+eY9xTlvIKwB4TwUooZQ8Iu7uJ
ARC-Seal: i=1; a=rsa-sha256; t=1518707960; cv=none;
        d=google.com; s=arc-20160816;
        b=06VVhNRJ/0VQK10AyG8dD4ifD4WXw+B1YJRPInIKLT4/qNPCOoXfLtZyGmteUczhVp
         IdiIqoAIVBpyzaKAs6R7Q2rxbEHLiYXlG+4GC0oXjG3sBQNrPG8+oE+v0b+75vU8cI2X
         VHC358S7/kxk35iHNjwBbRxde4br7bhCoJhTo/oikCkiaEkle0E9AVnudh1g0PCGKOqw
         HS2bdXG61OB6waO3LAJ1W5oxmLH25PnahYAtUIt5Xe5458/Ik5QPCfSW9fN6YUMZXte7
         IfWSYPTT+/bZH4zGooE4jK6RfTbSajUy+FkJH6uWZFvrPdhL8USnM2TifPkzLKw7y5+a
         Y1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MA8prFooXN6k7+M4RoBcM1j2+fzquOKELXIC6/+EhXg=;
        b=eBJucCXSGfaU1HfGTKWQKIGvQeOQ0HlPRbUX2uc0NWf2UrAaxOv+j/4Ob9qseauraV
         q0SJ1Swup7oSYCKD82NvE3txUAqeVvhBQRpM9WQBbLZrjtmksgwrvnun7YlrdYzguTZa
         P0wDNEd/CB7xPSGSSKEa4lHLpyBubx+9tiqdjJiroDXrgmr/s3JL48ysg+P2Oz198rnl
         BwCuwocMsmF7zs2J/fODjUOtIiqYa9ZIVhrwU2kxCnAVtjV51rzwmhNaHlce1hrZEnjk
         nsP0esCoUWy4nWor5M1JG/hTCg54xR9b3r//rzNQq5bPsnRO9O7VRjWCVWJpIESEJKrl
         sCdg==
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
Subject: [PATCH 3.18 25/45] media: dvb-usb-v2: lmedm04: Improve logic checking of warm start
Date: Thu, 15 Feb 2018 16:17:16 +0100
Message-Id: <20180215144121.289765596@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480718416650893?=
X-GMAIL-MSGID: =?utf-8?q?1592480718416650893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -438,18 +438,23 @@ static int lme2510_pid_filter(struct dvb
 
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
@@ -1231,6 +1236,7 @@ static int lme2510_get_adapter_count(str
 static int lme2510_identify_state(struct dvb_usb_device *d, const char **name)
 {
 	struct lme2510_state *st = d->priv;
+	int status;
 
 	usb_reset_configuration(d->udev);
 
@@ -1239,12 +1245,16 @@ static int lme2510_identify_state(struct
 
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
