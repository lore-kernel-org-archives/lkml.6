Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1A4ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D60D2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/xe0EZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D60D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeIOSnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 14:43:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44719 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeIOSno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 14:43:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so13030450wro.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=s8qfV0oeL14U7Por9KGmeOtriqoFZdbS3RwTkpKxSoQ=;
        b=W/xe0EZEuVHQatRpKqop1xKt5vQyrtZCTHGAVcdcQu+BGdFkydXUuE/apDKEfwrS3G
         StzJqdlB3WdaL0YXcSqnY5z2mPQF1AjA8a+Yw5Ou4gcFNpdpUogWnxhh88xk42OhUh9O
         QJqaEckh+SWd+kXNOc1xyEPMs1C4QcllzY3rdAtr40/5Fo46jkFo/68evQDu8bgYGg+E
         gA9ItOa92tMGFqGhTTKhkwiqiF5iMwPz6iGmu+8/+MFZIkb1yF9OeE3dIywnYp6sUxl1
         Qmj3BGgF01man7IZcYQzX7mQBjDnqKbeJ+pU28WQ+rW/iSLh0IIUS3A64YHe6tj2SOPp
         SUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=s8qfV0oeL14U7Por9KGmeOtriqoFZdbS3RwTkpKxSoQ=;
        b=muoyeFBcC+tauK5mtUnOR9pe0qnZOuvC4dHmwam/pWI7ft22+BByBWrm1/QnQm0NTm
         jOuMT3Awr3TVgKQhaszTCpCa1I2VjeF7JXLMUOOgI+Uem9bHoeXh4DAVSUwn7GIOaIq0
         BOclpVTw394sSTVmdkf715PhaDOSOx8C20G2LKybCYTPvLoUp8mwZ1jDazzYqrUQWWOK
         gtL9wUKdF5MNqZFN899BNIW/lVAU86crI/i3rwoS5NTA8n4sPkJ2NzBRm3pZ+YGX01zN
         p1G7jwB/qnGJRq31LUDfuooYaS/pUp/i1k7BKPOUjBoxMZ4K5c4bkGFldUocp5HDnDRU
         YmhA==
X-Gm-Message-State: APzg51DrG+omrgSfA14TYW1D+glFAeOK1dK9MtRdsXOoo3LbmJGTGdFA
        nAUe1euAeFupj6IKckxuv0M=
X-Google-Smtp-Source: ANB0VdaNY1tqcbK+MdUrwgsXk+4M+XqBo305lzm0XVhS2EqK8fAfpxTNjfakJu5nOjGGrSlek5WFPA==
X-Received: by 2002:a5d:514d:: with SMTP id u13-v6mr13287176wrt.162.1537017880406;
        Sat, 15 Sep 2018 06:24:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 34-v6sm14518097wra.20.2018.09.15.06.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 06:24:39 -0700 (PDT)
Date:   Sat, 15 Sep 2018 15:24:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20180915132437.GA127735@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 002b87d2aace62b4f3841c3aa43309d2380092be x86/APM: Fix build warning when PROC_FS is not enabled

Misc fixes:

 - EFI crash fix
 - Xen PV fixes
 - do not allow PTI on 2-level 32-bit kernels for now
 - documentation fix

 Thanks,

	Ingo

------------------>
Boris Ostrovsky (1):
      x86/EISA: Don't probe EISA bus for Xen PV guests

Guenter Roeck (1):
      x86/efi: Load fixmap GDT in efi_call_phys_epilog() before setting %cr3

Joerg Roedel (1):
      Revert "x86/mm/legacy: Populate the user page-table with user pgd's"

Juergen Gross (1):
      x86/xen: Disable CPU0 hotplug for Xen PV

Randy Dunlap (2):
      x86/doc: Fix Documentation/x86/earlyprintk.txt
      x86/APM: Fix build warning when PROC_FS is not enabled


 Documentation/x86/earlyprintk.txt     | 25 +++++++++++++++----------
 arch/x86/include/asm/pgtable-2level.h |  9 ---------
 arch/x86/kernel/apm_32.c              |  2 ++
 arch/x86/kernel/eisa.c                | 10 ++++++++--
 arch/x86/kernel/topology.c            |  4 +++-
 arch/x86/platform/efi/efi_32.c        |  3 +--
 security/Kconfig                      |  2 +-
 7 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/Documentation/x86/earlyprintk.txt b/Documentation/x86/earlyprintk.txt
index 688e3eeed21d..46933e06c972 100644
--- a/Documentation/x86/earlyprintk.txt
+++ b/Documentation/x86/earlyprintk.txt
@@ -35,25 +35,25 @@ and two USB cables, connected like this:
 ( If your system does not list a debug port capability then you probably
   won't be able to use the USB debug key. )
 
- b.) You also need a Netchip USB debug cable/key:
+ b.) You also need a NetChip USB debug cable/key:
 
         http://www.plxtech.com/products/NET2000/NET20DC/default.asp
 
-     This is a small blue plastic connector with two USB connections,
+     This is a small blue plastic connector with two USB connections;
      it draws power from its USB connections.
 
  c.) You need a second client/console system with a high speed USB 2.0
      port.
 
- d.) The Netchip device must be plugged directly into the physical
+ d.) The NetChip device must be plugged directly into the physical
      debug port on the "host/target" system.  You cannot use a USB hub in
      between the physical debug port and the "host/target" system.
 
      The EHCI debug controller is bound to a specific physical USB
-     port and the Netchip device will only work as an early printk
+     port and the NetChip device will only work as an early printk
      device in this port.  The EHCI host controllers are electrically
      wired such that the EHCI debug controller is hooked up to the
