Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ADCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA092081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895654;
	bh=hepuA9x5vf8MzH0/lhlK4Bb10SReS8VXED0zX66dIXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dEjDDIkiw2rzI35+KVQYn81xzY3DMlt3XoW73EGSjSeK+nhHig+xjEXCeraHTdbbC
	 WLZSaikfOWLDnLJv5Pegx9486VijwnwQVael64znWIxzOyouyndsF9xX0Dg0wMlSjl
	 h3sC/X3GvA4q2JhfH032yKNoBaqxBM3NUZzjb3bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfBKOeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbfBKOeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:34:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A29452081B;
        Mon, 11 Feb 2019 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895650;
        bh=hepuA9x5vf8MzH0/lhlK4Bb10SReS8VXED0zX66dIXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ychBdCNUGc5PwHVp3xTUdQW7CSU6eyCjTKvkvMtc7Bb074exRWtp3NKw1uleCdHeE
         6b8fcYsBjMo0MueKSjGwKkpcakCBFwBoDgHg2GOxbuPRaoL7zdfn+u7MiT8IGXPX1k
         CelMQ244YyA7tgxr4eeEf7WjutfUS6J7AjH9Tbqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 246/352] powerpc/fadump: Do not allow hot-remove memory from fadump reserved area.
Date:   Mon, 11 Feb 2019 15:17:53 +0100
Message-Id: <20190211141902.785114907@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit 0db6896ff6332ba694f1e61b93ae3b2640317633 ]

For fadump to work successfully there should not be any holes in reserved
memory ranges where kernel has asked firmware to move the content of old
kernel memory in event of crash. Now that fadump uses CMA for reserved
area, this memory area is now not protected from hot-remove operations
unless it is cma allocated. Hence, fadump service can fail to re-register
after the hot-remove operation, if hot-removed memory belongs to fadump
reserved region. To avoid this make sure that memory from fadump reserved
area is not hot-removable if fadump is registered.

However, if user still wants to remove that memory, he can do so by
manually stopping fadump service before hot-remove operation.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/fadump.h               |  2 +-
 arch/powerpc/kernel/fadump.c                    | 10 ++++++++--
 arch/powerpc/platforms/pseries/hotplug-memory.c |  7 +++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 1e7a33592e29..15bc07a31c46 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -200,7 +200,7 @@ struct fad_crash_memory_ranges {
 	unsigned long long	size;
 };
 
-extern int is_fadump_boot_memory_area(u64 addr, ulong size);
+extern int is_fadump_memory_area(u64 addr, ulong size);
 extern int early_init_dt_scan_fw_dump(unsigned long node,
 		const char *uname, int depth, void *data);
 extern int fadump_reserve_mem(void);
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 761b28b1427d..7fd9b3e1fa39 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -118,13 +118,19 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 
 /*
  * If fadump is registered, check if the memory provided
- * falls within boot memory area.
+ * falls within boot memory area and reserved memory area.
  */
-int is_fadump_boot_memory_area(u64 addr, ulong size)
+int is_fadump_memory_area(u64 addr, ulong size)
 {
+	u64 d_start = fw_dump.reserve_dump_area_start;
+	u64 d_end = d_start + fw_dump.reserve_dump_area_size;
+
 	if (!fw_dump.dump_registered)
 		return 0;
 
+	if (((addr + size) > d_start) && (addr <= d_end))
+		return 1;
+
 	return (addr + size) > RMA_START && addr <= fw_dump.boot_memory_size;
 }
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2a983b5a52e1..2318ab29d5dd 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -355,8 +355,11 @@ static bool lmb_is_removable(struct drmem_lmb *lmb)
 	phys_addr = lmb->base_addr;
 
 #ifdef CONFIG_FA_DUMP
-	/* Don't hot-remove memory that falls in fadump boot memory area */
-	if (is_fadump_boot_memory_area(phys_addr, block_sz))
+	/*
+	 * Don't hot-remove memory that falls in fadump boot memory area
+	 * and memory that is reserved for capturing old kernel memory.
+	 */
+	if (is_fadump_memory_area(phys_addr, block_sz))
 		return false;
 #endif
 
-- 
2.19.1



