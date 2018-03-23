Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuB7RmXq2kbXgLfIuJAdfHo7NpqL4RMsqR4ecsgdD2zLkoe+Gj9WRHqNk0Iv7y63q+hKqVo
ARC-Seal: i=1; a=rsa-sha256; t=1521800281; cv=none;
        d=google.com; s=arc-20160816;
        b=NA6rA4ah98f9LcaUWrds9MZSFpbMBQygr+yhWIknvMOjL7tN3kStDfB+B7sWSfUANs
         7LPNBiBOpj/UVCq9wwqPohLEMKnme2P1lkOQlj0PlY5p2IipjOle3yDpTcYs8hqrvN/w
         ogMMte/7J1xlKiX/SKNQr0wR0ZkedutJiPKstQ9uqoeX23El6+LsXA5IqwTsgJW7DqIm
         krHJufdZxsm8jJ0E1G7H7CarkQKVyI3ACHlJKNrVCjpyzXde0uYUgF6iU05CbqCRMZSo
         ag1Lqvc8hURE1BldEiVhRKMhL1cUmUJszxdYYsdU4qWRPZPOen5EvLfGj4SsyCMfi0EW
         XCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DQrD9TrMjtgPk9qlmvHEf4k6c66iZeJdpoA+iIEVtzM=;
        b=YiqTJQwrKAgX+xFV4Ta9rL0YgOHDKp/i5EaJv++DXybnVvI6JdqdEuNZGGVz/DQhAw
         wHEUUncGBf1flCQZCrRGz9QBmgJyEXAKY/IMo1M7PpRjwAtDUQfOHRzPGEi6K0Fv0hKH
         1qdteeKocbLVRsBG6pUcIw9HnocXFYjyxpawg7s3Njxi0PkupRixgeFOUh8OlzkesBri
         SD0WpPQSCi7rQzW8bHmhI6IbFJIRr2PXDwnkstkS0l1NLhF61sqGW7yuhPtOlkcF9yBH
         7nxQuYgqlpObgbISqfq74eb3VRj2hkpOI+7gegmpcRTxxEkHU9QY76fSezlPNjfjLmWB
         wEOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	David Gibson <david@gibson.dropbear.id.au>,
	Paul Mackerras <paulus@ozlabs.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 13/47] KVM: PPC: Book3S PR: Exit KVM on failed mapping
Date: Fri, 23 Mar 2018 10:55:04 +0100
Message-Id: <20180323094248.688129346@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722492763141099?=
X-GMAIL-MSGID: =?utf-8?q?1595723251955766612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kardashevskiy <aik@ozlabs.ru>


[ Upstream commit bd9166ffe624000140fc6b606b256df01fc0d060 ]

At the moment kvmppc_mmu_map_page() returns -1 if
mmu_hash_ops.hpte_insert() fails for any reason so the page fault handler
resumes the guest and it faults on the same address again.

This adds distinction to kvmppc_mmu_map_page() to return -EIO if
mmu_hash_ops.hpte_insert() failed for a reason other than full pteg.
At the moment only pSeries_lpar_hpte_insert() returns -2 if
plpar_pte_enter() failed with a code other than H_PTEG_FULL.
Other mmu_hash_ops.hpte_insert() instances can only fail with
-1 "full pteg".

With this change, if PR KVM fails to update HPT, it can signal
the userspace about this instead of returning to guest and having
the very same page fault over and over again.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/book3s_64_mmu_host.c |    5 ++++-
 arch/powerpc/kvm/book3s_pr.c          |    6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -176,12 +176,15 @@ map_again:
 	ret = ppc_md.hpte_insert(hpteg, vpn, hpaddr, rflags, vflags,
 				 hpsize, hpsize, MMU_SEGSIZE_256M);
 
-	if (ret < 0) {
+	if (ret == -1) {
 		/* If we couldn't map a primary PTE, try a secondary */
 		hash = ~hash;
 		vflags ^= HPTE_V_SECONDARY;
 		attempt++;
 		goto map_again;
+	} else if (ret < 0) {
+		r = -EIO;
+		goto out_unlock;
 	} else {
 		trace_kvm_book3s_64_mmu_map(rflags, hpteg,
 					    vpn, hpaddr, orig_pte);
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -625,7 +625,11 @@ int kvmppc_handle_pagefault(struct kvm_r
 			kvmppc_mmu_unmap_page(vcpu, &pte);
 		}
 		/* The guest's PTE is not mapped yet. Map on the host */
-		kvmppc_mmu_map_page(vcpu, &pte, iswrite);
+		if (kvmppc_mmu_map_page(vcpu, &pte, iswrite) == -EIO) {
+			/* Exit KVM if mapping failed */
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			return RESUME_HOST;
+		}
 		if (data)
 			vcpu->stat.sp_storage++;
 		else if (vcpu->arch.mmu.is_dcbz32(vcpu) &&
