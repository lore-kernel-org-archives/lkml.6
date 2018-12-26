Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD21FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FD4214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864345;
	bh=xHpUPkfqehI0wryWmy2Iqaf+OscGaJXfXJrjlrv+mGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q12qZxpM+ER/P8t4dFW07tEUoUunTEvr/EDeTZY00pevY2lq3TWcBm1imiB9S4DQB
	 5fAcnXQ6bQsGkTuVt1LFgx80XItspZYOm3WkjbywCFnt3ZOpAkvZC/cBPOEM3NflNJ
	 gRW6sT8jHd4wFlP72T1UAVRzRuo3t25A6Tpb7Ilg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeLZWpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbeLZWk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2C9720651;
        Wed, 26 Dec 2018 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864026;
        bh=xHpUPkfqehI0wryWmy2Iqaf+OscGaJXfXJrjlrv+mGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nK7XBcdl0v9Lo9olHrZfpw74BQYwQkYjsz3E9h2Z8V5wBQEu5ROMeKWa8ZfC2br+2
         4Wf0JdT8xcGkHeD5751EGbmBIQGK/eDqGx3+74loibsqOlZK4OaaN20XiEOYo+D4La
         oas4PZfxiuMFV1jDXNl7V+LxxR7edM8KAnv8C4Qc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        bhe@redhat.com, hans.van.kranenburg@mendix.com, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 19/59] x86/dump_pagetables: Fix LDT remap address marker
Date:   Wed, 26 Dec 2018 17:37:59 -0500
Message-Id: <20181226223839.150262-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

[ Upstream commit 254eb5505ca0ca749d3a491fc6668b6c16647a99 ]

The LDT remap placement has been changed. It's now placed before the direct
mapping in the kernel virtual address space for both paging modes.

Change address markers order accordingly.

Fixes: d52888aa2753 ("x86/mm: Move LDT remap out of KASLR region on 5-level paging")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: peterz@infradead.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: bhe@redhat.com
Cc: hans.van.kranenburg@mendix.com
Cc: linux-mm@kvack.org
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20181130202328.65359-3-kirill.shutemov@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/dump_pagetables.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index cf403e057f3f..6bca45d06676 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -51,10 +51,10 @@ struct addr_marker {
 enum address_markers_idx {
 	USER_SPACE_NR = 0,
 	KERNEL_SPACE_NR,
-	LOW_KERNEL_NR,
-#if defined(CONFIG_MODIFY_LDT_SYSCALL) && defined(CONFIG_X86_5LEVEL)
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
 	LDT_NR,
 #endif
+	LOW_KERNEL_NR,
 	VMALLOC_START_NR,
 	VMEMMAP_START_NR,
 #ifdef CONFIG_KASAN
@@ -62,9 +62,6 @@ enum address_markers_idx {
 	KASAN_SHADOW_END_NR,
 #endif
 	CPU_ENTRY_AREA_NR,
-#if defined(CONFIG_MODIFY_LDT_SYSCALL) && !defined(CONFIG_X86_5LEVEL)
-	LDT_NR,
-#endif
 #ifdef CONFIG_X86_ESPFIX64
 	ESPFIX_START_NR,
 #endif
-- 
2.19.1

