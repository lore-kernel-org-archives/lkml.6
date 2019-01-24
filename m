Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF98C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F064020663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358915;
	bh=UTQ9QzF9u3Kip6womoBwhlOmx/O1QJpriRFLZvn3YIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/YmNMlKiyhPQfg86YzUp8nHD/MztpfkkdiRmnSao38jje+veNV1PmC1AvIELvmLV
	 MT7nJ1IpEmPXXcM9jYHExCoVbGSD4nd21KCGIKO3FhpHDLGaWHpnb6BfWxb8R674o9
	 2oVLyyOb9oq23cwRk6lstvirnxKPIdOroQkyrbQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbfAXTlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:41:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387661AbfAXTlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:41:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A380720663;
        Thu, 24 Jan 2019 19:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358910;
        bh=UTQ9QzF9u3Kip6womoBwhlOmx/O1QJpriRFLZvn3YIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKKL6uw1JsHUyPqCPqIMWCH9Q5FodglaJgZcpC0a28hUMVTNyjifJ93CugTYeURe3
         2GsTp2BaeBPTSPfjQc2/jI1ZpR3bLDj3M71vw0UhZybqBjT0hgrhVItLECEuKrWqcg
         B5FI2SXfZY8VXnb1dDyILulNW23uK/bkI9Gul6+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 068/127] arm64: kasan: Increase stack size for KASAN_EXTRA
Date:   Thu, 24 Jan 2019 20:20:14 +0100
Message-Id: <20190124190215.067686211@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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
index f0a5c9531e8b..778af0b7f7fd 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -67,12 +67,17 @@
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



