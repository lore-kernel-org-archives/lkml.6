Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA214C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3D920700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760316;
	bh=bVdnAZuC9zpBJqGFcs2av9P/pemb+R9HXCnfEHXFCvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2GPR+iFTjUSlWarZJ+qcn2Vht0BDHuEGRmad2S8T95HU2wyQ6ZegTLfT4P2wqmZPh
	 8rNZcgPJQ5Xe/rRX8XHpY0LoCC4pvwD/hwtv7gVuHBsQh4gKHKMD5W0mnZblAq0Evi
	 sIbi2O05AhR/gxlPSCSjIC6GnEK8EKwY8NnmqyyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfBUOnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbfBUOnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:43:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A36462075A;
        Thu, 21 Feb 2019 14:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760183;
        bh=bVdnAZuC9zpBJqGFcs2av9P/pemb+R9HXCnfEHXFCvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOonzcU5g8cjdQc6S+dNWuIT4vCdRj1SN77tTtwPgRn0lxQm3lwKST32RI0Fht9+8
         TibQ7h6JpQWhU3jJCrjRlzuKgNNTg38uylnVpkZlIS+CmTE9DiGx4Q1lhHz9LVWotc
         +zqGeLlYE4PJOSNH7b/gyiAadcpZ3/lHgr+cTCAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 22/32] arm64, mm, efi: Account for GICv3 LPI tables in static memblock reserve table
Date:   Thu, 21 Feb 2019 15:36:10 +0100
Message-Id: <20190221125252.203198615@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit 8a5b403d71affa098009cc3dff1b2c45113021ad upstream.

In the irqchip and EFI code, we have what basically amounts to a quirk
to work around a peculiarity in the GICv3 architecture, which permits
the system memory address of LPI tables to be programmable only once
after a CPU reset. This means kexec kernels must use the same memory
as the first kernel, and thus ensure that this memory has not been
given out for other purposes by the time the ITS init code runs, which
is not very early for secondary CPUs.

On systems with many CPUs, these reservations could overflow the
memblock reservation table, and this was addressed in commit:

  eff896288872 ("efi/arm: Defer persistent reservations until after paging_init()")

However, this turns out to have made things worse, since the allocation
of page tables and heap space for the resized memblock reservation table
itself may overwrite the regions we are attempting to reserve, which may
cause all kinds of corruption, also considering that the ITS will still
be poking bits into that memory in response to incoming MSIs.

So instead, let's grow the static memblock reservation table on such
systems so it can accommodate these reservations at an earlier time.
This will permit us to revert the above commit in a subsequent patch.

[ mingo: Minor cleanups. ]

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190215123333.21209-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[ ardb: Double the size of the slack to account for the lack of an
        optimization that was introduced in mainline after the release
        of v4.20. ]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/memory.h | 11 +++++++++++
 include/linux/memblock.h        |  3 ---
 mm/memblock.c                   | 11 +++++++++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 778af0b7f7fd5..c67081301035f 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -303,6 +303,17 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_addr_valid(kaddr)		(_virt_addr_is_linear(kaddr) && \
 					 _virt_addr_valid(kaddr))
 
+/*
+ * Given that the GIC architecture permits ITS implementations that can only be
+ * configured with a LPI table address once, GICv3 systems with many CPUs may
+ * end up reserving a lot of different regions after a kexec for their LPI
+ * tables (one per CPU), as we are forced to reuse the same memory after kexec
+ * (and thus reserve it persistently with EFI beforehand)
+ */
+#if defined(CONFIG_EFI) && defined(CONFIG_ARM_GIC_V3_ITS)
+# define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + 2*(NR_CPUS + 1))
+#endif
+
 #include <asm-generic/memory_model.h>
 
 #endif
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 3ef3086ed52f9..ecff64ff365d4 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -29,9 +29,6 @@ extern unsigned long max_pfn;
  */
 extern unsigned long long max_possible_pfn;
 
-#define INIT_MEMBLOCK_REGIONS	128
-#define INIT_PHYSMEM_REGIONS	4
-
 /**
  * enum memblock_flags - definition of memory region attributes
  * @MEMBLOCK_NONE: no special request
diff --git a/mm/memblock.c b/mm/memblock.c
index f45a049532fea..74ac4f89018ab 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -26,6 +26,13 @@
 
 #include "internal.h"
 
+#define INIT_MEMBLOCK_REGIONS			128
+#define INIT_PHYSMEM_REGIONS			4
+
+#ifndef INIT_MEMBLOCK_RESERVED_REGIONS
+# define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
+#endif
+
 /**
  * DOC: memblock overview
  *
@@ -92,7 +99,7 @@ unsigned long max_pfn;
 unsigned long long max_possible_pfn;
 
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
-static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
+static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS] __initdata_memblock;
 #endif
@@ -105,7 +112,7 @@ struct memblock memblock __initdata_memblock = {
 
 	.reserved.regions	= memblock_reserved_init_regions,
 	.reserved.cnt		= 1,	/* empty dummy entry */
-	.reserved.max		= INIT_MEMBLOCK_REGIONS,
+	.reserved.max		= INIT_MEMBLOCK_RESERVED_REGIONS,
 	.reserved.name		= "reserved",
 
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
-- 
2.19.1



