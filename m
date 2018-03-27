Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+rfR/C0QLeoWFK+ncli8hl+YJ7ivlF6nMYvFdux+LUdZS/QY76GE14/cR8dNcwx8QZl+0V
ARC-Seal: i=1; a=rsa-sha256; t=1522168355; cv=none;
        d=google.com; s=arc-20160816;
        b=oXzt6JTUjS+GaeZUHx0Un3JaPhygeqhv4lfNKZnwaPwB681zcManbxNsheU9h9pmWw
         egysDAysXdpMmwwIbrUblo7VbST4e5TGQPcbCdxCRYiAqJ5dCeHjzuhhuZFD4nNVc91X
         F01hRTcfxuC3Y5HzIhrdUJ42V/lRDxW6b0YCUofP6h/fMgc5KOoCEX+6pk4PHsbNSHMX
         ZtSg4pGewi5AwGSR6Vc79VudH2BAWYAUfvql/2QwakQxcjQRjqKBOifrezZwmapqoWID
         5jp9JM2vyk3BPFhsBcg1/uZR6YBCPYkScTQoR4vzOqjVdaeSdQvkwOF38UNHFxeZqI64
         QmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wPA3F5pvN8LD8dNykTvhFzB9kShjuKJ5UGGuhyXyYEc=;
        b=clzq5x4Kz3oF09FIzulTJoYyogU5yaGtVePFX16ijyBcS56+A4o00WewagDuJTpj5S
         zo05pSFNv5AEZ50I6+wIK6fe4qL7NwdW2srHym6lRWchp6DNCpTo2T3c+o7URdu7M+vE
         B0rtW0Oh8NA7V1dnoGjvRtSoXakQbgcsRf3U6MeoY02OFuU0bnsF+dUAsazT3RcwICgF
         a12/WMsPEcBuKGSgjdGzZMyeUvwndpJgPsYt2erbpmE9ZgVusIp1lHKUXosUvIJmFnio
         0vMWRLJ9xNFvikC7i76LeBeU062E2l+F1S+dLVKmHHlVfT5Yra2sEjCVEQyhTsAyD9+q
         H64w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 50/67] kvm/x86: fix icebp instruction handling
Date: Tue, 27 Mar 2018 18:27:42 +0200
Message-Id: <20180327162730.130912033@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109082772350684?=
X-GMAIL-MSGID: =?utf-8?q?1596109205331963690?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 32d43cd391bacb5f0814c2624399a5dad3501d09 upstream.

The undocumented 'icebp' instruction (aka 'int1') works pretty much like
'int3' in the absense of in-circuit probing equipment (except,
obviously, that it raises #DB instead of raising #BP), and is used by
some validation test-suites as such.

But Andy Lutomirski noticed that his test suite acted differently in kvm
than on bare hardware.

The reason is that kvm used an inexact test for the icebp instruction:
it just assumed that an all-zero VM exit qualification value meant that
the VM exit was due to icebp.

That is not unlike the guess that do_debug() does for the actual
exception handling case, but it's purely a heuristic, not an absolute
rule.  do_debug() does it because it wants to ascribe _some_ reasons to
the #DB that happened, and an empty %dr6 value means that 'icebp' is the
most likely casue and we have no better information.

But kvm can just do it right, because unlike the do_debug() case, kvm
actually sees the real reason for the #DB in the VM-exit interruption
information field.

So instead of relying on an inexact heuristic, just use the actual VM
exit information that says "it was 'icebp'".

Right now the 'icebp' instruction isn't technically documented by Intel,
but that will hopefully change.  The special "privileged software
exception" information _is_ actually mentioned in the Intel SDM, even
though the cause of it isn't enumerated.

Reported-by: Andy Lutomirski <luto@kernel.org>
Tested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/vmx.h |    1 +
 arch/x86/kvm/vmx.c         |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -309,6 +309,7 @@ enum vmcs_field {
 #define INTR_TYPE_NMI_INTR		(2 << 8) /* NMI */
 #define INTR_TYPE_HARD_EXCEPTION	(3 << 8) /* processor exception */
 #define INTR_TYPE_SOFT_INTR             (4 << 8) /* software interrupt */
+#define INTR_TYPE_PRIV_SW_EXCEPTION	(5 << 8) /* ICE breakpoint - undocumented */
 #define INTR_TYPE_SOFT_EXCEPTION	(6 << 8) /* software exception */
 
 /* GUEST_INTERRUPTIBILITY_INFO flags. */
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1053,6 +1053,13 @@ static inline bool is_machine_check(u32
 		(INTR_TYPE_HARD_EXCEPTION | MC_VECTOR | INTR_INFO_VALID_MASK);
 }
 
+/* Undocumented: icebp/int1 */
+static inline bool is_icebp(u32 intr_info)
+{
+	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VALID_MASK))
+		== (INTR_TYPE_PRIV_SW_EXCEPTION | INTR_INFO_VALID_MASK);
+}
+
 static inline bool cpu_has_vmx_msr_bitmap(void)
 {
 	return vmcs_config.cpu_based_exec_ctrl & CPU_BASED_USE_MSR_BITMAPS;
@@ -5733,7 +5740,7 @@ static int handle_exception(struct kvm_v
 		      (KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))) {
 			vcpu->arch.dr6 &= ~15;
 			vcpu->arch.dr6 |= dr6 | DR6_RTM;
-			if (!(dr6 & ~DR6_RESERVED)) /* icebp */
+			if (is_icebp(intr_info))
 				skip_emulated_instruction(vcpu);
 
 			kvm_queue_exception(vcpu, DB_VECTOR);
