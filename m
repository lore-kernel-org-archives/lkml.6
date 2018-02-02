Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227sCnM69l4ju+JoxkmfZukEP6CQGA8e25mLZeC7NBNHCKW+8ZXGV2y853tFYb3Dbs88O1Sl
ARC-Seal: i=1; a=rsa-sha256; t=1517591217; cv=none;
        d=google.com; s=arc-20160816;
        b=r9k1Xvxm5eJSjLcQoQCT94u12If3ZrItD42GFcblU2miPgz40c5R0hzq1zTFDbeBt5
         Du3NQh6184vIR0AtGjStsHxrUEPaGBWKdbhevQ4ap30bar19vqz4x5tEc3IWt1y+bTu6
         IOzdb9fKD2d2+Tn/riNaveTa/E/HxmoU6Cvic2TZW8S0hf0FklqohRQpaAmyjANFze3r
         o5f48IOzxW3G20zddbL1JXYaRtMzOZroIW+SxU3BvZM7+95pYXDE114LtfCrLDnAFKJJ
         /mZa4Ikjw0jflhiby45zzg9QvPnNW2aDfn7U5TdkEinxZRM3g5685UcnkgeLaiULCffi
         8mjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7lZ3C2pPG7EA3gy9eR5cbyeu6c0h8r/7UM+KravkQ50=;
        b=mpoFQFrndT3BqtPvtvejcXQAnjtFmqxYXPksd5cpiwJWrhGZGy3aNYHPWqu0i3hzYX
         Cv6Nk/PC83nPakH/h/MZpePEzC9JyDGYzIS4tMAQ3OIvFQQEK0242HTwd+JjktE8a8/L
         mz4SMzLbk1w4YzAgSYegncSd7hv/RGbea5IYYQOwlJay1tK23r+9JotPChmtlcz2QBNp
         iMb9l85t0uc12BhK0RmebCpGKW0jBJpWI2xEztF4TG49dWnm0R2gOD7x84UdEMRlG0Rm
         b5fV3XNPHSAMT+Im2vMFQhwNgIBfmh+vcM9Bs3iDR9fhriKM5BPqXpZHVTY9hEqdyQ79
         iy5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.9 84/86] usbip: vhci_hcd: clear just the USB_PORT_STAT_POWER bit
Date: Fri,  2 Feb 2018 17:58:44 +0100
Message-Id: <20180202140830.395431799@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309727976197379?=
X-GMAIL-MSGID: =?utf-8?q?1591309727976197379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

Upstream commit 1c9de5bf4286 ("usbip: vhci-hcd: Add USB3 SuperSpeed
support")

vhci_hcd clears all the bits port_status bits instead of clearing
just the USB_PORT_STAT_POWER bit when it handles ClearPortFeature:
USB_PORT_FEAT_POWER. This causes vhci_hcd attach to fail in a bad
state, leaving device unusable by the client. The device is still
attached and however client can't use it.

The problem was fixed as part of larger change to add  USB3 Super
Speed support. This patch backports just the change to clear the
USB_PORT_STAT_POWER.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/usbip/vhci_hcd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -300,7 +300,7 @@ static int vhci_hub_control(struct usb_h
 		case USB_PORT_FEAT_POWER:
 			usbip_dbg_vhci_rh(
 				" ClearPortFeature: USB_PORT_FEAT_POWER\n");
-			dum->port_status[rhport] = 0;
+			dum->port_status[rhport] &= ~USB_PORT_STAT_POWER;
 			dum->resuming = 0;
 			break;
 		case USB_PORT_FEAT_C_RESET:
