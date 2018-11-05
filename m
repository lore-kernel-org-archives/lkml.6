Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23430C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1542085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aLrBRQ2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1542085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbeKFHdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:33:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbeKFHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SeRzingOFXeZOwwC0D35GfUZzAaTsr9AihvjeXksgo4=; b=aLrBRQ2S365qjvJPEIvPDrGXn
        5vj9BcZC3iAyw8va0b4BqIBK7XQcZ8GXth9Nvme7kiM24JtBbbjpemF4nr7KQUWdEJMP7KmJlC18K
        1alN0vEPgr2tG5wKMNDMWAlMkpxMfiV5MjJr6ngX+kGfzo/n3xLLBGwr4Hv07TGhEbtQGe/CHPf2e
        r/3g5QvYH11dNFp1xkuir0Y2iiN8rBkBwmRnZg1eXsdNfoRScQa2ZEaM9//BafvGp/GKgvn++2HqO
        Nnwmg7HSKK3bokIOouQwxhPguaaebLzIKpFIKEM+Xs6toUGmqxdmNuMdiv3LoO7/8zJ/MtvTYT+t6
        10seqJw0A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJn5d-0008Il-Iy; Mon, 05 Nov 2018 22:11:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] fls: Change parameter to unsigned int
Date:   Mon,  5 Nov 2018 14:11:17 -0800
Message-Id: <20181105221117.31828-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing in userspace, UBSAN pointed out that shifting into the sign
bit is undefined behaviour.  It doesn't really make sense to ask for the
highest set bit of a negative value, so just turn the argument type into
an unsigned int.

Some architectures (eg ppc) already had it declared as an unsigned int,
so I don't expect too many problems.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 arch/alpha/include/asm/bitops.h          | 4 ++--
 arch/arc/include/asm/bitops.h            | 4 ++--
 arch/c6x/include/asm/bitops.h            | 2 +-
 arch/csky/include/asm/bitops.h           | 2 +-
 arch/hexagon/include/asm/bitops.h        | 2 +-
 arch/ia64/include/asm/bitops.h           | 3 +--
 arch/m68k/include/asm/bitops.h           | 2 +-
 arch/mips/include/asm/bitops.h           | 2 +-
 arch/openrisc/include/asm/bitops/fls.h   | 2 +-
 arch/parisc/include/asm/bitops.h         | 2 +-
 arch/s390/include/asm/bitops.h           | 4 ++--
 arch/unicore32/include/asm/bitops.h      | 2 +-
 arch/x86/include/asm/bitops.h            | 2 +-
 include/asm-generic/bitops/builtin-fls.h | 2 +-
 include/asm-generic/bitops/fls.h         | 2 +-
 tools/include/asm-generic/bitops/fls.h   | 2 +-
 16 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index ca43f4d0b937..5adca78830b5 100644
--- a/arch/alpha/include/asm/bitops.h
+++ b/arch/alpha/include/asm/bitops.h
@@ -391,9 +391,9 @@ static inline unsigned long __fls(unsigned long x)
 	return fls64(x) - 1;
 }
 
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
-	return fls64((unsigned int) x);
+	return fls64(x);
 }
 
 /*
diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 8da87feec59a..ee9246184033 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -278,7 +278,7 @@ static inline __attribute__ ((const)) int clz(unsigned int x)
 	return res;
 }
 
-static inline int constant_fls(int x)
+static inline int constant_fls(unsigned int x)
 {
 	int r = 32;
 
@@ -312,7 +312,7 @@ static inline int constant_fls(int x)
  * @result: [1-32]
  * fls(1) = 1, fls(0x80000000) = 32, fls(0) = 0
  */
