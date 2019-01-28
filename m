Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF5CC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9B020989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696180;
	bh=QO0Z/ugaU9XCwato60uHHqSOeQSYOYfR4+uT1EqhkAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pHL+EaBBsdtEURJV6WJb2XHEtOCuO0iKhq5lZl/SCCfJM6o0/vKpLY45C7y0dWhNV
	 CV3kddkJJIcs9HHBjn4ajNqpvYxWrn7FOYbtBSpl1hAFcmasPyohnXhFXMwOxdEr4W
	 vEpl8ZKGFdCXr4PGaJLUAn4OBd8mX3p2BdI/4Mi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbfA1RW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:22:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731322AbfA1QDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:03:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E14821916;
        Mon, 28 Jan 2019 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691389;
        bh=QO0Z/ugaU9XCwato60uHHqSOeQSYOYfR4+uT1EqhkAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vs55CTczDUyEYtt+ljqGKHYcLWD1nuzNNCz7E/lAKUjZ2ia7YoX8uinpqmJMsM0UE
         e6Kx/HvttimreOdoh67MRda7JJ08r+ZAWd//UT93UKNeqTqJeOvxBmyeKb7rg7e/lG
         BLpyBpVgwavlUmsAKuYbJo3h/mXyjRc7qBwIPJek=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 077/258] arm64: io: Ensure calls to delay routines are ordered against prior readX()
Date:   Mon, 28 Jan 2019 10:56:23 -0500
Message-Id: <20190128155924.51521-77-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 6460d32014717686d3b7963595950ba2c6d1bb5e ]

A relatively standard idiom for ensuring that a pair of MMIO writes to a
device arrive at that device with a specified minimum delay between them
is as follows:

	writel_relaxed(42, dev_base + CTL1);
	readl(dev_base + CTL1);
	udelay(10);
	writel_relaxed(42, dev_base + CTL2);

the intention being that the read-back from the device will push the
prior write to CTL1, and the udelay will hold up the write to CTL1 until
at least 10us have elapsed.

Unfortunately, on arm64 where the underlying delay loop is implemented
as a read of the architected counter, the CPU does not guarantee
ordering from the readl() to the delay loop and therefore the delay loop
could in theory be speculated and not provide the desired interval
between the two writes.

Fix this in a similar manner to PowerPC by introducing a dummy control
dependency on the output of readX() which, combined with the ISB in the
read of the architected counter, guarantees that a subsequent delay loop
can not be executed until the readX() has returned its result.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/io.h | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 35b2e50f17fb..b2bc7dbc1fa6 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -106,7 +106,22 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 }
 
 /* IO barriers */
-#define __iormb()		rmb()
+#define __iormb(v)							\
+({									\
+	unsigned long tmp;						\
+									\
+	rmb();								\
+									\
+	/*								\
+	 * Create a dummy control dependency from the IO read to any	\
+	 * later instructions. This ensures that a subsequent call to	\
+	 * udelay() will be ordered due to the ISB in get_cycles().	\
+	 */								\
+	asm volatile("eor	%0, %1, %1\n"				\
+		     "cbnz	%0, ."					\
+		     : "=r" (tmp) : "r" (v) : "memory");		\
+})
+
 #define __iowmb()		wmb()
 
 #define mmiowb()		do { } while (0)
@@ -131,10 +146,10 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * following Normal memory access. Writes are ordered relative to any prior
  * Normal memory access.
  */
-#define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
-#define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
-#define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(); __v; })
-#define readq(c)		({ u64 __v = readq_relaxed(c); __iormb(); __v; })
+#define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
+#define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(__v); __v; })
+#define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(__v); __v; })
+#define readq(c)		({ u64 __v = readq_relaxed(c); __iormb(__v); __v; })
 
 #define writeb(v,c)		({ __iowmb(); writeb_relaxed((v),(c)); })
 #define writew(v,c)		({ __iowmb(); writew_relaxed((v),(c)); })
@@ -185,9 +200,9 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 /*
  * io{read,write}{16,32,64}be() macros
  */
-#define ioread16be(p)		({ __u16 __v = be16_to_cpu((__force __be16)__raw_readw(p)); __iormb(); __v; })
-#define ioread32be(p)		({ __u32 __v = be32_to_cpu((__force __be32)__raw_readl(p)); __iormb(); __v; })
-#define ioread64be(p)		({ __u64 __v = be64_to_cpu((__force __be64)__raw_readq(p)); __iormb(); __v; })
+#define ioread16be(p)		({ __u16 __v = be16_to_cpu((__force __be16)__raw_readw(p)); __iormb(__v); __v; })
+#define ioread32be(p)		({ __u32 __v = be32_to_cpu((__force __be32)__raw_readl(p)); __iormb(__v); __v; })
+#define ioread64be(p)		({ __u64 __v = be64_to_cpu((__force __be64)__raw_readq(p)); __iormb(__v); __v; })
 
 #define iowrite16be(v,p)	({ __iowmb(); __raw_writew((__force __u16)cpu_to_be16(v), p); })
 #define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
-- 
2.19.1

