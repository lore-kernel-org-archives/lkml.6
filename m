Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B68C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D9B2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D9B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeKSRxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 12:53:14 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36391 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbeKSRxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 12:53:14 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C830DA98389A;
        Mon, 19 Nov 2018 15:30:24 +0800 (CST)
Received: from SZX1000429595.huawei.com (100.101.59.90) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Mon, 19 Nov 2018 15:30:17 +0800
From:   Rui Sun <sunrui26@huawei.com>
To:     <catalin.marinas@arm.com>
CC:     <will.deacon@arm.com>, <ard.biesheuvel@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Rui Sun" <sunrui26@huawei.com>
Subject: [PATCH] arm64:crc:accelerated-crc32-by-64bytes
Date:   Mon, 19 Nov 2018 15:29:20 +0800
Message-ID: <1542612560-10089-1-git-send-email-sunrui26@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.101.59.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add 64 bytes loop to acceleration calculation

Signed-off-by: Rui Sun <sunrui26@huawei.com>
---
 arch/arm64/lib/crc32.S | 54 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S
index 5bc1e85..2b37009 100644
--- a/arch/arm64/lib/crc32.S
+++ b/arch/arm64/lib/crc32.S
@@ -15,15 +15,61 @@
 	.cpu		generic+crc
 
 	.macro		__crc32, c
-0:	subs		x2, x2, #16
-	b.mi		8f
+
+64: cmp     x2, #64
+    b.lt    32f
+
+    adds    x11, x1, #16
+    adds    x12, x1, #32
+    adds    x13, x1, #48
+
+0 : subs    x2, x2, #64
+    b.mi    32f
+
+    ldp     x3, x4, [x1], #64
+    ldp     x5, x6, [x11], #64
+    ldp     x7, x8, [x12], #64
+    ldp     x9, x10,[x13], #64
+
+ CPU_BE( rev     x3, x3      )
+ CPU_BE( rev     x4, x4      )
+ CPU_BE( rev     x5, x5      )
+ CPU_BE( rev     x6, x6      )
+ CPU_BE( rev     x7, x7      )
+ CPU_BE( rev     x8, x8      )
+ CPU_BE( rev     x9, x9      )
+ CPU_BE( rev     x10,x10     )
+
+    crc32\c\()x w0, w0, x3
+    crc32\c\()x w0, w0, x4
+    crc32\c\()x w0, w0, x5
+    crc32\c\()x w0, w0, x6
+    crc32\c\()x w0, w0, x7
+    crc32\c\()x w0, w0, x8
+    crc32\c\()x w0, w0, x9
+    crc32\c\()x w0, w0, x10
+
+    b.ne       0b
+    ret
+
+32: tbz     x2, #5, 16f
+    ldp     x3, x4, [x1], #16
+    ldp     x5, x6, [x1], #16
+CPU_BE( rev     x3, x3      )
+CPU_BE( rev     x4, x4      )
+CPU_BE( rev     x5, x5      )
+CPU_BE( rev     x6, x6      )
+    crc32\c\()x w0, w0, x3
+    crc32\c\()x w0, w0, x4
+    crc32\c\()x w0, w0, x5
+    crc32\c\()x w0, w0, x6
+
+16: tbz     x2, #4, 8f
 	ldp		x3, x4, [x1], #16
 CPU_BE(	rev		x3, x3		)
 CPU_BE(	rev		x4, x4		)
 	crc32\c\()x	w0, w0, x3
 	crc32\c\()x	w0, w0, x4
-	b.ne		0b
-	ret
 
 8:	tbz		x2, #3, 4f
 	ldr		x3, [x1], #8
-- 
1.8.3.1

