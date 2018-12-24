Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3EEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1292173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbeLXLjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:39:32 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:42390 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbeLXLjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 06:39:32 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 829A269ED47C4FC05DA8;
        Mon, 24 Dec 2018 19:39:29 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBOBdP1i068235;
        Mon, 24 Dec 2018 19:39:25 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018122419393333-18465267 ;
          Mon, 24 Dec 2018 19:39:33 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [RESEND PATCH]  kvm/x86: propagate fetch fault into guest
Date:   Mon, 24 Dec 2018 20:00:30 +0800
Message-Id: <1545652830-65253-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-24 19:39:33,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-24 19:39:25,
        Serialize complete at 2018-12-24 19:39:25
X-MAIL: mse01.zte.com.cn wBOBdP1i068235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling ept misconfig exit, it will call emulate instruction
with insn_len = 0. The decode instruction function may return a fetch
fault and should propagate to guest.

The problem will result to emulation fail.
KVM internal error. Suberror: 1
emulation failure
EAX=f81a0024 EBX=f6a07000 ECX=f6a0737c EDX=f8be0118
ESI=f6a0737c EDI=00000021 EBP=f6929f98 ESP=f6929f98
EIP=f8bdd141 EFL=00010086 [--S--P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
CS =0060 00000000 ffffffff 00c09b00 DPL=0 CS32 [-RA]
SS =0068 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
FS =00d8 2c044000 ffffffff 00809300 DPL=0 DS16 [-WA]
GS =0033 081a44c8 01000fff 00d0f300 DPL=3 DS   [-WA]
LDT=0000 00000000 ffffffff 00000000
TR =0080 f6ea0c80 0000206b 00008b00 DPL=0 TSS32-busy
GDT=     f6e99000 000000ff
IDT=     fffbb000 000007ff
CR0=80050033 CR2=b757d000 CR3=35d31000 CR4=001406d0

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kvm/emulate.c | 5 ++++-
 arch/x86/kvm/x86.c     | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 78e430f..dd132cf 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5114,8 +5114,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
 		memcpy(ctxt->fetch.data, insn, insn_len);
 	else {
 		rc = __do_insn_fetch_bytes(ctxt, 1);
-		if (rc != X86EMUL_CONTINUE)
+		if (rc != X86EMUL_CONTINUE) {
+			if (rc == X86EMUL_PROPAGATE_FAULT)
+				ctxt->have_exception = true;
 			return rc;
+		}
 	}
 
 	switch (mode) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f049ecf..137d384 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6333,8 +6333,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
 			if (reexecute_instruction(vcpu, cr2, write_fault_to_spt,
 						emulation_type))
 				return EMULATE_DONE;
-			if (ctxt->have_exception && inject_emulated_exception(vcpu))
+			if (ctxt->have_exception) {
+				inject_emulated_exception(vcpu);
 				return EMULATE_DONE;
+			}
 			if (emulation_type & EMULTYPE_SKIP)
 				return EMULATE_FAIL;
 			return handle_emulation_failure(vcpu, emulation_type);
-- 
1.8.3.1

