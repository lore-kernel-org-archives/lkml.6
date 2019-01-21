Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6C1C2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C3E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfAUMsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:48:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41274 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbfAUMsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:48:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so15392154lfj.8;
        Mon, 21 Jan 2019 04:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=1rik5yWAwK/VZEgE3GAP/26Xz0u6FKuRPpB5cNtjyms=;
        b=DPX5QiPhJznBlN+vd9vjGMrvlZHwpxjKSnx/xYYTu78H+7dtbwb6SDDFt9k8ctKTZJ
         jCDw1zkqT4M1gRWR+yFi+DjLwcI0sVFEkqf/UM3qd1XoCTkVcxApEH5fOh9HMSoX/4kl
         7dp2281IwD0fTEr6I+UU42CsHYVQ5qJr6CZXZB4K7u3nz6k/Fyu0TcL6oe5DjtCnCnI7
         s1vXtqpu6Id2g45nnsoRT4CFXERR+ZfSBXZsj4GITk3KMGTTbKYUkM1aumfQ0qfylIQd
         w/0lJg11ZMhLkugoi5nXESvChIRZRZsVQkoufy6v7IEL8QzF7CcVeBT7ceMEAE5e4Iwi
         vZHQ==
X-Gm-Message-State: AJcUukcEHeptivX6crbwUNmZ/VBBHEmBt8aMFrlHwVzK9HvW/nmXoelB
        ulj5V2TUk5e1bOYpOVVIkRc=
X-Google-Smtp-Source: ALg8bN6Ko9Iwu5fWvCaS60yLSJRKSDsyvVKlRT85yCEdok16q+tqefY4oIBm6IlKhLSI8+XxIIXszw==
X-Received: by 2002:a19:c70a:: with SMTP id x10mr17898358lff.88.1548074931300;
        Mon, 21 Jan 2019 04:48:51 -0800 (PST)
Received: from localhost.localdomain ([213.87.132.221])
        by smtp.gmail.com with ESMTPSA id k68-v6sm2288537ljb.35.2019.01.21.04.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 04:48:50 -0800 (PST)
From:   Alexander Popov <alex.popov@linux.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        H Peter Anvin <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>
Subject: [PATCH v2] KVM: x86: Fix single-step debugging
Date:   Mon, 21 Jan 2019 15:48:40 +0300
Message-Id: <1548074920-10651-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The single-step debugging of KVM guests on x86 is broken: if we run
gdb 'stepi' command at the breakpoint when the guest interrupts are
enabled, RIP always jumps to native_apic_mem_write(). Then other
nasty effects follow.

Long investigation showed that on Jun 7, 2017 the
commit c8401dda2f0a00cd25c0 ("KVM: x86: fix singlestepping over syscall")
introduced the kvm_run.debug corruption: kvm_vcpu_do_singlestep() can
be called without X86_EFLAGS_TF set.

Let's fix it. Please consider that for -stable.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 arch/x86/kvm/x86.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f049ecf..9686068 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6407,8 +6407,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
 		toggle_interruptibility(vcpu, ctxt->interruptibility);
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 		kvm_rip_write(vcpu, ctxt->eip);
-		if (r == EMULATE_DONE &&
-		    (ctxt->tf || (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)))
+		if (r == EMULATE_DONE && ctxt->tf)
 			kvm_vcpu_do_singlestep(vcpu, &r);
 		if (!ctxt->have_exception ||
 		    exception_type(ctxt->exception.vector) == EXCPT_TRAP)
-- 
2.7.4

