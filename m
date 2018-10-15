Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1356C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D2221502
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D2221502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJPBnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:43:43 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54728 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbeJPBng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:43:36 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gC77D-0002IK-Pi; Mon, 15 Oct 2018 11:57:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gC779-0002Mg-AI; Mon, 15 Oct 2018 11:57:11 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Russell King <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Philip Derrin <philip@cog.systems>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Date:   Mon, 15 Oct 2018 11:56:59 -0600
Message-Id: <20181015175702.9036-4-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181015175702.9036-1-logang@deltatee.com>
References: <20181015175702.9036-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, sbates@raithlin.com, palmer@sifive.com, aou@eecs.berkeley.edu, hch@lst.de, akpm@linux-foundation.org, arnd@arndb.de, logang@deltatee.com, linux@armlinux.org.uk, keescook@chromium.org, philip@cog.systems, rostedt@goodmis.org, nicolas.pitre@linaro.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 3/6] ARM: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the arm_memory_present() function seeing it's very
similar to other arches.

The new memblocks_present() helper checks for node ids which the
arm version did not. However, this is equivalent seeing
HAVE_MEMBLOCK_NODE_MAP should be false in this arch and therefore
memblock_get_region_node() should return 0.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Philip Derrin <philip@cog.systems>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mm/init.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 0cc8e04295a4..e2710dd7446f 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -201,21 +201,6 @@ int pfn_valid(unsigned long pfn)
 EXPORT_SYMBOL(pfn_valid);
 #endif
 
-#ifndef CONFIG_SPARSEMEM
-static void __init arm_memory_present(void)
-{
-}
-#else
-static void __init arm_memory_present(void)
-{
-	struct memblock_region *reg;
-
-	for_each_memblock(memory, reg)
-		memory_present(0, memblock_region_memory_base_pfn(reg),
-			       memblock_region_memory_end_pfn(reg));
-}
-#endif
-
 static bool arm_memblock_steal_permitted = true;
 
 phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
@@ -317,7 +302,7 @@ void __init bootmem_init(void)
 	 * Sparsemem tries to allocate bootmem in memory_present(),
 	 * so must be done after the fixed reservations
 	 */
-	arm_memory_present();
+	memblocks_present();
 
 	/*
 	 * sparse_init() needs the bootmem allocator up and running.
-- 
2.19.0

