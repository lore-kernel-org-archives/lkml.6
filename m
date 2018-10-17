Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C029ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59492150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59492150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeJQSQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:16:16 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24037 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727208AbeJQSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:16:15 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46265555"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Oct 2018 18:21:11 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id DCF9C4B6ED68;
        Wed, 17 Oct 2018 18:21:06 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 17 Oct 2018 18:21:12 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <bhe@redhat.com>,
        <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v9 5/8] x86/boot: Add get_acpi_rsdp() to parse RSDP in cmdlien from kexec
Date:   Wed, 17 Oct 2018 18:20:09 +0800
Message-ID: <20181017102012.872-6-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: DCF9C4B6ED68.A053A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If KEXEC write the RSDP pointer to cmdline, parse the cmdline
and use it.
Imitate from early_param of "acpi_rsdp".

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpitb.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
index 50fa65cf824d..37b1f4407be8 100644
--- a/arch/x86/boot/compressed/acpitb.c
+++ b/arch/x86/boot/compressed/acpitb.c
@@ -8,6 +8,9 @@
 #include <linux/numa.h>
 #include <linux/acpi.h>
 
+#define STATIC
+#include <linux/decompress/mm.h>
+
 /* Search EFI table for RSDP table. */
 static void efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
 {
@@ -200,3 +203,23 @@ static void bios_get_rsdp_addr(acpi_physical_address *rsdp_addr)
 		*rsdp_addr = (acpi_physical_address)address;
 	}
 }
+
+static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
+{
+#ifdef CONFIG_KEXEC
+	unsigned long long res;
+	int len = 0;
+	char *val;
+
+	val = malloc(20);
+	len = cmdline_find_option("acpi_rsdp", val, 20);
+
+	if (len == -1)
+		return;
+
+	if (len > 0) {
+		val[len] = 0;
+		*rsdp_addr = (acpi_physical_address)kstrtoull(val, 0, &res);
+	}
+#endif
+}
-- 
2.17.2



