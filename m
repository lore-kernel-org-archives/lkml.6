Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915E1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518B620879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170590;
	bh=Jg04Bd21jrTar/AHYTa21COY4a9PbqnjktyGpUeSzpA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xQhLPcj+wRc7EagM1vluvffiSGdust/ll3uILqNSPVxcBIkE4X0HrfXByo90SbzUI
	 hT/BUl4ImHp5jXNkGkUXyBABqsBaPx6QZv06L2k89jDHQwBDQJyWxvE2mAWykWbMgW
	 VRQ8dnr1E1YK56iFFPpOtXinXUSOyv0frajArBLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfAVPXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729778AbfAVPXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7894E20879;
        Tue, 22 Jan 2019 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170584;
        bh=Jg04Bd21jrTar/AHYTa21COY4a9PbqnjktyGpUeSzpA=;
        h=From:To:Cc:Subject:Date:From;
        b=CpdNYfjy2gwWziU4v4sHZXPht07vcZvvkNQ6oN5eXhoIErfhmsvo1MkwFRsySM2Hp
         g+Qi0g9Gnd7o6K6UjxpBpyGcjn38gKG+/p1WLBfhudZtdrM5q+W95OYes2EwLJ8KSu
         n40dXc+ZGsav3sujcWnvp0/VOU42dKL87fKgUMkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Yangtao Li <tiny.windzz@gmail.com>, linux-acpi@vger.kernel.org
