Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C45C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CEE21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548167793;
	bh=Fb1x9wfMhSsTmNRXzH9wpwEitgzAtF2Wt1sN/RgWX8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aqnZb85LkgU+JuJ2MCcnjZOfRoTiK+dazSZ7rjt+t5PBolak7+tFczUGfxP5lCzan
	 mntMoOv6/7Q9/YUYQDJbdGZvyoZgS9U9/x4LuRLevXtMOueaeNZFfZF404xSqRsGrg
	 9d8VCiU6xNhh5++MSqueS+tP0hhEhyGbjjFyMTPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfAVOgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:36:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbfAVOga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:36:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36168217D8;
        Tue, 22 Jan 2019 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548167788;
        bh=Fb1x9wfMhSsTmNRXzH9wpwEitgzAtF2Wt1sN/RgWX8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEryUQ5UMPVs5iBF9v/W0UHi+whSwMiaMPCQ3NTWgZmOFrN0qGULjDamJC3OxIP+7
         dyyod4Ietjx12X033pMFfZZIQtbY8zon21rZqtpEWjAaBrVAm89GlgckN0Z/o93acP
         oWsMLdDvnEs6LqMuAb9lbO1Ps9ghm8U5yw95bMLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 5/6] x86: platform: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:35:41 +0100
Message-Id: <20190122143542.8816-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122143542.8816-1-gregkh@linuxfoundation.org>
References: <20190122143542.8816-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/platform/atom/punit_atom_debug.c | 22 ++++------------------
 arch/x86/platform/intel-quark/imr.c       | 14 ++++----------
 arch/x86/platform/intel/iosf_mbi.c        | 21 +++------------------
 arch/x86/platform/uv/tlb_uv.c             | 15 ++-------------
 4 files changed, 13 insertions(+), 59 deletions(-)

diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
index 6cb6076223ba..4ac47e9f2089 100644
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -113,24 +113,12 @@ DEFINE_SHOW_ATTRIBUTE(punit_dev_state);
 
 static struct dentry *punit_dbg_file;
 
-static int punit_dbgfs_register(struct punit_device *punit_device)
+static void punit_dbgfs_register(struct punit_device *punit_device)
 {
-	struct dentry *dev_state;
-
 	punit_dbg_file = debugfs_create_dir("punit_atom", NULL);
-	if (!punit_dbg_file)
-		return -ENXIO;
-
-	dev_state = debugfs_create_file("dev_power_state", 0444,
-					punit_dbg_file, punit_device,
-					&punit_dev_state_fops);
-	if (!dev_state) {
-		pr_err("punit_dev_state register failed\n");
-		debugfs_remove(punit_dbg_file);
-		return -ENXIO;
-	}
 
-	return 0;
+	debugfs_create_file("dev_power_state", 0444, punit_dbg_file,
+			    punit_device, &punit_dev_state_fops);
 }
 
 static void punit_dbgfs_unregister(void)
@@ -160,9 +148,7 @@ static int __init punit_atom_debug_init(void)
 	if (!id)
 		return -ENODEV;
 
-	ret = punit_dbgfs_register((struct punit_device *)id->driver_data);
-	if (ret < 0)
-		return ret;
+	punit_dbgfs_register((struct punit_device *)id->driver_data);
 
 	return 0;
 }
diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index 49828c2707ac..98d7982e2594 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -34,7 +34,6 @@
 #include <linux/types.h>
 
 struct imr_device {
-	struct dentry	*file;
 	bool		init;
 	struct mutex	lock;
 	int		max_imr;
@@ -230,13 +229,11 @@ DEFINE_SHOW_ATTRIBUTE(imr_dbgfs_state);
  * imr_debugfs_register - register debugfs hooks.
  *
  * @idev:	pointer to imr_device structure.
- * @return:	0 on success - errno on failure.
  */
-static int imr_debugfs_register(struct imr_device *idev)
+static void imr_debugfs_register(struct imr_device *idev)
 {
-	idev->file = debugfs_create_file("imr_state", 0444, NULL, idev,
-					 &imr_dbgfs_state_fops);
-	return PTR_ERR_OR_ZERO(idev->file);
+	debugfs_create_file("imr_state", 0444, NULL, idev,
+			    &imr_dbgfs_state_fops);
 }
 
 /**
@@ -581,7 +578,6 @@ static const struct x86_cpu_id imr_ids[] __initconst = {
 static int __init imr_init(void)
 {
 	struct imr_device *idev = &imr_dev;
-	int ret;
 
 	if (!x86_match_cpu(imr_ids) || !iosf_mbi_available())
 		return -ENODEV;
@@ -591,9 +587,7 @@ static int __init imr_init(void)
 	idev->init = true;
 
 	mutex_init(&idev->lock);
-	ret = imr_debugfs_register(idev);
-	if (ret != 0)
-		pr_warn("debugfs register failed!\n");
+	imr_debugfs_register(idev);
 	imr_fixup_memmap(idev);
 	return 0;
 }
diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index a9f2e888e135..b18d4dec4658 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -470,31 +470,16 @@ static struct dentry *iosf_dbg;
 
 static void iosf_sideband_debug_init(void)
 {
-	struct dentry *d;
-
 	iosf_dbg = debugfs_create_dir("iosf_sb", NULL);
-	if (IS_ERR_OR_NULL(iosf_dbg))
-		return;
 
 	/* mdr */
-	d = debugfs_create_x32("mdr", 0660, iosf_dbg, &dbg_mdr);
-	if (!d)
-		goto cleanup;
+	debugfs_create_x32("mdr", 0660, iosf_dbg, &dbg_mdr);
 
 	/* mcrx */
-	d = debugfs_create_x32("mcrx", 0660, iosf_dbg, &dbg_mcrx);
-	if (!d)
-		goto cleanup;
+	debugfs_create_x32("mcrx", 0660, iosf_dbg, &dbg_mcrx);
 
 	/* mcr - initiates mailbox tranaction */
-	d = debugfs_create_file("mcr", 0660, iosf_dbg, &dbg_mcr, &iosf_mcr_fops);
-	if (!d)
-		goto cleanup;
-
-	return;
-
-cleanup:
-	debugfs_remove_recursive(d);
+	debugfs_create_file("mcr", 0660, iosf_dbg, &dbg_mcr, &iosf_mcr_fops);
 }
 
 static void iosf_debugfs_init(void)
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index a4130b84d1ff..33f79198d4c4 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -68,7 +68,6 @@ static struct tunables tunables[] = {
 };
 
 static struct dentry *tunables_dir;
-static struct dentry *tunables_file;
 
 /* these correspond to the statistics printed by ptc_seq_show() */
 static char *stat_description[] = {
@@ -1702,18 +1701,8 @@ static int __init uv_ptc_init(void)
 	}
 
 	tunables_dir = debugfs_create_dir(UV_BAU_TUNABLES_DIR, NULL);
-	if (!tunables_dir) {
-		pr_err("unable to create debugfs directory %s\n",
-		       UV_BAU_TUNABLES_DIR);
-		return -EINVAL;
-	}
-	tunables_file = debugfs_create_file(UV_BAU_TUNABLES_FILE, 0600,
-					tunables_dir, NULL, &tunables_fops);
-	if (!tunables_file) {
-		pr_err("unable to create debugfs file %s\n",
-		       UV_BAU_TUNABLES_FILE);
-		return -EINVAL;
-	}
+	debugfs_create_file(UV_BAU_TUNABLES_FILE, 0600, tunables_dir, NULL,
+			    &tunables_fops);
 	return 0;
 }
 
-- 
2.20.1

