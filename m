Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C43CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA1B218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497516;
	bh=L8M+5IJoOEq18hgdKu9M+U9V/xVcKbGVFewY0k6TDZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GsXrL4rii3Y7ifLwDYSdXg1F/EUGcCLpDC9hzQeTtO0avGkaxeDZmJE13iDSS+elq
	 YZ2haCvf0OKgcXOlo65dbEYqe9St7TicvPUbT+lSsvgV4sQWJBlHDWeN6DyOkirtLc
	 bVaclAXnHu3vvUvJpdIGyw6jNV0k5KOj22h8OkOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfBRNpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731243AbfBRNpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09FD217F5;
        Mon, 18 Feb 2019 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497511;
        bh=L8M+5IJoOEq18hgdKu9M+U9V/xVcKbGVFewY0k6TDZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmDD/toKsGvNEfuDRwcLNn/MfEStEIUyFQr0Y5rdsPDcy+4IGZ3rTFooJuJOcFt8Y
         W8AnDJzixkSn9h10a5q5+SBrdLiLmneH5JmnMSDO3XeP4Xb2G0fchPfy6LVvvjI2y+
         CUGUjKdZ/PTg2iKCeujvishQqz3s4YrZIErXgMDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Lu Baoquan <lu.baoquan@intellif.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 14/92] csky: fixup CACHEV1 store instruction fast retire
Date:   Mon, 18 Feb 2019 14:42:17 +0100
Message-Id: <20190218133455.977184903@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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



