Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39369C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4022085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4022085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeKFJhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:37:16 -0500
Received: from foss.arm.com ([217.140.101.70]:53540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbeKFJhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:37:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCA61A78;
        Mon,  5 Nov 2018 16:14:55 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F54C3F718;
        Mon,  5 Nov 2018 16:14:55 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthew.brown.dev@gmail.com, mpe@ellerman.id.au,
        ard.biesheuvel@linaro.org, arnd@arndb.de,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] lib/raid6: Fix arm64 test build
Date:   Mon,  5 Nov 2018 18:14:41 -0600
Message-Id: <20181106001441.42934-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lib/raid6/test fails to build the neon objects
on arm64 because the correct machine type is 'aarch64'.

Once this is correctly enabled, the neon recovery objects
need to be added to the build.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 lib/raid6/test/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
index 5d73f5cb4d8a..79777645cac9 100644
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
2.17.2

