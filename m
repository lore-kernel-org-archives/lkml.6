Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49u8pIdkHDYvgZq8psIM4zLQoD77ZK6W2E8jmmcpcVuMJ3vXhFM4VOhdec68IADOs2kIuKZ
ARC-Seal: i=1; a=rsa-sha256; t=1523981022; cv=none;
        d=google.com; s=arc-20160816;
        b=O2PcnEzEf7eUoJHNMUhcSBiyPjIN5J6Z8hI4xgvWdqWxOzCn5k50LjT8CXOpFuWCgm
         kPNl1CXs4gnIMB7XZp9A4L3PkO/FrCDtaaoL4lqqXOrIkejZUkJZcdWl/TlvXymwQ2B0
         tPs9HGpH3hRExBuDvOyXagFVxBATBumy3sNVOTWIROEit6AqstTamBHJfXGzocjMqd7v
         KXpaeNWdzHRyrONmA3arPNtnAwmJLuC0oxEOLJD5AszriaNWV8eCPrsyLPpsd4Ks9KpU
         FHS6u52YU66tavsRor6ot9ynRQRxXIRBGBE7CMmt/zir/a5UeSurYinWoucnSi40cxIk
         tQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=De5WKk5TzimG5mODcI/+Q4cj8qTyBaxfDisoCPphDXA=;
        b=ZzXrS27CN+l5M4OOkKGa0N5KLssCy+zGJNGuTYPRyrfpPoQyi0zCNG/DWqagSJOf8O
         OFyJCm4maNJWc4duN0CCpN45j3nEZ9JSzofi8mK6OaTTh8znNEmjO+SZOACpBAMfcDK9
         mMXofJK3YKDhYEQN4vCvGipmGkRD4wdOPHxJCfnOnei6DYu6ZtCeQtKZlefk8/NOuQL0
         blKXsUhw5cdCsBsX2cK54FEbSQ7xJo2ANhzutClu+FpqKbu/qiNzqsvTDbWA2/hO6aPk
         NXknJt2QbVwmr5ryETjHHYNy5fAB8UqorPwm3PdMU/VTFndPkjPayM0aXAk6DoS9dPK+
         R/nA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.15 20/53] KVM: PPC: Book3S HV: trace_tlbie must not be called in realmode
Date: Tue, 17 Apr 2018 17:58:45 +0200
Message-Id: <20180417155724.087762346@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009728604177210?=
X-GMAIL-MSGID: =?utf-8?q?1598009924631594789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 19ce7909ed11c49f7eddf59e7f49cd3062bf83d5 upstream.

This crashes with a "Bad real address for load" attempting to load
from the vmalloc region in realmode (faulting address is in DAR).

  Oops: Bad interrupt in KVM entry/exit code, sig: 6 [#1]
  LE SMP NR_CPUS=2048 NUMA PowerNV
  CPU: 53 PID: 6582 Comm: qemu-system-ppc Not tainted 4.16.0-01530-g43d1859f0994
  NIP:  c0000000000155ac LR: c0000000000c2430 CTR: c000000000015580
  REGS: c000000fff76dd80 TRAP: 0200   Not tainted  (4.16.0-01530-g43d1859f0994)
  MSR:  9000000000201003 <SF,HV,ME,RI,LE>  CR: 48082222  XER: 00000000
  CFAR: 0000000102900ef0 DAR: d00017fffd941a28 DSISR: 00000040 SOFTE: 3
  NIP [c0000000000155ac] perf_trace_tlbie+0x2c/0x1a0
  LR [c0000000000c2430] do_tlbies+0x230/0x2f0

I suspect the reason is the per-cpu data is not in the linear chunk.
This could be restored if that was able to be fixed, but for now,
just remove the tracepoints.

Fixes: 0428491cba92 ("powerpc/mm: Trace tlbie(l) instructions")
Cc: stable@vger.kernel.org # v4.13+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -470,8 +470,6 @@ static void do_tlbies(struct kvm *kvm, u
 		for (i = 0; i < npages; ++i) {
 			asm volatile(PPC_TLBIE_5(%0,%1,0,0,0) : :
 				     "r" (rbvalues[i]), "r" (kvm->arch.lpid));
-			trace_tlbie(kvm->arch.lpid, 0, rbvalues[i],
-				kvm->arch.lpid, 0, 0, 0);
 		}
 		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 		kvm->arch.tlbie_lock = 0;
@@ -481,8 +479,6 @@ static void do_tlbies(struct kvm *kvm, u
 		for (i = 0; i < npages; ++i) {
 			asm volatile(PPC_TLBIEL(%0,%1,0,0,0) : :
 				     "r" (rbvalues[i]), "r" (0));
-			trace_tlbie(kvm->arch.lpid, 1, rbvalues[i],
-				0, 0, 0, 0);
 		}
 		asm volatile("ptesync" : : : "memory");
 	}
