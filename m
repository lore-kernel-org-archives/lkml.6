Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A382C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A96720827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546964828;
	bh=GnBTm+DeAfY68Ta9VlAGebfCzp0Ny1jRJ1P4AuotXPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LZTGhmWVAaag9ZjbaQKp2qi/OGLbRrpEvqotrvPZy+MngA8mcOcg3AN3vg0FwIE3D
	 T7M+/ELvO45eG0ZEtcHR2iNwTGqFANl8MRqNI6Iwuw+58NbQWqLUJbdEOyI7lvM+GA
	 uDVvlLTPoxmQD0p0i7fvBnz7QSWlklw3Y7rYMUzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfAHQ1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbfAHQ1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:27:05 -0500
Received: from localhost.localdomain (unknown [218.0.237.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4BC92171F;
        Tue,  8 Jan 2019 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546964824;
        bh=GnBTm+DeAfY68Ta9VlAGebfCzp0Ny1jRJ1P4AuotXPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djCln0PCaBSjTR1zoj/eW6jWwlQ03soI02jRdbtCtrjnhGM6BEYpxJ76d+SDzXtwN
         ESlNlW+CdbKCOTLNAXJMuz0b2C2yXtve5BTy1Fv4hsBOn7KQDSgRhGFVyVpCuZf53T
         h6BmQ2yU+KUBB/JKvlptZJHQEA2XrfJJ13ry/yLI=
From:   guoren@kernel.org
To:     tglx@linutronix.de, marc.zyngier@arm.com, arnd@arndb.de
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mhocko@kernel.org,
        torvalds@linux-foundation.org, linux@roeck-us.net,
        Guo Ren <ren_guo@c-sky.com>,
        Lu Baoquan <lu.baoquan@intellif.com>
Subject: [PATCH 3/5] csky: fixup CACHEV1 store instruction fast retire
Date:   Wed,  9 Jan 2019 00:26:36 +0800
Message-Id: <1546964798-30067-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546964798-30067-1-git-send-email-guoren@kernel.org>
References: <1546964798-30067-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

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
---
 arch/csky/include/asm/io.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index ecae6b3..c1dfa9c 100644
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
2.7.4

