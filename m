Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933160AbeCOQCl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:02:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:57248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932979AbeCOQCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:02:39 -0400
From: Takashi Iwai <tiwai@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Ivan Levshin <ivan.levshin@microfocus.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluebooth: btusb: Fix quirk for Atheros 1525/QCA6174
Date: Thu, 15 Mar 2018 17:02:34 +0100
Message-Id: <20180315160234.21789-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.2
Patch-mainline: Submitted, linux-bluetooth ML
References: bsc#1082504
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Atheros 1525/QCA6174 BT doesn't seem working properly on the
recent kernels, as it tries to load a wrong firmware
ar3k/AthrBT_0x00000200.dfu and it fails.

This seems to have been a problem for some time, and the known
workaround is to apply BTUSB_QCA_ROM quirk instead of BTUSB_ATH3012.

The device in question is:

T: Bus=01 Lev=01 Prnt=01 Port=09 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P: Vendor=0cf3 ProdID=3004 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E: Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E: Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1082504
Reported-and-tested-by: Ivan Levshin <ivan.levshin@microfocus.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>

---
 drivers/bluetooth/btusb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -231,7 +231,6 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
@@ -264,6 +263,7 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
 	/* QCA ROME chipset */
+	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe009), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe010), .driver_info = BTUSB_QCA_ROME },
