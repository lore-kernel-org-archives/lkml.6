Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43D0C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 06:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE0208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 06:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCE0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeKKQXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 11:23:09 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:25452 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727764AbeKKQXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 11:23:07 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Sat, 10 Nov 2018 22:35:01 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 81B3440732;
        Sat, 10 Nov 2018 22:35:24 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v4 07/10] x86/kgdb: avoid redundant comparison of code
Date:   Sat, 10 Nov 2018 15:17:29 -0800
Message-ID: <20181110231732.15060-8-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181110231732.15060-1-namit@vmware.com>
References: <20181110231732.15060-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

text_poke() already ensures that the written value is the correct one
and fails if that is not the case. There is no need for an additional
comparison. Remove it.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/kgdb.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 8091b2e381d4..d14e1be576fd 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -751,7 +751,6 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 {
 	int err;
-	char opc[BREAK_INSTR_SIZE];
 
 	bpt->type = BP_BREAKPOINT;
 	err = probe_kernel_read(bpt->saved_instr, (char *)bpt->bpt_addr,
@@ -772,11 +771,6 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 			     BREAK_INSTR_SIZE);
 	if (err)
 		return err;
-	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
-	if (err)
-		return err;
-	if (memcmp(opc, arch_kgdb_ops.gdb_bpt_instr, BREAK_INSTR_SIZE))
-		return -EINVAL;
 	bpt->type = BP_POKE_BREAKPOINT;
 
 	return err;
@@ -785,7 +779,6 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 {
 	int err;
-	char opc[BREAK_INSTR_SIZE];
 
 	if (bpt->type != BP_POKE_BREAKPOINT)
 		goto knl_write;
@@ -798,9 +791,6 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	err = text_poke_kgdb((void *)bpt->bpt_addr, bpt->saved_instr,
 			     BREAK_INSTR_SIZE);
 	if (err)
-		return err;
-	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
-	if (err || memcmp(opc, bpt->saved_instr, BREAK_INSTR_SIZE))
 		goto knl_write;
 	return err;
 
-- 
2.17.1

