Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3827EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E813E21582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E813E21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeI0P2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:28:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeI0P2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:28:10 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5225B1117;
        Thu, 27 Sep 2018 09:10:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zdenek Kaspar <zkaspar82@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.18 49/88] crypto: x86/aegis,morus - Do not require OSXSAVE for SSE2
Date:   Thu, 27 Sep 2018 11:03:30 +0200
Message-Id: <20180927090306.774764066@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnacek <omosnace@redhat.com>

commit 24568b47d48ec8c906fd0f589489a08b17e1edca upstream.

It turns out OSXSAVE needs to be checked only for AVX, not for SSE.
Without this patch the affected modules refuse to load on CPUs with SSE2
but without AVX support.

Fixes: 877ccce7cbe8 ("crypto: x86/aegis,morus - Fix and simplify CPUID checks")
Cc: <stable@vger.kernel.org> # 4.18
Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aegis128-aesni-glue.c  |    1 -
 arch/x86/crypto/aegis128l-aesni-glue.c |    1 -
 arch/x86/crypto/aegis256-aesni-glue.c  |    1 -
 arch/x86/crypto/morus1280-sse2-glue.c  |    1 -
 arch/x86/crypto/morus640-sse2-glue.c   |    1 -
 5 files changed, 5 deletions(-)

--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -379,7 +379,6 @@ static int __init crypto_aegis128_aesni_
 {
 	if (!boot_cpu_has(X86_FEATURE_XMM2) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE) ||
 	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
 		return -ENODEV;
 
--- a/arch/x86/crypto/aegis128l-aesni-glue.c
+++ b/arch/x86/crypto/aegis128l-aesni-glue.c
@@ -379,7 +379,6 @@ static int __init crypto_aegis128l_aesni
 {
 	if (!boot_cpu_has(X86_FEATURE_XMM2) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE) ||
 	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
 		return -ENODEV;
 
--- a/arch/x86/crypto/aegis256-aesni-glue.c
+++ b/arch/x86/crypto/aegis256-aesni-glue.c
@@ -379,7 +379,6 @@ static int __init crypto_aegis256_aesni_
 {
 	if (!boot_cpu_has(X86_FEATURE_XMM2) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE) ||
 	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
 		return -ENODEV;
 
--- a/arch/x86/crypto/morus1280-sse2-glue.c
+++ b/arch/x86/crypto/morus1280-sse2-glue.c
@@ -40,7 +40,6 @@ MORUS1280_DECLARE_ALGS(sse2, "morus1280-
 static int __init crypto_morus1280_sse2_module_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_XMM2) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE) ||
 	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
 		return -ENODEV;
 
--- a/arch/x86/crypto/morus640-sse2-glue.c
+++ b/arch/x86/crypto/morus640-sse2-glue.c
@@ -40,7 +40,6 @@ MORUS640_DECLARE_ALGS(sse2, "morus640-ss
 static int __init crypto_morus640_sse2_module_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_XMM2) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE) ||
 	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
 		return -ENODEV;
 


