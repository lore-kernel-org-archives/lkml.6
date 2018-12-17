Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BAAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F32820883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbeLQCkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 21:40:40 -0500
Received: from [38.106.11.25] ([38.106.11.25]:56168 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726260AbeLQCkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 21:40:39 -0500
X-Greylist: delayed 1190 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Dec 2018 21:40:38 EST
X-ASG-Debug-ID: 1545013239-107606139f07bd0001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net (localhost [10.128.0.14]) by barracuda02.hxt-semitech.com with ESMTP id E05lSFeLqCQCjHd9 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 17 Dec 2018 10:20:39 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from y.localdomain (10.5.21.109) by HXTBJIDCEMVIW01.hxtcorp.net
 (10.128.0.14) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 17 Dec
 2018 10:19:43 +0800
From:   Shunyong Yang <shunyong.yang@hxt-semitech.com>
To:     <rjw@rjwysocki.net>
CC:     <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH] ACPI / tables: table upgrade from built-in initrd
Date:   Mon, 17 Dec 2018 10:19:44 +0800
X-ASG-Orig-Subj: [PATCH] ACPI / tables: table upgrade from built-in initrd
Message-ID: <1545013184-2487-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: localhost[10.128.0.14]
X-Barracuda-Start-Time: 1545013239
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 2473
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8061 1.0000 2.2786
X-Barracuda-Spam-Score: 2.28
X-Barracuda-Spam-Status: No, SCORE=2.28 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63913
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some scenario, we need to build initrd with kernel in a single image.
This can simplify system deployment process by downloading the whole system
once, such as in IC verification.

This patch adds support to upgrade ACPI tables from built-in initrd.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 drivers/acpi/Kconfig   |  9 +++++++++
 drivers/acpi/tables.c  | 12 ++++++++++--
 include/linux/initrd.h |  3 +++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7cea769c37df..30976496fe77 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -357,6 +357,15 @@ config ACPI_TABLE_UPGRADE
 	  initrd, therefore it's safe to say Y.
 	  See Documentation/acpi/initrd_table_override.txt for details
 
+config ACPI_TABLE_UPGRADE_VIA_BUILTIN_INITRD
+	bool "Upgrade ACPI tables from built-in initrd"
+	depends on ACPI_TABLE_UPGRADE
+	depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION=""
+	def_bool n
+	help
+	  This option provides functionality to upgrade arbitrary ACPI tables
+	  from built-in uncompressed initrd.
+
 config ACPI_DEBUG
 	bool "Debug Statements"
 	help
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 61203eebf3a1..88e3a34443da 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -473,14 +473,22 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
 
 void __init acpi_table_upgrade(void)
 {
-	void *data = (void *)initrd_start;
-	size_t size = initrd_end - initrd_start;
+	void *data;
+	size_t size;
 	int sig, no, table_nr = 0, total_offset = 0;
 	long offset = 0;
 	struct acpi_table_header *table;
 	char cpio_path[32] = "kernel/firmware/acpi/";
 	struct cpio_data file;
 
+	if (IS_ENABLED(CONFIG_ACPI_TABLE_UPGRADE_VIA_BUILTIN_INITRD)) {
+		data = __initramfs_start;
+		size = __initramfs_size;
+	} else {
+		data = (void *)initrd_start;
+		size = initrd_end - initrd_start;
+	}
+
 	if (data == NULL || size == 0)
 		return;
 
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 84b423044088..02d94aae54c7 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -22,3 +22,6 @@
 extern void free_initrd_mem(unsigned long, unsigned long);
 
 extern unsigned int real_root_dev;
+
+extern char __initramfs_start[];
+extern unsigned long __initramfs_size;
-- 
1.8.3.1

