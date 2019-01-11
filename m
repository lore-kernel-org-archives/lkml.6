Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7420C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791302177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216720;
	bh=BXXDzqq8wJtvo7WE24heaNxLLn7VNKQ7c0b93ub0p80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mWbS7WiaBHLYrGcRFrLjrqFPBRaVCN0Ybu4Fr5uH210VFRd7HlHPAmKcMmARdNUeu
	 6V2jWrDyOOOF1lzPZ9nUuSeovbytuZXSOYBKG4tkvH92xisaDZL/jnc3c54790lb72
	 J84iHPZdBC/eLEDkoqY3joSo8nw1gaCLTCk8J1Zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbfAKOZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387974AbfAKOSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D012177B;
        Fri, 11 Jan 2019 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216312;
        bh=BXXDzqq8wJtvo7WE24heaNxLLn7VNKQ7c0b93ub0p80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByIaAzDrs0aGkAi7o3qCcMZmtkaLrooTC5bNLpuxApsalfqNgi6TYDZh6B6M1P7lI
         HR0kuH6ryKPFG1KL6AOCT77ILipLh2ZczluEMJrTRZYcnw3F2cy+EURqrIwxnELP8d
         TwwLz9DYzeSDf8i6jcLZvIAirVcye8WHOgCH6/V4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Mike Haboustak <haboustak@gmail.com>
Subject: [PATCH 4.4 54/88] x86/kvm/vmx: do not use vm-exit instruction length for fast MMIO when running nested
Date:   Fri, 11 Jan 2019 15:08:23 +0100
Message-Id: <20190111131054.124701505@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit d391f1207067268261add0485f0f34503539c5b0 upstream.

I was investigating an issue with seabios >= 1.10 which stopped working
for nested KVM on Hyper-V. The problem appears to be in
handle_ept_violation() function: when we do fast mmio we need to skip
the instruction so we do kvm_skip_emulated_instruction(). This, however,
depends on VM_EXIT_INSTRUCTION_LEN field being set correctly in VMCS.
However, this is not the case.

Intel's manual doesn't mandate VM_EXIT_INSTRUCTION_LEN to be set when
EPT MISCONFIG occurs. While on real hardware it was observed to be set,
some hypervisors follow the spec and don't set it; we end up advancing
IP with some random value.

I checked with Microsoft and they confirmed they don't fill
VM_EXIT_INSTRUCTION_LEN on EPT MISCONFIG.

Fix the issue by doing instruction skip through emulator when running
nested.

Fixes: 68c3b4d1676d870f0453c31d5a52e7e65c7448ae
Suggested-by: Radim Krčmář <rkrcmar@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
[mhaboustak: backport to 4.9.y]
Signed-off-by: Mike Haboustak <haboustak@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   19 +++++++++++++++++--
 arch/x86/kvm/x86.c |    3 ++-
 2 files changed, 19 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6163,9 +6163,24 @@ static int handle_ept_misconfig(struct k
 
 	gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
 	if (!kvm_io_bus_write(vcpu, KVM_FAST_MMIO_BUS, gpa, 0, NULL)) {
-		skip_emulated_instruction(vcpu);
 		trace_kvm_fast_mmio(gpa);
-		return 1;
+		/*
+		* Doing kvm_skip_emulated_instruction() depends on undefined
+		* behavior: Intel's manual doesn't mandate
+		* VM_EXIT_INSTRUCTION_LEN to be set in VMCS when EPT MISCONFIG
+		* occurs and while on real hardware it was observed to be set,
+		* other hypervisors (namely Hyper-V) don't set it, we end up
+		* advancing IP with some random value. Disable fast mmio when
+		* running nested and keep it for real hardware in hope that
+		* VM_EXIT_INSTRUCTION_LEN will always be set correctly.
+		*/
+		if (!static_cpu_has(X86_FEATURE_HYPERVISOR)) {
+			skip_emulated_instruction(vcpu);
+			return 1;
+		}
+		else
+			return x86_emulate_instruction(vcpu, gpa, EMULTYPE_SKIP,
+						       NULL, 0) == EMULATE_DONE;
 	}
 
 	ret = handle_mmio_page_fault(vcpu, gpa, true);
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5436,7 +5436,8 @@ int x86_emulate_instruction(struct kvm_v
 		 * handle watchpoints yet, those would be handled in
 		 * the emulate_ops.
 		 */
-		if (kvm_vcpu_check_breakpoint(vcpu, &r))
+		if (!(emulation_type & EMULTYPE_SKIP) &&
+		    kvm_vcpu_check_breakpoint(vcpu, &r))
 			return r;
 
 		ctxt->interruptibility = 0;


