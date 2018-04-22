Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48jftWuhiYZed1KDt76dXXoBFlt6PjRuAjDzhW7vm1jg7mWGKR4RSnxg6a0T6tjAypdS2i4
ARC-Seal: i=1; a=rsa-sha256; t=1524406454; cv=none;
        d=google.com; s=arc-20160816;
        b=oz7Cjw3g3zy7zMsz27pP/xoS8+bC/GX+Ol8t0rYKr0dcKhcd9M7ywY/F1HApHUB/z7
         yvam9qwpGgw0PZUodoOg16GXkYvqcmewGHfbOSmZDJezIAVxeU291eLuViOC5v0W2GBm
         cSf/AatchwG8imCGKkgertOjFUOTC4xqVqxlk0v+L5LyAFE1UWFViufPxPN3DQyQ6jV0
         GbTHDJM6aA3XZEY8L4Q951Y8ZayKZmOl9YEOpPM1qTX/ZNrO7yGDoUmGd/dnvrTGAx+G
         2RYwilyQuuWeFpC0mD+mMFqGyARVOM0bNzbQsaAg9iX/1f6374MUTha6k2EfI9IMPYX1
         7ESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=x6AgQW90E7fp9F2cPYTvOeRZoTGtcYpGquEy+DIqRwM=;
        b=aPPcWXmXV7NSdWYCw3svLi6MO/3+vjpBhVO3xvAPBzpiqVskifc3AKUKA6BzT6mkl+
         UKvFoTcmAFuNV9XZHsU9ZVySHJRJSIKaE+7b0INLeheh3bvzDWO0s4sekVygwRlRpCWP
         E53TrDVGZu9rm/6TUlndtGeS5wOWe269+g/uWK4y63AWAMoRVlJwlXaxqF2Q9Wifkelw
         7mkAivOZznOEPYQVTgFXiGhSx3FEHQs/3XKm7bNVPg6eKAwtbMPBl5unwTN8oscYm+Cn
         vnzhY2jT9laDsbsl7Kl+jFCYIVWNCsEHme1wA1PKuIRZv320Y93vGHq4C3bSYaj8HEZ6
         omKQ==
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
Subject: [PATCH 4.9 78/95] HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device
Date: Sun, 22 Apr 2018 15:53:47 +0200
Message-Id: <20180422135213.620479881@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455251173047528?=
X-GMAIL-MSGID: =?utf-8?q?1598456022694683048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
