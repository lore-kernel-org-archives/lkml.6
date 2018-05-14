Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrfsWguOMS3KGZNtiLVTABknZn8O8ZvDYpIMtsBL0TjVp/aoqjVf3Nbp/kejRsQqr0F+cyy
ARC-Seal: i=1; a=rsa-sha256; t=1526280709; cv=none;
        d=google.com; s=arc-20160816;
        b=DEAJmcI2EBoJI5CtYbqrCGMrebL1dtpVv1v8bhbmvaN+CPJaxSafZV2GUaoqJlgb0Q
         oM/GTxosvmdYuW1LReQoLcqiZJZJtrhJa5tYQCJE8gR7gnByoR7znWDxLTSifujx0u8h
         Fpo7EkqvqGP6Ke/ykZkiA6TDe2z1RKwsc5IRyiSx+qNLflws2X7L5cqk5731H7WDh4NJ
         6T/xtURYFmnJxE+LnIS7wdR3yuy5rtGjHGUYCElggvcxUofb4V4IOs/s+w0Ex7c7DViF
         agWq1DVbebKo1YJF0th5cp4UaFdqdrgmi8QDxKADPVOLl4mKhppNowtOkieuxpb7IBEz
         zfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=EdtUVd4IU/2gpSusuCpF5J2HZC+EkhDWDD7Q9Hrft94=;
        b=oaX9SOZRS3gMssJ21ARMWd5puWZR6MoCaAgHXaklNPwxJItP4T2TXe9tv2M8/kg+l4
         fJApHNWH6ZXq/TNWFSQfYwwCeqB3WkPiQ8OyRwS8kQGBaPjFoip3rNc3HMo2SXz7rMrH
         P92HiyZAIrPO7vESPcnpBYxtsNP7Agos7zAezyp9X9nFVFITWwES/MuJ9T1uvvpTdruZ
         kl66J27yd4kn0reIS0uVhl3eY9OHPLShbHsZV4dJmy86A04IMYPbJcRNY00ES0tbn3kG
         AGHMi5p0nbR7RgUODoP++M3C/8IRSXAwkOFxdoovY0xykMvLBtx+FETCSszXqTD6rQCb
         HLEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wWnXRlen;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wWnXRlen;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Elvinas <elvinas@veikia.lt>
Subject: [PATCH 4.4 27/56] USB: Accept bulk endpoints with 1024-byte maxpacket
Date: Mon, 14 May 2018 08:48:32 +0200
Message-Id: <20180514064757.446194114@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421320975379108?=
X-GMAIL-MSGID: =?utf-8?q?1600421320975379108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit fb5ee84ea72c5f1b6cabdd1c9d6e8648995ca7c6 upstream.

Some non-compliant high-speed USB devices have bulk endpoints with a
1024-byte maxpacket size.  Although such endpoints don't work with
xHCI host controllers, they do work with EHCI controllers.  We used to
accept these invalid sizes (with a warning), but we no longer do
because of an unintentional change introduced by commit aed9d65ac327
("USB: validate wMaxPacketValue entries in endpoint descriptors").

This patch restores the old behavior, so that people with these
peculiar devices can use them without patching their kernels by hand.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Suggested-by: Elvinas <elvinas@veikia.lt>
Fixes: aed9d65ac327 ("USB: validate wMaxPacketValue entries in endpoint descriptors")
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/config.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -157,7 +157,9 @@ static const unsigned short full_speed_m
 static const unsigned short high_speed_maxpacket_maxes[4] = {
 	[USB_ENDPOINT_XFER_CONTROL] = 64,
 	[USB_ENDPOINT_XFER_ISOC] = 1024,
-	[USB_ENDPOINT_XFER_BULK] = 512,
+
+	/* Bulk should be 512, but some devices use 1024: we will warn below */
+	[USB_ENDPOINT_XFER_BULK] = 1024,
 	[USB_ENDPOINT_XFER_INT] = 1024,
 };
 static const unsigned short super_speed_maxpacket_maxes[4] = {
