Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227PMnM1Y6VkgWogLRRHwAo1uR+Cx15qJFRfbE0wpgwnyQM3UaKpm+Q6nIKKD1G9oiynLFSf
ARC-Seal: i=1; a=rsa-sha256; t=1519218489; cv=none;
        d=google.com; s=arc-20160816;
        b=ieHBF11Zlho1rH7PxYbxuuOLKa/YAX2nZzEvJZSvbWbJwsrHHyKeBkML4TBlVk5msK
         O3TQm+RFFqI1616Y+jrCk0DzNS+R1rH9y6NOjtLFJAz17WXpZYNnhEaEsji3TeBj72v6
         gXdqcymyDaXymbYrn6WgvpfUl/KzfYBMYCgsYzVnrTS56LfrFkHqd6FEkySc1dZT010m
         EMpJY5ZoDb/9qZ3qpTyGUoJ5ZjyDDG1k1l3y5vpXc1wOu92yRqWJf7PHoogI609CDh3N
         D/x/qooltftVMTBPR/lPefJRWi2K2+aUX3sOmiyMKIdqKRkgx/d97JblA2bnqoG3aVy/
         OMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QFDmPDECbxrkJHHzUbyDj2hxCXztv7/40PRo9lRKyZM=;
        b=bW0P1ywZQ7d9mVQacsEBuPTb2R+BC8kdeb2wmujs9ZJn8noR1s2L2uFzgz51DraOO6
         QcFUfExA+B+UKyZus7jMJ8LFuVpR+zyl5IM1uShwTiMIy04H9cHR34gsaS9Y41OjF43h
         bkP10G/MwFNQLkCi+clJ9k4it8rcPKg7GIDHpiEKUWPVsKUJ2KfImtPKYAFCAnmOOR+4
         3P4YUvUptqqQEC6Ug13Q9qU4ZK13bdiMKnrIz7sZ0N42w4jDNwTv7Ftjg9hUO/c7+r+4
         I67kDPdxpAcIORMdnjBW1hrY8jW7kL5kMen4BJDrLswOJXb/8Gwx9vwZFLVDAn7YPYgn
         43jA==
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
Subject: [PATCH 4.15 023/163] powerpc/mm: Flush radix process translations when setting MMU type
Date: Wed, 21 Feb 2018 13:47:32 +0100
Message-Id: <20180221124531.475915279@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015440301212181?=
X-GMAIL-MSGID: =?utf-8?q?1593016046797365987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
