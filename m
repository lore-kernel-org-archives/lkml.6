Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2270g33qHMBQlcugR5JThnPYD/rYzsV6vYhnlqE5y9vW1maaGvMVKbfF2sG4X8BxA5kKOlAs
ARC-Seal: i=1; a=rsa-sha256; t=1518709061; cv=none;
        d=google.com; s=arc-20160816;
        b=jSgAefszuj2Qkzh85wDONzgyYZy5LRaClEKLDotR76lqXWyItu33GapOk5xQQ/4A9O
         Acb0vEye+ejgUY0jVugzMGGg2H8GF8rBeZPHFtV7s+dl5V3Vyil8J54QqitcTWsLEcOq
         marfRzx1UhARk/jg3CqCnUQVTpWmjCsYipGx0xZRvagEb0GyQiIXsC3zBRTel0PCMqMY
         koGxPgSitC4YCEcTX+Daj/AaYfSfxLX9jmqAsAR07tXpjEF72gNEl/wqZdwHy3hjoCnv
         0TNSO1AaWU+5qqTcXxqrpjgE5OWVwurLXuISn8h51Y4CWbiZJCGJlfqriH2zyDKtza2D
         c1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1ptg6pru9X0Sv0H2fKdbznw5b6RJf+3tMKzQzxVonPA=;
        b=hZCB+ANFKQxXQLC3qbc+duTZqWjIRsq1qMCRy100IGBddi2/QSM9JxI+SGB7AJlJGY
         pMdwJQTxYmQDkkDeAFucOgu7Vk8KWqjUqTlIxnKEb8Ybquh1GtbGTmhAAxyxx6WBGrkF
         A3JErnozC3TbGeP0etoNxB2cNVwYTMJeEwpGsXnb+7Yy8IErLBlgl7zgU/TvRBj05ifk
         85rjxJVDnJRCPEz3pf0T8YM1MsQatMLU9a3GWnlORX9Usz+dLCVe7cRkC6sngMg2pisG
         if7jkYCrBo/jOctoAvKEWlExCSsO/bvAN4mjKw/aut9lhLwBzbEvKZymHyvPkMPQs37D
         Zpng==
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
Subject: [PATCH 4.14 160/195] Bluetooth: btusb: Restore QCA Rome suspend/resume fix with a "rewritten" version
Date: Thu, 15 Feb 2018 16:17:31 +0100
Message-Id: <20180215151713.945507305@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481108912063395?=
X-GMAIL-MSGID: =?utf-8?q?1592481872832432897?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/bluetooth/btusb.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -23,6 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/usb/quirks.h>
 #include <linux/firmware.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -392,9 +393,8 @@ static const struct usb_device_id blackl
 #define BTUSB_FIRMWARE_LOADED	7
 #define BTUSB_FIRMWARE_FAILED	8
 #define BTUSB_BOOTING		9
-#define BTUSB_RESET_RESUME	10
-#define BTUSB_DIAG_RUNNING	11
-#define BTUSB_OOB_WAKE_ENABLED	12
+#define BTUSB_DIAG_RUNNING	10
+#define BTUSB_OOB_WAKE_ENABLED	11
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -3099,6 +3099,12 @@ static int btusb_probe(struct usb_interf
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
@@ -3109,7 +3115,7 @@ static int btusb_probe(struct usb_interf
 		 * but the USB hub doesn't notice any status change.
 		 * Explicitly request a device reset on resume.
 		 */
-		set_bit(BTUSB_RESET_RESUME, &data->flags);
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
 	}
 #endif
 
@@ -3274,14 +3280,6 @@ static int btusb_suspend(struct usb_inte
 		enable_irq(data->oob_wake_irq);
 	}
 
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
 
