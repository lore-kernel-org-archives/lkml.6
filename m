Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48t+fKRa1I5dAOIdRRrNXujEpMRdb/n8uZ7Ehk+Vet4YT7eZKPf/ijrNgjSPdT+8Iz5rkcY
ARC-Seal: i=1; a=rsa-sha256; t=1524405494; cv=none;
        d=google.com; s=arc-20160816;
        b=nHuFQq6ek9pEgdjpkjNLAkEfzpKNSjP8qq5dgZbi1bplBBCVs60tLdGvJoGt9mIbel
         IjCTHTpdwRGHGpAFaKb+pOMI6Z3j+mq+T8qSQOfHl0ZwRnsrifcFkBOpkaIkjCsXMKRD
         v9yl09EkE9sFRpH/oFT/tZeLuDoyh+LnEjHmVos5h+Dob7T3QiYP92J85QfYfOcPSDmx
         AXao24OcrtVafI2C/oH3eVvcF/nEMq6JlJW1LYGRJB3NMcjnfADDI5mWejjWCHW5hRQO
         0M9b9VI/AxRXTAhMfgdFigv5VOAA8Tz31H3nlBHK292PQzoFZHm+3ddVwcPyKEpYVveR
         9Yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CzgWlsbsBe+VO8BesllvL+k2csf/pEUfnPCaRVwN9MU=;
        b=skKD7DZCw8A+xyjbMSOnJkXn6y+H2ha0DvOzmV1XGEMKoqkiIVvL+vEGagYuS6ItGy
         dpzGlWWxdrhl3RYTXzjfx5n0Q2EFWZVkbU2YjnhYbuKlOy9oeqIckA2bYs/EYeDYrCue
         QqNzGhbDSMFyPPGA6RKvBP+DJbEdSQTTxdmFM+40QZYWVIbcxYDpXFJjsxCp4kdrh9ZV
         f2Yr9AtW+9VOf7CpNDOcODFX6ZAwW5aKtALnhcMQD5yK33bWOg7+oABLxpeokdHcHMHD
         QjlyZhj0v2O2pstbDC7Nqob/mpArJwsXkacat3kJ3dLDmZ3wjioVQ56Bc004SzAqYUsA
         WCbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aaron Ma <aaron.ma@canonical.com>,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.16 051/196] HID: i2c-hid: fix size check and type usage
Date: Sun, 22 Apr 2018 15:51:11 +0200
Message-Id: <20180422135106.727958516@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455016186220261?=
X-GMAIL-MSGID: =?utf-8?q?1598455016186220261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit ac75a041048b8c1f7418e27621ca5efda8571043 upstream.

When convert char array with signed int, if the inbuf[x] is negative then
upper bits will be set to 1. Fix this by using u8 instead of char.

ret_size has to be at least 3, hid_input_report use it after minus 2 bytes.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/i2c-hid/i2c-hid.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -144,10 +144,10 @@ struct i2c_hid {
 						   * register of the HID
 						   * descriptor. */
 	unsigned int		bufsize;	/* i2c buffer size */
-	char			*inbuf;		/* Input buffer */
-	char			*rawbuf;	/* Raw Input buffer */
-	char			*cmdbuf;	/* Command buffer */
-	char			*argsbuf;	/* Command arguments buffer */
+	u8			*inbuf;		/* Input buffer */
+	u8			*rawbuf;	/* Raw Input buffer */
+	u8			*cmdbuf;	/* Command buffer */
+	u8			*argsbuf;	/* Command arguments buffer */
 
 	unsigned long		flags;		/* device flags */
 	unsigned long		quirks;		/* Various quirks */
@@ -455,7 +455,8 @@ out_unlock:
 
 static void i2c_hid_get_input(struct i2c_hid *ihid)
 {
-	int ret, ret_size;
+	int ret;
+	u32 ret_size;
 	int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
 
 	if (size > ihid->bufsize)
@@ -480,7 +481,7 @@ static void i2c_hid_get_input(struct i2c
 		return;
 	}
 
-	if (ret_size > size) {
+	if ((ret_size > size) || (ret_size <= 2)) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
 		return;
