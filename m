Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7487C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B125D21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B125D21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJIWSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:18:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58421 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJIWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:18:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99F0vVL1081541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:00:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99F0u9l1081538;
        Tue, 9 Oct 2018 08:00:56 -0700
Date:   Tue, 9 Oct 2018 08:00:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-97807813fe7074ee865d6bc1df1d0f8fb878ee9d@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, riel@surriel.com,
        peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, riel@surriel.com,
          peterz@infradead.org
In-Reply-To: <20180926035844.1420-7-riel@surriel.com>
References: <20180926035844.1420-7-riel@surriel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/tlb: Add freed_tables element to flush_tlb_info
Git-Commit-ID: 97807813fe7074ee865d6bc1df1d0f8fb878ee9d
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

Commit-ID:  97807813fe7074ee865d6bc1df1d0f8fb878ee9d
Gitweb:     https://git.kernel.org/tip/97807813fe7074ee865d6bc1df1d0f8fb878ee9d
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Tue, 25 Sep 2018 23:58:43 -0400
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:12 +0200

x86/mm/tlb: Add freed_tables element to flush_tlb_info

Pass the information on to native_flush_tlb_others.

No functional changes.

Cc: npiggin@gmail.com
Cc: mingo@kernel.org
Cc: will.deacon@arm.com
Cc: songliubraving@fb.com
Cc: kernel-team@fb.com
Cc: hpa@zytor.com
Cc: luto@kernel.org
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180926035844.1420-7-riel@surriel.com
---
 arch/x86/include/asm/tlbflush.h | 1 +
 arch/x86/mm/tlb.c               | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 1dea9860ce5b..323a313947e0 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -532,6 +532,7 @@ struct flush_tlb_info {
 	unsigned long		end;
 	u64			new_tlb_gen;
 	unsigned int		stride_shift;
+	bool			freed_tables;
 };
 
 #define local_flush_tlb() __flush_tlb()
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 14bf39fc0447..92e46f4c058c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -617,6 +617,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
 		.mm = mm,
 		.stride_shift = stride_shift,
+		.freed_tables = freed_tables,
 	};
 
 	cpu = get_cpu();
