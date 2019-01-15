Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F11C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D0D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570456;
	bh=wKX+v7Ayh9D9Ayomi9/v940GNfK//n5ZNnK2yrvjfQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J6Pqrd6m9BL+D8JwpTH0HapSlPCloYmT7oe8iZjWyuy0P4ZHHdHCGrJLitpNH8kJJ
	 MnMMVLq7YV9TvZdCORGPJ5RUMrT+2eZ3vhM/ti9MX3ayjUkEQiu6CjXAHjTXMGQ07m
	 X6cZf8qZTLOc7NKXByps4QnjBr6fDGYq2OqXRuOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbfAOQkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732676AbfAOQkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:40:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C6B62054F;
        Tue, 15 Jan 2019 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570450;
        bh=wKX+v7Ayh9D9Ayomi9/v940GNfK//n5ZNnK2yrvjfQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ort12DRdBJ7mVk0kX6wmbp/MtBNaGKfR7snfOLz83pc8Q6NDHT9A5HSqy41o6awvM
         8W/zxsJtxFvauJBOYP88dzgtv8Nsh2BnU/S3Tmr1GYG3BZs2ymiWZYltEDqcFJ5D2l
         vp40w6/iOVwvbeuTlnfX9huy4mZ4N23Ejn6XR+sY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 27/27] KVM: arm/arm64: Fix VMID alloc race by reverting to lock-less
Date:   Tue, 15 Jan 2019 17:36:16 +0100
Message-Id: <20190115154903.313894096@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
References: <20190115154901.189747728@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoffer Dall <christoffer.dall@arm.com>

commit fb544d1ca65a89f7a3895f7531221ceeed74ada7 upstream.

We recently addressed a VMID generation race by introducing a read/write
lock around accesses and updates to the vmid generation values.

However, kvm_arch_vcpu_ioctl_run() also calls need_new_vmid_gen() but
does so without taking the read lock.

As far as I can tell, this can lead to the same kind of race:

  VM 0, VCPU 0			VM 0, VCPU 1
  ------------			------------
  update_vttbr (vmid 254)
  				update_vttbr (vmid 1) // roll over
				read_lock(kvm_vmid_lock);
				force_vm_exit()
  local_irq_disable
  need_new_vmid_gen == false //because vmid gen matches

  enter_guest (vmid 254)
  				kvm_arch.vttbr = <PGD>:<VMID 1>
				read_unlock(kvm_vmid_lock);

  				enter_guest (vmid 1)

Which results in running two VCPUs in the same VM with different VMIDs
and (even worse) other VCPUs from other VMs could now allocate clashing
VMID 254 from the new generation as long as VCPU 0 is not exiting.

Attempt to solve this by making sure vttbr is updated before another CPU
can observe the updated VMID generation.

Cc: stable@vger.kernel.org
Fixes: f0cf47d939d0 "KVM: arm/arm64: Close VMID generation race"
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/arm.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -61,7 +61,7 @@ static DEFINE_PER_CPU(struct kvm_vcpu *,
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u32 kvm_next_vmid;
 static unsigned int kvm_vmid_bits __read_mostly;
-static DEFINE_RWLOCK(kvm_vmid_lock);
+static DEFINE_SPINLOCK(kvm_vmid_lock);
 
 static bool vgic_present;
 
@@ -447,7 +447,9 @@ void force_vm_exit(const cpumask_t *mask
  */
 static bool need_new_vmid_gen(struct kvm *kvm)
 {
-	return unlikely(kvm->arch.vmid_gen != atomic64_read(&kvm_vmid_gen));
+	u64 current_vmid_gen = atomic64_read(&kvm_vmid_gen);
+	smp_rmb(); /* Orders read of kvm_vmid_gen and kvm->arch.vmid */
+	return unlikely(READ_ONCE(kvm->arch.vmid_gen) != current_vmid_gen);
 }
 
 /**
@@ -462,16 +464,11 @@ static void update_vttbr(struct kvm *kvm
 {
 	phys_addr_t pgd_phys;
 	u64 vmid;
-	bool new_gen;
 
-	read_lock(&kvm_vmid_lock);
-	new_gen = need_new_vmid_gen(kvm);
-	read_unlock(&kvm_vmid_lock);
-
-	if (!new_gen)
+	if (!need_new_vmid_gen(kvm))
 		return;
 
-	write_lock(&kvm_vmid_lock);
+	spin_lock(&kvm_vmid_lock);
 
 	/*
 	 * We need to re-check the vmid_gen here to ensure that if another vcpu
@@ -479,7 +476,7 @@ static void update_vttbr(struct kvm *kvm
 	 * use the same vmid.
 	 */
 	if (!need_new_vmid_gen(kvm)) {
-		write_unlock(&kvm_vmid_lock);
+		spin_unlock(&kvm_vmid_lock);
 		return;
 	}
 
@@ -502,7 +499,6 @@ static void update_vttbr(struct kvm *kvm
 		kvm_call_hyp(__kvm_flush_vm_context);
 	}
 
-	kvm->arch.vmid_gen = atomic64_read(&kvm_vmid_gen);
 	kvm->arch.vmid = kvm_next_vmid;
 	kvm_next_vmid++;
 	kvm_next_vmid &= (1 << kvm_vmid_bits) - 1;
@@ -513,7 +509,10 @@ static void update_vttbr(struct kvm *kvm
 	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
 	kvm->arch.vttbr = pgd_phys | vmid;
 
-	write_unlock(&kvm_vmid_lock);
+	smp_wmb();
+	WRITE_ONCE(kvm->arch.vmid_gen, atomic64_read(&kvm_vmid_gen));
+
+	spin_unlock(&kvm_vmid_lock);
 }
 
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)


