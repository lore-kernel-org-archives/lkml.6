Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvaxwgtCrGvmFwpwj6EttnpCJifNkLd/L38lsCuVlINxJJ2IqVCu9jN38zdrb9SF2I39ugc
ARC-Seal: i=1; a=rsa-sha256; t=1521483600; cv=none;
        d=google.com; s=arc-20160816;
        b=iyZNAH76gwQJ9A9NziAe74/z69PsC4d7CEGJLEGaaC73OBcc8LofyrMBO2shDXG+r6
         /LQnq/k0+SEe/oaqHyf1P2BAtM8WyVkCO5RTqynyVIOPh3FTxNkldhEWm+Apz4hHCYm4
         9VQYD11KLUTUO33g1HmdiGk3euPAn4eHpyX/dxVilc10ZD2GRtRpf6UAYKc+cY33CuZb
         n66XjBal8hYXxuvBTbLWJBvHgG0ZhgzTw4xz5H03MCvmG2J+zUqXl6twdNxCQiRK+cC8
         3vPbQRlqd3Eho2+p3UY4trosN+3gZ8ZFucwBbtYtLJVqveuT+a0MzCz08GhIaEcZamfH
         EjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TdQsaFgk7FpD4F0dQzMzCERRCer82wdcw3bBJ2TgtGM=;
        b=HHEkkt+ZmfMVvmUP/r7Rkj35ptDzkYV/JTkv3pIm4M3QXfcQn6oOMBRPjK/NwgoVvy
         b0An51q9ayadzVKYlaYLHdooFhxz2EMegVC0D7B2YgEnpykAZPmGibaMh1JPVabZ0qU1
         GtrHIXxJ5Pe0T3z5nbV2J8U9f78N4Q0iltklDRSpE/EWRS7GzCGBN2y3YIpvvwGg3Y+j
         dKbU9DdEuvkinrDST/rnaWq+0SmaTkA/gbTgI/r4GrIsBRNp0DPaMCXzj3NoyqEMATa6
         +lut+vpEdRMcmjgdRQwgmacAVdoCxtGgpNP92pfqnqsCEYYYW4sTCvc9k68R7IxBiZ1o
         J0DA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Drake <dsd@gentoo.org>,
	Johan Hovold <johan@kernel.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 048/241] zd1211rw: fix NULL-deref at probe
Date: Mon, 19 Mar 2018 19:05:13 +0100
Message-Id: <20180319180753.190838192@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391187722604375?=
X-GMAIL-MSGID: =?utf-8?q?1595391187722604375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>


[ Upstream commit ca260ece6a57dc7d751e0685f51fa2c55d851873 ]

Make sure to check the number of endpoints to avoid dereferencing a
NULL-pointer or accessing memory beyond the endpoint array should a
malicious device lack the expected endpoints.

Fixes: a1030e92c150 ("[PATCH] zd1211rw: Convert installer CDROM device into WLAN device")
Cc: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -1278,6 +1278,9 @@ static int eject_installer(struct usb_in
 	u8 bulk_out_ep;
 	int r;
 
+	if (iface_desc->desc.bNumEndpoints < 2)
+		return -ENODEV;
+
 	/* Find bulk out endpoint */
 	for (r = 1; r >= 0; r--) {
 		endpoint = &iface_desc->endpoint[r].desc;
