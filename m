Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49dKdxCCWgTOWDH+ae2zvhfD0Kfuz7WKA/JWUkKE8Wk2Lt5Q+TrmaDDpmh2QLfd3OP+HtaE
ARC-Seal: i=1; a=rsa-sha256; t=1524406824; cv=none;
        d=google.com; s=arc-20160816;
        b=FKCgjOzmPJSkY0K5smE6sVtKb1WZ/LBcab6wtfoFUs+MGebEWIVS7VTLGz5F8+mo56
         Lg6WZfq+Ao8YvapwsVsY0UDkOalMuBCWNf/MaRo2TcPNR9CE0v/Zjt9ZEDgLQMiDCcEu
         11W/sDm+vR9RXs1f2LMZ4YYjD9lDEIR3on4HGfpfl3qExjjLMXC+jlqL2++DhhdmMpE0
         RkFP/e1TOIwVEdqZ6Iann/2up15I2HJ1EXsdqofWdbMz78VRmlt50KI+xYgxyq5oV95P
         PnaLQXu5GPLmJ0BfC4/406Dr2axik5NSBgKMuz31+WRAobfhtb+H0EN3tIfnmVpiv+2t
         NcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lUkU1/3pcCyj/OFrRfbkwFbYHCi4GeO5IgXbdVU/pjc=;
        b=RdO2XWvLfcc5sitgA5Q4o/umrB333mE3RqSJpnQenkFkLmUE2utxAuqvd5A9wf8962
         y+b5cIEh4uKfgZIulK8jThffKPqyd8qYdaa8TIlVo90aLZOhpzqKRYFgKP5a635OBYkq
         czDN6TeOOf+zDAnpji0kq0WYYFgNeuwEVCisRFhYzkY5xhLKeeU1W9Ovs3WElW6fVSvb
         6zZRZ1UaIJx2TsjCw33bdK8wJ+7T1sBkeKTPGYaBuqlbB/7tOVxvymlIPSniMOZrtubc
         wAjJ+SiP2iTsSwOWSvA0Hq4vbtjoj304kCgWuxZ3l1fjJYmdxsVxwCN9PVCXdXw6d53h
         7Rdg==
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
Subject: [PATCH 3.18 18/52] HID: i2c-hid: fix size check and type usage
Date: Sun, 22 Apr 2018 15:53:51 +0200
Message-Id: <20180422135316.112014588@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455016186220261?=
X-GMAIL-MSGID: =?utf-8?q?1598456410264375038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -136,10 +136,10 @@ struct i2c_hid {
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
 
@@ -373,7 +373,8 @@ static int i2c_hid_hwreset(struct i2c_cl
 
 static void i2c_hid_get_input(struct i2c_hid *ihid)
 {
-	int ret, ret_size;
+	int ret;
+	u32 ret_size;
 	int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
 
 	if (size > ihid->bufsize)
@@ -398,7 +399,7 @@ static void i2c_hid_get_input(struct i2c
 		return;
 	}
 
-	if (ret_size > size) {
+	if ((ret_size > size) || (ret_size <= 2)) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
 		return;
