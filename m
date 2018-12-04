Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A3CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783182087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcTlY8ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783182087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeLDK5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbeLDK5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5539214ED;
        Tue,  4 Dec 2018 10:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921057;
        bh=PaA2CqYsNYaISFZSki5ZPqSEOt8LyVWDbxRA/A/3zrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcTlY8ZKk3mCYQj+N6nMvcmGS6OjSzF4fuenmVW3SythGmem76nhjOnfntjt3vuKz
         TF1Q9J4tlmbw4vm+c0qoykxgPMMpM6tdni6U+Fl5xg1LiFNCVDuSbezYeNTmOVhOZd
         fhpxp0k1/YxEOdloYgYBF9pDRXHWN1GGmb4ZSkHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 063/139] kvm: mmu: Fix race in emulated page table writes
Date:   Tue,  4 Dec 2018 11:49:04 +0100
Message-Id: <20181204103652.612267666@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5013,9 +5013,9 @@ static bool need_remote_flush(u64 old, u
 }
 
 static u64 mmu_pte_write_fetch_gpte(struct kvm_vcpu *vcpu, gpa_t *gpa,
-				    const u8 *new, int *bytes)
+				    int *bytes)
 {
-	u64 gentry;
+	u64 gentry = 0;
 	int r;
 
 	/*
@@ -5027,22 +5027,12 @@ static u64 mmu_pte_write_fetch_gpte(stru
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
@@ -5146,8 +5136,6 @@ static void kvm_mmu_pte_write(struct kvm
 
 	pgprintk("%s: gpa %llx bytes %d\n", __func__, gpa, bytes);
 
-	gentry = mmu_pte_write_fetch_gpte(vcpu, &gpa, new, &bytes);
-
 	/*
 	 * No need to care whether allocation memory is successful
 	 * or not since pte prefetch is skiped if it does not have
@@ -5156,6 +5144,9 @@ static void kvm_mmu_pte_write(struct kvm
 	mmu_topup_memory_caches(vcpu);
 
 	spin_lock(&vcpu->kvm->mmu_lock);
+
+	gentry = mmu_pte_write_fetch_gpte(vcpu, &gpa, &bytes);
+
 	++vcpu->kvm->stat.mmu_pte_write;
 	kvm_mmu_audit(vcpu, AUDIT_PRE_PTE_WRITE);
 


