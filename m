Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B30C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D6D20868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D6D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeH2Rwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:52:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727316AbeH2Rwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:52:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21D1340216E8;
        Wed, 29 Aug 2018 13:55:45 +0000 (UTC)
Received: from flask (unknown [10.40.205.185])
        by smtp.corp.redhat.com (Postfix) with SMTP id B4D842166B41;
        Wed, 29 Aug 2018 13:55:41 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Wed, 29 Aug 2018 15:55:40 +0200
Date:   Wed, 29 Aug 2018 15:55:40 +0200
From:   Radim Krcmar <rkrcmar@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: LAPIC: Fix pv ipis out-of-bounds access
Message-ID: <20180829135539.GA15829@flask>
References: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
 <A523C29C-C3E8-4FEF-8620-96365F774582@oracle.com>
 <20180829101205.jsp53e2wq7fc6ukd@mwanda>
 <20180829101822.qo3u7lsmghs3kcuf@mwanda>
 <CANRm+Cy9n=2Ssy_cEWRtnoQJczjdqB+m-dA6zesz75r0h532iA@mail.gmail.com>
 <20180829102910.rkyato47chayt22s@mwanda>
 <485CA660-9423-45B7-848F-49E3D13D5CBD@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <485CA660-9423-45B7-848F-49E3D13D5CBD@oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 29 Aug 2018 13:55:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 29 Aug 2018 13:55:45 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-29 13:43+0300, Liran Alon:
> Why is “min” defined as “int” instead of “unsigned int”?
> It represents the lowest APIC ID in bitmap so it can’t be negative…

Right,

I think the code would look better as something like (untested):

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0cefba28c864..24fc84eb97d2 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -548,7 +548,7 @@ int kvm_apic_set_irq(struct kvm_vcpu *vcpu, struct kvm_lapic_irq *irq,
 }
 
 int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
-    		    unsigned long ipi_bitmap_high, int min,
+		    unsigned long ipi_bitmap_high, u32 min,
 		    unsigned long icr, int op_64_bit)
 {
 	int i;
@@ -557,6 +557,7 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 	struct kvm_lapic_irq irq = {0};
 	int cluster_size = op_64_bit ? 64 : 32;
 	int count = 0;
+	unsigned long ipi_bitmap[2] = {ipi_bitmap_low, ipi_bitmap_high};
 
 	irq.vector = icr & APIC_VECTOR_MASK;
 	irq.delivery_mode = icr & APIC_MODE_MASK;
@@ -571,16 +572,14 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 	rcu_read_lock();
 	map = rcu_dereference(kvm->arch.apic_map);
 
-	/* Bits above cluster_size are masked in the caller.  */
-	for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
-		vcpu = map->phys_map[min + i]->vcpu;
-		count += kvm_apic_set_irq(vcpu, &irq, NULL);
-	}
+	if (min <= map->max_apic_id) {
+		size_t ipi_bitmap_size = MIN(sizeof(ipi_bitmap) * 8,
+		                             map->max_apic_id - min + 1);
 
-	min += cluster_size;
-	for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
-		vcpu = map->phys_map[min + i]->vcpu;
-		count += kvm_apic_set_irq(vcpu, &irq, NULL);
+		for_each_set_bit(i, ipi_bitmap, ipi_bitmap_size) {
+			vcpu = map->phys_map[min + i]->vcpu;
+			count += kvm_apic_set_irq(vcpu, &irq, NULL);
+		}
 	}
 
 	rcu_read_unlock();
