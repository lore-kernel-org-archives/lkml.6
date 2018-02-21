Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224dXzp2TEO0bZM2+ftpsa2gMDa3WyxEnh3Fo1+7Ihs7YFxSpm9LMqI2wLfIQI/81vIZrgAy
ARC-Seal: i=1; a=rsa-sha256; t=1519218151; cv=none;
        d=google.com; s=arc-20160816;
        b=o7I5AwhGOKcuK646+cecSJikyYd1CtKeDsvVXVM+MWWsV5IuJq/IWhJlrIQ2Pdz6Vd
         eQhtoWU1hqJv2+ipkBpgVAIZze1wbY5pH2GLWlXzueTEs7AjY0sjDxNJRPKqSDyoPPh7
         FIuwT7LW7Qtv09Ri41yIpEaxs/zXyakMAU6PO6MpUpJeIg24fdBdN3+RxJCHsrW9Hm7D
         4SqPzMKpTNezoaGXV5v72w4a1fGzdHpl7L4TNQ05g7ivLwkZ7adW6hUxO7Zt5alEpUHx
         KE/YBmGUcgjqByhlbU7mcDRDQEGDdifuAV/tsQzritQkcq+u0ezNsibqUjVr1AIkWggX
         EH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kiXUPhMIidnYg2NkcZrAzbJUXpNqY9l7C1bPaBZouAo=;
        b=TsWxgLP1SCdsv2lnD12Tnmc4oWfo0Ebz0k51DieQY8MYZmlHEVIJ9QUJ4vFvQL9bHG
         JuvRtbM6Z3QjVhOEQ1/zViae/Tr37VMzgm2E7Zpmm+5w2EXeVeD6vThEJz2xz9wISOMQ
         tmDxYv+EGPJzzwi1Z9C2/h5k+RKs1Q1XXw/UNoSDmYgL0cbd7v7ng7WhqlDaBl1LjkWa
         z8wPOT8YDEie3m5ghYtHrFUf3HIIDJmqrYitL3LuIM7QQwLsk9lVqNHbqbIeS3xO2IKz
         6i4I4Rwg5+izfSf5DjciFpTk8AdetXg63Ljd/Wk72W+JkGZv3cXX2fKaECVC43UjdKfx
         Sk8A==
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
Subject: [PATCH 4.14 104/167] Revert "apple-gmux: lock iGP IO to protect from vgaarb changes"
Date: Wed, 21 Feb 2018 13:48:35 +0100
Message-Id: <20180221124530.053661678@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015691967203234?=
X-GMAIL-MSGID: =?utf-8?q?1593015691967203234?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
