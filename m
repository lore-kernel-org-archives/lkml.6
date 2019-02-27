Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0ABC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31922084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbfB0JnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:43:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:33122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfB0JnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:43:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4D9FADFB;
        Wed, 27 Feb 2019 09:43:09 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2] MIPS: fix memory setup for platforms with PHYS_OFFSET != 0
Date:   Wed, 27 Feb 2019 10:42:56 +0100
Message-Id: <20190227094256.7658-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For platforms, which use a PHYS_OFFSET != 0, symbol _end also
contains that offset. So when calling memblock_reserve() for
reserving kernel the size argument needs to be adjusted.

Fixes: bcec54bf3118 ("mips: switch to NO_BOOTMEM")
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8c6c48ed786a..d2e5a5ad0e6f 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -384,7 +384,8 @@ static void __init bootmem_init(void)
 	init_initrd();
 	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
 
-	memblock_reserve(PHYS_OFFSET, reserved_end << PAGE_SHIFT);
+	memblock_reserve(PHYS_OFFSET,
+			 (reserved_end << PAGE_SHIFT) - PHYS_OFFSET);
 
 	/*
 	 * max_low_pfn is not a number of pages. The number of pages
-- 
2.13.7

