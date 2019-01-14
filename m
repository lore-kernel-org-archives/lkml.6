Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFCCC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3299208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ipyBJTYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfANPRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:17:08 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:44828 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:17:06 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 761EA24E2195;
        Mon, 14 Jan 2019 07:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547479025; bh=FXq38szj8Yhe2iCzIxf8yiFpQOX80RR9QkVsExfPfUA=;
        h=From:To:Cc:Subject:Date:From;
        b=ipyBJTYZB3OmjH1veZj5Nc/+1N1SLIDUqh7Zsv1kEkCXjmPA09JONmRxVWxoYgopB
         sbUfhQYjXav9nCcvslEQw+Icqk0D/t8nugNfshrEzvZDTwhMNMgm7erUkUPaMzUi5F
         ELCwyI5+qyHXJPlpQHMUSanxR4SyFHwXoRROfa0JoxoukRQa1kL8c0ydRv8IJ/qMD/
         WP3U8guzvieYFRfIrf0GeD2qFUwvTunY4ZtCHMHy47cq/snzGRbXdOW/gAgHcyVAVQ
         nouRiJ+Kv20NEQAZDTXmrPN7lEogDRbIpmHSTUgb0iM6ke6nEFQfeFP7o9dDEubiIo
         OBKlPgHyTfQgg==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 148BA58AE;
        Mon, 14 Jan 2019 07:17:03 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/2] ARCv2: LIB: memeset: fix doing prefetchw outside of buffer
Date:   Mon, 14 Jan 2019 18:16:48 +0300
Message-Id: <20190114151649.32726-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current ARCv2 memeset implementation may call 'prefetchw'
instruction for address which lies outside of memset area.
So we got one modified (dirty) cache line outside of memset
area. This may lead to data corruption if this area is used
for DMA IO.

Another issue is that current ARCv2 memeset implementation
may call 'prealloc' instruction for L1 cache line which
doesn't fully belongs to memeset area in case of 128B L1 D$
line length. That leads to data corruption.

Fix prefetchw/prealloc instructions using in case of 64B L1 data
cache line (default case) and don't use prefetch* instructions
for other possible L1 data cache line lengths (32B and 128B).

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/lib/memset-archs.S | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arc/lib/memset-archs.S b/arch/arc/lib/memset-archs.S
index 62ad4bcb841a..c7717832336f 100644
--- a/arch/arc/lib/memset-archs.S
+++ b/arch/arc/lib/memset-archs.S
@@ -7,11 +7,32 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/cache.h>
 
 #undef PREALLOC_NOT_AVAIL
 
+/*
+ * The memset implementation below is optimized to use prefetchw and prealloc
+ * instruction in case of CPU with 64B L1 data cache line (L1_CACHE_SHIFT == 6)
+ * If you want to implement optimized memset for other possible L1 data cache
+ * line lengths (32B and 128B) you should rewrite code carefully checking
+ * we don't call any prefetchw/prealloc instruction for L1 cache lines which
+ * don't belongs to memset area.
+ */
+#if L1_CACHE_SHIFT!=6
+# define PREALLOC_INSTR(...)
+# define PREFETCHW_INSTR(...)
+#else  /* L1_CACHE_SHIFT!=6 */
+# define PREFETCHW_INSTR(...)	prefetchw __VA_ARGS__
+# ifdef PREALLOC_NOT_AVAIL
+#  define PREALLOC_INSTR(...)	prefetchw __VA_ARGS__
+# else
+#  define PREALLOC_INSTR(...)	prealloc __VA_ARGS__
+# endif
+#endif /* L1_CACHE_SHIFT!=6 */
+
 ENTRY_CFI(memset)
-	prefetchw [r0]		; Prefetch the write location
+	PREFETCHW_INSTR([r0])	; Prefetch the first write location
 	mov.f	0, r2
 ;;; if size is zero
 	jz.d	[blink]
@@ -48,11 +69,7 @@ ENTRY_CFI(memset)
 
 	lpnz	@.Lset64bytes
 	;; LOOP START
-#ifdef PREALLOC_NOT_AVAIL
-	prefetchw [r3, 64]	;Prefetch the next write location
-#else
-	prealloc  [r3, 64]
-#endif
+	PREALLOC_INSTR([r3, 64]) ;Prefetch the next write location
 #ifdef CONFIG_ARC_HAS_LL64
 	std.ab	r4, [r3, 8]
 	std.ab	r4, [r3, 8]
@@ -85,7 +102,6 @@ ENTRY_CFI(memset)
 	lsr.f	lp_count, r2, 5 ;Last remaining  max 124 bytes
 	lpnz	.Lset32bytes
 	;; LOOP START
-	prefetchw   [r3, 32]	;Prefetch the next write location
 #ifdef CONFIG_ARC_HAS_LL64
 	std.ab	r4, [r3, 8]
 	std.ab	r4, [r3, 8]
-- 
2.14.5

