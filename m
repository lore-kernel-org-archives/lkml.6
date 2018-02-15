Return-Path: <jackstocker.93@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518719094; cv=none;
        d=google.com; s=arc-20160816;
        b=FhwJIgnlQsXQEuaXGIiASDNyOfWMozGZpjjRCoJoewdGuxqci06cmwD9QscoXmUszx
         arUsCIv5yMEYhwH8K1q/1qaeqZKVdwCTk6Tvv6MMVm8OFP/yDq3DPo7wAyHxU7SQ/1eY
         MuFM1wlTTpTda1o1u/0Bf7mxeyN3sIdNhW6+GMJDNwKRhs/uJopvUzznWtg7PfN8s3X1
         GoOUSfyeu9tM4MzBr31acCS94QzTKLe/aAILJrZTzT5YkJyoE6REoPe7l3VglhtAh3mC
         Jj5rtZ2RCz4cJoXAIW6Q0EAKqnh9Nlueo5JWQvCB9ZnUYnPXCPfabXAd3vhRM2aZkWKK
         CTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=73HW0Ru0uZGi8LVWkZ+oPJ7Zse8MiL9W/Uz/a7phH/0=;
        b=hQff4qpgwtadrl0WSiJq6ZbTsbc3AM8IsAGmLEdbnzJjq0sr5fS7uCSnrpfTVkHUaG
         B9y16UH9Mk/AEmURHsYtO7/8H8WNhdofPJHHtujNYnDByCKI/2rDliXUzVg+ZJDftgyX
         s3glLun8AOETDEfPRdPy28jg+4sX/ImEoZu3gCusWgSLdsgdEcSLBGzG1r1V97DHfOrP
         /aDLHoLc6pbgnEcsS9jEAlUF2Tlci749A3stHNy/GZisjZplILfM85OhOfqM+jJmtAcl
         G417ZM8eFlyutcSTxP7YylX4La5lcQ9LzQFoYYJUaR9+ie71qe/lbujJj9EUN0o1Nnml
         r/qg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J/ukLLCU;
       spf=pass (google.com: domain of jackstocker.93@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jackstocker.93@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J/ukLLCU;
       spf=pass (google.com: domain of jackstocker.93@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jackstocker.93@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224X9lm5+rNk7B0ft6MjyTteSS0ox+NwhfxjonDacOcbDg2CWYWwVcrJdXmGyW5upJPkoeD9dQ==
From: Jack Stocker <jackstocker.93@gmail.com>
To: 
Cc: Jack Stocker <jackstocker.93@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Seth Forshee <seth.forshee@canonical.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Dmitry Fleytman <dmitry@daynix.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Devin Heitmueller <dheitmueller@kernellabs.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] Add delay-init quirk for Corsair K70 RGB keyboards
Date: Thu, 15 Feb 2018 18:24:10 +0000
Message-Id: <1518719051-9644-1-git-send-email-jackstocker.93@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180215180205.GA15170@kroah.com>
References: <20180215180205.GA15170@kroah.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591305042869034715?=
X-GMAIL-MSGID: =?utf-8?q?1592492392678744776?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
Corsair K70 RGB keyboards also require the DELAY_INIT quirk to
start correctly at boot.

Device ids found here:
usb 3-3: New USB device found, idVendor=1b1c, idProduct=1b13
usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-3: Product: Corsair K70 RGB Gaming Keyboard

Signed-off-by: Jack Stocker <jackstocker.93@gmail.com>
Cc: stable <stable@vger.kernel.org>
---
Changes in v4:
  - Corrected 'real' name.
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
