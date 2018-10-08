Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33902ECDE2C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7532088F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7532088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeJHHqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 03:46:13 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:37360 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeJHHqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 03:46:13 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994248AbeJHAhHk-6vL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:07 +0200
Date:   Mon, 8 Oct 2018 01:37:07 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] MIPS: Correct `mmiowb' barrier for `wbflush' platforms
In-Reply-To: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810070303380.7757@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redefine `mmiowb' in terms of `iobarrier_w' so that it works correctly 
for MIPS I platforms, which have no SYNC machine instruction and use a 
call to `wbflush' instead.

This doesn't change the semantics for CONFIG_CPU_CAVIUM_OCTEON, because 
`iobarrier_w' expands to `wmb', which is ultimately the same as the 
current arrangement.  For MIPS I platforms this not only makes any code 
that would happen to use `mmiowb' build and run, but it actually 
enforces the ordering required as well, as `iobarrier_w' has it already 
covered with the use of `wmb'.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/include/asm/io.h |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

linux-mips-mmiowb.patch
Index: linux-20180930-3maxp/arch/mips/include/asm/io.h
===================================================================
--- linux-20180930-3maxp.orig/arch/mips/include/asm/io.h
+++ linux-20180930-3maxp/arch/mips/include/asm/io.h
@@ -91,6 +91,9 @@ static inline void set_io_port_base(unsi
 #define iobarrier_w() wmb()
 #define iobarrier_sync() iob()
 
+/* Some callers use this older API instead.  */
+#define mmiowb() iobarrier_w()
+
 /*
  * Thanks to James van Artsdalen for a better timing-fix than
  * the two short jumps: using outb's to a nonexistent port seems
@@ -573,14 +576,6 @@ BUILDSTRING(l, u32)
 BUILDSTRING(q, u64)
 #endif
 
-
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
-#define mmiowb() wmb()
-#else
-/* Depends on MIPS II instruction set */
-#define mmiowb() asm volatile ("sync" ::: "memory")
-#endif
-
 static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
 	memset((void __force *) addr, val, count);
