Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208C1C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0C420645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0C420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbeJNXp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:45:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35698 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726937AbeJNXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:43 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0004cd-Ho; Sun, 14 Oct 2018 16:30:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLT-0000MQ-3S; Sun, 14 Oct 2018 16:30:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Marc Zyngier" <marc.zyngier@arm.com>,
        "Shannon Zhao" <zhaoshenglong@huawei.com>,
        "Mark Rutland" <mark.rutland@arm.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.519925825@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 162/366] KVM: arm/arm64: Close VMID generation race
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit f0cf47d939d0b4b4f660c5aaa4276fa3488f3391 upstream.

Before entering the guest, we check whether our VMID is still
part of the current generation. In order to avoid taking a lock,
we start with checking that the generation is still current, and
only if not current do we take the lock, recheck, and update the
generation and VMID.

This leaves open a small race: A vcpu can bump up the global
generation number as well as the VM's, but has not updated
the VMID itself yet.

At that point another vcpu from the same VM comes in, checks
the generation (and finds it not needing anything), and jumps
into the guest. At this point, we end-up with two vcpus belonging
to the same VM running with two different VMIDs. Eventually, the
VMID used by the second vcpu will get reassigned, and things will
really go wrong...

A simple solution would be to drop this initial check, and always take
the lock. This is likely to cause performance issues. A middle ground
is to convert the spinlock to a rwlock, and only take the read lock
on the fast path. If the check fails at that point, drop it and
acquire the write lock, rechecking the condition.

This ensures that the above scenario doesn't occur.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Shannon Zhao <zhaoshenglong@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/kvm/arm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -59,7 +59,7 @@ static DEFINE_PER_CPU(struct kvm_vcpu *,
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u8 kvm_next_vmid;
-static DEFINE_SPINLOCK(kvm_vmid_lock);
+static DEFINE_RWLOCK(kvm_vmid_lock);
 
 static bool vgic_present;
 
@@ -391,11 +391,16 @@ static void update_vttbr(struct kvm *kvm
 {
 	phys_addr_t pgd_phys;
 	u64 vmid;
+	bool new_gen;
 
-	if (!need_new_vmid_gen(kvm))
+	read_lock(&kvm_vmid_lock);
+	new_gen = need_new_vmid_gen(kvm);
+	read_unlock(&kvm_vmid_lock);
+
+	if (!new_gen)
 		return;
 
-	spin_lock(&kvm_vmid_lock);
+	write_lock(&kvm_vmid_lock);
 
 	/*
 	 * We need to re-check the vmid_gen here to ensure that if another vcpu
@@ -403,7 +408,7 @@ static void update_vttbr(struct kvm *kvm
 	 * use the same vmid.
 	 */
 	if (!need_new_vmid_gen(kvm)) {
-		spin_unlock(&kvm_vmid_lock);
+		write_unlock(&kvm_vmid_lock);
 		return;
 	}
 
@@ -436,7 +441,7 @@ static void update_vttbr(struct kvm *kvm
 	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
 	kvm->arch.vttbr = pgd_phys | vmid;
 
-	spin_unlock(&kvm_vmid_lock);
+	write_unlock(&kvm_vmid_lock);
 }
 
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)

