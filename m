Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB98C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110A52082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMzEhYP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110A52082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeLDLIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:08:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbeLDLIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:08:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 577922151B;
        Tue,  4 Dec 2018 11:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921681;
        bh=nkcHH/Rk4Xw3Qc5yXz7X8r4aAO1nOiYQK/Y15zle+ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMzEhYP3b71fYs9A3Z8PsJxZQMUrvnKO/zfVevsLu2/rDWcJD/APnGnXV8sbnGace
         D5uHYzXzraPXoykeGx2brEn+3VpVxGIG1p5uos4EnffIppCB5X2ZL88nM5Qwj1iAm2
         AUoFF9CLhQSfypi0yDVHb2QgxnYgtg2CHpyZgWWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 19/50] kvm: mmu: Fix race in emulated page table writes
Date:   Tue,  4 Dec 2018 11:50:14 +0100
Message-Id: <20181204103715.498761676@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junaid Shahid <junaids@google.com>

commit 0e0fee5c539b61fdd098332e0e2cc375d9073706 upstream.

When a guest page table is updated via an emulated write,
kvm_mmu_pte_write() is called to update the shadow PTE using the just
written guest PTE value. But if two emulated guest PTE writes happened
concurrently, it is possible that the guest PTE and the shadow PTE end
up being out of sync. Emulated writes do not mark the shadow page as
unsync-ed, so this inconsistency will not be resolved even by a guest TLB
flush (unless the page was marked as unsync-ed at some other point).

This is fixed by re-reading the current value of the guest PTE after the
MMU lock has been acquired instead of just using the value that was
written prior to calling kvm_mmu_pte_write().

Signed-off-by: Junaid Shahid <junaids@google.com>
Reviewed-by: Wanpeng Li <wanpengli@tencent.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |   27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4297,9 +4297,9 @@ static bool need_remote_flush(u64 old, u
 }
 
 static u64 mmu_pte_write_fetch_gpte(struct kvm_vcpu *vcpu, gpa_t *gpa,
-				    const u8 *new, int *bytes)
+				    int *bytes)
 {
-	u64 gentry;
+	u64 gentry = 0;
 	int r;
 
 	/*
@@ -4311,22 +4311,12 @@ static u64 mmu_pte_write_fetch_gpte(stru
 		/* Handle a 32-bit guest writing two halves of a 64-bit gpte */
 		*gpa &= ~(gpa_t)7;
 		*bytes = 8;
-		r = kvm_vcpu_read_guest(vcpu, *gpa, &gentry, 8);
-		if (r)
-			gentry = 0;
-		new = (const u8 *)&gentry;
 	}
 
-	switch (*bytes) {
-	case 4:
-		gentry = *(const u32 *)new;
-		break;
-	case 8:
-		gentry = *(const u64 *)new;
-		break;
-	default:
-		gentry = 0;
-		break;
+	if (*bytes == 4 || *bytes == 8) {
+		r = kvm_vcpu_read_guest_atomic(vcpu, *gpa, &gentry, *bytes);
+		if (r)
+			gentry = 0;
 	}
 
 	return gentry;
@@ -4437,8 +4427,6 @@ static void kvm_mmu_pte_write(struct kvm
 
 	pgprintk("%s: gpa %llx bytes %d\n", __func__, gpa, bytes);
 
-	gentry = mmu_pte_write_fetch_gpte(vcpu, &gpa, new, &bytes);
-
 	/*
 	 * No need to care whether allocation memory is successful
 	 * or not since pte prefetch is skiped if it does not have
@@ -4447,6 +4435,9 @@ static void kvm_mmu_pte_write(struct kvm
 	mmu_topup_memory_caches(vcpu);
 
 	spin_lock(&vcpu->kvm->mmu_lock);
+
+	gentry = mmu_pte_write_fetch_gpte(vcpu, &gpa, &bytes);
+
 	++vcpu->kvm->stat.mmu_pte_write;
 	kvm_mmu_audit(vcpu, AUDIT_PRE_PTE_WRITE);
 