Subject: [PATCH] acpi: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:03 +0100
Message-Id: <20190122152151.16139-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Yangtao Li <tiny.windzz@gmail.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_dbg.c      | 15 +------
 drivers/acpi/apei/einj.c     | 86 +++++++++---------------------------
 drivers/acpi/custom_method.c |  6 ---
 drivers/acpi/ec_sys.c        | 36 ++++-----------
 4 files changed, 32 insertions(+), 111 deletions(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index a2dcd62ea32f..f3bca448b305 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -752,11 +752,6 @@ int __init acpi_aml_init(void)
 {
 	int ret = 0;
 
-	if (!acpi_debugfs_dir) {
-		ret = -ENOENT;
-		goto err_exit;
-	}
-
 	/* Initialize AML IO interface */
 	mutex_init(&acpi_aml_io.lock);
 	init_waitqueue_head(&acpi_aml_io.wait);
@@ -766,10 +761,6 @@ int __init acpi_aml_init(void)
 					      S_IFREG | S_IRUGO | S_IWUSR,
 					      acpi_debugfs_dir, NULL,
 					      &acpi_aml_operations);
-	if (acpi_aml_dentry == NULL) {
-		ret = -ENODEV;
-		goto err_exit;
-	}
 	ret = acpi_register_debugger(THIS_MODULE, &acpi_aml_debugger);
 	if (ret)
 		goto err_fs;
@@ -788,10 +779,8 @@ void __exit acpi_aml_exit(void)
 {
 	if (acpi_aml_initialized) {
 		acpi_unregister_debugger(&acpi_aml_debugger);
-		if (acpi_aml_dentry) {
-			debugfs_remove(acpi_aml_dentry);
-			acpi_aml_dentry = NULL;
-		}
+		debugfs_remove(acpi_aml_dentry);
+		acpi_aml_dentry = NULL;
 		acpi_aml_initialized = false;
 	}
 }
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index fcccbfdbdd1a..c42299e048e4 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -679,7 +679,6 @@ static int __init einj_init(void)
 {
 	int rc;
 	acpi_status status;
-	struct dentry *fentry;
 	struct apei_exec_context ctx;
 
 	if (acpi_disabled) {
@@ -707,25 +706,13 @@ static int __init einj_init(void)
 
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
-	if (!einj_debug_dir) {
-		pr_err("Error creating debugfs node.\n");
-		goto err_cleanup;
-	}
 
-	fentry = debugfs_create_file("available_error_type", S_IRUSR,
-				     einj_debug_dir, NULL,
-				     &available_error_type_fops);
-	if (!fentry)
-		goto err_cleanup;
-
-	fentry = debugfs_create_file("error_type", S_IRUSR | S_IWUSR,
-				     einj_debug_dir, NULL, &error_type_fops);
-	if (!fentry)
-		goto err_cleanup;
-	fentry = debugfs_create_file("error_inject", S_IWUSR,
-				     einj_debug_dir, NULL, &error_inject_fops);
-	if (!fentry)
-		goto err_cleanup;
+	debugfs_create_file("available_error_type", S_IRUSR, einj_debug_dir,
+			    NULL, &available_error_type_fops);
+	debugfs_create_file("error_type", S_IRUSR | S_IWUSR, einj_debug_dir,
+			    NULL, &error_type_fops);
+	debugfs_create_file("error_inject", S_IWUSR, einj_debug_dir,
+			    NULL, &error_inject_fops);
 
 	apei_resources_init(&einj_resources);
 	einj_exec_ctx_init(&ctx);
@@ -750,66 +737,37 @@ static int __init einj_init(void)
 	rc = -ENOMEM;
 	einj_param = einj_get_parameter_address();
 	if ((param_extension || acpi5) && einj_param) {
-		fentry = debugfs_create_x32("flags", S_IRUSR | S_IWUSR,
-					    einj_debug_dir, &error_flags);
-		if (!fentry)
-			goto err_unmap;
-		fentry = debugfs_create_x64("param1", S_IRUSR | S_IWUSR,
-					    einj_debug_dir, &error_param1);
-		if (!fentry)
-			goto err_unmap;
-		fentry = debugfs_create_x64("param2", S_IRUSR | S_IWUSR,
-					    einj_debug_dir, &error_param2);
-		if (!fentry)
-			goto err_unmap;
-		fentry = debugfs_create_x64("param3", S_IRUSR | S_IWUSR,
-					    einj_debug_dir, &error_param3);
-		if (!fentry)
-			goto err_unmap;
-		fentry = debugfs_create_x64("param4", S_IRUSR | S_IWUSR,
-					    einj_debug_dir, &error_param4);
-		if (!fentry)
-			goto err_unmap;
-
-		fentry = debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
-					    einj_debug_dir, &notrigger);
-		if (!fentry)
-			goto err_unmap;
+		debugfs_create_x32("flags", S_IRUSR | S_IWUSR, einj_debug_dir,
+				   &error_flags);
+		debugfs_create_x64("param1", S_IRUSR | S_IWUSR, einj_debug_dir,
+				   &error_param1);
+		debugfs_create_x64("param2", S_IRUSR | S_IWUSR, einj_debug_dir,
+				   &error_param2);
+		debugfs_create_x64("param3", S_IRUSR | S_IWUSR, einj_debug_dir,
+				   &error_param3);
+		debugfs_create_x64("param4", S_IRUSR | S_IWUSR, einj_debug_dir,
+				   &error_param4);
+		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
+				   einj_debug_dir, &notrigger);
 	}
 
 	if (vendor_dev[0]) {
 		vendor_blob.data = vendor_dev;
 		vendor_blob.size = strlen(vendor_dev);
-		fentry = debugfs_create_blob("vendor", S_IRUSR,
-					     einj_debug_dir, &vendor_blob);
-		if (!fentry)
-			goto err_unmap;
-		fentry = debugfs_create_x32("vendor_flags", S_IRUSR | S_IWUSR,
-					    einj_debug_dir, &vendor_flags);
-		if (!fentry)
-			goto err_unmap;
+		debugfs_create_blob("vendor", S_IRUSR, einj_debug_dir,
+				    &vendor_blob);
+		debugfs_create_x32("vendor_flags", S_IRUSR | S_IWUSR,
+				   einj_debug_dir, &vendor_flags);
 	}
 
 	pr_info("Error INJection is initialized.\n");
 
 	return 0;
 
-err_unmap:
-	if (einj_param) {
-		acpi_size size = (acpi5) ?
-			sizeof(struct set_error_type_with_address) :
-			sizeof(struct einj_parameter);
-
-		acpi_os_unmap_iomem(einj_param, size);
-		pr_err("Error creating param extension debugfs nodes.\n");
-	}
-	apei_exec_post_unmap_gars(&ctx);
 err_release:
 	apei_resources_release(&einj_resources);
 err_fini:
 	apei_resources_fini(&einj_resources);
-err_cleanup:
-	pr_err("Error creating primary debugfs nodes.\n");
 	debugfs_remove_recursive(einj_debug_dir);
 
 	return rc;
diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 4451877f83b6..aa972dc5cb7e 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -79,14 +79,8 @@ static const struct file_operations cm_fops = {
 
 static int __init acpi_custom_method_init(void)
 {
-	if (acpi_debugfs_dir == NULL)
-		return -ENOENT;
-
 	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
 					acpi_debugfs_dir, NULL, &cm_fops);
-	if (cm_dentry == NULL)
-		return -ENODEV;
-
 	return 0;
 }
 
diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index dd70d6c2bca0..23faa66ea772 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -108,52 +108,32 @@ static const struct file_operations acpi_ec_io_ops = {
 	.llseek = default_llseek,
 };
 
-static int acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
+static void acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
 {
 	struct dentry *dev_dir;
 	char name[64];
 	umode_t mode = 0400;
 
-	if (ec_device_count == 0) {
+	if (ec_device_count == 0)
 		acpi_ec_debugfs_dir = debugfs_create_dir("ec", NULL);
-		if (!acpi_ec_debugfs_dir)
-			return -ENOMEM;
-	}
 
 	sprintf(name, "ec%u", ec_device_count);
 	dev_dir = debugfs_create_dir(name, acpi_ec_debugfs_dir);
-	if (!dev_dir) {
-		if (ec_device_count != 0)
-			goto error;
-		return -ENOMEM;
-	}
 
-	if (!debugfs_create_x32("gpe", 0444, dev_dir, &first_ec->gpe))
-		goto error;
-	if (!debugfs_create_bool("use_global_lock", 0444, dev_dir,
-				 &first_ec->global_lock))
-		goto error;
+	debugfs_create_x32("gpe", 0444, dev_dir, &first_ec->gpe);
+	debugfs_create_bool("use_global_lock", 0444, dev_dir,
+			    &first_ec->global_lock);
 
 	if (write_support)
 		mode = 0600;
-	if (!debugfs_create_file("io", mode, dev_dir, ec, &acpi_ec_io_ops))
-		goto error;
-
-	return 0;
-
-error:
-	debugfs_remove_recursive(acpi_ec_debugfs_dir);
-	return -ENOMEM;
+	debugfs_create_file("io", mode, dev_dir, ec, &acpi_ec_io_ops);
 }
 
 static int __init acpi_ec_sys_init(void)
 {
-	int err = 0;
 	if (first_ec)
-		err = acpi_ec_add_debugfs(first_ec, 0);
-	else
-		err = -ENODEV;
-	return err;
+		acpi_ec_add_debugfs(first_ec, 0);
+	return 0;
 }
 
 static void __exit acpi_ec_sys_exit(void)
-- 
2.20.1

