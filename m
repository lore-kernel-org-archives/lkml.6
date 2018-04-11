Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rNx0jc3B18JEnxtEIUykYcO+GOi1+Hu/mWID99GrC9WEaDSYG1Jy7hriy34LCCDvwHU0O
ARC-Seal: i=1; a=rsa-sha256; t=1523473195; cv=none;
        d=google.com; s=arc-20160816;
        b=hrKWvNl44V2wgXnNPzVvvoBXe4swkvMMtNdNXlD0kdJ9io+kJSGzlQxD7MCnV+46h4
         C02+drARct2oMUv9tnnCVrcyztra2Mjn7bOQcQeLcl3htXyeLbfpPp9JRDd82PJJXAq2
         7ddmsbBRyK+rWMgowshf9dlAKHZBhLoMdIG7PwUCCUFKyEfxqh+VsfSzL9VoOzc1ENR4
         7sdwb6YEw8rYM1EMaF5iy7LriChCD06ZmPsZE/s3c6IdB3TGhId1c7q4lposDz20RCVv
         /8AQjaJxPEKi+5Nruct5EuK4Z4LKCdKtF2EWBt/lOwgQfBqc9KWEKvxSRHgPqMMUP74X
         imTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Us2jcT793qaf+gZOhpgNvyyaaKftPGXpPLpAPHhvY0Y=;
        b=08z+vHSW0LDl03eRNwejqlJ+KTA/Ng4yI1EXwoDJRJohh7M+Vm7GZsSRcQoaX31UFY
         keBqRh3Qr0ceLkcXZS2EqDJrbEZiKxjHxz8aaNJjiuQKS7eUZhJ3AbtS5kYbHPFalzH9
         E23gYyuwjG8ZYQGysMH3eOnUG6L6JG6ItvefiebIpi2VvXJ0oj4sZPLG4ILgGRe83Z/a
         CcZQx4OOfFHOmSPuh7dO/1ZOqTk/mz2NmsTwdnTlNlSihnWd4PHxIuFgC3z11rWGnrKm
         uHaw7dAVZ9NFqMLmIYsJyHswUMHXk+XvOa8ApwwA2oVNX5mQUFmLtOzol5Sa21V19SbN
         Z2RA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gary Bisson <gary.bisson@boundarydevices.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 160/310] rtc: m41t80: fix SQW dividers override when setting a date
Date: Wed, 11 Apr 2018 20:34:59 +0200
Message-Id: <20180411183629.277414543@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477429275993198?=
X-GMAIL-MSGID: =?utf-8?q?1597477429275993198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gary Bisson <gary.bisson@boundarydevices.com>


[ Upstream commit 0f546b058b86ea2f661cc7a6e931cee5a29959ef ]

This patch is only relevant for RTC with the SQ_ALT feature which
means the clock output frequency divider is stored in the weekday
register.

Current implementation discards the previous dividers value and clear
them as soon as the time is set.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-m41t80.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -168,6 +168,7 @@ static int m41t80_get_datetime(struct i2
 /* Sets the given date and time to the real time clock. */
 static int m41t80_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
+	struct m41t80_data *clientdata = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -183,6 +184,17 @@ static int m41t80_set_datetime(struct i2
 	buf[M41T80_REG_YEAR] = bin2bcd(tm->tm_year - 100);
 	buf[M41T80_REG_WDAY] = tm->tm_wday;
 
+	/* If the square wave output is controlled in the weekday register */
+	if (clientdata->features & M41T80_FEATURE_SQ_ALT) {
+		int val;
+
+		val = i2c_smbus_read_byte_data(client, M41T80_REG_WDAY);
+		if (val < 0)
+			return val;
+
+		buf[M41T80_REG_WDAY] |= (val & 0xf0);
+	}
+
 	err = i2c_smbus_write_i2c_block_data(client, M41T80_REG_SSEC,
 					     sizeof(buf), buf);
 	if (err < 0) {
