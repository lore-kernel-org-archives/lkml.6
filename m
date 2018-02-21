Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227u/JR27WB865fQa0ZCTOx49/KRQ3oEEwCeBHhj5w7bPGnrJVmYr8rmC7wr0Lf0MF85bTCX
ARC-Seal: i=1; a=rsa-sha256; t=1519217788; cv=none;
        d=google.com; s=arc-20160816;
        b=xtooRcQY1h+99Kh7smvq+4LYXBB7vjcx4igZG0kdP6FUA00XZeCS/zPZ9BNnGhaFzP
         xCsZR9BVlX/BODiVU2dGiqWk9dxFWKyrSgHqNN2K6HNj0s8j8P170b6YMoyAdFQQe8jP
         7d8QEsT6gnJXfYQRxFXqZsf9EWasJuaDdFiuHlFkkYDmOQc7P2odZE37FHOUNciuGRWJ
         LQ1AmbTYJ2inM5l8czZFEvI1N08RNu2Z2ONhKmU/Vl8yGYoZIyvw5l8ZOCHxNTVYeliv
         t/T6rUQtuaG5fkxAJKTGDvQimXV1G98UFB+/zdKeuI4EiBxni18W1QBDNYLiWUzBhLDe
         F1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gshqDhAGf/3i1Yl1yih/UH305H35MpsKN3qOqhNLa4U=;
        b=ezbJqp/4l2KcBW/5S5iLGRMTj1LBkXXjg4bSHmpOWak81vuNWf99cQpm8uMWFJzf5q
         WSYeDpK9//UCs4G1jFP80gL6/yBh15KrEM6s2rz15rBKw/ToAVBc5CS6CDbEdGRvsQvh
         t+L6mZ8WGggf0MGpaJ9A8L/apo8XL8y6kacoU3Zyottm/cU08K1Wm22oZVXDhmJD9knH
         OWJwB7+RaeUl6nXlVVfkxlU+1rpw/f3D3Hlupm2bL9rKhcIlq+PiQpmx+q5JOtb6GgtB
         4B2MIMNJ4gq/98k2IVBEs/JvpVIovR8Q3taEo26uH3AQZQKocEwPBi1G7gCANly3sImU
         ctqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	KarimAllah Ahmed <karahmed@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jim Mattson <jmattson@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	arjan.van.de.ven@intel.com,
	dave.hansen@intel.com,
	kvm@vger.kernel.org,
	sironi@amazon.de,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 55/77] X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs
Date: Wed, 21 Feb 2018 13:49:04 +0100
Message-Id: <20180221124434.536279228@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015311446762291?=
X-GMAIL-MSGID: =?utf-8?q?1593015311446762291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed <karahmed@amazon.de>

commit 206587a9fb764d71f035dc7f6d3b6488f5d5b304 upstream.

These two variables should check whether SPEC_CTRL and PRED_CMD are
supposed to be passed through to L2 guests or not. While
msr_write_intercepted_l01 would return 'true' if it is not passed through.

So just invert the result of msr_write_intercepted_l01 to implement the
correct semantics.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jim Mattson <jmattson@google.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: dave.hansen@intel.com
Cc: kvm@vger.kernel.org
Cc: sironi@amazon.de
Fixes: 086e7d4118cc ("KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL")
Link: http://lkml.kernel.org/r/1518305967-31356-5-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9606,8 +9606,8 @@ static inline bool nested_vmx_merge_msr_
 	 *    updated to reflect this when L1 (or its L2s) actually write to
 	 *    the MSR.
 	 */
-	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
-	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
+	bool pred_cmd = !msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
+	bool spec_ctrl = !msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
 
 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
 	    !pred_cmd && !spec_ctrl)
