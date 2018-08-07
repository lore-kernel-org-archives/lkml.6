Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51371C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163572170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163572170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbeHGPFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:05:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727056AbeHGPFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:05:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4830D7C6CA;
        Tue,  7 Aug 2018 12:51:35 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-32.ams2.redhat.com [10.36.116.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA43D2156897;
        Tue,  7 Aug 2018 12:51:33 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH RFC 1/2] KVM: s390: vsie: simulate VCPU SIE entry/exit
Date:   Tue,  7 Aug 2018 14:51:30 +0200
Message-Id: <20180807125131.3606-2-david@redhat.com>
In-Reply-To: <20180807125131.3606-1-david@redhat.com>
References: <20180807125131.3606-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 07 Aug 2018 12:51:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 07 Aug 2018 12:51:35 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VCPU requests and VCPU blocking right now don't take care of the vSIE
(as it was not necessary until now). But we want to have VCPU requests
that will also be handled before running the vSIE again.

So let's simulate a SIE entry when entering the vSIE loop and check
for PROG_ flags. The existing infrastructure (e.g. exit_sie()) will then
detect that the SIE (in form of the vSIE execution loop) is running and
properly kick the vSIE CPU, resulting in it leaving the vSIE loop and
therefore the vSIE interception handler, allowing it to handle VCPU
requests.

E.g. if we want to modify the crycb of the VCPU and make sure that any
masks also get applied to the VSIE crycb shadow (which uses masks from the
VCPU crycb), we will need a way to hinder the vSIE from running and make
sure to process the updated crycb before reentering the vSIE again.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/kvm-s390.c |  9 ++++++++-
 arch/s390/kvm/kvm-s390.h |  1 +
 arch/s390/kvm/vsie.c     | 20 ++++++++++++++++++--
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 91ad4a9425c0..c87734a31fdb 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2766,18 +2766,25 @@ static void kvm_s390_vcpu_request(struct kvm_vcpu *vcpu)
 	exit_sie(vcpu);
 }
 
+bool kvm_s390_vcpu_sie_inhibited(struct kvm_vcpu *vcpu)
+{
+	return atomic_read(&vcpu->arch.sie_block->prog20) &
+	       (PROG_BLOCK_SIE | PROG_REQUEST);
+}
+
 static void kvm_s390_vcpu_request_handled(struct kvm_vcpu *vcpu)
 {
 	atomic_andnot(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
 }
 
 /*
- * Kick a guest cpu out of SIE and wait until SIE is not running.
+ * Kick a guest cpu out of (v)SIE and wait until (v)SIE is not running.
  * If the CPU is not running (e.g. waiting as idle) the function will
  * return immediately. */
 void exit_sie(struct kvm_vcpu *vcpu)
 {
 	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOP_INT);
+	kvm_s390_vsie_kick(vcpu);
 	while (vcpu->arch.sie_block->prog0c & PROG_IN_SIE)
 		cpu_relax();
 }
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 981e3ba97461..1f6e36cdce0d 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -290,6 +290,7 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu);
+bool kvm_s390_vcpu_sie_inhibited(struct kvm_vcpu *vcpu);
 void exit_sie(struct kvm_vcpu *vcpu);
 void kvm_s390_sync_request(int req, struct kvm_vcpu *vcpu);
 int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 63844b95c22c..faac06886f77 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -989,6 +989,17 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	int rc = 0;
 
+	/*
+	 * Simulate a SIE entry of the VCPU (see sie64a), so VCPU blocking
+	 * and VCPU requests can hinder the whole vSIE loop from running
+	 * and lead to an immediate exit. We do it at this point (not
+	 * earlier), so kvm_s390_vsie_kick() works correctly already.
+	 */
+	vcpu->arch.sie_block->prog0c |= PROG_IN_SIE;
+	barrier();
+	if (kvm_s390_vcpu_sie_inhibited(vcpu))
+		return 0;
+
 	while (1) {
 		rc = acquire_gmap_shadow(vcpu, vsie_page);
 		if (!rc)
@@ -1004,10 +1015,14 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		if (rc == -EAGAIN)
 			rc = 0;
 		if (rc || scb_s->icptcode || signal_pending(current) ||
-		    kvm_s390_vcpu_has_irq(vcpu, 0))
+		    kvm_s390_vcpu_has_irq(vcpu, 0) ||
+		    kvm_s390_vcpu_sie_inhibited(vcpu))
 			break;
 	}
 
+	barrier();
+	vcpu->arch.sie_block->prog0c &= ~PROG_IN_SIE;
+
 	if (rc == -EFAULT) {
 		/*
 		 * Addressing exceptions are always presentes as intercepts.
@@ -1121,7 +1136,8 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 	if (unlikely(scb_addr & 0x1ffUL))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	if (signal_pending(current) || kvm_s390_vcpu_has_irq(vcpu, 0))
+	if (signal_pending(current) || kvm_s390_vcpu_has_irq(vcpu, 0) ||
+	    kvm_s390_vcpu_sie_inhibited(vcpu))
 		return 0;
 
 	vsie_page = get_vsie_page(vcpu->kvm, scb_addr);
-- 
2.17.1

