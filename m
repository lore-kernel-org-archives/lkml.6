Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293EFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBC821721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548167778;
	bh=pMlCFbhDQad9IB4n6AfqY+TPY7WGcWyYTKmXubFQC5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nx9O43Prjxgg43fbd3Gh9aE2FfGHJW20ccklc6ItENrnQ7hyqntx6iqFEGhl5+SOF
	 NSNthQP4K3lG3+zQo+wfsQ69AmDrhqpsbqLt8uSWaZSL0nzt4ny54IEwjZRWEpAhxm
	 dj3bYNA0Kh1INgHzirKm4bpHIAP0Jj7H4dWB/an0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfAVOgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:36:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbfAVOgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:36:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C721621726;
        Tue, 22 Jan 2019 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548167774;
        bh=pMlCFbhDQad9IB4n6AfqY+TPY7WGcWyYTKmXubFQC5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGrujZQkWBMfsW8pcK8zaUqTL6caonq/kTnz5DvUSybPVDQqAqsVegGKCttD3p0fU
         cveAsufJALSdLsZD/XSDOzXohHtTcFHC3bez6VgnnRwkYJK6PZvyf+rH8Bp4Psd9tT
         ubE92Oro+z69M0DCqK4A5bFm6AgMiRsJWtkQIWyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH 1/6] x86: mce: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:35:37 +0100
Message-Id: <20190122143542.8816-2-gregkh@linuxfoundation.org>
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
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Pu Wen <puwen@hygon.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/mce/core.c     | 15 ++++---------
 arch/x86/kernel/cpu/mce/inject.c   | 34 +++++-------------------------
 arch/x86/kernel/cpu/mce/severity.c | 14 +++---------
 3 files changed, 12 insertions(+), 51 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 672c7225cb1b..1f13f9032a8a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2457,22 +2457,15 @@ static int fake_panic_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(fake_panic_fops, fake_panic_get,
 			fake_panic_set, "%llu\n");
 
-static int __init mcheck_debugfs_init(void)
+static void __init mcheck_debugfs_init(void)
 {
-	struct dentry *dmce, *ffake_panic;
+	struct dentry *dmce;
 
 	dmce = mce_get_debugfs_dir();
-	if (!dmce)
-		return -ENOMEM;
-	ffake_panic = debugfs_create_file("fake_panic", 0444, dmce, NULL,
-					  &fake_panic_fops);
-	if (!ffake_panic)
-		return -ENOMEM;
-
-	return 0;
+	debugfs_create_file("fake_panic", 0444, dmce, NULL, &fake_panic_fops);
 }
 #else
-static int __init mcheck_debugfs_init(void) { return -EINVAL; }
+static void __init mcheck_debugfs_init(void) { }
 #endif
 
 DEFINE_STATIC_KEY_FALSE(mcsafe_key);
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 8492ef7d9015..0f5b6c57ffde 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -648,7 +648,6 @@ static const struct file_operations readme_fops = {
 
 static struct dfs_node {
 	char *name;
-	struct dentry *d;
 	const struct file_operations *fops;
 	umode_t perm;
 } dfs_fls[] = {
@@ -662,7 +661,7 @@ static struct dfs_node {
 	{ .name = "README",	.fops = &readme_fops, .perm = S_IRUSR | S_IRGRP | S_IROTH },
 };
 
-static int __init debugfs_init(void)
+static void __init debugfs_init(void)
 {
 	unsigned int i;
 	u64 cap;
@@ -671,30 +670,11 @@ static int __init debugfs_init(void)
 	n_banks = cap & MCG_BANKCNT_MASK;
 
 	dfs_inj = debugfs_create_dir("mce-inject", NULL);
-	if (!dfs_inj)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(dfs_fls); i++) {
-		dfs_fls[i].d = debugfs_create_file(dfs_fls[i].name,
-						    dfs_fls[i].perm,
-						    dfs_inj,
-						    &i_mce,
-						    dfs_fls[i].fops);
-
-		if (!dfs_fls[i].d)
-			goto err_dfs_add;
-	}
-
-	return 0;
 
-err_dfs_add:
-	while (i-- > 0)
-		debugfs_remove(dfs_fls[i].d);
+	for (i = 0; i < ARRAY_SIZE(dfs_fls); i++)
+		debugfs_create_file(dfs_fls[i].name, dfs_fls[i].perm, dfs_inj,
+				    &i_mce, dfs_fls[i].fops);
 
-	debugfs_remove(dfs_inj);
-	dfs_inj = NULL;
-
-	return -ENODEV;
 }
 
 static int __init inject_init(void)
@@ -704,11 +684,7 @@ static int __init inject_init(void)
 	if (!alloc_cpumask_var(&mce_inject_cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
-	err = debugfs_init();
-	if (err) {
-		free_cpumask_var(mce_inject_cpumask);
-		return err;
-	}
+	debugfs_init();
 
 	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify");
 	mce_register_injector_chain(&inject_nb);
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dc3e26e905a3..a2d297981b8a 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -399,21 +399,13 @@ static const struct file_operations severities_coverage_fops = {
 
 static int __init severities_debugfs_init(void)
 {
-	struct dentry *dmce, *fsev;
+	struct dentry *dmce;
 
 	dmce = mce_get_debugfs_dir();
-	if (!dmce)
-		goto err_out;
-
-	fsev = debugfs_create_file("severities-coverage", 0444, dmce, NULL,
-				   &severities_coverage_fops);
-	if (!fsev)
-		goto err_out;
 
+	debugfs_create_file("severities-coverage", 0444, dmce, NULL,
+			    &severities_coverage_fops);
 	return 0;
-
-err_out:
-	return -ENOMEM;
 }
 late_initcall(severities_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
-- 
2.20.1

