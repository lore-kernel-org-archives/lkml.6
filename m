Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EE2ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 04:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA832086B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 04:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="zrh4Hx9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA832086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeIPKAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 06:00:16 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:38480 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725739AbeIPKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 06:00:15 -0400
Received: from trochilidae.hsd1.wa.comcast.net (unknown [IPv6:2601:602:8700:fb00:81ae:bc59:4e6c:42ca])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id EFC6B5C2222;
        Sun, 16 Sep 2018 06:38:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537072718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lA4pWBiapQwb05oCOx8c7PAm+j6USrDO0AnRCDFKdjo=;
        b=zrh4Hx9Hr25DRjwB0zna5s84CAvsiwduWmtJ3iQRBg0nesurFQg2QIR/t3Olmw2/ZUcG5O
        dUHBabNBOPzMgvswxo9IrzdefgdVDSplb9dY1/9QaDswe4guMVhjTVDMzHIkoFlNwNMxPr
        ZMsjOzwfBi4G/GPHnxTinjTRAPCcxXY=
From:   Stefan Agner <stefan@agner.ch>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ard.biesheuvel@linaro.org
Cc:     linux@armlinux.org.uk, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] crypto: arm/crc32 - avoid warning when compiling with Clang
Date:   Sat, 15 Sep 2018 21:38:25 -0700
Message-Id: <20180916043825.23247-2-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180916043825.23247-1-stefan@agner.ch>
References: <20180916043825.23247-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The table id (second) argument to MODULE_DEVICE_TABLE is often
referenced otherwise. This is not the case for CPU features. This
leads to a warning when building the kernel with Clang:
  arch/arm/crypto/crc32-ce-glue.c:239:33: warning: variable
    'crc32_cpu_feature' is not needed and will not be emitted
    [-Wunneeded-internal-declaration]
  static const struct cpu_feature crc32_cpu_feature[] = {
                                  ^

Avoid warnings by using __maybe_unused, similar to commit 1f318a8bafcf
("modules: mark __inittest/__exittest as __maybe_unused").

Fixes: 2a9faf8b7e43 ("crypto: arm/crc32 - enable module autoloading based on CPU feature bits")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/crypto/crc32-ce-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/crypto/crc32-ce-glue.c b/arch/arm/crypto/crc32-ce-glue.c
index 96e62ec105d0..cd9e93b46c2d 100644
--- a/arch/arm/crypto/crc32-ce-glue.c
+++ b/arch/arm/crypto/crc32-ce-glue.c
@@ -236,7 +236,7 @@ static void __exit crc32_pmull_mod_exit(void)
 				  ARRAY_SIZE(crc32_pmull_algs));
 }
 
-static const struct cpu_feature crc32_cpu_feature[] = {
+static const struct cpu_feature __maybe_unused crc32_cpu_feature[] = {
 	{ cpu_feature(CRC32) }, { cpu_feature(PMULL) }, { }
 };
 MODULE_DEVICE_TABLE(cpu, crc32_cpu_feature);
-- 
2.19.0

