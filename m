Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Xuae7I7CKIxU4Q1nGrpjZJ4gyh4mA90rdhf/1qxGbtQzOSlmF6frIWn6deYZE8dbY5/uj
ARC-Seal: i=1; a=rsa-sha256; t=1519218669; cv=none;
        d=google.com; s=arc-20160816;
        b=pD440soyE2iqkOQzvoF5vLYrb7es59vLCchlSchkEYyJoswuPlbIvrE4lsykov1CjO
         Dexv18LfOzBNQavNdJ3I6GBqp5FLBF8BDEz7nP6u1Qrw/N1ColXc3njaFlS3PyGe9mxj
         /sxERlbPu0kJZ+B+/s9F6npTL3hF7wBEuxSOmO9tILOXtPxx498lh+5OELlDgGvhBSBU
         I9WMm9QI2AnaCS8pBzslgH1DH0g8WNbjD3P5suLyi77dsBxHHvgZ6G5p42YImPQ/FEaH
         sovNVxa4HByQxyW2X0vC/sRJs7B2I3oCjXQNO24FZRWKSFx5mDUjIEJ5lIO20POG67mw
         CT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gDPUqoF1Pi+WIx1HdEbY6mpqLqoSmnUiejGIF75+4rk=;
        b=KARIh9xz+TneX413L1W8/AEk+q5uvMTJiELK9WlTNGCco5la+0dApPud9hQsG3CjsN
         1F3wJMAKltulZlY4zOEuMq4lM4R+I7/vkhXMfsGSY3ebxYa96bo0DVRjLsb4ypIWJzNT
         BPJyfQCs/iUAiM5rQ/ywWcTnhFYpLzy7pvzpXMGwh5McfDvQ8vKy7kIZgQQyF4XDvD0V
         QZN5Hve41aeDUFDUbLFP6q8rz95FhnVHu8u2gjBhCyAF2C984moTMpdoBsnmS84TfBkp
         cUHd3oE/YhXGCM+JePNWowKcnU5WFiYh9L6tyTwoh3vqVZcoOTsSx3nHI/1PeTLJhjZx
         IBqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Petri Hodju <petrihodju@yahoo.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Andy Ritger <aritger@nvidia.com>,
	=?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
	Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>,
	Lukas Wunner <lukas@wunner.de>,
	"Darren Hart (VMware)" <dvhart@infradead.org>
Subject: [PATCH 4.15 105/163] Revert "apple-gmux: lock iGP IO to protect from vgaarb changes"
Date: Wed, 21 Feb 2018 13:48:54 +0100
Message-Id: <20180221124536.068297885@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015691967203234?=
X-GMAIL-MSGID: =?utf-8?q?1593016235800462250?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/apple-gmux.c |   48 --------------------------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -24,7 +24,6 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/vga_switcheroo.h>
-#include <linux/vgaarb.h>
 #include <acpi/video.h>
 #include <asm/io.h>
 
@@ -54,7 +53,6 @@ struct apple_gmux_data {
 	bool indexed;
 	struct mutex index_lock;
 
-	struct pci_dev *pdev;
 	struct backlight_device *bdev;
 
 	/* switcheroo data */
@@ -599,23 +597,6 @@ static int gmux_resume(struct device *de
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
 static int is_thunderbolt(struct device *dev, void *data)
 {
 	return to_pci_dev(dev)->is_thunderbolt;
@@ -631,7 +612,6 @@ static int gmux_probe(struct pnp_dev *pn
 	int ret = -ENXIO;
 	acpi_status status;
 	unsigned long long gpe;
-	struct pci_dev *pdev = NULL;
 
 	if (apple_gmux_data)
 		return -EBUSY;
@@ -682,7 +662,7 @@ static int gmux_probe(struct pnp_dev *pn
 			ver_minor = (version >> 16) & 0xff;
 			ver_release = (version >> 8) & 0xff;
 		} else {
-			pr_info("gmux device not present or IO disabled\n");
+			pr_info("gmux device not present\n");
 			ret = -ENODEV;
 			goto err_release;
 		}
@@ -690,23 +670,6 @@ static int gmux_probe(struct pnp_dev *pn
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
@@ -822,10 +785,6 @@ err_enable_gpe:
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
@@ -845,11 +804,6 @@ static void gmux_remove(struct pnp_dev *
 					   &gmux_notify_handler);
 	}
 
-	if (gmux_data->pdev) {
-		vga_put(gmux_data->pdev,
-			VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM);
-		pci_dev_put(gmux_data->pdev);
-	}
 	backlight_device_unregister(gmux_data->bdev);
 
 	release_region(gmux_data->iostart, gmux_data->iolen);
