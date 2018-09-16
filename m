Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F4BECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 04:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F292086B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 04:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Q5MdjeQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F292086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeIPKAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 06:00:12 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:38464 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725739AbeIPKAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 06:00:12 -0400
Received: from trochilidae.hsd1.wa.comcast.net (unknown [IPv6:2601:602:8700:fb00:81ae:bc59:4e6c:42ca])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 7AB0B5C00D5;
        Sun, 16 Sep 2018 06:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537072715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=2lK0vZCW1aPI14wGfZXet/bAIJfwAIYj8AD9d3l2++o=;
        b=Q5MdjeQeOo6w5q+qx9ejuyhu7/XhB6idKaUbXfhwybML96qPTzL2QEUCZXMqS+8FCgnr26
        q6IUtr6SBG0DabFVe4Gw/E4pooixR78oVpwD1d8XGq2dmQSjZGw0MtIrEI0J/PJfiDVdHT
        VG28O9hU0drjDCbuxliDHyYR054ux8g=
From:   Stefan Agner <stefan@agner.ch>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ard.biesheuvel@linaro.org
Cc:     linux@armlinux.org.uk, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] cpufeature: avoid warning when compiling with clang
Date:   Sat, 15 Sep 2018 21:38:24 -0700
Message-Id: <20180916043825.23247-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The table id (second) argument to MODULE_DEVICE_TABLE is often
referenced otherwise. This is not the case for CPU features. This
leads to warnings when building the kernel with Clang:
  arch/arm/crypto/aes-ce-glue.c:450:1: warning: variable
    'cpu_feature_match_AES' is not needed and will not be emitted
    [-Wunneeded-internal-declaration]
  module_cpu_feature_match(AES, aes_init);
  ^

Avoid warnings by using __maybe_unused, similar to commit 1f318a8bafcf
("modules: mark __inittest/__exittest as __maybe_unused").

Fixes: 67bad2fdb754 ("cpu: add generic support for CPU feature based module autoloading")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 include/linux/cpufeature.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpufeature.h b/include/linux/cpufeature.h
index 986c06c88d81..84d3c81b5978 100644
--- a/include/linux/cpufeature.h
+++ b/include/linux/cpufeature.h
@@ -45,7 +45,7 @@
  * 'asm/cpufeature.h' of your favorite architecture.
  */
 #define module_cpu_feature_match(x, __initfunc)			\
-static struct cpu_feature const cpu_feature_match_ ## x[] =	\
+static struct cpu_feature const __maybe_unused cpu_feature_match_ ## x[] = \
 	{ { .feature = cpu_feature(x) }, { } };			\
 MODULE_DEVICE_TABLE(cpu, cpu_feature_match_ ## x);		\
 								\
-- 
2.19.0