-static inline __attribute__ ((const)) int fls(unsigned long x)
+static inline __attribute__ ((const)) int fls(unsigned int x)
 {
 	if (__builtin_constant_p(x))
 	       return constant_fls(x);
diff --git a/arch/c6x/include/asm/bitops.h b/arch/c6x/include/asm/bitops.h
index f0ab012401b6..8b68234ace18 100644
--- a/arch/c6x/include/asm/bitops.h
+++ b/arch/c6x/include/asm/bitops.h
@@ -54,7 +54,7 @@ static inline unsigned long __ffs(unsigned long x)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	if (!x)
 		return 0;
diff --git a/arch/csky/include/asm/bitops.h b/arch/csky/include/asm/bitops.h
index 335f2883fb1e..43b9838bff63 100644
--- a/arch/csky/include/asm/bitops.h
+++ b/arch/csky/include/asm/bitops.h
@@ -40,7 +40,7 @@ static __always_inline unsigned long __ffs(unsigned long x)
 /*
  * asm-generic/bitops/fls.h
  */
-static __always_inline int fls(int x)
+static __always_inline int fls(unsigned int x)
 {
 	asm volatile(
 		"ff1 %0\n"
diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 2691a1857d20..bee974262387 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -211,7 +211,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	int r;
 
diff --git a/arch/ia64/include/asm/bitops.h b/arch/ia64/include/asm/bitops.h
index 56a774bf13fa..2f24ee6459d2 100644
--- a/arch/ia64/include/asm/bitops.h
+++ b/arch/ia64/include/asm/bitops.h
@@ -388,8 +388,7 @@ ia64_fls (unsigned long x)
  * Find the last (most significant) bit set.  Returns 0 for x==0 and
  * bits are numbered from 1..32 (e.g., fls(9) == 4).
  */
-static inline int
-fls (int t)
+static inline int fls(unsigned int t)
 {
 	unsigned long x = t & 0xffffffffu;
 
diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index d979f38af751..10133a968c8e 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -502,7 +502,7 @@ static inline unsigned long __ffs(unsigned long x)
 /*
  *	fls: find last bit set.
  */
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	int cnt;
 
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index da1b8718861e..997263921a26 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -541,7 +541,7 @@ static inline unsigned long __ffs(unsigned long word)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	int r;
 
diff --git a/arch/openrisc/include/asm/bitops/fls.h b/arch/openrisc/include/asm/bitops/fls.h
index 9efbf9ad86c4..57de5a1115bf 100644
--- a/arch/openrisc/include/asm/bitops/fls.h
+++ b/arch/openrisc/include/asm/bitops/fls.h
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_OPENRISC_HAVE_INST_FL1
 
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	int ret;
 
diff --git a/arch/parisc/include/asm/bitops.h b/arch/parisc/include/asm/bitops.h
index 53252d4f9a57..a09eaebfdfd0 100644
--- a/arch/parisc/include/asm/bitops.h
+++ b/arch/parisc/include/asm/bitops.h
@@ -188,7 +188,7 @@ static __inline__ int ffs(int x)
  * fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
 
-static __inline__ int fls(int x)
+static __inline__ int fls(unsigned int x)
 {
 	int ret;
 	if (!x)
diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 86e5b2fdee3c..d1f8a4d94cca 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -397,9 +397,9 @@ static inline int fls64(unsigned long word)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(int word)
+static inline int fls(unsigned int word)
 {
-	return fls64((unsigned int)word);
+	return fls64(word);
 }
 
 #else /* CONFIG_HAVE_MARCH_Z9_109_FEATURES */
diff --git a/arch/unicore32/include/asm/bitops.h b/arch/unicore32/include/asm/bitops.h
index c0cbdbe17168..de5853761c22 100644
--- a/arch/unicore32/include/asm/bitops.h
+++ b/arch/unicore32/include/asm/bitops.h
@@ -22,7 +22,7 @@
  * the cntlz instruction for much better code efficiency.
  */
 
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	int ret;
 
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 124f9195eb3e..ad7b210aa3f6 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -448,7 +448,7 @@ static __always_inline int ffs(int x)
  * set bit if value is nonzero. The last (most significant) bit is
  * at position 32.
  */
-static __always_inline int fls(int x)
+static __always_inline int fls(unsigned int x)
 {
 	int r;
 
diff --git a/include/asm-generic/bitops/builtin-fls.h b/include/asm-generic/bitops/builtin-fls.h
index 62daf940989d..c8455cc28841 100644
--- a/include/asm-generic/bitops/builtin-fls.h
+++ b/include/asm-generic/bitops/builtin-fls.h
@@ -9,7 +9,7 @@
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static __always_inline int fls(int x)
+static __always_inline int fls(unsigned int x)
 {
 	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
 }
diff --git a/include/asm-generic/bitops/fls.h b/include/asm-generic/bitops/fls.h
index 753aecaab641..b168bb10e1be 100644
--- a/include/asm-generic/bitops/fls.h
+++ b/include/asm-generic/bitops/fls.h
@@ -10,7 +10,7 @@
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
 
-static __always_inline int fls(int x)
+static __always_inline int fls(unsigned int x)
 {
 	int r = 32;
 
diff --git a/tools/include/asm-generic/bitops/fls.h b/tools/include/asm-generic/bitops/fls.h
index 753aecaab641..b168bb10e1be 100644
--- a/tools/include/asm-generic/bitops/fls.h
+++ b/tools/include/asm-generic/bitops/fls.h
@@ -10,7 +10,7 @@
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
 
-static __always_inline int fls(int x)
+static __always_inline int fls(unsigned int x)
 {
 	int r = 32;
 
-- 
2.19.1

