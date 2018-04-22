Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/B4UwsOdZyGpzuXCAsUCJKjENC5YorM+WBkEKIUOtXLFipZ4YQKbP3CHxuK36kfmHBVemT
ARC-Seal: i=1; a=rsa-sha256; t=1524405373; cv=none;
        d=google.com; s=arc-20160816;
        b=0p8rM+/y9IemZ+NmajpHnfdgx9uOn/c+EdxObtgqkcjUgcBGLxvEpumQOtrbyG4pDQ
         jiGjuNvTxHqGStqo+OdwMobgTefF3ZTs3NSyI5A13c1PTnrlD/w8yQhGqpNAYx9Tq2wW
         B7XIllVkBt0BFC4DnwdrzhthMfBopEiGK+WUsSkB1EdO0xEoCKgBkOpEypIMQfYVo2Y9
         ED9mi4cUAJ2c8LtCXMBJjmTeFn1k5Vik3ygbA9tJHSVpRDhd47BrCp4BJdFT+T1MuQlX
         9Lz6uf6oiL5X/Nef3dycgKe6dDTXe16Wd07eQH/TIa90sW3iymvm8S+Q+uqmQqc1Fy+L
         5D6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tpAlNLaBqYtjumiYyQDuIF9ClREOJMNFCE3DPy3DpPE=;
        b=xyIKLPCcJk9xENkmAmkoue/nEGVYGep9/KKu82RoH/hYTV29vQRgCjyiKaF9JV4NUP
         lW4YOAjxJYU9Z6eG2Bq2URhv7AF6wvCOpS0dpJ6fwfkBw6EXlwXncB2dKeHeD9O1SpLv
         S2LQK/GmZKorL3uh3KfVVZHf6NU61DXfQ2pHaKAkmcHxxgMNqeFCYM7oGZqpnga7uYFC
         ewzVfsHMMPc/mPSDLzs3Lgk1LPaT8jVuXblqqO+HWJykcDQhxV3P8tJUMFIYHdEigwyL
         iAXgOJQSn2DFGBjwQy0omK9WgCXBFw+35wPxqKia5HGHi3qwiP5V5Pl5dIVhmQLvX+Yc
         kcFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: [PATCH 4.16 041/196] USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw
Date: Sun, 22 Apr 2018 15:51:01 +0200
Message-Id: <20180422135106.201017679@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454888478547425?=
X-GMAIL-MSGID: =?utf-8?q?1598454888478547425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

commit 64627388b50158fd24d6ad88132525b95a5ef573 upstream.

USB3 hubs don't support global suspend.

USB3 specification 10.10, Enhanced SuperSpeed hubs only support selective
suspend and resume, they do not support global suspend/resume where the
hub downstream facing ports states are not affected.

When system enters hibernation it first enters freeze process where only
the root hub enters suspend, usb_port_suspend() is not called for other
devices, and suspend status flags are not set for them. Other devices are
expected to suspend globally. Some external USB3 hubs will suspend the
downstream facing port at global suspend. These devices won't be resumed
at thaw as the suspend status flag is not set.

A USB3 removable hard disk connected through a USB3 hub that won't resume
at thaw will fail to synchronize SCSI cache, return “cmd cmplt err -71”
error, and needs a 60 seconds timeout which causing system hang for 60s
before the USB host reset the port for the USB3 removable hard disk to
recover.

Fix this by always calling usb_port_suspend() during freeze for USB3
devices.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/generic.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -210,8 +210,13 @@ static int generic_suspend(struct usb_de
 	if (!udev->parent)
 		rc = hcd_bus_suspend(udev, msg);
 
-	/* Non-root devices don't need to do anything for FREEZE or PRETHAW */
-	else if (msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_PRETHAW)
+	/*
+	 * Non-root USB2 devices don't need to do anything for FREEZE
+	 * or PRETHAW. USB3 devices don't support global suspend and
+	 * needs to be selectively suspended.
+	 */
+	else if ((msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_PRETHAW)
+		 && (udev->speed < USB_SPEED_SUPER))
 		rc = 0;
 	else
 		rc = usb_port_suspend(udev, msg);
