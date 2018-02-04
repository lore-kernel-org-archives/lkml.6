Return-Path: <jackstocker.93@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517763080; cv=none;
        d=google.com; s=arc-20160816;
        b=g0361qv4Gz/J2PA69oB09ei40JwpDrK6GX7Km4LhmbYiW02644GetiZvEklHrJpE8F
         Tawkht78fRWv2Cf14HC/n/lgk2TUfzP2+yHsXd8Gpfee0tGkw2QbaGKuwG2m/usekkcf
         e9iICEmSjYGaAV7fpNsnx62ZezfMlWO0qQDj/WccrgBgucJyANFqVQZgxNUot/8Iyy8i
         t5dXKYB6aCr5lxvSjhCgXQUx2aPX6kkQoPb1qQLzn6KCzTJVladOdm3gdoMMYwpXf5mB
         jqS2dJasPUuhdyXe2Y0RJKrijRoNrSQ9uLBQi83qqgfnmxwmiCtwYZ3shwAFih0ur1u5
         q4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=AFdG9DnfaD/sjCXVBTbnSeLs7yTq/NLOyiURxSDUvDg=;
        b=kyj+Z9rz/aBLVr3/asxjZgpgLrA40wj9oLJfoxnspTUGcjgSR7lQ5g5QYysRTx8QQV
         8bPNCtYO9XM9jrhiFs4RArbkpNmWsaDW/7VfblsiwwqjltLTAuVnkzsIjWDSStSghveG
         DybBEYnknE3kJj2PwPP19vMaIQTQoIEpgrHaHULSr8Kk9qMlsQGunAqcYf6yDAL8HiZs
         3s1MKo3jBo9ayWuyQkFyaxoQ6IbNZjJ9voNBP2A/cZX2CNdvbS/s6wiLgNNOWymSOiWp
         R1hHWdLysqHnrS4PIIy5f2G21HOrmQJ/KCS+5u1MWYBY+EWykIGL0YXNdxhuwYMwrypS
         CamA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=L7FDuSQe;
       spf=pass (google.com: domain of jackstocker.93@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jackstocker.93@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=L7FDuSQe;
       spf=pass (google.com: domain of jackstocker.93@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jackstocker.93@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226zIZ/vyTqMebrgPdW0JAGeeWU615F47ewxK9/LMcesjACWNQCyU0rrfxnBjcRXCGhq3guAUA==
From: JackStocker <jackstocker.93@gmail.com>
To: 
Cc: JackStocker <jackstocker.93@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Seth Forshee <seth.forshee@canonical.com>,
	Dmitry Fleytman <dmitry@daynix.com>,
	Devin Heitmueller <dheitmueller@kernellabs.com>,
	Sandeep Singh <sandeep.singh@amd.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Add delay-init quirk for Corsair K70 RGB keyboards
Date: Sun,  4 Feb 2018 16:50:58 +0000
Message-Id: <1517763059-9334-1-git-send-email-jackstocker.93@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <AE53BCA5-F49A-41ED-B6F4-1B5FF8B4391F@canonical.com>
References: <AE53BCA5-F49A-41ED-B6F4-1B5FF8B4391F@canonical.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591305042869034715?=
X-GMAIL-MSGID: =?utf-8?q?1591489939818145075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
Corsair K70 RGB keyboards also require the DELAY_INIT quirk to
start correctly at boot.

Device ids found here:
usb 3-3: New USB device found, idVendor=1b1c, idProduct=1b13
usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-3: Product: Corsair K70 RGB Gaming Keyboard

Signed-off-by: JackStocker <jackstocker.93@gmail.com>
---
Changes in v3:
  - Added correct v1 commit message.
Changes in v2:
  - Moved K70 entry above Strafe to preserve ascending order.

 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index a6aaf2f..0405d68 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -218,6 +218,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x1a0a, 0x0200), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
+	/* Corsair K70 RGB */
+	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
 
-- 
2.7.4