-     first physical and there is no way to change this via software.
+     first physical port and there is no way to change this via software.
      You can find the physical port through experimentation by trying
      each physical port on the system and rebooting.  Or you can try
      and use lsusb or look at the kernel info messages emitted by the
@@ -65,9 +65,9 @@ and two USB cables, connected like this:
      to the hardware vendor, because there is no reason not to wire
      this port into one of the physically accessible ports.
 
- e.) It is also important to note, that many versions of the Netchip
+ e.) It is also important to note, that many versions of the NetChip
      device require the "client/console" system to be plugged into the
-     right and side of the device (with the product logo facing up and
+     right hand side of the device (with the product logo facing up and
      readable left to right).  The reason being is that the 5 volt
      power supply is taken from only one side of the device and it
      must be the side that does not get rebooted.
@@ -81,13 +81,18 @@ and two USB cables, connected like this:
       CONFIG_EARLY_PRINTK_DBGP=y
 
     And you need to add the boot command line: "earlyprintk=dbgp".
+
     (If you are using Grub, append it to the 'kernel' line in
-     /etc/grub.conf)
+     /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
+     append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
+     using Grub2 on an EFI firmware system, append it to the 'linux'
+     or 'linuxefi' line in /boot/grub2/grub.cfg or
+     /boot/efi/EFI/<distro>/grub.cfg.)
 
     On systems with more than one EHCI debug controller you must
     specify the correct EHCI debug controller number.  The ordering
     comes from the PCI bus enumeration of the EHCI controllers.  The
-    default with no number argument is "0" the first EHCI debug
+    default with no number argument is "0" or the first EHCI debug
     controller.  To use the second EHCI debug controller, you would
     use the command line: "earlyprintk=dbgp1"
 
@@ -111,7 +116,7 @@ and two USB cables, connected like this:
     see the raw output.
 
  c.) On Nvidia Southbridge based systems: the kernel will try to probe
-     and find out which port has debug device connected.
+     and find out which port has a debug device connected.
 
 3. Testing that it works fine:
 
diff --git a/arch/x86/include/asm/pgtable-2level.h b/arch/x86/include/asm/pgtable-2level.h
index 24c6cf5f16b7..60d0f9015317 100644
--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -19,9 +19,6 @@ static inline void native_set_pte(pte_t *ptep , pte_t pte)
 
 static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pmd.pud.p4d.pgd = pti_set_user_pgtbl(&pmdp->pud.p4d.pgd, pmd.pud.p4d.pgd);
-#endif
 	*pmdp = pmd;
 }
 
@@ -61,9 +58,6 @@ static inline pte_t native_ptep_get_and_clear(pte_t *xp)
 #ifdef CONFIG_SMP
 static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pti_set_user_pgtbl(&xp->pud.p4d.pgd, __pgd(0));
-#endif
 	return __pmd(xchg((pmdval_t *)xp, 0));
 }
 #else
@@ -73,9 +67,6 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 #ifdef CONFIG_SMP
 static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pti_set_user_pgtbl(&xp->p4d.pgd, __pgd(0));
-#endif
 	return __pud(xchg((pudval_t *)xp, 0));
 }
 #else
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index ec00d1ff5098..f7151cd03cb0 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1640,6 +1640,7 @@ static int do_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+#ifdef CONFIG_PROC_FS
 static int proc_apm_show(struct seq_file *m, void *v)
 {
 	unsigned short	bx;
@@ -1719,6 +1720,7 @@ static int proc_apm_show(struct seq_file *m, void *v)
 		   units);
 	return 0;
 }
+#endif
 
 static int apm(void *unused)
 {
diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index f260e452e4f8..e8c8c5d78dbd 100644
--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -7,11 +7,17 @@
 #include <linux/eisa.h>
 #include <linux/io.h>
 
+#include <xen/xen.h>
+
 static __init int eisa_bus_probe(void)
 {
-	void __iomem *p = ioremap(0x0FFFD9, 4);
+	void __iomem *p;
+
+	if (xen_pv_domain() && !xen_initial_domain())
+		return 0;
 
-	if (readl(p) == 'E' + ('I'<<8) + ('S'<<16) + ('A'<<24))
+	p = ioremap(0x0FFFD9, 4);
+	if (p && readl(p) == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
 		EISA_bus = 1;
 	iounmap(p);
 	return 0;
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 12cbe2b88c0f..738bf42b0218 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -111,8 +111,10 @@ int arch_register_cpu(int num)
 	/*
 	 * Currently CPU0 is only hotpluggable on Intel platforms. Other
 	 * vendors can add hotplug support later.
+	 * Xen PV guests don't support CPU0 hotplug at all.
 	 */
-	if (c->x86_vendor != X86_VENDOR_INTEL)
+	if (c->x86_vendor != X86_VENDOR_INTEL ||
+	    boot_cpu_has(X86_FEATURE_XENPV))
 		cpu0_hotpluggable = 0;
 
 	/*
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 05ca14222463..9959657127f4 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -85,10 +85,9 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
 {
+	load_fixmap_gdt(0);
 	load_cr3(save_pgd);
 	__flush_tlb_all();
-
-	load_fixmap_gdt(0);
 }
 
 void __init efi_runtime_update_mappings(void)
diff --git a/security/Kconfig b/security/Kconfig
index 27d8b2688f75..d9aa521b5206 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -57,7 +57,7 @@ config SECURITY_NETWORK
 config PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
 	default y
-	depends on X86 && !UML
+	depends on (X86_64 || X86_PAE) && !UML
 	help
 	  This feature reduces the number of hardware side channels by
 	  ensuring that the majority of kernel addresses are not mapped
