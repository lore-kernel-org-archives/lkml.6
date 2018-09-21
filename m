Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5557EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F1921479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EVK1j/R3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F1921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388751AbeIUGBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:01:37 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:33427 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeIUGBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:01:37 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 499de603;
        Thu, 20 Sep 2018 23:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=cZBWkEKOtTRZyHxO/CPoLybUAi8=; b=EVK1j/R3aIU+22r9g11C
        tGPNgZ6OmFn7OwX5dkijmwJmtroeWC18EbpmMm5yvYSLlrRg4BXyMCCzwBCMzuQ6
        RsaB1GHQbMipdu6qEiTA/wu21vDoNM/1Wt5cBN+XU7EqA+kaTfxZU1Ku+vtio0OQ
        cLimQtoaSzQVWZUDVEVi8YJyg+iDl2sVmxg3HJLgMCMgIlqA90X1lnsRl8pVNI64
        HRXKdhuV00+2oRQnc2UBaGKvI+w+E5MScHEiiq3XPm/cG426ZUk3QOqOnUFehU7n
        FyK8lA8lBcTzryKG7vAcQlOEZS5XE88UkBftH3kl+BZ6m26yWFMxmBGsvrMEo/n+
        Mg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a9aa2bd6 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 20 Sep 2018 23:57:38 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] framewarn: expand KASAN_EXTRA exception to KASAN
Date:   Fri, 21 Sep 2018 02:15:13 +0200
Message-Id: <20180921001513.12504-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that KASAN in general will bloat stack frames in unexpected
ways, not just KASAN_EXTRA. So, this patch trivially changes that
default to be associated with KASAN instead of KASAN_EXTRA.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4966c4fbe7f7..39078a080e29 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -222,7 +222,7 @@ config ENABLE_MUST_CHECK
 config FRAME_WARN
 	int "Warn for stack frames larger than (needs gcc 4.4)"
 	range 0 8192
-	default 3072 if KASAN_EXTRA
+	default 3072 if KASAN
 	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
 	default 1280 if (!64BIT && PARISC)
 	default 1024 if (!64BIT && !PARISC)
-- 
2.19.0

