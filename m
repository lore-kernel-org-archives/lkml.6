Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpJOUsFsPukVEfdVG6t47ACsGKFNdYcx+T6fixdNm7whiSc/Zxn42ytdQY6ZEtTaghVX0N5
ARC-Seal: i=1; a=rsa-sha256; t=1525116419; cv=none;
        d=google.com; s=arc-20160816;
        b=sW7e/But9TZX5z90oigYWVPN+LMcftuptLQ/tljIXl6elhgIbZmYP5ksTwg9hbKGNz
         FMf0VsENZtwg0roNW2jlr4evFMN4IkQXQ6eWZ94KTV6MUaHyKEhkKOMR008nwFc2OGoc
         xJf0V4fG9XKOOitPw60W3SJLvHYLcrEK7jgPNA6oKwWmJu0YR+s0cHbrZsULDZRWCgXP
         RAdjIHwStZK1u8GQJcTewe0Gby/4+awtQwtWiZE6zXc9EH/PSdBQaV8lyvykbtT5OM9N
         cGItrr/iAc6hh2kXZbu1ToNVtJuGGmEVZsTE2mS4MlSpAEXd6GmXSmVEoux0iZ+xs/Hl
         YMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=qhhh/fC7u7dHGH8Jokg/L6JvWKU6CBjlg+bgAPeOvHo=;
        b=OP/ga3aqRNxS9PD8Ir2n/HYlBEe0pOZHuByXnhWltoZVcu+dnp/a80JSubsI+gn2Zj
         6foOffpn7HKvoo7mqkmbJRGPi9FJXXvmPmBJ8Mmp5DmtcDpjQ25wj/5RM66ip4zmBR6f
         6r4yvSbiJTzYGOGImyaIfYja38mtQugEA2UZIzkH9yJ0Cqw07U1VaArLAp+9G89AFtEA
         /vMGxqtmGd6y1nbb6lfleUdQg6saIRtM57IK01GEcDz5t2EyeXoXGq55CH1aKDeVNedl
         uuxBpVEakEAWvice40966Ts4dABefNWyEFPZ0eZdEavhTZp+N5YjrYC3+0aEL2J/N5Ek
         9Cuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA3522DC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vasyl Vavrychuk <vvavrychuk@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 16/91] USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster
Date: Mon, 30 Apr 2018 12:23:58 -0700
Message-Id: <20180430184005.077018234@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200290734996799?=
X-GMAIL-MSGID: =?utf-8?q?1599200474560089119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1902,7 +1902,8 @@ static int ftdi_8u2232c_probe(struct usb
 		return ftdi_jtag_probe(serial);
 
 	if (udev->product &&
-		(!strcmp(udev->product, "BeagleBone/XDS100V2") ||
+		(!strcmp(udev->product, "Arrow USB Blaster") ||
+		 !strcmp(udev->product, "BeagleBone/XDS100V2") ||
 		 !strcmp(udev->product, "SNAP Connect E10")))
 		return ftdi_jtag_probe(serial);
 
