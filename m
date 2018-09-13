Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB47C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F06620C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F06620C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeIMR6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:58:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47104 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeIMR6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:58:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB7047A9;
        Thu, 13 Sep 2018 05:48:40 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD25E3F575;
        Thu, 13 Sep 2018 05:48:37 -0700 (PDT)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
        yuanzhichang@hisilicon.com, dann.frazier@canonical.com,
        gabriele.paoloni@huawei.com, bhelgaas@google.com,
        andy.shevchenko@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        jean-philippe.brucker@arm.com
Subject: [PATCH] asm-generic: io: Fix ioport_map() for !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO
Date:   Thu, 13 Sep 2018 13:48:27 +0100
Message-Id: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
prevent users from making I/O accesses outside the expected I/O range -
however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
contradictory to its other users.

The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
mangling the given port rather than capping it.

We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
implementation of ioport_map by using the comparison operator and
returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
we don't break existing buggy drivers that somehow rely on this masking.

Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO hosts")
Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 include/asm-generic/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 66d1d45..d356f80 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1026,7 +1026,8 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
 #define ioport_map ioport_map
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
-	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
+	port &= IO_SPACE_LIMIT;
+	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
 }
 #endif
 
-- 
2.7.4

