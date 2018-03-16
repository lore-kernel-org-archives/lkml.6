Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtp3PIjTaGew+gZ5Ux8+dWOFAwJ7yEGlnwoAFuZHOuecTTqPmPMII9HpArDch0wCem1ULhA
ARC-Seal: i=1; a=rsa-sha256; t=1521215039; cv=none;
        d=google.com; s=arc-20160816;
        b=K0Rb3u+VVxKA0+Cl/0X51QA+yHmMKBXN1J+HYnY9Pz8RrJdPHYudN+/LmvfQylDXat
         0FlNU3B84fiHSxWATlEmd3RPD+Nt5j6fqg03cSiVdmG77q6BlyQ087wNOUuXjtTudzqj
         vzA0aKM0zjL7THkAmeeJ7/RwCwg180265HzhSpmu+mtnzbRRTe9wttmTg6plTCqLdlyL
         vxJqVf7UvoiUI1dfWuzu1MiWUcBmcz4e5RsUX65qFpqyJQpcqqHIAJBh/jEIL1eq9Isv
         31RlYA8myPvdFq3njBGrHrHGDv1mCONR1UFAheUpJJoz7zUadxOVeXJFfR1XrQHA3z3b
         T/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5obkeADDQpkraRprRovI4tNi7ZNZkXLdVEw8z5/OfhM=;
        b=VnivqwBDNlOC0bZQ4vcRDT0hb8lc1UHjxSliq49fB0E+xKcTonQJtv5HPPNjtI13TO
         B8O/6/JsvbIAFvgy3S4z//ZphRvuFDwYtUwtnctcZRrcYzFTG6KNaG7YdtrD7L6LyDmS
         pntO1qrAnAUipdmV27M4NwcI0lXm5FiSmBlMIGBIfFI/zyTvF537pmtdme3lZ5jdeebe
         4frySfDNEYMNMncrltKU632SXCgerj4u0Zhx6EUwxGsnHgQp784srCA75MVcq+QcnQd2
         yuCj7lUBhmT9gB3LazW5opkzUeYBQKz9d5p7CIYZBwZGXvNZijKD05Vb72NreOplXy0B
         TNMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Borislav Petkov <bp@suse.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	x86@kernel.org,
	kvm@vger.kernel.org,
	Brijesh Singh <brijesh.singh@amd.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 079/128] KVM: X86: Restart the guest when insn_len is zero and SEV is enabled
Date: Fri, 16 Mar 2018 16:23:40 +0100
Message-Id: <20180316152340.594456442@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109581775312555?=
X-GMAIL-MSGID: =?utf-8?q?1595109581775312555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brijesh Singh <brijesh.singh@amd.com>


[ Upstream commit 00b10fe1046c4b2232097a7ffaa9238c7e479388 ]

On AMD platforms, under certain conditions insn_len may be zero on #NPF.
This can happen if a guest gets a page-fault on data access but the HW
table walker is not able to read the instruction page (e.g instruction
page is not present in memory).

Typically, when insn_len is zero, x86_emulate_instruction() walks the
guest page table and fetches the instruction bytes from guest memory.
When SEV is enabled, the guest memory is encrypted with guest-specific
key hence hypervisor will not able to fetch the instruction bytes.
In those cases we simply restart the guest.

I have encountered this issue when running kernbench inside the guest.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/mmu.c |   10 ++++++++++
 arch/x86/kvm/svm.c |    6 ++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4951,6 +4951,16 @@ int kvm_mmu_page_fault(struct kvm_vcpu *
 	if (mmio_info_in_cache(vcpu, cr2, direct))
 		emulation_type = 0;
 emulate:
+	/*
+	 * On AMD platforms, under certain conditions insn_len may be zero on #NPF.
+	 * This can happen if a guest gets a page-fault on data access but the HW
+	 * table walker is not able to read the instruction page (e.g instruction
+	 * page is not present in memory). In those cases we simply restart the
+	 * guest.
+	 */
+	if (unlikely(insn && !insn_len))
+		return 1;
+
 	er = x86_emulate_instruction(vcpu, cr2, emulation_type, insn, insn_len);
 
 	switch (er) {
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2178,7 +2178,8 @@ static int pf_interception(struct vcpu_s
 	u64 error_code = svm->vmcb->control.exit_info_1;
 
 	return kvm_handle_page_fault(&svm->vcpu, error_code, fault_address,
-			svm->vmcb->control.insn_bytes,
+			static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
+			svm->vmcb->control.insn_bytes : NULL,
 			svm->vmcb->control.insn_len);
 }
 
@@ -2189,7 +2190,8 @@ static int npf_interception(struct vcpu_
 
 	trace_kvm_page_fault(fault_address, error_code);
 	return kvm_mmu_page_fault(&svm->vcpu, fault_address, error_code,
-			svm->vmcb->control.insn_bytes,
+			static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
+			svm->vmcb->control.insn_bytes : NULL,
 			svm->vmcb->control.insn_len);
 }
 
