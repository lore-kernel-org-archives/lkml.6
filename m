Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56809C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270BF20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270BF20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeJNXYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:24:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37007 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJNXYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:24:49 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiME-0004cZ-Rg; Sun, 14 Oct 2018 16:31:06 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLO-0000CX-Qz; Sun, 14 Oct 2018 16:30:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "Leonard Crestez" <leonard.crestez@nxp.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.842862920@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 050/366] crypto: arm,arm64 - Fix random regeneration
 of S_shipped
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Leonard Crestez <leonard.crestez@nxp.com>

commit 6aaf49b495b446ff6eec0ac983f781ca0dc56a73 upstream.

The decision to rebuild .S_shipped is made based on the relative
timestamps of .S_shipped and .pl files but git makes this essentially
random. This means that the perl script might run anyway (usually at
most once per checkout), defeating the whole purpose of _shipped.

Fix by skipping the rule unless explicit make variables are provided:
REGENERATE_ARM_CRYPTO or REGENERATE_ARM64_CRYPTO.

This can produce nasty occasional build failures downstream, for example
for toolchains with broken perl. The solution is minimally intrusive to
make it easier to push into stable.

Another report on a similar issue here: https://lkml.org/lkml/2018/3/8/1379

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[bwh: Backported to 3.16: Only arm has this problem]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -10,10 +10,12 @@ aes-arm-y	:= aes-armv4.o aes_glue.o
 aes-arm-bs-y	:= aesbs-core.o aesbs-glue.o
 sha1-arm-y	:= sha1-armv4-large.o sha1_glue.o
 
+ifdef REGENERATE_ARM_CRYPTO
 quiet_cmd_perl = PERL    $@
       cmd_perl = $(PERL) $(<) > $(@)
 
 $(src)/aesbs-core.S_shipped: $(src)/bsaes-armv7.pl
 	$(call cmd,perl)
+endif
 
 .PRECIOUS: $(obj)/aesbs-core.S

