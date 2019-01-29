Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943B1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A4720881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="C/vu+DhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfA2Ktu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:49:50 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:43320 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2Kts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:49:48 -0500
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 53EEB24E1EDF;
        Tue, 29 Jan 2019 02:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548758988; bh=mouU16pCIcH5sqT/DTD5iHNFBk1TiYPGBPqoc02eNy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/vu+DhVumFDwX7dn3D4JgIldudgdoVA0pWuFVb8c8Dwgj/73n9Zzs9Kb1cq9GBhO
         +/1mjzlLquBmWRPUlo/I7bgtwX42Oee0WjIy5JQgrpud+ohPMkkJWyyv4d4ANoF9Lw
         9zBJCC6xBOmvwNfcghRdhpByLGxO+kvbFHXyo7X+J8/nAneRiFJqj7xkZCP2muf7ZR
         w5G7h0N09G41WZ+2JQTi7Oke0sE2F58gJXcqTaLsjvray2s44FG7IzU7gfE6wU9l/K
         g3pS0a0QL3EQaVc8R/TYcNx1CG9ctQQdfLzZIpB0XKMUVRsaJNDKHQfhZXuEZFCAd1
         gITnijuVaYe/w==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.46])
        by mailhost.synopsys.com (Postfix) with ESMTP id F1818A00AA;
        Tue, 29 Jan 2019 10:49:46 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 1/5] ARCv2: lib: memcpy: fix doing prefetchw outside of buffer
Date:   Tue, 29 Jan 2019 13:49:38 +0300
Message-Id: <20190129104942.31705-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
References: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCv2 optimized memcpy uses PREFETCHW instruction for prefetching the
next cache line but doesn't ensure that the line is not past the end of
the buffer. PRETECHW changes the line ownership and marks it dirty,
which can cause data corruption if this area is used for DMA IO.

Fix the issue by avoiding the PREFETCHW. This leads to performance
degradation but it is OK as we'll introduce new memcpy implementation
optimized for unaligned memory access using.

We also cut off all PREFETCH instructions at they are quite useless
according to benchmark.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/lib/memcpy-archs.S | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arc/lib/memcpy-archs.S b/arch/arc/lib/memcpy-archs.S
index d61044dd8b58..ea14b0bf3116 100644
--- a/arch/arc/lib/memcpy-archs.S
+++ b/arch/arc/lib/memcpy-archs.S
@@ -25,15 +25,11 @@
 #endif
 
 #ifdef CONFIG_ARC_HAS_LL64
-# define PREFETCH_READ(RX)	prefetch    [RX, 56]
-# define PREFETCH_WRITE(RX)	prefetchw   [RX, 64]
 # define LOADX(DST,RX)		ldd.ab	DST, [RX, 8]
 # define STOREX(SRC,RX)		std.ab	SRC, [RX, 8]
 # define ZOLSHFT		5
 # define ZOLAND			0x1F
 #else
-# define PREFETCH_READ(RX)	prefetch    [RX, 28]
-# define PREFETCH_WRITE(RX)	prefetchw   [RX, 32]
 # define LOADX(DST,RX)		ld.ab	DST, [RX, 4]
 # define STOREX(SRC,RX)		st.ab	SRC, [RX, 4]
 # define ZOLSHFT		4
@@ -41,8 +37,6 @@
 #endif
 
 ENTRY_CFI(memcpy)
-	prefetch [r1]		; Prefetch the read location
-	prefetchw [r0]		; Prefetch the write location
 	mov.f	0, r2
 ;;; if size is zero
 	jz.d	[blink]
@@ -72,8 +66,6 @@ ENTRY_CFI(memcpy)
 	lpnz	@.Lcopy32_64bytes
 	;; LOOP START
 	LOADX (r6, r1)
-	PREFETCH_READ (r1)
-	PREFETCH_WRITE (r3)
 	LOADX (r8, r1)
 	LOADX (r10, r1)
 	LOADX (r4, r1)
@@ -117,9 +109,7 @@ ENTRY_CFI(memcpy)
 	lpnz	@.Lcopy8bytes_1
 	;; LOOP START
 	ld.ab	r6, [r1, 4]
-	prefetch [r1, 28]	;Prefetch the next read location
 	ld.ab	r8, [r1,4]
-	prefetchw [r3, 32]	;Prefetch the next write location
 
 	SHIFT_1	(r7, r6, 24)
 	or	r7, r7, r5
@@ -162,9 +152,7 @@ ENTRY_CFI(memcpy)
 	lpnz	@.Lcopy8bytes_2
 	;; LOOP START
 	ld.ab	r6, [r1, 4]
-	prefetch [r1, 28]	;Prefetch the next read location
 	ld.ab	r8, [r1,4]
-	prefetchw [r3, 32]	;Prefetch the next write location
 
 	SHIFT_1	(r7, r6, 16)
 	or	r7, r7, r5
@@ -204,9 +192,7 @@ ENTRY_CFI(memcpy)
 	lpnz	@.Lcopy8bytes_3
 	;; LOOP START
 	ld.ab	r6, [r1, 4]
-	prefetch [r1, 28]	;Prefetch the next read location
 	ld.ab	r8, [r1,4]
-	prefetchw [r3, 32]	;Prefetch the next write location
 
 	SHIFT_1	(r7, r6, 8)
 	or	r7, r7, r5
-- 
2.14.5

