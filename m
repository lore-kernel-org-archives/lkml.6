Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xHbKFYFAGVs8YgAAmS7hNA
	; Thu, 07 Jun 2018 14:26:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 38AD3608FD; Thu,  7 Jun 2018 14:26:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CCBFF60912;
	Thu,  7 Jun 2018 14:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCBFF60912
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933601AbeFGO0M (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:26:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40158 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933420AbeFGO0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:26:06 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbj-0005Zq-Bi; Thu, 07 Jun 2018 15:09:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002y0-09; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Bruno =?UTF-8?Q?Pr=C3=A9mont?=" <bonbons@linux-vserver.org>,
        "Ronald =?UTF-8?Q?Tschal=C3=A4r?=" <ronald@innovation.ch>,
        "Petri Hodju" <petrihodju@yahoo.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Andy Ritger" <aritger@nvidia.com>,
        "Wilfried Klaebe" <linux-kernel@lebenslange-mailadresse.de>,
        "Lukas Wunner" <lukas@wunner.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.594249066@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 182/410] Revert "apple-gmux: lock iGP IO to protect
 from vgaarb changes"
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit d6fa7588fd7a8def4c747c0c574ce85d453e3788 upstream.

Commit 4eebd5a4e726 ("apple-gmux: lock iGP IO to protect from vgaarb
changes") amended this driver's ->probe hook to lock decoding of normal
(non-legacy) I/O space accesses to the integrated GPU on dual-GPU
MacBook Pros.  The lock stays in place until the driver is unbound.

The change was made to work around an issue with the out-of-tree nvidia
graphics driver (available at http://www.nvidia.com/object/unix.html).
It contains the following sequence in nvidia/nv.c:

	#if defined(CONFIG_VGA_ARB) && !defined(NVCPU_PPC64LE)
	#if defined(VGA_DEFAULT_DEVICE)
	    vga_tryget(VGA_DEFAULT_DEVICE, VGA_RSRC_LEGACY_MASK);
	#endif
	    vga_set_legacy_decoding(dev, VGA_RSRC_NONE);
	#endif

This code was reported to cause deadlocks with VFIO already in 2013:
https://devtalk.nvidia.com/default/topic/545560

I've reported the issue to Nvidia developers once more in 2017:
https://www.spinics.net/lists/dri-devel/msg138754.html

On the MacBookPro10,1, this code apparently breaks backlight control
(which is handled by apple-gmux via an I/O region starting at 0x700),
as reported by Petri Hodju:
https://bugzilla.kernel.org/show_bug.cgi?id=86121

I tried to replicate Petri's observations on my MacBook9,1, which uses
the same Intel Ivy Bridge + Nvidia GeForce GT 650M architecture, to no
avail.  On my machine apple-gmux' I/O region remains accessible even
with the nvidia driver loaded and commit 4eebd5a4e726 reverted.
Petri reported that apple-gmux becomes accessible again after a
suspend/resume cycle because the BIOS changed the VGA routing on the
root port to the Nvidia GPU.  Perhaps this is a BIOS issue after all
that can be fixed with an update?

In any case, the change made by commit 4eebd5a4e726 has turned out to
cause two new issues:

* Wilfried Klaebe reports a deadlock when launching Xorg because it
  opens /dev/vga_arbiter and calls vga_get(), but apple-gmux is holding
  a lock on I/O space indefinitely.  It looks like apple-gmux' current
  behavior is an abuse of the vgaarb API as locks are not meant to be
  held for longer periods:
  https://bugzilla.kernel.org/show_bug.cgi?id=88861#c11
  https://bugzilla.kernel.org/attachment.cgi?id=217541

* On dual GPU MacBook Pros introduced since 2013, the integrated GPU is
  powergated on boot und thus becomes invisible to Linux unless a custom
  EFI protocol is used to leave it powered on.  (A patch exists but is
  not in mainline yet due to several negative side effects.)  On these
  machines, locking I/O to the integrated GPU (as done by 4eebd5a4e726)
  fails and backlight control is therefore broken:
  https://bugzilla.kernel.org/show_bug.cgi?id=105051

So let's revert commit 4eebd5a4e726 please.  Users experiencing the
issue with the proprietary nvidia driver can comment out the above-
quoted problematic code as a workaround (or try updating the BIOS).

Cc: Petri Hodju <petrihodju@yahoo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bruno Prémont <bonbons@linux-vserver.org>
Cc: Andy Ritger <aritger@nvidia.com>
Cc: Ronald Tschalär <ronald@innovation.ch>
Tested-by: Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/platform/x86/apple-gmux.c | 48 +------------------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -22,7 +22,6 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/vga_switcheroo.h>
-#include <linux/vgaarb.h>
 #include <acpi/video.h>
 #include <asm/io.h>
 
@@ -32,7 +31,6 @@ struct apple_gmux_data {
 	bool indexed;
 	struct mutex index_lock;
 
-	struct pci_dev *pdev;
 	struct backlight_device *bdev;
 
 	/* switcheroo data */
@@ -417,23 +415,6 @@ static int gmux_resume(struct device *de
 	return 0;
 }
 
-static struct pci_dev *gmux_get_io_pdev(void)
-{
-	struct pci_dev *pdev = NULL;
-
-	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev))) {
-		u16 cmd;
-
-		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-		if (!(cmd & PCI_COMMAND_IO))
-			continue;
-
-		return pdev;
-	}
-
-	return NULL;
-}
-
 static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 {
 	struct apple_gmux_data *gmux_data;
@@ -444,7 +425,6 @@ static int gmux_probe(struct pnp_dev *pn
 	int ret = -ENXIO;
 	acpi_status status;
 	unsigned long long gpe;
-	struct pci_dev *pdev = NULL;
 
 	if (apple_gmux_data)
 		return -EBUSY;
@@ -495,7 +475,7 @@ static int gmux_probe(struct pnp_dev *pn
 			ver_minor = (version >> 16) & 0xff;
 			ver_release = (version >> 8) & 0xff;
 		} else {
-			pr_info("gmux device not present or IO disabled\n");
+			pr_info("gmux device not present\n");
 			ret = -ENODEV;
 			goto err_release;
 		}
@@ -503,23 +483,6 @@ static int gmux_probe(struct pnp_dev *pn
 	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major, ver_minor,
 		ver_release, (gmux_data->indexed ? "indexed" : "classic"));
 
-	/*
-	 * Apple systems with gmux are EFI based and normally don't use
-	 * VGA. In addition changing IO+MEM ownership between IGP and dGPU
-	 * disables IO/MEM used for backlight control on some systems.
-	 * Lock IO+MEM to GPU with active IO to prevent switch.
-	 */
-	pdev = gmux_get_io_pdev();
-	if (pdev && vga_tryget(pdev,
-			       VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM)) {
-		pr_err("IO+MEM vgaarb-locking for PCI:%s failed\n",
-			pci_name(pdev));
-		ret = -EBUSY;
-		goto err_release;
-	} else if (pdev)
-		pr_info("locked IO for PCI:%s\n", pci_name(pdev));
-	gmux_data->pdev = pdev;
-
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = gmux_read32(gmux_data, GMUX_PORT_MAX_BRIGHTNESS);
@@ -611,10 +574,6 @@ err_enable_gpe:
 err_notify:
 	backlight_device_unregister(bdev);
 err_release:
-	if (gmux_data->pdev)
-		vga_put(gmux_data->pdev,
-			VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM);
-	pci_dev_put(pdev);
 	release_region(gmux_data->iostart, gmux_data->iolen);
 err_free:
 	kfree(gmux_data);
@@ -634,11 +593,6 @@ static void gmux_remove(struct pnp_dev *
 					   &gmux_notify_handler);
 	}
 
-	if (gmux_data->pdev) {
-		vga_put(gmux_data->pdev,
-			VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM);
-		pci_dev_put(gmux_data->pdev);
-	}
 	backlight_device_unregister(gmux_data->bdev);
 
 	release_region(gmux_data->iostart, gmux_data->iolen);
