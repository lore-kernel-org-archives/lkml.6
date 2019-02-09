Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED608C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3EB20643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738639;
	bh=59Vga8ht6ffSRgDIcUkB1REx/orLYMgBGQiMPWO+ESU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ydzdFvEulgjFUPulo5yJBSr6wbb0X0hCAaC3i0MUbDiJjxklEhHkrl5K6UOgJd7Jx
	 yzGcdPAkBUjKFrnWJdExqGOKna1HeV0FfsBx4Q3RcIyZydJzO0r5eqD7h9Z/oKQtM+
	 GwKAVVYef+xbv/JTKMfG7pJsg/KrsJQNfASrE6GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfBIS5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfBISrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A2AA2192B;
        Sat,  9 Feb 2019 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738067;
        bh=59Vga8ht6ffSRgDIcUkB1REx/orLYMgBGQiMPWO+ESU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHBO6l4gYncxDLRgbWYXGCn/WHqFJ6GoIHpYz86hJNW5vJpkK323sG7s5gcF0yKMd
         S3m3SwtFeeKfZ0Kg8ObbzcW5lKvYBo8p6zbf0wpC+p4yMhvryrKefUA81gQPQjiTF+
         yMoCjoqDQw9hfQkP/zHl766G8lsEa9AILaY0VXJY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>, Lu Baoquan <lu.baoquan@intellif.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 11/42] csky: fixup CACHEV1 store instruction fast retire
Date:   Sat,  9 Feb 2019 13:47:03 -0500
Message-Id: <20190209184734.125935-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

[ Upstream commit 96354ad79e2e59f9d620669c8e1ac2452440c260 ]

For I/O access, 810/807 store instruction fast retire will cause wrong
primitive. For example:

	stw (clear interrupt source)
	stw (unmask interrupt controller)
	enable interrupt

stw is fast retire instruction. When PC is run at enable interrupt
stage, the clear interrupt source hasn't finished. It will cause another
wrong irq-enter.

So use mb() to prevent above.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Lu Baoquan <lu.baoquan@intellif.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/include/asm/io.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index ecae6b358f95..c1dfa9c10e36 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -15,6 +15,31 @@ extern void iounmap(void *addr);
 extern int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
 		size_t size, unsigned long flags);
 
+/*
+ * I/O memory access primitives. Reads are ordered relative to any
+ * following Normal memory access. Writes are ordered relative to any prior
+ * Normal memory access.
+ *
+ * For CACHEV1 (807, 810), store instruction could fast retire, so we need
+ * another mb() to prevent st fast retire.
+ *
+ * For CACHEV2 (860), store instruction with PAGE_ATTR_NO_BUFFERABLE won't
+ * fast retire.
+ */
+#define readb(c)		({ u8  __v = readb_relaxed(c); rmb(); __v; })
+#define readw(c)		({ u16 __v = readw_relaxed(c); rmb(); __v; })
+#define readl(c)		({ u32 __v = readl_relaxed(c); rmb(); __v; })
+
+#ifdef CONFIG_CPU_HAS_CACHEV2
+#define writeb(v,c)		({ wmb(); writeb_relaxed((v),(c)); })
+#define writew(v,c)		({ wmb(); writew_relaxed((v),(c)); })
+#define writel(v,c)		({ wmb(); writel_relaxed((v),(c)); })
+#else
+#define writeb(v,c)		({ wmb(); writeb_relaxed((v),(c)); mb(); })
+#define writew(v,c)		({ wmb(); writew_relaxed((v),(c)); mb(); })
+#define writel(v,c)		({ wmb(); writel_relaxed((v),(c)); mb(); })
+#endif
+
 #define ioremap_nocache(phy, sz)	ioremap(phy, sz)
 #define ioremap_wc ioremap_nocache
 #define ioremap_wt ioremap_nocache
-- 
2.19.1

