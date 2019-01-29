Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501A8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E66820882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762481;
	bh=D/AkT5HBQ0+Te2TPqbXz/C80+hFhL0/CRO/ttymw4ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P66+uW5LLVqhUst9XeOgmWl5DEFg5WHFZFbuIBRt9W3TeDNNCUhCvmuDoVPCBzuD4
	 MmQskAmejBM963Uo4xYqRaHms1mQKnSzS/NQPFD2BD2OnzRHnA1dAMnH3UMB59WJBJ
	 zSjj0VAxQ5mAi7EFDfzuYpD2CRYknEovjsPUMK/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfA2Lr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731249AbfA2Lr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39712086C;
        Tue, 29 Jan 2019 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762475;
        bh=D/AkT5HBQ0+Te2TPqbXz/C80+hFhL0/CRO/ttymw4ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYMei2LS3Vm+2bBRUJVo8EesRSgQuqlTLFOvo0fWlQtc4Y6hSSOB2Mogd0hDzML/F
         UON/mjGPKUHw2iT40WN8DNW5bUqy8FGPvsvYEH3kI7dUFpedXsUou5xGephwwB0k6F
         T+Xy+lhqHUOE+0JxllLX1mejBF2QWUhRokGdNJ7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.14 18/68] ARCv2: lib: memeset: fix doing prefetchw outside of buffer
Date:   Tue, 29 Jan 2019 12:35:40 +0100
Message-Id: <20190129113133.145596929@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

commit e6a72b7daeeb521753803550f0ed711152bb2555 upstream.

ARCv2 optimized memset uses PREFETCHW instruction for prefetching the
next cache line but doesn't ensure that the line is not past the end of
the buffer. PRETECHW changes the line ownership and marks it dirty,
which can cause issues in SMP config when next line was already owned by
other core. Fix the issue by avoiding the PREFETCHW

Some more details:

The current code has 3 logical loops (ignroing the unaligned part)
  (a) Big loop for doing aligned 64 bytes per iteration with PREALLOC
  (b) Loop for 32 x 2 bytes with PREFETCHW
  (c) any left over bytes

loop (a) was already eliding the last 64 bytes, so PREALLOC was
safe. The fix was removing PREFETCW from (b).

Another potential issue (applicable to configs with 32 or 128 byte L1
cache line) is that PREALLOC assumes 64 byte cache line and may not do
the right thing specially for 32b. While it would be easy to adapt,
there are no known configs with those lie sizes, so for now, just
compile out PREALLOC in such cases.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: stable@vger.kernel.org #4.4+
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[vgupta: rewrote changelog, used asm .macro vs. "C" macro]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/lib/memset-archs.S |   40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

--- a/arch/arc/lib/memset-archs.S
+++ b/arch/arc/lib/memset-archs.S
@@ -7,11 +7,39 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/cache.h>
 
-#undef PREALLOC_NOT_AVAIL
+/*
+ * The memset implementation below is optimized to use prefetchw and prealloc
+ * instruction in case of CPU with 64B L1 data cache line (L1_CACHE_SHIFT == 6)
+ * If you want to implement optimized memset for other possible L1 data cache
+ * line lengths (32B and 128B) you should rewrite code carefully checking
+ * we don't call any prefetchw/prealloc instruction for L1 cache lines which
+ * don't belongs to memset area.
+ */
+
+#if L1_CACHE_SHIFT == 6
+
+.macro PREALLOC_INSTR	reg, off
+	prealloc	[\reg, \off]
+.endm
+
+.macro PREFETCHW_INSTR	reg, off
+	prefetchw	[\reg, \off]
+.endm
+
+#else
+
+.macro PREALLOC_INSTR
+.endm
+
+.macro PREFETCHW_INSTR
+.endm
+
+#endif
 
 ENTRY_CFI(memset)
-	prefetchw [r0]		; Prefetch the write location
+	PREFETCHW_INSTR	r0, 0	; Prefetch the first write location
 	mov.f	0, r2
 ;;; if size is zero
 	jz.d	[blink]
@@ -48,11 +76,8 @@ ENTRY_CFI(memset)
 
 	lpnz	@.Lset64bytes
 	;; LOOP START
-#ifdef PREALLOC_NOT_AVAIL
-	prefetchw [r3, 64]	;Prefetch the next write location
-#else
-	prealloc  [r3, 64]
-#endif
+	PREALLOC_INSTR	r3, 64	; alloc next line w/o fetching
+
 #ifdef CONFIG_ARC_HAS_LL64
 	std.ab	r4, [r3, 8]
 	std.ab	r4, [r3, 8]
@@ -85,7 +110,6 @@ ENTRY_CFI(memset)
 	lsr.f	lp_count, r2, 5 ;Last remaining  max 124 bytes
 	lpnz	.Lset32bytes
 	;; LOOP START
-	prefetchw   [r3, 32]	;Prefetch the next write location
 #ifdef CONFIG_ARC_HAS_LL64
 	std.ab	r4, [r3, 8]
 	std.ab	r4, [r3, 8]


