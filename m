Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224zgYzapkdb+IcXB1GNVOhzFdE/vBVqBlKRotoly8hfw3gSZcxk08qOLCwCRlkyIOPphJ5f
ARC-Seal: i=1; a=rsa-sha256; t=1518709132; cv=none;
        d=google.com; s=arc-20160816;
        b=NgQc+mWn8leFq24OA7bb7d+G0NBWTydJwJq/xdxRlk1oG1zv2Mcqi76CHGCwjFwyQR
         6FLIXsy1iOmTGlVJBLjuVKWAmkEbiggxg7GmloEBUFV9pR9JxAYs7Y+yt+QP0r8fUh95
         TS26sLRzFBItROaekFZLJNZefww87YDv/DKcVZZ5eCTRzGPl2b3Vbm+2oR3vKRSejxem
         ribn/6AeWXDSsLIng8aWNdTQ1rvsyyDkvOz4XEWKNLTZWBROsjeNfTC6kCKCZJvVSuH+
         Q2RcKweW10rqTc7EqMrgGkJKp67+EiIfMHElO/GUSQPt5HFz4alzc4RhzSH3fWG81T4E
         zD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rVz2DvaABwaJx+xz3EwrimKfk4j0e/1QWEZye6ZXfmE=;
        b=DfuePngzg+JvZMyTFjbA/0Ne2YBjIyvsazPc6TtuEUiCL7MGlcyQmFuzn/QBCQn2sm
         CTh0jrXpvrMBqYRtwyvfiqkM27Mz3smg4v2n2DvmDYqUqpp1AMyPRzgtikMOi+Ak5vZb
         nM+TUdPuOeC6LQAAkuFyrU5fy+4+eGX8oKFWQsl97tGLgc5WKFsHFGVu99Ykc40wyjBH
         NDQpiQ8MMV0eBTRXVdW3I0tzxTdW1QOdg9icTGL9GurvjI1RMpqJ2hLiJpb+JpknwtNS
         2UxOILuAvO0qMhxsphfIK0SxrTh7cszcZ184Kr1mVsZe/UqjSyeTFGUGc767us7Ac39m
         PAjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.14 158/195] Bluetooth: btsdio: Do not bind to non-removable BCM43341
Date: Thu, 15 Feb 2018 16:17:29 +0100
Message-Id: <20180215151713.831864646@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481102414655693?=
X-GMAIL-MSGID: =?utf-8?q?1592481946708865352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit b4cdaba274247c9c841c6a682c08fa91fb3aa549 upstream.

BCM43341 devices soldered onto the PCB (non-removable) always (AFAICT)
use an UART connection for bluetooth. But they also advertise btsdio
support on their 3th sdio function, this causes 2 problems:

1) A non functioning BT HCI getting registered

2) Since the btsdio driver does not have suspend/resume callbacks,
mmc_sdio_pre_suspend will return -ENOSYS, causing mmc_pm_notify()
to react as if the SDIO-card is removed and since the slot is
marked as non-removable it will never get detected as inserted again.
Which results in wifi no longer working after a suspend/resume.

This commit fixes both by making btsdio ignore BCM43341 devices
when connected to a slot which is marked non-removable.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btsdio.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -31,6 +31,7 @@
 #include <linux/errno.h>
 #include <linux/skbuff.h>
 
+#include <linux/mmc/host.h>
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/sdio_func.h>
 
@@ -292,6 +293,14 @@ static int btsdio_probe(struct sdio_func
 		tuple = tuple->next;
 	}
 
+	/* BCM43341 devices soldered onto the PCB (non-removable) use an
+	 * uart connection for bluetooth, ignore the BT SDIO interface.
+	 */
+	if (func->vendor == SDIO_VENDOR_ID_BROADCOM &&
+	    func->device == SDIO_DEVICE_ID_BROADCOM_43341 &&
+	    !mmc_card_is_removable(func->card->host))
+		return -ENODEV;
+
 	data = devm_kzalloc(&func->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
