Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56318C04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B80222419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B80222419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeKLU2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:28:38 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbeKLU2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:28:37 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 0A4FE4D0CD286;
        Mon, 12 Nov 2018 10:34:06 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.42) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 12 Nov 2018 10:33:59 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <dhowells@redhat.com>, <dwmw2@infradead.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 12/12] KEYS: Introduce load_pgp_public_keyring()
Date:   Mon, 12 Nov 2018 11:24:23 +0100
Message-ID: <20181112102423.30415-13-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112102423.30415-1-roberto.sassu@huawei.com>
References: <20181112102423.30415-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preload PGP keys from 'pubring.gpg', placed in the kernel source directory.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 certs/Kconfig          |  7 +++++++
 certs/Makefile         |  3 +++
 certs/system_keyring.c | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/certs/Kconfig b/certs/Kconfig
index c94e93d8bccf..71be583e55a4 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -83,4 +83,11 @@ config SYSTEM_BLACKLIST_HASH_LIST
 	  wrapper to incorporate the list into the kernel.  Each <hash> should
 	  be a string of hex digits.
 
+config PGP_PRELOAD_PUBLIC_KEYS
+	bool "Preload PGP public keys"
+	select PGP_PRELOAD
+	default n
+	help
+	  Provide a keyring of PGP public keys.
+
 endmenu
diff --git a/certs/Makefile b/certs/Makefile
index 5d0999b9e21b..4338af9182e3 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -4,6 +4,9 @@
 #
 
 obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o
+ifdef CONFIG_PGP_PRELOAD_PUBLIC_KEYS
+certs/system_keyring.o: pubring.gpg
+endif
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o
 ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),"")
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index e4c59a5c7a9d..5dacb124133f 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -189,6 +189,31 @@ static __init int load_system_certificate_list(void)
 }
 late_initcall(load_system_certificate_list);
 
+#ifdef CONFIG_PGP_PRELOAD_PUBLIC_KEYS
+extern __initconst const u8 pgp_public_keys[];
+extern __initconst const u8 pgp_public_keys_end[];
+asm(".section .init.data,\"aw\"\n"
+	"pgp_public_keys:\n"
+	".incbin \"pubring.gpg\"\n"
+	"pgp_public_keys_end:");
+
+/*
+ * Load a list of PGP keys.
+ */
+static __init int load_pgp_public_keyring(void)
+{
+	pr_notice("Load PGP public keys\n");
+
+	if (preload_pgp_keys(pgp_public_keys,
+			     pgp_public_keys_end - pgp_public_keys,
+			     builtin_trusted_keys) < 0)
+		pr_err("Can't load PGP public keys\n");
+
+	return 0;
+}
+late_initcall(load_pgp_public_keyring);
+#endif /* CONFIG_PGP_PRELOAD_PUBLIC_KEYS */
+
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
 
 /**
-- 
2.17.1

