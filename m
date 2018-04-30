Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoiuNtFAEoBvVZ2LD8lHTOoanYktUqXs32OVtH7iKfIKFC07wNOr5fyfy1VCR1eASv29OrL
ARC-Seal: i=1; a=rsa-sha256; t=1525116377; cv=none;
        d=google.com; s=arc-20160816;
        b=UYTvUtsAA6SWIK5nUxydp7CDczE8uKy2FqcdHnRicBmL2FEn7H+8tJWSI79DK4Eu6+
         Vtzbt4+twPoRxg+m385pJPx/tOOSaULmOjnsT9KmiyqLxOMN95YE73fpu8xuUceRK2dQ
         d3JA/+YwlKSXeDa2jOtUWV7cbkXzoK3Wh27pwu41+rGpLdAMoKWFwN7DB5zf2ISvmB3v
         QgspmekdJGCEuo4jUvwtB1rGpA2UVdyJ005kX4i0pTcT7c2UEPhjnsuG678vlrA9XF7e
         GP6lHUMcjrhAUN3/XFPmN5q5F7BaRI4eOrI5nRrj1sZzT8psqKdnphhLR9DhEa2Muk4m
         3hTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=nAUEaQpNv4UEfpGnPPNJfa0eL83fgcSNewKuq+SmFTU=;
        b=gPfVNh6JySQVTiRXcV0mWG66w05H+tylN/XP07RoyNymJGyhAasK4sKUiRGT2/MLBP
         WXs+w0Rls73J41dPTbSRgrhb03fohzjAQ3SHocd+zLa1OIfYfaLnNP1YmOtmKcc8otBL
         1eryxhFi2KbDxDGQ4O0wfEapLni1p20aGL+nzsCTuDhCM2Pd2v4h8s6QEu6QBS7S856x
         wqJ7CKM4w4sfrg6QByLd6TR6kgNKx8jdTUou6wTQdEBS24xGcy9sej3hotgoQj1YnzSn
         NaNbkJtVSZz1kSDYYTi387qftSI/RwCol3cZbbk3lC2rFP5Ku3Ko+f2loufW1s1nZ5+m
         13Vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AA222DC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vasyl Vavrychuk <vvavrychuk@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 12/61] USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster
Date: Mon, 30 Apr 2018 12:24:15 -0700
Message-Id: <20180430183952.276145572@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200290734996799?=
X-GMAIL-MSGID: =?utf-8?q?1599200430403005384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
