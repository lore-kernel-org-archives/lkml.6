Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431E0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F93621B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbfBKRpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:45:53 -0500
Received: from foss.arm.com ([217.140.101.70]:54876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730177AbfBKRpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:45:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C63F15AD;
        Mon, 11 Feb 2019 09:45:51 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 684783F675;
        Mon, 11 Feb 2019 09:45:50 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de,
        catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/2] asm-generic/io: Pass result on inX() accessor to __io_par()
Date:   Mon, 11 Feb 2019 17:45:43 +0000
Message-Id: <20190211174544.4302-2-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190211174544.4302-1-will.deacon@arm.com>
References: <20190211174544.4302-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inX() I/O accessors must enforce ordering against subsequent calls
to the delay() routines, so that a read-back from a device can be used
to postpone a subsequent write to the same device.

On some architectures, including arm64, this ordering can only be
achieved by creating a dependency on the value returned by the inX()
operation, so we need to pass the value we read to the __io_par()
macro in this case.

Reported-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d356f802945a..b5737c0d8316 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -65,7 +65,7 @@
 #endif
 
 #ifndef __io_par
-#define __io_par()     __io_ar()
+#define __io_par(v)     __io_ar()
 #endif
 
 
@@ -471,7 +471,7 @@ static inline u8 inb(unsigned long addr)
 
 	__io_pbr();
 	val = __raw_readb(PCI_IOBASE + addr);
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
@@ -484,7 +484,7 @@ static inline u16 inw(unsigned long addr)
 
 	__io_pbr();
 	val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
@@ -497,7 +497,7 @@ static inline u32 inl(unsigned long addr)
 
 	__io_pbr();
 	val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
-- 
2.11.0

