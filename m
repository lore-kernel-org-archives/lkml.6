Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B1AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114F421905
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358576;
	bh=7ztoFz+yTIgIiaByKok51CqSe+1UBYfyd6XyjTlX1pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y5aW4/vHnoDWIuUjpyZMZOHTtajqKbhpPh30fAbZx5g5JWLHo3sBzlHgOuOt7oph2
	 ugXAw35dn3Wl79AwZ7xxP317VDDaQtZwxrPStLjRhNIMjR6i4q3WShRR9T30wVavVU
	 AKbJoWevDtLJJ31TUaiiNxWoMX1onsqGrySKnwgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfAXTgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732477AbfAXTgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:36:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41EFC218FC;
        Thu, 24 Jan 2019 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358568;
        bh=7ztoFz+yTIgIiaByKok51CqSe+1UBYfyd6XyjTlX1pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3hwHA2fPZKhClfkqjoDXi2CZCh2T6BFZKD9LW5oihVfwRUgsdijNmY5QVfQ/n7+7
         TDhlT332xuMk1gHdOUyZHibGV06TShEgrZDBsDq0utqR6wZc/0LDge89LMKvKdGXe9
         jI9ZXi/WcH6AgPHPv0UW00CiOrh04aQPsoDIzHZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 053/106] arm64: kasan: Increase stack size for KASAN_EXTRA
Date:   Thu, 24 Jan 2019 20:20:10 +0100
Message-Id: <20190124190209.801341683@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6e8830674ea77f57d57a33cca09083b117a71f41 ]

If the kernel is configured with KASAN_EXTRA, the stack size is
increased significantly due to setting the GCC -fstack-reuse option to
"none" [1]. As a result, it can trigger a stack overrun quite often with
32k stack size compiled using GCC 8. For example, this reproducer

  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise06.c

can trigger a "corrupted stack end detected inside scheduler" very
reliably with CONFIG_SCHED_STACK_END_CHECK enabled. There are other
reports at:

  https://lore.kernel.org/lkml/1542144497.12945.29.camel@gmx.us/
  https://lore.kernel.org/lkml/721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us/

There are just too many functions that could have a large stack with
KASAN_EXTRA due to large local variables that have been called over and
over again without being able to reuse the stacks. Some noticiable ones
are,

size
7536 shrink_inactive_list
7440 shrink_page_list
6560 fscache_stats_show
3920 jbd2_journal_commit_transaction
3216 try_to_unmap_one
3072 migrate_page_move_mapping
3584 migrate_misplaced_transhuge_page
3920 ip_vs_lblcr_schedule
4304 lpfc_nvme_info_show
3888 lpfc_debugfs_nvmestat_data.constprop

There are other 49 functions over 2k in size while compiling kernel with
"-Wframe-larger-than=" on this machine. Hence, it is too much work to
change Makefiles for each object to compile without
-fsanitize-address-use-after-scope individually.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/memory.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..56562ff01076 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -76,12 +76,17 @@
 /*
  * KASAN requires 1/8th of the kernel virtual address space for the shadow
  * region. KASAN can bloat the stack significantly, so double the (minimum)
- * stack size when KASAN is in use.
+ * stack size when KASAN is in use, and then double it again if KASAN_EXTRA is
+ * on.
  */
 #ifdef CONFIG_KASAN
 #define KASAN_SHADOW_SCALE_SHIFT 3
 #define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
+#ifdef CONFIG_KASAN_EXTRA
+#define KASAN_THREAD_SHIFT	2
+#else
 #define KASAN_THREAD_SHIFT	1
+#endif /* CONFIG_KASAN_EXTRA */
 #else
 #define KASAN_SHADOW_SIZE	(0)
 #define KASAN_THREAD_SHIFT	0
-- 
2.19.1



