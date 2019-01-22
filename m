Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D973C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A73720855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfAVPMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:12:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:58386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728795AbfAVPMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:12:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18A64B04D;
        Tue, 22 Jan 2019 15:12:04 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     thomas@winischhofer.net
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/4] tty: sisusb_con, cleanup configs
Date:   Tue, 22 Jan 2019 16:12:00 +0100
Message-Id: <20190122151202.18152-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122151202.18152-1-jslaby@suse.cz>
References: <20190122151202.18152-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two macros defined:
1) ifdef CONFIG_COMPAT => define SISUSB_NEW_CONFIG_COMPAT
2) ifdef CONFIG_USB_SISUSBVGA_CON => define INCL_SISUSB_CON

Remove the latter and make use only of the former. This removes one
layer of obfuscation.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/usb/misc/sisusbvga/sisusb.c      | 32 ++++++++++++------------
 drivers/usb/misc/sisusbvga/sisusb.h      | 15 +----------
 drivers/usb/misc/sisusbvga/sisusb_con.c  |  2 +-
 drivers/usb/misc/sisusbvga/sisusb_init.c |  4 +--
 4 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusb.c
index 3198d0477cf8..9560fde621ee 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -53,7 +53,7 @@
 #include "sisusb.h"
 #include "sisusb_init.h"
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 #include <linux/font.h>
 #endif
 
@@ -61,7 +61,7 @@
 
 /* Forward declarations / clean-up routines */
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 static int sisusb_first_vc;
 static int sisusb_last_vc;
 module_param_named(first, sisusb_first_vc, int, 0);
