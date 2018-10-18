Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7B1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E402098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E402098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeJRQ4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:56:15 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:50692 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727360AbeJRQ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:56:14 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w9I8audu003430
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:36:56 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9I8aluu003408;
        Thu, 18 Oct 2018 16:36:47 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 18 Oct 2018
 16:34:51 +0800
From:   Nickhu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <deanbo422@gmail.com>, <zong@andestech.com>,
        <ebiederm@xmission.com>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH 3/3] nds32: Add unaligned access in kernel space.
Date:   Thu, 18 Oct 2018 16:34:34 +0800
Message-ID: <8c0a7e07b1c5ff5dd2df18db2d7f32dc87705551.1539654057.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1539654056.git.nickhu@andestech.com>
References: <cover.1539654056.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9I8aluu003408
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As my colleague has encountered kernel panic when unaligned access
in kernel space. Here is the situation, the structure 'TP_STRUCT__entry':

TP_STRUCT__entry(
                __field(        u32,    tb_id           )
                __field(        int,    err             )
                __field(        int,    oif             )
                __field(        int,    iif             )
                __field(        __u8,   tos             )
                __field(        __u8,   scope           )
                __field(        __u8,   flags           )
                __field(        u8,     proto           )
                __array(        __u8,   src,    4       )
                __array(        __u8,   dst,    4       )
                __array(        __u8,   gw,     4       )
                __array(        __u8,   saddr,  4       )
                __field(        u16,    sport           )
                __field(        u16,    dport           )
                __dynamic_array(char,  name,   IFNAMSIZ )
        )

When he try to access the element in the structure, the kernel panic
happen. Although he has rearrange the order of the structure to fix
the problem, but we cannot ignore the fact that there still need
unaligned access in kernel space. It can help us to avoid kernel panic
when reasonable unaligned address access happen. The users need to have
the knowledge that some unreasonable unaligned address may cause the bug
in kernel.

The config 'HAVE_EFFICIENT_UNALIGNED_ACCESS' must be with the hw
unaligned access config 'HW_SUPPORT_UNALIGNMENT_ACCESS'. In sw
unalinged access handler, the code 'get_inst()' in arch/nds32/mm/
alignment.c:522 would be generate as load word instruction if
'HAVE_EFFICIENT_UNALIGNED_ACCESS' is set. This would cause the kernel
hang in loop if the address of the load word instruction is unaligned.
For example:

	0xbc39e: lwi450 $r0, [$r1], if the $r1 cause unaligned access.
								|
								| unaligned access handler
								v
	arch/nds32/mm/alignment.c:522: get_ints():0xb0874b7e lwi450 $r2, [$3],
	$r3 is the address '0xbc39e', it would cause kernel unaligned access.
								|
								| unaligned access handler
								v
	arch/nds32/mm/alignment.c:522: get_ints():0xb0874b7e lwi450 $r2, [$3],
	$r3 is the address '0xb0874b7e', it would cause kernel unaligned access.

The kernel is hang in the loop.

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/kernel/traps.c | 4 +++-
 arch/nds32/mm/alignment.c | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 1496aab48998..dcde7abc5515 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -331,6 +331,7 @@ void do_revinsn(struct pt_regs *regs)
 #ifdef CONFIG_ALIGNMENT_TRAP
 extern int unalign_access_mode;
 extern int do_unaligned_access(unsigned long addr, struct pt_regs *regs);
+extern int va_kernel_present(unsigned long addr);
 #endif
 void do_dispatch_general(unsigned long entry, unsigned long addr,
 			 unsigned long itype, struct pt_regs *regs,
@@ -341,7 +342,8 @@ void do_dispatch_general(unsigned long entry, unsigned long addr,
 	if (type == ETYPE_ALIGNMENT_CHECK) {
 #ifdef CONFIG_ALIGNMENT_TRAP
 		/* Alignment check */
-		if (user_mode(regs) && unalign_access_mode) {
+		if ((user_mode(regs) && unalign_access_mode) ||
+		    va_kernel_present(addr)) {
 			int ret;
 			ret = do_unaligned_access(addr, regs);
 
diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
index 66a556befd05..2d7a08af6622 100644
--- a/arch/nds32/mm/alignment.c
+++ b/arch/nds32/mm/alignment.c
@@ -524,8 +524,10 @@ int do_unaligned_access(unsigned long addr, struct pt_regs *regs)
 	DEBUG((unalign_access_debug > 0), 1,
 	      "Faulting addr: 0x%08lx, pc: 0x%08lx [inst: 0x%08lx ]\n", addr,
 	      regs->ipc, inst);
-
-	set_fs(USER_DS);
+	if ((user_mode(regs) && unalign_access_mode))
+		set_fs(USER_DS);
+	else if (va_kernel_present(addr))
+		set_fs(KERNEL_DS);
 
 	if (inst & NDS32_16BIT_INSTRUCTION)
 		ret = do_16((inst >> 16) & 0xffff, regs);
-- 
2.17.0

