Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48TmBeMiJN7ZjAmX6iC/8YNNxatCxjDHpaaIZifH1q7iqZPNLfVzndpib/4ef0N/skvnzg6
ARC-Seal: i=1; a=rsa-sha256; t=1522168945; cv=none;
        d=google.com; s=arc-20160816;
        b=KOxkPg6bLpyZGEF3po9iGfGHdmbntk4mk2xmkzrluekna3dZZ1dn42jOQ3ij8K0ic7
         fF2PSOI3DMnlet6zZQeGQxcITXY18hun8g8eCMlMtUU0lAzJPjmgzSqAJ6r64vDXWzsZ
         nvTS6sNHRrYSRz6SI6YigdhDeGBA5JLieyJ+uKVPwBR//JWtWmL+07kaXkYNx/qbKD4E
         yOWtmAkZ8y9d3gXhjN9PZ/96rJbHklZ2P78ssdO/6gOeJNRGwIU+cUzK+c0LYed7Tyad
         iDRaMDHtZTCJOr3mjCttzwX1eZqgc267/Kak7rTf25i1Ti4Zxv28+A3yZ3sZ7lnQGjid
         3FqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=z2z9DGrkWuu0HPOKQwOGtGJr1NU7mApIU6ImFgmc1/0=;
        b=oeukmijjxc51qz0neB6zyRN4zgdDah/iI6J151gFCmfDqMz7+MGzplw/MB/Mp+ATOw
         4zVjJAdKa7FKnPMFmn62X869gkINwPOBnj4AZhjBsYUB4cuXp7ZRKxJG1efvuvShllXP
         NyHlxQ5KZllZUMe6KRlW5NHKCYjls5QuOaJpp5ZJMCbMr+lzDh0qigoBKf2sjXCj0TI4
         MIr8v5tdbYi6b0kzthaApmh/mPU4mAOaY3KeorfIYBZaF7QTVmb/+wED4EgUwgf1x5dj
         SofPuFFU2X3g5S7GqEBBXA5xQD1xlHNDGdZ9V+9j9gwRB1Td1pBR0xgTn0Kvd9GB16i5
         mK3A==
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
Subject: [PATCH 4.15 088/105] kvm/x86: fix icebp instruction handling
Date: Tue, 27 Mar 2018 18:28:08 +0200
Message-Id: <20180327162803.598562499@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109082772350684?=
X-GMAIL-MSGID: =?utf-8?q?1596109823814594352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -352,6 +352,7 @@ enum vmcs_field {
 #define INTR_TYPE_NMI_INTR		(2 << 8) /* NMI */
 #define INTR_TYPE_HARD_EXCEPTION	(3 << 8) /* processor exception */
 #define INTR_TYPE_SOFT_INTR             (4 << 8) /* software interrupt */
+#define INTR_TYPE_PRIV_SW_EXCEPTION	(5 << 8) /* ICE breakpoint - undocumented */
 #define INTR_TYPE_SOFT_EXCEPTION	(6 << 8) /* software exception */
 
 /* GUEST_INTERRUPTIBILITY_INFO flags. */
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1079,6 +1079,13 @@ static inline bool is_machine_check(u32
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
@@ -6173,7 +6180,7 @@ static int handle_exception(struct kvm_v
 		      (KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))) {
 			vcpu->arch.dr6 &= ~15;
 			vcpu->arch.dr6 |= dr6 | DR6_RTM;
-			if (!(dr6 & ~DR6_RESERVED)) /* icebp */
+			if (is_icebp(intr_info))
 				skip_emulated_instruction(vcpu);
 
 			kvm_queue_exception(vcpu, DB_VECTOR);
