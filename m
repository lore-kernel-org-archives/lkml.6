Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E71DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCE72075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfBVSFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:05:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38178 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfBVSFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:05:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E010165C;
        Fri, 22 Feb 2019 10:05:05 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D9A23F5C1;
        Fri, 22 Feb 2019 10:05:03 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de,
        catalin.marinas@arm.com, geert@linux-m68k.org, palmer@sifive.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 3/3] arm64: io: Hook up __io_par() for inX() ordering
Date:   Fri, 22 Feb 2019 18:04:54 +0000
Message-Id: <20190222180454.5992-4-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190222180454.5992-1-will.deacon@arm.com>
References: <20190222180454.5992-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that inX() provides the same ordering guarantees as readX()
by hooking up __io_par() so that it maps directly to __iormb().

Reported-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index ee723835c1f4..8bb7210ac286 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -121,6 +121,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 		     : "memory");					\
 })
 
+#define __io_par(v)		__iormb(v)
 #define __iowmb()		wmb()
 
 #define mmiowb()		do { } while (0)
-- 
2.11.0

