Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224GVPuqPK+7lorWm9OayxaoifPqy7KzaB7lFpVV2m7I/1wz5TzNzCS/kdZFHmYNVb1abYBJ
ARC-Seal: i=1; a=rsa-sha256; t=1519217910; cv=none;
        d=google.com; s=arc-20160816;
        b=TnRoiyULEiSa2PJze+nrDYWdR16T80vcDoJ3MI1XwEjK8TZh7FShjfKo7G1fn0WLLc
         PG/cCSohSRh7yvkYSRQWQXQZBUiyAgWBT73YiNBFzk/YgbK/4F2hAoen/bqURTOEoyyw
         2eHVi+faJImpGMGnC3p20j5Xck1UV0hHh8iwSPsZ0e5eNGR4UJT+YnCZ6+tPzAQuRV9s
         P7a183MNJv1qCND3pfUOx3s6aFDEU4Ng2aCJhlJOwsJVzuXwx5An2VFHYDTt1Se29SoK
         9LpNbkzFjsbvKkChLMV8CXAy26c5C9e692/3Of6i6xb8YRTXj6l/NXxA64VgxrP37+Yv
         Bhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sK4vBGMS3O3SsQhr1L2kynC38ADTT8JN/VxRRMOjgdI=;
        b=HRdY7qYNOMePgnuwAJvtk66yCJWTbL80tqoY4CFbw+0pOClM92oGhuJSfaAi+yPQIl
         84X7VNMDeNGpnmkLawojupFvPj6IAqXsF2fwF0oC+QdtDKxMb9PImLB71+fTUJy0Fikt
         56u56SVB6uvKEQ+XUv875MB1SKNtUwz7vuj3860zxUJ/UQRSEhRZKYkMfGAkC+LTlWPO
         W55v9Bu0210NgyPfdJhQe4+U0poLJOXxZx/hp7B1kQ8TN5x1JcfRUR5bbFIEDs5DtR/M
         C3W6q7zkiwydkEOURt9ohcq3jBN5ep8AkmOlwjXTvb62n2ceL68DA6h2zGlmw3ZWoFXn
         fKgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Laurent Vivier <lvivier@redhat.com>,
	Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 021/167] powerpc/mm: Flush radix process translations when setting MMU type
Date: Wed, 21 Feb 2018 13:47:12 +0100
Message-Id: <20180221124525.783825428@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015440301212181?=
X-GMAIL-MSGID: =?utf-8?q?1593015440301212181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kardashevskiy <aik@ozlabs.ru>

commit 62e984ddfd6b056d399e24113f5e6a7145e579d8 upstream.

Radix guests do normally invalidate process-scoped translations when a
new pid is allocated but migrated guests do not invalidate these so
migrated guests crash sometime, especially easy to reproduce with
migration happening within first 10 seconds after the guest boot start
on the same machine.

This adds the "Invalidate process-scoped translations" flush to fix
radix guests migration.

Fixes: 2ee13be34b13 ("KVM: PPC: Book3S HV: Update kvmppc_set_arch_compat() for ISA v3.00")
Cc: stable@vger.kernel.org # v4.10+
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/pgtable_64.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -483,6 +483,8 @@ void mmu_partition_table_set_entry(unsig
 	if (old & PATB_HR) {
 		asm volatile(PPC_TLBIE_5(%0,%1,2,0,1) : :
 			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
+		asm volatile(PPC_TLBIE_5(%0,%1,2,1,1) : :
+			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
 		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 1);
 	} else {
 		asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : :
