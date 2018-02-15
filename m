Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225fEaaceU5cbNw/zmAQnMyrwks08EWLUQDmtgKybHTwfbbQlGH5kxhoXPzCoEiuJBbrE7rL
ARC-Seal: i=1; a=rsa-sha256; t=1518708511; cv=none;
        d=google.com; s=arc-20160816;
        b=RuLSQpHR4GcZugDZEz1oIw8hhkZ0AyN9qpxZmuBB/2pT8ld28PrnpQlhT9iVFuL4na
         W+cC6CD7WrYWczHO9mEGUydoKmoqd/4VhB31dxyehJu7BoQbmAGma2yrN2wkp/oXA3lk
         rcHVEET9aW4fmaER3QaTNUEguIvcZWj6xdSrD0ecI99sRfJsq2g3KWwzNkpyQ2OC1BLe
         nYMXSUldykaHRt/XZ3T8DlfBl45CGZNU/+tiFqoqt6KJ4K9svgpxaLQCAGJ0q9VMutD5
         yvcmFvKUoQszgJa/gC7le9Vy53R0j8AZ2hI2fUupjxyrHwmP1RBon6tLqOHZstCWer+I
         zYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LOZCkKNexxJEGlQ+oRoX9+mY1j/oOtegxjB8DY2Bisk=;
        b=YAZ7wS7ANT12rBHxSoRoEF2HlhzHHbqm/Xz0b1NCQtRtzBUEzPs4+Cs/WxOEDgd2SM
         9ZNX8tW9hnR6HmLXYHZ99rTlhwBEesOwzhx4hntQS+6Rj0VJxpDwYrT1AAUhXolP9/L8
         KzKm1eEvQ1s0SBVZFfncm0Vq24wjduhUzLhc+6QJrT8PKt2yQT5QkYLJ5hh1TTxVC8zW
         bxBaWUF/lkyMVfWVVGbS+8iKxk0C3hhwRqAIPIq6xr2htK46qki1p4Nx57sst/8/gW6C
         ucR/QQbjrYMHH1iofbcNJC+5iFHcZdwL7iqJPpZP07Boac/RbzK4D0/aajPr1opViHNA
         8Zhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Leif Liddy <leif.linux@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Daniel Drake <drake@endlessm.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.9 69/88] Bluetooth: btusb: Restore QCA Rome suspend/resume fix with a "rewritten" version
Date: Thu, 15 Feb 2018 16:17:36 +0100
Message-Id: <20180215151232.076118027@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481108912063395?=
X-GMAIL-MSGID: =?utf-8?q?1592481295813577401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 61f5acea8737d9b717fcc22bb6679924f3c82b98 upstream.

Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.

This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
has several issues (see the original commit message). An added advantage
of moving over to the USB-core reset-resume handling is that it also
disables autosuspend for these devices, which is similarly broken on these.

But there are 2 issues with this approach:
1) It leaves the broken DIY BTUSB_RESET_RESUME code in place for Realtek
   devices.
2) Sofar only 2 of the 10 QCA devices known to the btusb code have been
   added to usb/core/quirks.c and if we fix the Realtek case the same way
   we need to add an additional 14 entries. So in essence we need to
   duplicate a large part of the usb_device_id table in btusb.c in
   usb/core/quirks.c and manually keep them in sync.

This commit instead restores setting a reset-resume quirk for QCA devices
in the btusb.c code, avoiding the duplicate usb_device_id table problem.

This commit avoids the problems with the original DIY BTUSB_RESET_RESUME
code by simply setting the USB_QUIRK_RESET_RESUME quirk directly on the
usb_device.

This commit also moves the BTUSB_REALTEK case over to directly setting the
USB_QUIRK_RESET_RESUME on the usb_device and removes the now unused
BTUSB_RESET_RESUME code.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Fixes: 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
Cc: Leif Liddy <leif.linux@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -23,6 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/usb/quirks.h>
 #include <linux/firmware.h>
 #include <asm/unaligned.h>
 
@@ -369,8 +370,8 @@ static const struct usb_device_id blackl
 #define BTUSB_FIRMWARE_LOADED	7
 #define BTUSB_FIRMWARE_FAILED	8
 #define BTUSB_BOOTING		9
-#define BTUSB_RESET_RESUME	10
-#define BTUSB_DIAG_RUNNING	11
+#define BTUSB_DIAG_RUNNING	10
+#define BTUSB_OOB_WAKE_ENABLED	11
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -2925,6 +2926,12 @@ static int btusb_probe(struct usb_interf
 	if (id->driver_info & BTUSB_QCA_ROME) {
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+
+		/* QCA Rome devices lose their updated firmware over suspend,
+		 * but the USB hub doesn't notice any status change.
+		 * explicitly request a device reset on resume.
+		 */
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
 	}
 
 #ifdef CONFIG_BT_HCIBTUSB_RTL
@@ -2935,7 +2942,7 @@ static int btusb_probe(struct usb_interf
 		 * but the USB hub doesn't notice any status change.
 		 * Explicitly request a device reset on resume.
 		 */
-		set_bit(BTUSB_RESET_RESUME, &data->flags);
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
 	}
 #endif
 
@@ -3092,14 +3099,6 @@ static int btusb_suspend(struct usb_inte
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
 
-	/* Optionally request a device reset on resume, but only when
-	 * wakeups are disabled. If wakeups are enabled we assume the
-	 * device will stay powered up throughout suspend.
-	 */
-	if (test_bit(BTUSB_RESET_RESUME, &data->flags) &&
-	    !device_may_wakeup(&data->udev->dev))
-		data->udev->reset_resume = 1;
-
 	return 0;
 }
 
