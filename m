Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/vX+90WB77EtnLkjtL2newJyUOkvLaCnX5jV0UZuIMmv1FLqFB/chKQkgodMAWf4SsZ4hj
ARC-Seal: i=1; a=rsa-sha256; t=1524405914; cv=none;
        d=google.com; s=arc-20160816;
        b=CafFrdMJV0dpx4A+xfNocudtPagm+9KWF/kr+HNcsT5BJ0H+/DgvbUlxOP7M8J0cs6
         WDnMjcEJsO6Wsxey/P5FBp+8kbLpL6SdeOTPH80X+Ji9w5yqGNJcCRG63oLo/AX8m3JO
         92lF5Hkav+jEgrG+7mglyU/+LmdK0hZzX1UXM9w9BNK0epAFzq6Y5pwCQUySoZ/aWoU1
         RdaXIgZMrJlImi+FNlBjjYLstjOmG3plGYKO/mEofWRCmc0hqu6rYOffwq3XnXI2GJ43
         rgRGF6igNJ3stn40MrsXEotRV9s01fwU1o0dNOJ+aTTlmWlAFf/Ji8cjZ67lFPJqal5q
         xYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SQk8viL2Vww3A76wd2UGFhOLh/ulYLA2vX2FVtQOkE4=;
        b=YjGD+3HAWUJROZy9u0KnL8iHOOUGrJbWLStE2MOTTtYVBQbUKssc5DCYkPHX6w4lae
         8hdokoWsbINZWRZezRZOyFXTmQngS+vaZRJDNt44S76irrjOMha+X1KJzxdTBpI/LnZx
         fI6NuSwxI/tSjVu5RMtP8Lmiesew+JxVFsXYjdojepZQ5Iw45+5NG+hGRV/ZKr9LBDjc
         TMdH/wJs4B84vcQSD9DAqDd6327vReW8uI+FRgdf7nlSs95ohL+/F5SSNVNwtUXyT+1b
         FBS4GFQ5w1iwcXf7k91WuyanphhHM5HgZ8W/Csb26cAOKzzhYU4OAeEqzdFI4Mna2z9G
         3QIQ==
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
Subject: [PATCH 4.14 045/164] HID: i2c-hid: fix size check and type usage
Date: Sun, 22 Apr 2018 15:51:52 +0200
Message-Id: <20180422135137.253698698@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455016186220261?=
X-GMAIL-MSGID: =?utf-8?q?1598455456799803177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -143,10 +143,10 @@ struct i2c_hid {
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
@@ -450,7 +450,8 @@ out_unlock:
 
 static void i2c_hid_get_input(struct i2c_hid *ihid)
 {
-	int ret, ret_size;
+	int ret;
+	u32 ret_size;
 	int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
 
 	if (size > ihid->bufsize)
@@ -475,7 +476,7 @@ static void i2c_hid_get_input(struct i2c
 		return;
 	}
 
-	if (ret_size > size) {
+	if ((ret_size > size) || (ret_size <= 2)) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
 		return;
