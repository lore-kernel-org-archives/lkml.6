Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B48C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16299214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYHmZrLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16299214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbeKTJLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbeKTJLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:11:49 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6B7520851;
        Mon, 19 Nov 2018 22:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542667556;
        bh=5uzy4AP48hkewUCs85Xy/7AJYLLCllybvIaEASouOoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CYHmZrLTw54zQHrocBDVN/XdQwPHm7j89B1n4M0z3wcGnsKk/z+1m4OQ++2r9dOOe
         gyyZjIrvozglvsJJglyVYDDb16cm61QWhYRCLJr8I8oVHZCE1A0E1CdUbRsEwOtDcg
         BAiFV2tLsNVYAwuCwkr9tOPg62dcB4lK0aekDiwQ=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 11/13] x86/oops: Show the correct CS value in show_regs()
Date:   Mon, 19 Nov 2018 14:45:35 -0800
Message-Id: <19b4052cdb692eb66ef48b078ac3197b6787564a.1542667307.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_regs() shows the CS in the CPU register instead of the value in
regs.  This means that we'll probably print "CS: 0010" almost all
the time regardless of what was actually in CS when the kernel
malfunctioned.  This gives a particularly confusing result if we
OOPSed due to an implicit supervisor access from user mode.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/process_64.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 0e0b4288a4b2..2b8e6324fa20 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -66,7 +66,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L, fs, gs, shadowgs;
 	unsigned long d0, d1, d2, d3, d6, d7;
 	unsigned int fsindex, gsindex;
-	unsigned int ds, cs, es;
+	unsigned int ds, es;
 
 	show_iret_regs(regs);
 
@@ -98,7 +98,6 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	}
 
 	asm("movl %%ds,%0" : "=r" (ds));
-	asm("movl %%cs,%0" : "=r" (cs));
 	asm("movl %%es,%0" : "=r" (es));
 	asm("movl %%fs,%0" : "=r" (fsindex));
 	asm("movl %%gs,%0" : "=r" (gsindex));
@@ -114,7 +113,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 
 	printk(KERN_DEFAULT "FS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
 	       fs, fsindex, gs, gsindex, shadowgs);
-	printk(KERN_DEFAULT "CS:  %04x DS: %04x ES: %04x CR0: %016lx\n", cs, ds,
+	printk(KERN_DEFAULT "CS:  %04lx DS: %04x ES: %04x CR0: %016lx\n", regs->cs, ds,
 			es, cr0);
 	printk(KERN_DEFAULT "CR2: %016lx CR3: %016lx CR4: %016lx\n", cr2, cr3,
 			cr4);
-- 
2.17.2

