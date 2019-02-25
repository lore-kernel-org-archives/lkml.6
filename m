Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047DFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C2B20578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130545;
	bh=09r3L5PakHBEkH++zCurOY5pE9cTHt3+lGz3zNX6Eo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x7wUGRRsqLHARf6Si1Hk4nQmzgSfjexOWjxKGaRpfuiEB5IqmxF0z+KNqbWEnu7SQ
	 bcArCpdlBHw6J5/UiNzMgC7ap8LiyUbbJD5TuPJvEhGTLaLjvE6MnnyaTPpUUqRKU2
	 uTJyto1IA44CZRNrJVnp1V8T4aKQ0EF+zyI5+pVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbfBYVfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733026AbfBYVfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A001220578;
        Mon, 25 Feb 2019 21:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130540;
        bh=09r3L5PakHBEkH++zCurOY5pE9cTHt3+lGz3zNX6Eo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSWFdJx1DP4nIPNnJMtwzvoLjFv8lQWQVj2i1lVXkPKsoplHulMrNgbjj0XW3C3ws
         rcyZzHp8B7ZbK812m7eNLTTdvLxc6tmxGp1uCOaQAdYlZaqha1zHroPDHrk8cOOn3T
         Ck5yuf5/rsz5f4kAvR8lwwVzCYmQzGPRhlV23qBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.20 154/183] ARC: define ARCH_SLAB_MINALIGN = 8
Date:   Mon, 25 Feb 2019 22:12:07 +0100
Message-Id: <20190225195120.918996613@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Alexey Brodkin <abrodkin@synopsys.com>

commit b6835ea77729e7faf4656ca637ba53f42b8ee3fd upstream.

The default value of ARCH_SLAB_MINALIGN in "include/linux/slab.h" is
"__alignof__(unsigned long long)" which for ARC unexpectedly turns out
to be 4. This is not a compiler bug, but as defined by ARC ABI [1]

Thus slab allocator would allocate a struct which is 32-bit aligned,
which is generally OK even if struct has long long members.
There was however potetial problem when it had any atomic64_t which
use LLOCKD/SCONDD instructions which are required by ISA to take
64-bit addresses. This is the problem we ran into

[    4.015732] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
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
...
...
[    4.270510] Stack Trace:
[    4.274510]   ext4_delete_entry+0x13e/0x234
[    4.278695]   ext4_rmdir+0xe0/0x238
[    4.282187]   vfs_rmdir+0x50/0xf0
[    4.285492]   do_rmdir+0x9e/0x154
[    4.288802]   EV_Trap+0x110/0x114

The fix is to make sure slab allocations are 64-bit aligned.

Do note that atomic64_t is __attribute__((aligned(8)) which means gcc
does generate 64-bit aligned references, relative to beginning of
container struct. However the issue is if the container itself is not
64-bit aligned, atomic64_t ends up unaligned which is what this patch
ensures.

[1] https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/wiki/files/ARCv2_ABI.pdf

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: <stable@vger.kernel.org> # 4.8+
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[vgupta: reworked changelog, added dependency on LL64+LLSC]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/include/asm/cache.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -52,6 +52,17 @@
 #define cache_line_size()	SMP_CACHE_BYTES
 #define ARCH_DMA_MINALIGN	SMP_CACHE_BYTES
 
+/*
+ * Make sure slab-allocated buffers are 64-bit aligned when atomic64_t uses
+ * ARCv2 64-bit atomics (LLOCKD/SCONDD). This guarantess runtime 64-bit
+ * alignment for any atomic64_t embedded in buffer.
+ * Default ARCH_SLAB_MINALIGN is __alignof__(long long) which has a relaxed
+ * value of 4 (and not 8) in ARC ABI.
+ */
+#if defined(CONFIG_ARC_HAS_LL64) && defined(CONFIG_ARC_HAS_LLSC)
+#define ARCH_SLAB_MINALIGN	8
+#endif
+
 extern void arc_cache_init(void);
 extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
 extern void read_decode_cache_bcr(void);


