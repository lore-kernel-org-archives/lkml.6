Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B970C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D5820868
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ7BL247"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D5820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbeKOIhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbeKOIaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:30:46 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B832222544;
        Wed, 14 Nov 2018 22:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234341;
        bh=6jmCeZQAb6F97TZbfELEkrwfVzp8kyyFM0LgbgnIT8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJ7BL247faWYoMbzzAOweieleP1J8sjV8dK4OUfvzePq5PUiPDf+FfVTs7H+SW35D
         zWjG6F+chs3Tosa8Hg4j0qJ11a+kNBdNF4pgWUvHE5w2CApTcJS3X+IRYce9hxsqUx
         KmUihcY5/RVZG6hJWLvQSlB2LFtflz/I83JZc3nw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 15/27] lib/raid6: Fix arm64 test build
Date:   Wed, 14 Nov 2018 17:25:04 -0500
Message-Id: <20181114222520.99926-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222520.99926-1-sashal@kernel.org>
References: <20181114222520.99926-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Linton <jeremy.linton@arm.com>

[ Upstream commit 313a06e636808387822af24c507cba92703568b1 ]

The lib/raid6/test fails to build the neon objects
on arm64 because the correct machine type is 'aarch64'.

Once this is correctly enabled, the neon recovery objects
need to be added to the build.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/raid6/test/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
index be1010bdc435..565a77220fae 100644
--- a/lib/raid6/test/Makefile
+++ b/lib/raid6/test/Makefile
@@ -27,7 +27,7 @@ ifeq ($(ARCH),arm)
         CFLAGS += -I../../../arch/arm/include -mfpu=neon
         HAS_NEON = yes
 endif
-ifeq ($(ARCH),arm64)
+ifeq ($(ARCH),aarch64)
         CFLAGS += -I../../../arch/arm64/include
         HAS_NEON = yes
 endif
@@ -41,7 +41,7 @@ ifeq ($(IS_X86),yes)
 		    gcc -c -x assembler - >&/dev/null &&        \
 		    rm ./-.o && echo -DCONFIG_AS_AVX512=1)
 else ifeq ($(HAS_NEON),yes)
-        OBJS   += neon.o neon1.o neon2.o neon4.o neon8.o
+        OBJS   += neon.o neon1.o neon2.o neon4.o neon8.o recov_neon.o recov_neon_inner.o
         CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
 else
         HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
-- 
2.17.1

