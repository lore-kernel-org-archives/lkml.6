Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2C5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2172098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2172098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbeIYAlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:41:45 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36328 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbeIYAlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:41:44 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g4VkD-0002qj-Uk; Mon, 24 Sep 2018 14:38:05 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kernel-team@fb.com, songliubraving@fb.com,
        mingo@kernel.org, will.deacon@arm.com, hpa@zytor.com,
        luto@kernel.org, npiggin@gmail.com, Rik van Riel <riel@surriel.com>
Subject: [PATCH 6/7] Add freed_tables element to flush_tlb_info
Date:   Mon, 24 Sep 2018 14:37:58 -0400
Message-Id: <20180924183759.23955-7-riel@surriel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924183759.23955-1-riel@surriel.com>
References: <20180924183759.23955-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the information on to native_flush_tlb_others.

No functional changes.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/include/asm/tlbflush.h | 1 +
 arch/x86/mm/tlb.c               | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index ae1ef755cb94..dc4d99579984 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -511,6 +511,7 @@ struct flush_tlb_info {
 	unsigned long		start;
 	unsigned long		end;
 	u64			new_tlb_gen;
+	bool			freed_tables;
 };
 
 #define local_flush_tlb() __flush_tlb()
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 62f147b0f6b7..5d73bde0e4c8 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -578,6 +578,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 
 	struct flush_tlb_info info = {
 		.mm = mm,
+		.freed_tables = freed_tables,
 	};
 
 	cpu = get_cpu();
-- 
2.17.1

