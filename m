Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B37CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43ED3218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfAXK1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:27:01 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41693 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:27:01 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id ebc915f730573006; Thu, 24 Jan 2019 11:26:59 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] ACPI: debug: Clean up acpi_aml_init()
Date:   Thu, 24 Jan 2019 11:25:59 +0100
Message-ID: <2715517.7WDaClUie6@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The err_exit label in acpi_aml_init() is not used any more after
commit 9ec6dbfbdc0a ("ACPI: no need to check return value of
debugfs_create functions"), but the other label in there is not
necessary too, so rearrange the code to get rid of them both.

No intentional functional impact.

Fixes: 9ec6dbfbdc0a ("ACPI: no need to check return value of debugfs_create functions")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_dbg.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/acpi_dbg.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_dbg.c
+++ linux-pm/drivers/acpi/acpi_dbg.c
@@ -750,29 +750,28 @@ static const struct acpi_debugger_ops ac
 
 int __init acpi_aml_init(void)
 {
-	int ret = 0;
+	int ret;
 
 	/* Initialize AML IO interface */
 	mutex_init(&acpi_aml_io.lock);
 	init_waitqueue_head(&acpi_aml_io.wait);
 	acpi_aml_io.out_crc.buf = acpi_aml_io.out_buf;
 	acpi_aml_io.in_crc.buf = acpi_aml_io.in_buf;
+
 	acpi_aml_dentry = debugfs_create_file("acpidbg",
 					      S_IFREG | S_IRUGO | S_IWUSR,
 					      acpi_debugfs_dir, NULL,
 					      &acpi_aml_operations);
-	ret = acpi_register_debugger(THIS_MODULE, &acpi_aml_debugger);
-	if (ret)
-		goto err_fs;
-	acpi_aml_initialized = true;
 
-err_fs:
+	ret = acpi_register_debugger(THIS_MODULE, &acpi_aml_debugger);
 	if (ret) {
 		debugfs_remove(acpi_aml_dentry);
 		acpi_aml_dentry = NULL;
+		return ret;
 	}
-err_exit:
-	return ret;
+
+	acpi_aml_initialized = true;
+	return 0;
 }
 
 void __exit acpi_aml_exit(void)

