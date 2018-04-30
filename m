Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqKrZ6pOEOdQk+/GpB6spV5FtdhDuWs8+XcnI4d8i0a762PJXYVwWP1A3y1rEiS7QPUF7+P
ARC-Seal: i=1; a=rsa-sha256; t=1525116352; cv=none;
        d=google.com; s=arc-20160816;
        b=BotdjK2s6yKsnViNjrIbOMMzvxVCGd47alFCU60Ryio0XSqTAeTCnXnCbBUOT3mhWZ
         +r8gJUO59aSmNGnGsSifBHKBBIeMOYt3PrlTv/ksTvy/bAWvKedw3mZaw2U5iZ+bJrhH
         qZg2Ie6ab10mWrInU4S3WMAXpNrMVma0hVCvjZSQTzpeI968Pm+XjlNPS62jJOsZNrcv
         LgVig8brIhePZBEFxm8mPbJmUn/8K8muc9wHupsYM088/1Fy4B1ePHN0K1QkhKr8D9cN
         imsiSrfrWZOQbZ+T4KDHmoR/gO8xRImuCNzGadF851U0NCAdBqteQTyZio+qxG59zWn0
         Uhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=L9jZs6PqEVSd04ZLltTPJaF88dVAwmJ2AEM5Mk1AhTY=;
        b=IEHkyn+uhDBfSw1WnUvVModpPmvmeI5gPGghaGjJth8opIHz4+Cnollhplc699tH7a
         75ffOLFNMHVgTininoPpmURNhfU2MRHg4xEKkR4nCMWTZPbie0NRQNz21MYEVNFe+fcv
         XV2354X1+GQHxeIMFg2a4BC8zEv82LwYC3+1x0SvhLCnNwxmbdAxJo/QTV5VjHgvg5/Y
         nZ/3iBu8cp64kTBKREm+jetTBiryaLeiM5z0HIGnSmFuM2n4fm8eZyRXNAs3Ymz6TIfW
         phBb3xakwahJjxm349IO09rw4Y0faHD1o4qcBG2verChWvZ1g4obyrNs1WtStk/Ki93h
         yHQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D80C22DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vasyl Vavrychuk <vvavrychuk@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 08/44] USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster
Date: Mon, 30 Apr 2018 12:24:19 -0700
Message-Id: <20180430190946.672704982@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200290734996799?=
X-GMAIL-MSGID: =?utf-8?q?1599200404842372196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1911,7 +1911,8 @@ static int ftdi_8u2232c_probe(struct usb
 		return ftdi_jtag_probe(serial);
 
 	if (udev->product &&
-		(!strcmp(udev->product, "BeagleBone/XDS100V2") ||
+		(!strcmp(udev->product, "Arrow USB Blaster") ||
+		 !strcmp(udev->product, "BeagleBone/XDS100V2") ||
 		 !strcmp(udev->product, "SNAP Connect E10")))
 		return ftdi_jtag_probe(serial);
 
