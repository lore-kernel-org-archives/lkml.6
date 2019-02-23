Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD36C10F0B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39A720651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956432;
	bh=nKG708QBKM0+6yRFPdKGiz7MoaKf/KM311QfwB7Fk9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cAmdtknzKb/0Z+ACvC8IzGt5sBYh9psZa7xS37FKuyzY5MIxQ0zoTIpu6hio34BMT
	 wY0qliVP/USiUyT8vqY4pueGEV/Qw0NwSvQrfZ+caq236fxiKEnOw+Ne6e5JCCuN8d
	 9r2wyitVw1z5KnjAbHPBaYKkJzRTC0L4mMBO39uQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfBWVLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:11:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbfBWVLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD512085A;
        Sat, 23 Feb 2019 21:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956284;
        bh=nKG708QBKM0+6yRFPdKGiz7MoaKf/KM311QfwB7Fk9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jmpe8+tXERdcoAQPDCHUjozaVA4YLKEmXCX4uJlT/ZAtWwhKZBGp7EBzawG1gMpJk
         SCTtf9jZi39189smU4IR1/vYN7w5KYWjcz83QBbqdk1b9l+7RSpJTAWYVLAyzuNszX
         +kaqZKrGEp4F4nDoDnF0OAd7aQYr1nVLtrZA4z5E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 21/26] x86_64: increase stack size for KASAN_EXTRA
Date:   Sat, 23 Feb 2019 16:10:42 -0500
Message-Id: <20190223211047.202725-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211047.202725-1-sashal@kernel.org>
References: <20190223211047.202725-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit a8e911d13540487942d53137c156bd7707f66e5d ]

If the kernel is configured with KASAN_EXTRA, the stack size is
increasted significantly because this option sets "-fstack-reuse" to
"none" in GCC [1].  As a result, it triggers stack overrun quite often
with 32k stack size compiled using GCC 8.  For example, this reproducer

  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise06.c

triggers a "corrupted stack end detected inside scheduler" very reliably
with CONFIG_SCHED_STACK_END_CHECK enabled.

There are just too many functions that could have a large stack with
KASAN_EXTRA due to large local variables that have been called over and
over again without being able to reuse the stacks.  Some noticiable ones
are

  size
  7648 shrink_page_list
  3584 xfs_rmap_convert
  3312 migrate_page_move_mapping
  3312 dev_ethtool
  3200 migrate_misplaced_transhuge_page
  3168 copy_process

There are other 49 functions are over 2k in size while compiling kernel
with "-Wframe-larger-than=" even with a related minimal config on this
machine.  Hence, it is too much work to change Makefiles for each object
to compile without "-fsanitize-address-use-after-scope" individually.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23

Although there is a patch in GCC 9 to help the situation, GCC 9 probably
won't be released in a few months and then it probably take another
6-month to 1-year for all major distros to include it as a default.
Hence, the stack usage with KASAN_EXTRA can be revisited again in 2020
when GCC 9 is everywhere.  Until then, this patch will help users avoid
stack overrun.

This has already been fixed for arm64 for the same reason via
6e8830674ea ("arm64: kasan: Increase stack size for KASAN_EXTRA").

Link: http://lkml.kernel.org/r/20190109215209.2903-1-cai@lca.pw
Signed-off-by: Qian Cai <cai@lca.pw>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/page_64_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 4928cf0d5af0f..fb1251946b45e 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -2,7 +2,11 @@
 #define _ASM_X86_PAGE_64_DEFS_H
 
 #ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_EXTRA
+#define KASAN_STACK_ORDER 2
+#else
 #define KASAN_STACK_ORDER 1
+#endif
 #else
 #define KASAN_STACK_ORDER 0
 #endif
-- 
2.19.1

