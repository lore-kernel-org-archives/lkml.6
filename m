Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+dhjeifUPZYsETetYwpgRf2FoEByhLV17QFcZ88+a2Z6ZZlIuOe4aZ5b4RQ3DpPg7NhmAM
ARC-Seal: i=1; a=rsa-sha256; t=1523981157; cv=none;
        d=google.com; s=arc-20160816;
        b=j+jVm3JSgGnouOVqGyzag69KrWA6Gdydlo+84JslXux0EdpNVqhTUQK2zfHML8RNfD
         nmR51YiX+bzp+kHalRb6aLFWJ+yjSw2Ap4CNyB4S99/xzvHQLtUVWumtfn1xUQhW7RQt
         kqoVIGcve9MLu5QRPibfbV4jlK1BpVjTA5BSDI/MFrqEItirLYY5kO29iP5FopCVjiwU
         nl+Tx0z5XYVCiw+ujiUFepfAEWRpCatXze+g1DUxc6bqhV6Ze9uPsSK7oA2RnpUMuM+s
         L/pe9DmGivdC7ZK6oG7PpprKwGnT/X+zAJN7lcdNHDrdpZ+yTyaX/rA9F0BzK0Axk2Of
         Bqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QAei+o/rnFpve0reAy6B1fYMl8q0OoPabTWWRxeCFLU=;
        b=0+JNBjABSfnIQhy3TV9UFhAR04PDlV9h19bPa/Pp7WhGY6ntvuGKCr2t1CnKRw4aUR
         jxLSNyk2MFwCo12sF8Li5NQuCZ/ZOSfIf1AeDxhvEMeN3F3fm4V77TBZFLXzLfumuBTK
         hN8KyhEzSS0QQjVr8kZV67YyyivVBpeKd9sLgmko0zJyR/qZSAdOfJ7zEGq+92y/UU+N
         giq7ZmVx/4XlukMcGeacT+IbFIVgqobC+YPjXEUdO9V6uJheZ1j6PuV8jlLH1W45oYD9
         NWTIJki0QN4WsFNjINhKLE4aUJ93S5Hi40X8h1qanGU9CyPlrkpkYGfO14+D6qCbr/Ub
         sz0w==
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
Subject: [PATCH 4.14 14/49] KVM: PPC: Book3S HV: trace_tlbie must not be called in realmode
Date: Tue, 17 Apr 2018 17:58:53 +0200
Message-Id: <20180417155715.687711563@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009728604177210?=
X-GMAIL-MSGID: =?utf-8?q?1598010065658086396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -447,8 +447,6 @@ static void do_tlbies(struct kvm *kvm, u
 		for (i = 0; i < npages; ++i) {
 			asm volatile(PPC_TLBIE_5(%0,%1,0,0,0) : :
 				     "r" (rbvalues[i]), "r" (kvm->arch.lpid));
-			trace_tlbie(kvm->arch.lpid, 0, rbvalues[i],
-				kvm->arch.lpid, 0, 0, 0);
 		}
 		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 		kvm->arch.tlbie_lock = 0;
@@ -458,8 +456,6 @@ static void do_tlbies(struct kvm *kvm, u
 		for (i = 0; i < npages; ++i) {
 			asm volatile(PPC_TLBIEL(%0,%1,0,0,0) : :
 				     "r" (rbvalues[i]), "r" (0));
-			trace_tlbie(kvm->arch.lpid, 1, rbvalues[i],
-				0, 0, 0, 0);
 		}
 		asm volatile("ptesync" : : : "memory");
 	}
