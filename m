Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4E1ECDE2D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBCE2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBCE2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeJHHqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 03:46:22 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:37360 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeJHHqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 03:46:22 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994541AbeJHAhQNouZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:16 +0200
Date:   Mon, 8 Oct 2018 01:37:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] MIPS: Enforce strong ordering for MMIO accessors
In-Reply-To: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810070307160.7757@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architecturally the MIPS ISA does not specify ordering requirements for 
uncached bus accesses such as MMIO operations normally use and therefore 
explicit barriers have to be inserted between MMIO accesses where 
unspecified ordering of operations would cause unpredictable results.

For example the R2020 write buffer implements write gathering and 
combining[1] and as used with the DECstation models 2100 and 3100 for 
MMIO accesses it bypasses the read buffer entirely, because conflicts 
are resolved by the memory controller for DRAM accesses only[2] (NB the 
R2020 and R3020 buffers are the same except for the maximum clock rate).

Consequently if a device has say a 16-bit control register at offset 0, 
a 16-bit event mask register at offset 2 and a 16-bit reset register at 
offset 4, and the initial value of the control register is 0x1111, then 
in the absence of barriers a hypothetical code sequence like this:

u16 init_dev(u16 __iomem *dev);
	u16 x;

	write16(dev + 2, 0xffff);
	write16(dev + 0, 0x2222);
	x = read16(dev + 0);
	write16(dev + 1, 0x3333);
	write16(dev + 0, 0x4444);

	return x;
}

will return 0x1111 and issue a single 32-bit write of 0x33334444 (in the 
little-endian bus configuration) to offset 0 on the system bus.

This is because the read to set `x' from offset 0 bypasses the write of 
0x2222 that is still in the write buffer pending the completion of the 
write of 0xffff to the reset register.  Then the write of 0x3333 to the 
event mask register is merged with the preceding write to the control 
register as they share the same word address, making it a 32-bit write 
of 0x33332222 to offset 0.  Finally the write of 0x4444 to the control 
register is combined with the outstanding 32-bit write of 0x33332222 to 
offset 0, because, again, it shares the same address.

This is an example from a legacy system, given here because it is well 
documented and affects a machine we actually support.  But likewise 
modern MIPS systems may implement weak MMIO ordering, possibly even 
without having it clearly documented except for being compliant with the 
architecture specification with respect to the currently defined SYNC 
instruction variants[3].

Considering the above and that we are required to implement MMIO 
accessors such that individual accesses made with them are strongly 
ordered with respect to each other[4], add the necessary barriers to our 
`inX', `outX', `readX' and `writeX' handlers, as well the associated 
special use variants.  It's up to platforms then to possibly define the 
respective barriers so as to expand to nil if no ordering enforcement is 
actually needed for a given system; SYNC is supposed to be as cheap as 
a NOP on strongly ordered MIPS implementations though.