@@ -1198,7 +1198,7 @@ static int sisusb_read_mem_bulk(struct sisusb_usb_data *sisusb, u32 addr,
 
 /* High level: Gfx (indexed) register access */
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 int sisusb_setreg(struct sisusb_usb_data *sisusb, int port, u8 data)
 {
 	return sisusb_write_memio_byte(sisusb, SISUSB_TYPE_IO, port, data);
@@ -1272,7 +1272,7 @@ int sisusb_setidxregand(struct sisusb_usb_data *sisusb, int port,
 
 /* Write/read video ram */
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 int sisusb_writeb(struct sisusb_usb_data *sisusb, u32 adr, u8 data)
 {
 	return sisusb_write_memio_byte(sisusb, SISUSB_TYPE_MEM, adr, data);
@@ -2255,7 +2255,7 @@ static int sisusb_init_gfxdevice(struct sisusb_usb_data *sisusb, int initscreen)
 }
 
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 
 /* Set up default text mode:
  * - Set text mode (0x03)
@@ -2448,7 +2448,7 @@ void sisusb_delete(struct kref *kref)
 	sisusb->sisusb_dev = NULL;
 	sisusb_free_buffers(sisusb);
 	sisusb_free_urbs(sisusb);
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 	kfree(sisusb->SiS_Pr);
 #endif
 	kfree(sisusb);
@@ -2844,7 +2844,7 @@ static int sisusb_handle_command(struct sisusb_usb_data *sisusb,
 
 	case SUCMD_HANDLETEXTMODE:
 		retval = 0;
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 		/* Gfx core must be initialized, SiS_Pr must exist */
 		if (!sisusb->gfxinit || !sisusb->SiS_Pr)
 			return -ENODEV;
@@ -2860,7 +2860,7 @@ static int sisusb_handle_command(struct sisusb_usb_data *sisusb,
 #endif
 		break;
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 	case SUCMD_SETMODE:
 		/* Gfx core must be initialized, SiS_Pr must exist */
 		if (!sisusb->gfxinit || !sisusb->SiS_Pr)
@@ -2944,7 +2944,7 @@ static long sisusb_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		x.sisusb_vramsize = sisusb->vramsize;
 		x.sisusb_minor = sisusb->minor;
 		x.sisusb_fbdevactive = 0;
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 		x.sisusb_conactive  = sisusb->haveconsole ? 1 : 0;
 #else
 		x.sisusb_conactive  = 0;
@@ -2975,7 +2975,7 @@ static long sisusb_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return retval;
 }
 
-#ifdef SISUSB_NEW_CONFIG_COMPAT
+#ifdef CONFIG_COMPAT
 static long sisusb_compat_ioctl(struct file *f, unsigned int cmd,
 		unsigned long arg)
 {
@@ -2998,7 +2998,7 @@ static const struct file_operations usb_sisusb_fops = {
 	.read =		sisusb_read,
 	.write =	sisusb_write,
 	.llseek =	sisusb_lseek,
-#ifdef SISUSB_NEW_CONFIG_COMPAT
+#ifdef CONFIG_COMPAT
 	.compat_ioctl = sisusb_compat_ioctl,
 #endif
 	.unlocked_ioctl = sisusb_ioctl
@@ -3091,7 +3091,7 @@ static int sisusb_probe(struct usb_interface *intf,
 	dev_info(&sisusb->sisusb_dev->dev, "Allocated %d output buffers\n",
 			sisusb->numobufs);
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 	/* Allocate our SiS_Pr */
 	sisusb->SiS_Pr = kmalloc(sizeof(struct SiS_Private), GFP_KERNEL);
 	if (!sisusb->SiS_Pr) {
@@ -3112,7 +3112,7 @@ static int sisusb_probe(struct usb_interface *intf,
 
 	if (dev->speed == USB_SPEED_HIGH || dev->speed >= USB_SPEED_SUPER) {
 		int initscreen = 1;
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 		if (sisusb_first_vc > 0 && sisusb_last_vc > 0 &&
 				sisusb_first_vc <= sisusb_last_vc &&
 				sisusb_last_vc <= MAX_NR_CONSOLES)
@@ -3134,7 +3134,7 @@ static int sisusb_probe(struct usb_interface *intf,
 	dev_dbg(&sisusb->sisusb_dev->dev, "*** RWTEST END ***\n");
 #endif
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 	sisusb_console_init(sisusb, sisusb_first_vc, sisusb_last_vc);
 #endif
 
@@ -3160,7 +3160,7 @@ static void sisusb_disconnect(struct usb_interface *intf)
 	if (!sisusb)
 		return;
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 	sisusb_console_exit(sisusb);
 #endif
 
@@ -3210,7 +3210,7 @@ static struct usb_driver sisusb_driver = {
 static int __init usb_sisusb_init(void)
 {
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 	sisusb_init_concode();
 #endif
 
diff --git a/drivers/usb/misc/sisusbvga/sisusb.h b/drivers/usb/misc/sisusbvga/sisusb.h
index 20f03ad0ea16..8a5e6bb07d05 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.h
+++ b/drivers/usb/misc/sisusbvga/sisusb.h
@@ -38,17 +38,8 @@
 #ifndef _SISUSB_H_
 #define _SISUSB_H_
 
-#ifdef CONFIG_COMPAT
-#define SISUSB_NEW_CONFIG_COMPAT
-#endif
-
 #include <linux/mutex.h>
 
-/* For older kernels, support for text consoles is by default
- * off. To enable text console support, change the following:
- */
-/* #define CONFIG_USB_SISUSBVGA_CON */
-
 /* Version Information */
 
 #define SISUSB_VERSION		0
@@ -57,10 +48,6 @@
 
 /* Include console and mode switching code? */
 
-#ifdef CONFIG_USB_SISUSBVGA_CON
-#define INCL_SISUSB_CON		1
-#endif
-
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include "sisusb_struct.h"
@@ -139,7 +126,7 @@ struct sisusb_usb_data {
 	unsigned char gfxinit;	/* graphics core initialized? */
 	unsigned short chipid, chipvendor;
 	unsigned short chiprevision;
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 	struct SiS_Private *SiS_Pr;
 	unsigned long scrbuf;
 	unsigned int scrbuf_size;
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 28faf566b8fb..10c15723a7c5 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -70,7 +70,7 @@
 #include "sisusb.h"
 #include "sisusb_init.h"
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 
 #define sisusbcon_writew(val, addr)	(*(addr) = (val))
 #define sisusbcon_readw(addr)		(*(addr))
diff --git a/drivers/usb/misc/sisusbvga/sisusb_init.c b/drivers/usb/misc/sisusbvga/sisusb_init.c
index 6a30e8bd9221..0f7170f5b53f 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_init.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_init.c
@@ -45,7 +45,7 @@
 
 #include "sisusb.h"
 
-#ifdef INCL_SISUSB_CON
+#ifdef CONFIG_USB_SISUSBVGA_CON
 
 #include "sisusb_init.h"
 
@@ -956,4 +956,4 @@ int SiSUSBSetVESAMode(struct SiS_Private *SiS_Pr, unsigned short VModeNo)
 	return SiSUSBSetMode(SiS_Pr, ModeNo);
 }
 
-#endif /* INCL_SISUSB_CON */
+#endif /* CONFIG_USB_SISUSBVGA_CON */
-- 
2.20.1

