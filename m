Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeCVIeU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 04:34:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40631 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeCVIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 04:34:16 -0400
X-Google-Smtp-Source: AG47ELsUGP3umth8CSZf7McefXooCWdgAWjJ2jsKJ23t0DdBF8CAI2yohtYHxX27af6vsl65vXCobA==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit mode
Date: Thu, 22 Mar 2018 16:34:11 +0800
Message-Id: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Explicit segment overides other than %fs and %gs are documented as ignored by
both Intel and AMD.

In practice, this means that:

 * Explicit uses of %ss don't actually yield #SS[0] for non-canonical
   memory references.
 * Explicit uses of %{e,c,d}s don't override %rbp/%rsp-based memory references
   to yield #GP[0] for non-canonical memory references.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/emulate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index dd88158..5091255 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5148,8 +5148,10 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
 		case 0x2e:	/* CS override */
 		case 0x36:	/* SS override */
 		case 0x3e:	/* DS override */
-			has_seg_override = true;
-			ctxt->seg_override = (ctxt->b >> 3) & 3;
+			if (mode != X86EMUL_MODE_PROT64) {
+				has_seg_override = true;
+				ctxt->seg_override = (ctxt->b >> 3) & 3;
+			}
 			break;
 		case 0x64:	/* FS override */
 		case 0x65:	/* GS override */
-- 
2.7.4
