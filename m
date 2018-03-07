Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuMqaX1cAFBiXW15rojRaxdeEjxEIkUle9OVKGDpGHZzCUCxssZYznpY1JgvKllOmAG4+Q7
ARC-Seal: i=1; a=rsa-sha256; t=1520451644; cv=none;
        d=google.com; s=arc-20160816;
        b=JhrR0DeJIQcvo/Sk6CysuQ5d9UIAZphNRxTFnsM8iJ4JbDIAEFwlsEfFqWiFZ1lvRS
         0IcAa9LiMN34RsjoWJNd7Nk7Adzz2JHwz1rsotXSlPkjKZ2Zbfn2Ee3ctHJpC6AQC6bT
         uxbLjNXsafLu0lGW3U8JE3wlF1qG6PX8pdVox8gkLLQEWLoqR9OmyUBAiRsJrBpl0Fjr
         W5QF/6rwkenLe9eVfOYhwkMRZZYKT+KsS6o0ThJsKX+Sdjui+/IL/JeAQjLr/0sV8hZf
         9maE3NM53jehLKcDvfnF5VuMPrVtOWnv0oe1gVL5vpNBf+tWu2VnTjOZHLX7pnnQzm67
         BH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oYdQR94sBQi9MPcxackKOakJ+OzvG9S6ymBU+6JLPII=;
        b=eqO/V19wwnsyTrXT2ISHS5XtscNmIE2krc1mnH7qxvPuepms9zNN271GlZ0O06iAQ/
         N+1CAkYcnlpb76zd9OPDbTqZKVfjJJP06PQAYaYK5qKgYxxqz6OSjGUxolPH0Qx4vUWs
         obcHsG/nm+ng8iAU4bh4DIRq2MT+IBBMceIrp0P2ctIXFGaz5rXEg+i696sM3hr3hq+J
         zqJizghdvNrilDc+uwO1oAz+jdngFDEpkqYnPJ8Apwmeck2twkmLstrOKIq1rn9pIbW8
         xsX3TR7gOm644crF5/bGlP74OLXu2TveMpZaEIlx3BmLC3mqh4X5ADNYfm/bMiWpqpxx
         wdJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.15 006/122] Bluetooth: btusb: Use DMI matching for QCA reset_resume quirking
Date: Wed,  7 Mar 2018 11:36:58 -0800
Message-Id: <20180307191730.225023436@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309103997173719?=
X-GMAIL-MSGID: =?utf-8?q?1594309103997173719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 1fdb926974695d3dbc05a429bafa266fdd16510e upstream.

Commit 61f5acea8737 ("Bluetooth: btusb: Restore QCA Rome suspend/resume fix
with a "rewritten" version") applied the USB_QUIRK_RESET_RESUME to all QCA
USB Bluetooth modules. But it turns out that the resume problems are not
caused by the QCA Rome chipset, on most platforms it resumes fine. The
resume problems are actually a platform problem (likely the platform
cutting all power when suspended).

The USB_QUIRK_RESET_RESUME quirk also disables runtime suspend, so by
matching on usb-ids, we're causing all boards with these chips to use extra
power, to fix resume problems which only happen on some boards.

This commit fixes this by applying the quirk based on DMI matching instead
of on usb-ids, so that we match the platform and not the chipset.

Here is the /sys/kernel/debug/usb/devices for the Bluetooth module:

T:  Bus=01 Lev=01 Prnt=01 Port=07 Cnt=04 Dev#=  5 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e300 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Fixes: 61f5acea8737 ("Bluetooth: btusb: Restore QCA Rome suspend/resume..")
Cc: stable@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reported-and-tested-by: Kevin Fenzi <kevin@scrye.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -21,6 +21,7 @@
  *
  */
 
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/usb.h>
 #include <linux/usb/quirks.h>
@@ -376,6 +377,21 @@ static const struct usb_device_id blackl
 	{ }	/* Terminating entry */
 };
 
+/* The Bluetooth USB module build into some devices needs to be reset on resume,
+ * this is a problem with the platform (likely shutting off all power) not with
+ * the module itself. So we use a DMI list to match known broken platforms.
+ */
+static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
+	{
+		/* Lenovo Yoga 920 (QCA Rome device 0cf3:e300) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 920"),
+		},
+	},
+	{}
+};
+
 #define BTUSB_MAX_ISOC_FRAMES	10
 
 #define BTUSB_INTR_RUNNING	0
@@ -3031,6 +3047,9 @@ static int btusb_probe(struct usb_interf
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 
+	if (dmi_check_system(btusb_needs_reset_resume_table))
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
+
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
@@ -3117,12 +3136,6 @@ static int btusb_probe(struct usb_interf
 	if (id->driver_info & BTUSB_QCA_ROME) {
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
-
-		/* QCA Rome devices lose their updated firmware over suspend,
-		 * but the USB hub doesn't notice any status change.
-		 * explicitly request a device reset on resume.
-		 */
-		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
 	}
 
 #ifdef CONFIG_BT_HCIBTUSB_RTL
