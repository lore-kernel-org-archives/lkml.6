Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+bxGj+qR8HwxqVrEnm4n/sVZCYBe1ZyweEHLg6a4jnIT8/YpjCJBLu+bQOaL6Z7RMCI+fL
ARC-Seal: i=1; a=rsa-sha256; t=1524406174; cv=none;
        d=google.com; s=arc-20160816;
        b=geLkdLyKI1dp9+dfXkl+dNnuhu7gc+1u7KYMEToo8khuqshWIVGGbjujBlqe3sI5mg
         2WB9V+mMVxacp2d9i8Grg7ZUsN5DJpLSbjI9iTwLhpD3bYjo/DUwiu+xfmvNiXAqbhuJ
         Fa2F0vaEfbpAJ1sxLxuFtitC+OwEbvc42kiyxPtvVrIFcS3Dpn3aCYYw8ScdwVz0ep2m
         I/HhYDAssosZHsUARot93zSxw3yftQZs/8E6NEDNXXuHtPiuml1L+ZbnQarCIPFIMuDA
         PcLpaXhyF26BWZEJiHYU52hErdyCOoXDYylx751o0UFix9h0vSws8mw3WjDto0eooJOc
         xk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7/g1f+p6RzqQ4lpyzsPB1HYWDkUsVn3/luKEG6LsoKs=;
        b=bK+HWooNXeelUYmUKCE14Xg0gRu5DXDA7WyfbWsIkd1wTzyNQgun5+KAhk/cpzr3ZF
         bWLiXwvlbAULy848asNMUOH1k67GdLNG96VrEUS8Is5R7EXneXafCZ1a5dlTEDji6wnt
         Xy+dbmVhvACekBUs/4azVexShF3z84eH8xFcpZZKcPv/YYXxS67uBuqKDKmZm1d+x49b
         42oaO/ugIS0emt0A9MJYY7CDSVQ2VhekxL3RAqU0K6u8bxG48H516SM49CYKEzMOwaqY
         PfaF94d+2PWk4TT3XVJ0ZV09LFbW21NZF5eEilFkTWolYydRlwtSAWIm2FDS9uVb5Gvj
         Ht1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.14 139/164] HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device
Date: Sun, 22 Apr 2018 15:53:26 +0200
Message-Id: <20180422135141.122064841@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455251173047528?=
X-GMAIL-MSGID: =?utf-8?q?1598455729183185780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>

commit a955358d54695e4ad9f7d6489a7ac4d69a8fc711 upstream.

Doing `ioctl(HIDIOCGFEATURE)` in a tight loop on a hidraw device
and then disconnecting the device, or unloading the driver, can
cause a NULL pointer dereference.

When a hidraw device is destroyed it sets 0 to `dev->exist`.
Most functions check 'dev->exist' before doing its work, but
`hidraw_get_report()` was missing that check.

Cc: stable@vger.kernel.org
Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hidraw.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -192,6 +192,11 @@ static ssize_t hidraw_get_report(struct
 	int ret = 0, len;
 	unsigned char report_number;
 
+	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	dev = hidraw_table[minor]->hid;
 
 	if (!dev->ll_driver->raw_request) {
