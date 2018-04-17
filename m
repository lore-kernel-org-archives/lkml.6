Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ogaVpBd9z90CGUVHkWkcOLzV509g/hjkoQztolzbPkQXAF7rlYK7ImnlvdkyhEGyUoeRt
ARC-Seal: i=1; a=rsa-sha256; t=1523980835; cv=none;
        d=google.com; s=arc-20160816;
        b=pvEEiay4J2wnsEP/D6D2ZyFLjA4yJeV2Hll6Qoyp0nMyvCMjbIobYnX+DGZfTMQuJg
         7Zcn8MspscndW03oYLE+yaCA9fbQ+Tc85pnkVD9vlg4jgiKtHDjp5jzBJPnYza9TEdeg
         Id1MCkL792seO06C+xN1qOm92KY58uK6Ta7SCV6fT3JZMqDcAMjwJp3EW6aAw/GOqeVZ
         OwGhYUWL5JU/lgy/gG6efuI5eHRxdv1JxxJc8bxqtZr4wxCLa15XP/cdxOxmf/lwxDHJ
         xJDnFCH52eg6nwI3ORNqYX++ZChoaPa/G4A2wAIgA4TSYJyShckktWhngePEugQFgX4r
         nfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ERTu1cnsEN1/WWiPmTbrN6DzbgZzQYo+rU8CcbeBMkw=;
        b=W+c32YhNh5womPQG42jdHPzY3Y9TLQ5e9CVLdnifrcY0dU3HSQ7TEYoHkYWRcQ4D7A
         D9uCDPoU4FqjOIVxT0iriiNFoA+eYZg+HmyZdPZo5tdXsxX/wtYOx0n8ygxHWwry9BHy
         18ZYAFtT4u9y6EAr9+mgjmuIeU2b8sj9h6EfnEpu3ne801i1lsi+C3HHM+znVeQmuMt2
         uYUyNycmXNxmvk+8jHlO9SUBdK3k5vk7QDv48/PvoXPhiypCPHtmNYyE6HYDWlumdF3g
         n6JOgv27xyGCbuNJD8W1ahe6mGlfYu02DfExxjXEKO7PGrINeq0cI57QUTCFONYPkPPO
         uQ/w==
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
Subject: [PATCH 4.16 21/68] KVM: PPC: Book3S HV: trace_tlbie must not be called in realmode
Date: Tue, 17 Apr 2018 17:57:34 +0200
Message-Id: <20180417155750.207845446@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009728604177210?=
X-GMAIL-MSGID: =?utf-8?q?1598009728604177210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
 		if (cpu_has_feature(CPU_FTR_P9_TLBIE_BUG)) {
@@ -492,8 +490,6 @@ static void do_tlbies(struct kvm *kvm, u
 		for (i = 0; i < npages; ++i) {
 			asm volatile(PPC_TLBIEL(%0,%1,0,0,0) : :
 				     "r" (rbvalues[i]), "r" (0));
-			trace_tlbie(kvm->arch.lpid, 1, rbvalues[i],
-				0, 0, 0, 0);
 		}
 		asm volatile("ptesync" : : : "memory");
 	}
