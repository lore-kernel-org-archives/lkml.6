Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3279C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18FD208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18FD208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbeHAKpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:45:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23042 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388250AbeHAKpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:45:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41gS2f3lCxz9ttgC;
        Wed,  1 Aug 2018 11:00:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lbW2n5fb1_rO; Wed,  1 Aug 2018 11:00:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41gS2f1Xyzz9ttg5;
        Wed,  1 Aug 2018 11:00:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C139F8B831;
        Wed,  1 Aug 2018 11:01:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MMu0JUqgXpw6; Wed,  1 Aug 2018 11:01:10 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A50CC8B756;
        Wed,  1 Aug 2018 11:01:10 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 808697120B; Wed,  1 Aug 2018 09:01:10 +0000 (UTC)
Message-Id: <b3d7b6cdb89a48be06a2630bf0d762d9d17d931f.1531511429.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 1/4] selftests/powerpc: add test for 32 bits memcmp
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  1 Aug 2018 09:01:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames memcmp test to memcmp_64 and adds
a memcmp_32 test for testing the 32 bits version of memcmp()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v8: rebased on latest powerpc/merge
 v7: no change
 v6: no change
 v5: no change
 v4: new

 tools/testing/selftests/powerpc/stringloops/Makefile    | 14 +++++++++++---
 tools/testing/selftests/powerpc/stringloops/memcmp_32.S |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)
 create mode 120000 tools/testing/selftests/powerpc/stringloops/memcmp_32.S

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index c60c6172dd3c..3862256c2b7d 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -1,10 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0
 # The loops are all 64-bit code
-CFLAGS += -m64 -maltivec
 CFLAGS += -I$(CURDIR)
 
-TEST_GEN_PROGS := memcmp
-EXTRA_SOURCES := memcmp_64.S ../harness.c
+EXTRA_SOURCES := ../harness.c
+
+$(OUTPUT)/memcmp_64: memcmp.c
+$(OUTPUT)/memcmp_64: CFLAGS += -m64 -maltivec
+
+$(OUTPUT)/memcmp_32: memcmp.c
+$(OUTPUT)/memcmp_32: CFLAGS += -m32
+
+ASFLAGS = $(CFLAGS)
+
+TEST_GEN_PROGS := memcmp_32 memcmp_64
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp_32.S b/tools/testing/selftests/powerpc/stringloops/memcmp_32.S
new file mode 120000
index 000000000000..056f2b3af789
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/memcmp_32.S
@@ -0,0 +1 @@
+../../../../../arch/powerpc/lib/memcmp_32.S
\ No newline at end of file
-- 
2.13.3

