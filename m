Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72865C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2892221C68
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2892221C68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965058AbeFZKde (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:33:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54089 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933880AbeFZKdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:33:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QAXBK01649344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:33:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QAXBgs1649341;
        Tue, 26 Jun 2018 03:33:11 -0700
Date:   Tue, 26 Jun 2018 03:33:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrey Ryabinin <tipbot@zytor.com>
Message-ID: <tip-0e311d237d7f3022b7dafb639b42541bfb42fe94@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, aryabinin@virtuozzo.com, peterz@infradead.org
Reply-To: aryabinin@virtuozzo.com, peterz@infradead.org, mingo@kernel.org,
          hpa@zytor.com, kirill.shutemov@linux.intel.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180625102427.15015-1-aryabinin@virtuozzo.com>
References: <20180625102427.15015-1-aryabinin@virtuozzo.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Don't free P4D table when it is folded at
 runtime
Git-Commit-ID: 0e311d237d7f3022b7dafb639b42541bfb42fe94
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0e311d237d7f3022b7dafb639b42541bfb42fe94
Gitweb:     https://git.kernel.org/tip/0e311d237d7f3022b7dafb639b42541bfb42fe94
Author:     Andrey Ryabinin <aryabinin@virtuozzo.com>
AuthorDate: Mon, 25 Jun 2018 13:24:27 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:21:48 +0200

x86/mm: Don't free P4D table when it is folded at runtime

When the P4D page table layer is folded at runtime, the p4d_free()
should do nothing, the same as in <asm-generic/pgtable-nop4d.h>.

It seems this bug should cause double-free in efi_call_phys_epilog(),
but I don't know how to trigger that code path, so I can't confirm that
by testing.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org # 4.17
Fixes: 98219dda2ab5 ("x86/mm: Fold p4d page table layer at runtime")
Link: http://lkml.kernel.org/r/20180625102427.15015-1-aryabinin@virtuozzo.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgalloc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index ada6410fd2ec..fbd578daa66e 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -184,6 +184,9 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
+	if (!pgtable_l5_enabled())
+		return;
+
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
 	free_page((unsigned long)p4d);
 }
