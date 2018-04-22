Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49kCODbVwxUPU4PtXjBpiOFne1OGJECbPGzuYp17ALdk+3mWc46UGs44TSEDH3NoleBTiyu
ARC-Seal: i=1; a=rsa-sha256; t=1524405718; cv=none;
        d=google.com; s=arc-20160816;
        b=ao+1j453oYDOeuGm/uqCVDkoMOYPErNRzDia2G1QH4KdCoOmA5ibOOM2oVK6332QF4
         FIET205x6IJmawQSgaNo06SzdZAF7CzmzpZCrrLdjsSFjyC4FGJbOJeRzIudR85+oX4K
         UqYa6JuUmzSj04SFOBsqvyXqdY5VeEyptc4X14Cjs1hvAb7lDPVDHJyDeyxSJoVhKCJ3
         vJKl0JE6PD4k8V+KLVMYKTXg538Y7RO9rOUnsUdqgj8Fd7sCNO8qV2jlge2kpf9pGTOJ
         y9uhl2HN3FTI1X/0Z0Keocscfa6tbmbQEDeEtBbjmG+fSB22FvFW+fWcoEBKpzchFfnz
         ogyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=G3MrEDpHRF1omz2m57A3b3C+fxKXiTpciA67DufaXgg=;
        b=0JijU2ElsydJrVAyI+AXn70emxgXetQjPcOSfWCbUyuus61ZBpeT6GneHFipK1i8ML
         +f/UlfT0mlfR7jpWIWTOp0FbPy7QuaDh1V/awjtWwxmM4nwtkAlS58devwFLVy6156yo
         Yg82BAu2oQJ4CYGkIQMqtgps9vdG16nK3/Nwcio9UsNY6RarjVb9l4LTc5uO8JYKKok1
         D6FxOwwKXhmYouOIDCBJm8ulk3p381r7nGINj1P1at0+aWp6B83/6KQ83F3Tz1fBElOc
         +ZGZHEehmdfvINQMvmLiL83N5i1WrrqU6Y8byUqeW6MaoKaKgYg0CRF0mgPhIlBTZzzs
         t30w==
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
Subject: [PATCH 4.16 170/196] HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device
Date: Sun, 22 Apr 2018 15:53:10 +0200
Message-Id: <20180422135113.048045666@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455251173047528?=
X-GMAIL-MSGID: =?utf-8?q?1598455251173047528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
