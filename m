Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2D0ECDE2B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53402086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53402086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeJHHqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 03:46:08 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:37360 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeJHHqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 03:46:07 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994427AbeJHAhBnNEAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:01 +0200
Date:   Mon, 8 Oct 2018 01:37:01 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] MIPS: Define MMIO ordering barriers
In-Reply-To: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810070232470.7757@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define MMIO ordering barriers as separate operations so as to allow 
making places where such a barrier is required distinct from places 
where a memory or a DMA barrier is needed.

Architecturally MIPS does not specify ordering requirements for uncached 
bus accesses such as MMIO operations normally use and therefore explicit 
barriers have to be inserted between MMIO accesses where unspecified 
ordering of operations would cause unpredictable results.

MIPS MMIO ordering barriers are implemented using the same underlying 
mechanism that memory or a DMA barrier ordering barriers use, that is 
either a suitable SYNC instruction or a platform-specific `wbflush' 
call.  However platforms may implement different ordering rules for 
different kinds of bus activity, so having a separate API makes it 
possible to remove unnecessary barriers and avoid a performance hit they 
may cause due to unrelated bus activity by making their implementation 
expand to nil while keeping the necessary ones.

Also having distinct barriers for each kind of use makes it easier for 
the reader to understand what code has been intended to do.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/include/asm/io.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

linux-mips-iobarrier.patch
Index: linux-20180930-3maxp/arch/mips/include/asm/io.h
===================================================================
--- linux-20180930-3maxp.orig/arch/mips/include/asm/io.h
+++ linux-20180930-3maxp/arch/mips/include/asm/io.h
@@ -20,6 +20,7 @@
 #include <linux/irqflags.h>
 
 #include <asm/addrspace.h>
+#include <asm/barrier.h>
 #include <asm/bug.h>
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
@@ -80,6 +81,17 @@ static inline void set_io_port_base(unsi
 }
 
 /*
+ * Enforce in-order execution of data I/O.  In the MIPS architecture
+ * these are equivalent to corresponding platform-specific memory
+ * barriers defined in <asm/barrier.h>.  API pinched from PowerPC,
+ * with sync additionally defined.
+ */
+#define iobarrier_rw() mb()
+#define iobarrier_r() rmb()
+#define iobarrier_w() wmb()
+#define iobarrier_sync() iob()
+
+/*
  * Thanks to James van Artsdalen for a better timing-fix than
  * the two short jumps: using outb's to a nonexistent port seems
  * to guarantee better timings even on fast machines.
