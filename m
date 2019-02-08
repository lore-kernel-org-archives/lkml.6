Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA9FC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EABC21919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NsxINz1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfBHKz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:55:28 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:52248 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHKz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:55:28 -0500
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id D544424E2154;
        Fri,  8 Feb 2019 02:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549623327; bh=/ImxSKSZVi6jhe3QHM/0C4FbQEYs2kGVpoNld2Ojpi4=;
        h=From:To:Cc:Subject:Date:From;
        b=NsxINz1pSDVNa76CLEpo58yxM2l0AIVGG2rQq0EyBxZK+BylAhWxccrJM7gT1CuGj
         qUm1AxKIjMpnR1hffqj8a+1evNmhR+HfmLi4Q/BCF3AUeLtgfSlv2zcHbsYzB9daXg
         8p9PZ6BgmVBP4nHzYjRea4/l5EKYNTFboToN2uz8tILReOq0xn1F8+URPbi3UnT8ON
         asB9BddKRJo4Qz0eMPoxo56wpQl0dB1B9C41bnSQLtWCdgNzxq4U4o0qF4pDkqcbEw
         VfP2vZW/16QJ3h5CNhr+TFkcZs3wekqTAWCZHZLqDkajA3sox/mb9J0/cQ3tvsntUu
         rP+lLJEfPFcrA==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6E662A005A;
        Fri,  8 Feb 2019 10:55:25 +0000 (UTC)
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        stable@vger.kernel.org
Subject: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Date:   Fri,  8 Feb 2019 13:55:19 +0300
Message-Id: <20190208105519.26750-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default ARCH_SLAB_MINALIGN is defined in "include/linux/slab.h" as
"__alignof__(unsigned long long)" which looks fine but not for ARC.

ARC tools ABI sets align of "long long" the same as for "long" = 4
instead of 8 one may think of.

Thus slab allocator may easily allocate a buffer which is 32-bit aligned.
And most of the time it's OK until we start dealing with 64-bit atomics
with special LLOCKD/SCONDD instructions which (as opposed to their 32-bit
counterparts LLOCK/SCOND) operate with full 64-bit words but those words
must be 64-bit aligned.

Fixes Ext4 folder removal:
--------------------->8-------------------
[    4.015732] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
[    4.167881]
[    4.167881] Misaligned Access
[    4.172356] Path: /bin/busybox.nosuid
[    4.176004] CPU: 2 PID: 171 Comm: rm Not tainted 4.19.14-yocto-standard #1
[    4.182851]
[    4.182851] [ECR   ]: 0x000d0000 => Check Programmer's Manual
[    4.190061] [EFA   ]: 0xbeaec3fc
[    4.190061] [BLINK ]: ext4_delete_entry+0x210/0x234
[    4.190061] [ERET  ]: ext4_delete_entry+0x13e/0x234
[    4.202985] [STAT32]: 0x80080002 : IE K
[    4.207236] BTA: 0x9009329c   SP: 0xbe5b1ec4  FP: 0x00000000
[    4.212790] LPS: 0x9074b118  LPE: 0x9074b120 LPC: 0x00000000
[    4.218348] r00: 0x00000040  r01: 0x00000021 r02: 0x00000001
[    4.218348] r03: 0x00000000  r04: 0x00000002 r05: 0x00000000
[    4.218348] r06: 0x000000c6  r07: 0x00000000 r08: 0x9050f140
[    4.218348] r09: 0x000000c6  r10: 0x0000000a r11: 0x00000000
[    4.218348] r12: 0x90247a9c  r13: 0x9004e574 r14: 0x0008e150
[    4.218348] r15: 0x000989b8  r16: 0x0008cbec r17: 0x0009806c
[    4.218348] r18: 0x0009806c  r19: 0x0008e150 r20: 0x0008f0f8
[    4.218348] r21: 0x000000ab  r22: 0x0008f0f8 r23: 0x00000000
[    4.218348] r24: 0x00000000  r25: 0x00000000
[    4.218348]
[    4.218348]
[    4.270510]
[    4.270510] Stack Trace:
[    4.274510]   ext4_delete_entry+0x13e/0x234
[    4.278695]   ext4_rmdir+0xe0/0x238
[    4.282187]   vfs_rmdir+0x50/0xf0
[    4.285492]   do_rmdir+0x9e/0x154
[    4.288802]   EV_Trap+0x110/0x114
--------------------->8-------------------

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: <stable@vger.kernel.org> # 4.8+
---
 arch/arc/include/asm/cache.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index f393b663413e..74f8fcaaef5c 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -52,6 +52,16 @@
 #define cache_line_size()	SMP_CACHE_BYTES
 #define ARCH_DMA_MINALIGN	SMP_CACHE_BYTES
 
+/*
+ * Make sure slab-allocated buffers are 64-bit aligned.
+ * This is required for llockd/scondd to deal with 64-bit aligned dwords.
+ * By default ARCH_SLAB_MINALIGN is __alignof__(long long) which in
+ * case of ARC is 4 instead of 8!
+ */
+#ifdef CONFIG_ARC_HAS_LL64
+#define ARCH_SLAB_MINALIGN	8
+#endif
+
 extern void arc_cache_init(void);
 extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
 extern void read_decode_cache_bcr(void);
-- 
2.16.2

