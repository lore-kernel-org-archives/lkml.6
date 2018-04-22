Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/hOdXMZzEw58JsOd1dhcN7bgLSM1JLng1Uv4rojfmreUnJmnZzkNassQ/1r/tH76E3PEem
ARC-Seal: i=1; a=rsa-sha256; t=1524406708; cv=none;
        d=google.com; s=arc-20160816;
        b=F6r6+N65IIblB1PAfGlPmaCY1YLY5iv4FurZdPZQ5PwRdJpIWstRaQsqwB6YZJUnkT
         lNIJgoXClHUdcVMdrxezJ0+SOttTbpUExMQBHOZ8RRqf7mXwh+O7g86wu+OlstCb3pRr
         URqQw295tlEDGf0VAowUGYt4EdVC5caGZ7gsNN1qxYpdRKvLrIRWPUco3S7zSWuHLD3y
         9z7kEUNWeC0ckNLWb+E08NX4pzaxiYJb7o1GJYtfpbdbMmQR/VzazxXNleRyUNLhEQYM
         DAMAhM7lVovtrPCzEx0ZS7JQQc/k/DEwgF1Q6OAVLjnajFhh4/Soy+JxTt1XG55C56Wi
         sImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nwng4XIU3iYB1lhyWlrGZaSquqD8ORxucyTZXIJa8/k=;
        b=odIZAWCJiSsXFec/BhLNKWLIojtb462sqT30XnelGO+g57kAlylAKbpP6ACwd96A55
         sFDAq8QJZhxGqiAfKfrDon8P5SHqDeMl6wr57IUUl5vkhe7DDefewwYbi3erz6t4Aiwr
         toxInDk7ldlh6JpuN4/7n/AkzM26bsxekos/Q/gyt3Yxle0DRpG3BdMykVNK1QQy4oA9
         cDKm4xNA8fXTJIJp0GKWT91bnR5aZ3xNBrD26DB3otO/CFi2oiX0lqYrtVJilqvQzmVN
         wpuaAI7a5/i5pVyoeZGGNXkc698EXd53byDxGwU9u8BR3aoe2ZSvcVLeNn0d6EIuCz92
         Ju4w==
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
Subject: [PATCH 4.4 39/97] HID: i2c-hid: fix size check and type usage
Date: Sun, 22 Apr 2018 15:53:17 +0200
Message-Id: <20180422135307.503753820@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455016186220261?=
X-GMAIL-MSGID: =?utf-8?q?1598456288878019015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -137,10 +137,10 @@ struct i2c_hid {
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
 
@@ -387,7 +387,8 @@ static int i2c_hid_hwreset(struct i2c_cl
 
 static void i2c_hid_get_input(struct i2c_hid *ihid)
 {
-	int ret, ret_size;
+	int ret;
+	u32 ret_size;
 	int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
 
 	if (size > ihid->bufsize)
@@ -412,7 +413,7 @@ static void i2c_hid_get_input(struct i2c
 		return;
 	}
 
-	if (ret_size > size) {
+	if ((ret_size > size) || (ret_size <= 2)) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
 		return;
