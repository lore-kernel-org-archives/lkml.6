Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx491HXQgjOByPQfu4yU42Dz49OSONaI+bgUuNEaA/KVJfYe+vY6Q2XVc9x36BBmYsOyjBmOJ
ARC-Seal: i=1; a=rsa-sha256; t=1524652907; cv=none;
        d=google.com; s=arc-20160816;
        b=CtsGaP1hN4BO61pFpScr1tGX0g9Fm0rD8zP4+K270qrCSfg/aVKVtkIXhwRfMMcSKr
         61uQrLGHPATBX9EmKcjM3Y2InWnhPHw04iC86oegrUUvAh8esNe1RkNd5y6npghKKuUz
         5INl2m1HxzvyYOdI6rTw5VpdIIlQq7A3jPSn1lxKHDeZuAVGL+x11ctd9DnWtPuN1C8y
         kEaOiwXfByRNoUsNpYzQDnGmRKpDxkGzRwr3InZ2G6lSCS2r+o3qMjt2rY1oFqZ8rGlx
         np//pQ7kOApVWwqlhnJQA7YGhU6kOMYX3b2OWd2ksyyyWbJavD/btBNtS6yfMk45xAMU
         1yNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VbKSzK/YN16HNOzoW6NHLlYLrbUGGdMfuMPmVUo+Opc=;
        b=BO+44OHXPP5dzGJjvbz4vW1tZcONbz9RjkDsWrv6J/toCXsgIZsOLHIJ5W7zcDSaIj
         XTVVQfPiyHoSJd+NBqaKQWEs+LlQqgxyk11EmsXV5Vs5bbPJIEtjn0Jk2lWBr9bPMfjY
         Zm2d/TJSoTCWxQWKIgi/Y4fUZd5EY9iNmBYiPS244qoAP1MckmpB7b3fLL81xl2e+W07
         4sbqbii0fn9wQEZ90O4fm+n6ZgGJnNJmedPj9Uyi8iOAcWywA3u+GFG6nnoyiRWAn4NK
         /SVTyETjiv3A+4/8ra7SEpeGj0hJiKz5VO3KuiVJQ2Zues8k8FvsLMOcDiAY2QscWQNf
         irRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 106/183] x86/kvm/vmx: do not use vm-exit instruction length for fast MMIO when running nested
Date: Wed, 25 Apr 2018 12:35:26 +0200
Message-Id: <20180425103246.712311937@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714446628467090?=
X-GMAIL-MSGID: =?utf-8?q?1598714446628467090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>


[ Upstream commit d391f1207067268261add0485f0f34503539c5b0 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   16 +++++++++++++++-
 arch/x86/kvm/x86.c |    3 ++-
 2 files changed, 17 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6765,7 +6765,21 @@ static int handle_ept_misconfig(struct k
 	if (!is_guest_mode(vcpu) &&
 	    !kvm_io_bus_write(vcpu, KVM_FAST_MMIO_BUS, gpa, 0, NULL)) {
 		trace_kvm_fast_mmio(gpa);
-		return kvm_skip_emulated_instruction(vcpu);
+		/*
+		 * Doing kvm_skip_emulated_instruction() depends on undefined
+		 * behavior: Intel's manual doesn't mandate
+		 * VM_EXIT_INSTRUCTION_LEN to be set in VMCS when EPT MISCONFIG
+		 * occurs and while on real hardware it was observed to be set,
+		 * other hypervisors (namely Hyper-V) don't set it, we end up
+		 * advancing IP with some random value. Disable fast mmio when
+		 * running nested and keep it for real hardware in hope that
+		 * VM_EXIT_INSTRUCTION_LEN will always be set correctly.
+		 */
+		if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
+			return kvm_skip_emulated_instruction(vcpu);
+		else
+			return x86_emulate_instruction(vcpu, gpa, EMULTYPE_SKIP,
+						       NULL, 0) == EMULATE_DONE;
 	}
 
 	ret = kvm_mmu_page_fault(vcpu, gpa, PFERR_RSVD_MASK, NULL, 0);
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5699,7 +5699,8 @@ int x86_emulate_instruction(struct kvm_v
 		 * handle watchpoints yet, those would be handled in
 		 * the emulate_ops.
 		 */
-		if (kvm_vcpu_check_breakpoint(vcpu, &r))
+		if (!(emulation_type & EMULTYPE_SKIP) &&
+		    kvm_vcpu_check_breakpoint(vcpu, &r))
 			return r;
 
 		ctxt->interruptibility = 0;
