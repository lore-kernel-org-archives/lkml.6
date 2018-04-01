Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbeDAQLm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 12:11:42 -0400
Received: from manul.sfritsch.de ([138.201.64.112]:59928 "EHLO
        manul.sfritsch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753623AbeDAQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 12:11:41 -0400
From: Stefan Fritsch <sf@sfritsch.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Stefan Fritsch <sf@sfritsch.de>
Subject: [PATCH] kvm: Add emulation for movups/movupd
Date: Sun,  1 Apr 2018 17:54:44 +0200
Message-Id: <20180401155444.7006-1-sf@sfritsch.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is very similar to the aligned versions movaps/movapd.

We have seen the corresponding emulation failures with openbsd as guest
and with Windows 10 with intel HD graphics pass through.

Signed-off-by: Christian Ehrhardt <christian_ehrhardt@genua.de>
Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
---
 arch/x86/kvm/emulate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index d91eaeb01034..7dda8e38c19a 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4498,6 +4498,10 @@ static const struct gprefix pfx_0f_2b = {
 	ID(0, &instr_dual_0f_2b), ID(0, &instr_dual_0f_2b), N, N,
 };
 
+static const struct gprefix pfx_0f_10_0f_11 = {
+	I(Unaligned, em_mov), I(Unaligned, em_mov), N, N,
+};
+
 static const struct gprefix pfx_0f_28_0f_29 = {
 	I(Aligned, em_mov), I(Aligned, em_mov), N, N,
 };
@@ -4709,7 +4713,9 @@ static const struct opcode twobyte_table[256] = {
 	DI(ImplicitOps | Priv, invd), DI(ImplicitOps | Priv, wbinvd), N, N,
 	N, D(ImplicitOps | ModRM | SrcMem | NoAccess), N, N,
 	/* 0x10 - 0x1F */
-	N, N, N, N, N, N, N, N,
+	GP(ModRM | DstReg | SrcMem | Mov | Sse, &pfx_0f_10_0f_11),
+	GP(ModRM | DstMem | SrcReg | Mov | Sse, &pfx_0f_10_0f_11),
+	N, N, N, N, N, N,
 	D(ImplicitOps | ModRM | SrcMem | NoAccess),
 	N, N, N, N, N, N, D(ImplicitOps | ModRM | SrcMem | NoAccess),
 	/* 0x20 - 0x2F */
-- 
2.11.0
