Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D52AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3446820877
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3446820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933637AbeGFFth (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:49:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60340 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932910AbeGFFte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:49:34 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11623BC1;
        Fri,  6 Jul 2018 05:49:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.17 45/46] x86/mm: Dont free P4D table when it is folded at runtime
Date:   Fri,  6 Jul 2018 07:47:06 +0200
Message-Id: <20180706054526.911333236@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
References: <20180706054524.595521988@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

commit 0e311d237d7f3022b7dafb639b42541bfb42fe94 upstream.

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
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/pgalloc.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -184,6 +184,9 @@ static inline p4d_t *p4d_alloc_one(struc
 
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
+	if (!pgtable_l5_enabled)
+		return;
+
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
 	free_page((unsigned long)p4d);
 }


