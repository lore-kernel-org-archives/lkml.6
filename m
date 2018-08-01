Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAAEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5572083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5572083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436603AbeHAT0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:26:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390538AbeHATSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BDAB9F06;
        Wed,  1 Aug 2018 16:55:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 051/336] powerpc/lib: Adjust .balign inside string functions for PPC32
Date:   Wed,  1 Aug 2018 18:46:26 +0200
Message-Id: <20180801165031.030505241@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 1128bb7813a896bd608fb622eee3c26aaf33b473 ]

commit 87a156fb18fe1 ("Align hot loops of some string functions")
degraded the performance of string functions by adding useless
nops

A simple benchmark on an 8xx calling 100000x a memchr() that
matches the first byte runs in 41668 TB ticks before this patch
and in 35986 TB ticks after this patch. So this gives an
improvement of approx 10%

Another benchmark doing the same with a memchr() matching the 128th
byte runs in 1011365 TB ticks before this patch and 1005682 TB ticks
after this patch, so regardless on the number of loops, removing
those useless nops improves the test by 5683 TB ticks.

Fixes: 87a156fb18fe1 ("Align hot loops of some string functions")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/cache.h |    3 +++
 arch/powerpc/lib/string.S        |    7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -9,11 +9,14 @@
 #if defined(CONFIG_PPC_8xx) || defined(CONFIG_403GCX)
 #define L1_CACHE_SHIFT		4
 #define MAX_COPY_PREFETCH	1
+#define IFETCH_ALIGN_SHIFT	2
 #elif defined(CONFIG_PPC_E500MC)
 #define L1_CACHE_SHIFT		6
 #define MAX_COPY_PREFETCH	4
+#define IFETCH_ALIGN_SHIFT	3
 #elif defined(CONFIG_PPC32)
 #define MAX_COPY_PREFETCH	4
+#define IFETCH_ALIGN_SHIFT	3	/* 603 fetches 2 insn at a time */
 #if defined(CONFIG_PPC_47x)
 #define L1_CACHE_SHIFT		7
 #else
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -12,6 +12,7 @@
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
+#include <asm/cache.h>
 
 	.text
 	
@@ -23,7 +24,7 @@ _GLOBAL(strncpy)
 	mtctr	r5
 	addi	r6,r3,-1
 	addi	r4,r4,-1
-	.balign 16
+	.balign IFETCH_ALIGN_BYTES
 1:	lbzu	r0,1(r4)
 	cmpwi	0,r0,0
 	stbu	r0,1(r6)
@@ -43,7 +44,7 @@ _GLOBAL(strncmp)
 	mtctr	r5
 	addi	r5,r3,-1
 	addi	r4,r4,-1
-	.balign 16
+	.balign IFETCH_ALIGN_BYTES
 1:	lbzu	r3,1(r5)
 	cmpwi	1,r3,0
 	lbzu	r0,1(r4)
@@ -77,7 +78,7 @@ _GLOBAL(memchr)
 	beq-	2f
 	mtctr	r5
 	addi	r3,r3,-1
-	.balign 16
+	.balign IFETCH_ALIGN_BYTES
 1:	lbzu	r0,1(r3)
 	cmpw	0,r0,r4
 	bdnzf	2,1b


