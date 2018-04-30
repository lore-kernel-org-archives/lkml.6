Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqSBAjsiI/He91KI9WDxhzEuaDjb14mBHDfOVXK/igYPpI4/v51MyCeDfgL5tKBE08crK96
ARC-Seal: i=1; a=rsa-sha256; t=1525116477; cv=none;
        d=google.com; s=arc-20160816;
        b=U6911KD5l18Fo2iIuCvc8R1E7z9OHF9T+blmjqTTSDstHRGZKVwW/XVdSLeuD/WT5R
         yHlztn/QlSqJC8S2kCjSdfjv5dMEs1SPpcP1SCtLAzxUmsIV0Y6M7qDBJyRgjlfc06Ki
         3jr166krzY75vsN5LZqaiB+Hw1+OPrz4MU2ZSylh6SJbLMnha/n8p6pMY/HbfKHz8om2
         WJ24Ner+9+MPeWmc4UcqQEu6qWe2VR+X1321mSHee3XuPgjJswZLXDt61NtyRpbpkEfp
         r5WFTlmKjWFN7keYvwHcTg+7cOiJVJT1ZhRt5iNILI9V7bgDqp4dDBnqd0TJHNYCmj1W
         DJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=19EomCia93l/o2MgEur/stUou4TueROzVtNIpn0ZOmY=;
        b=pyV0PYiD2VNIpMoL9arxa3gQMCe4x9HSUBMk0+BHNPG4cdHqWBjlKz93N9mJZJnWPu
         2uY6tDVvtR6Sg2/BvV4xuzzYZ0P931Rc3QI7MaYLYgUW4q8FtyBzaeKSLzPQBbaDmDXv
         b1tNx/wmAVOkFfQVg56+iUqdNCSVDUCuBeFEURI3qe6ITrdQoWzNwWiIOVFJ7+GocYF5
         NrmAUdg7evspcHL5Vu7aCYJNYl8wmQrYpJLqz4ewzHj0cdBL2EthF/2aLZetGhNTQ3iY
         h+IaaGCyc+CQNaexk2jeHCrYntPlhkM79AAXVgXauOtXc+CNNryNpTEc5jsCMF4/i6Lc
         qseg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5251722E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vasyl Vavrychuk <vvavrychuk@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.16 017/113] USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster
Date: Mon, 30 Apr 2018 12:23:48 -0700
Message-Id: <20180430184015.809223277@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200290734996799?=
X-GMAIL-MSGID: =?utf-8?q?1599200535823063535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasyl Vavrychuk <vvavrychuk@gmail.com>

commit 470b5d6f0cf4674be2d1ec94e54283a1770b6a1a upstream.

Arrow USB Blaster integrated on MAX1000 board uses the same vendor ID
(0x0403) and product ID (0x6010) as the "original" FTDI device.

This patch avoids picking up by ftdi_sio of the first interface of this
USB device. After that this device can be used by Arrow user-space JTAG
driver.

Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ftdi_sio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1898,7 +1898,8 @@ static int ftdi_8u2232c_probe(struct usb
 		return ftdi_jtag_probe(serial);
 
 	if (udev->product &&
-		(!strcmp(udev->product, "BeagleBone/XDS100V2") ||
+		(!strcmp(udev->product, "Arrow USB Blaster") ||
+		 !strcmp(udev->product, "BeagleBone/XDS100V2") ||
 		 !strcmp(udev->product, "SNAP Connect E10")))
 		return ftdi_jtag_probe(serial);
 
