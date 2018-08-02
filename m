Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212EBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4925215E5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4925215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeHCATf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbeHCATe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:19:34 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68BA21582;
        Thu,  2 Aug 2018 22:26:21 +0000 (UTC)
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, stable-rt@vger.kernel.org,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 02/15] arm*: disable NEON in kernel mode
Date:   Thu,  2 Aug 2018 17:25:17 -0500
Message-Id: <90e82fad6865051bc8896ab94e40843a94adf6e8.1533242791.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

NEON in kernel mode is used by the crypto algorithms and raid6 code.
While the raid6 code looks okay, the crypto algorithms do not: NEON
is enabled on first invocation and may allocate/free/map memory before
the NEON mode is disabled again.
This needs to be changed until it can be enabled.
On ARM NEON in kernel mode can be simply disabled. on ARM64 it needs to
stay on due to possible EFI callbacks so here I disable each algorithm.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Daniel Wagner <wagi@monom.org>
(cherry picked from commit 728b41d8e7b5307b52bdbffcb492bc8345a4e38a)
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 arch/arm/Kconfig          |  2 +-
 arch/arm64/crypto/Kconfig | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d635abf51063..12b1e7a5f103 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2122,7 +2122,7 @@ config NEON
 
 config KERNEL_MODE_NEON
 	bool "Support for NEON in kernel mode"
-	depends on NEON && AEABI
+	depends on NEON && AEABI && !PREEMPT_RT_BASE
 	help
 	  Say Y to include support for NEON in kernel mode.
 
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 5562652c5316..003fe0718117 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -10,42 +10,42 @@ if ARM64_CRYPTO
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_SHA2_ARM64_CE
 	tristate "SHA-224/SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_GHASH_ARM64_CE
 	tristate "GHASH (for GCM chaining mode) using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_AES_ARM64_CE
 	tristate "AES core cipher using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES
 
 config CRYPTO_AES_ARM64_CE_CCM
 	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES
 	select CRYPTO_AEAD
 
 config CRYPTO_AES_ARM64_CE_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES
 	select CRYPTO_ABLK_HELPER
 
 config CRYPTO_AES_ARM64_NEON_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using NEON instructions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES
 	select CRYPTO_ABLK_HELPER
-- 
2.14.1