Retain the option to generate weakly-ordered accessors, so that the 
arrangement for `war_io_reorder_wmb' is not lost in case we need it for 
fully raw accessors in the future.  The reason for this is that it is 
unclear from commit 1e820da3c9af ("MIPS: Loongson-3: Introduce 
CONFIG_LOONGSON3_ENHANCEMENT") and especially commit 8faca49a6731 
("MIPS: Modify core io.h macros to account for the Octeon Errata 
Core-301.") why they are needed there under the previous assumption that 
these accessors can be weakly ordered.

References:

[1] "LR3020 Write Buffer", LSI Logic Corporation, September 1988, 
    Section "Byte Gathering", pp. 6-7

[2] "DECstation 3100 Desktop Workstation Functional Specification", 
    Digital Equipment Corporation, Revision 1.3, August 28, 1990, 
    Section 6.1 "Processor", p. 4

[3] "MIPS Architecture For Programmers, Volume II-A: The MIPS32 
    Instruction Set Manual", Imagination Technologies LTD, Document 
    Number: MD00086, Revision 6.06, December 15, 2016, Table 5.5 
    "Encodings of the Bits[10:6] of the SYNC instruction; the SType 
    Field", p. 409

[4] "LINUX KERNEL MEMORY BARRIERS", Documentation/memory-barriers.txt, 
    Section "KERNEL I/O BARRIER EFFECTS"

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
References: 8faca49a6731 ("MIPS: Modify core io.h macros to account for the Octeon Errata Core-301.")
References: 1e820da3c9af ("MIPS: Loongson-3: Introduce CONFIG_LOONGSON3_ENHANCEMENT")
---
 arch/mips/include/asm/io.h |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

linux-mips-readx-writex-barrier.patch
Index: linux-20180930-3maxp/arch/mips/include/asm/io.h
===================================================================
--- linux-20180930-3maxp.orig/arch/mips/include/asm/io.h
+++ linux-20180930-3maxp/arch/mips/include/asm/io.h
@@ -337,7 +337,7 @@ static inline void iounmap(const volatil
 #define war_io_reorder_wmb()		barrier()
 #endif
 
-#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq)			\
+#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, barrier, irq)		\
 									\
 static inline void pfx##write##bwlq(type val,				\
 				    volatile void __iomem *mem)		\
@@ -345,7 +345,10 @@ static inline void pfx##write##bwlq(type
 	volatile type *__mem;						\
 	type __val;							\
 									\
-	war_io_reorder_wmb();					\
+	if (barrier)							\
+		iobarrier_rw();						\
+	else								\
+		war_io_reorder_wmb();					\
 									\
 	__mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
 									\
@@ -382,6 +385,9 @@ static inline type pfx##read##bwlq(const
 									\
 	__mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
 									\
+	if (barrier)							\
+		iobarrier_rw();						\
+									\
 	if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long)) \
 		__val = *__mem;						\
 	else if (cpu_has_64bits) {					\
@@ -409,14 +415,17 @@ static inline type pfx##read##bwlq(const
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p, slow)			\
+#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, barrier, p, slow)		\
 									\
 static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 {									\
 	volatile type *__addr;						\
 	type __val;							\
 									\
-	war_io_reorder_wmb();					\
+	if (barrier)							\
+		iobarrier_rw();						\
+	else								\
+		war_io_reorder_wmb();					\
 									\
 	__addr = (void *)__swizzle_addr_##bwlq(mips_io_port_base + port); \
 									\
@@ -438,6 +447,9 @@ static inline type pfx##in##bwlq##p(unsi
 									\
 	BUILD_BUG_ON(sizeof(type) > sizeof(unsigned long));		\
 									\
+	if (barrier)							\
+		iobarrier_rw();						\
+									\
 	__val = *__addr;						\
 	slow;								\
 									\
@@ -448,7 +460,7 @@ static inline type pfx##in##bwlq##p(unsi
 
 #define __BUILD_MEMORY_PFX(bus, bwlq, type)				\
 									\
-__BUILD_MEMORY_SINGLE(bus, bwlq, type, 1)
+__BUILD_MEMORY_SINGLE(bus, bwlq, type, 1, 1)
 
 #define BUILDIO_MEM(bwlq, type)						\
 									\
@@ -462,8 +474,8 @@ BUILDIO_MEM(l, u32)
 BUILDIO_MEM(q, u64)
 
 #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)			\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, _p, SLOW_DOWN_IO)
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, ,)			\
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, _p, SLOW_DOWN_IO)
 
 #define BUILDIO_IOPORT(bwlq, type)					\
 	__BUILD_IOPORT_PFX(, bwlq, type)				\
@@ -478,7 +490,7 @@ BUILDIO_IOPORT(q, u64)
 
 #define __BUILDIO(bwlq, type)						\
 									\
-__BUILD_MEMORY_SINGLE(____raw_, bwlq, type, 0)
+__BUILD_MEMORY_SINGLE(____raw_, bwlq, type, 1, 0)
 
 __BUILDIO(q, u64)
 
