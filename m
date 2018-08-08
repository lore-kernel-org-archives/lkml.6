Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68327C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224DF21737
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224DF21737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeHHRHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:07:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727629AbeHHREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:04:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78EiLpY016410
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 10:44:52 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kr1ew3b6w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:44:51 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 10:44:50 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 10:44:47 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78EijYV5898680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 14:44:45 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB8BA28058;
        Wed,  8 Aug 2018 10:43:33 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF76528059;
        Wed,  8 Aug 2018 10:43:32 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.187.56])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Aug 2018 10:43:32 -0400 (EDT)
From:   Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v8 05/22] KVM: s390: vsie: simulate VCPU SIE entry/exit
Date:   Wed,  8 Aug 2018 10:44:15 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080814-0064-0000-0000-000003377475
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009507; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070983; UDB=6.00551365; IPR=6.00850513;
 MB=3.00022589; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 14:44:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080814-0065-0000-0000-00003A3B66BB
Message-Id: <1533739472-7172-6-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

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

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c |    9 ++++++++-
 arch/s390/kvm/kvm-s390.h |    1 +
 arch/s390/kvm/vsie.c     |   20 ++++++++++++++++++--
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3b7a515..6df2d12 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2655,18 +2655,25 @@ static void kvm_s390_vcpu_request(struct kvm_vcpu *vcpu)
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
index 981e3ba..1f6e36c 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -290,6 +290,7 @@ void kvm_s390_set_tod_clock(struct kvm *kvm,
 void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu);
+bool kvm_s390_vcpu_sie_inhibited(struct kvm_vcpu *vcpu);
 void exit_sie(struct kvm_vcpu *vcpu);
 void kvm_s390_sync_request(int req, struct kvm_vcpu *vcpu);
 int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 84c89cb..aa30b48 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -982,6 +982,17 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
@@ -997,10 +1008,14 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
@@ -1114,7 +1129,8 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 	if (unlikely(scb_addr & 0x1ffUL))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	if (signal_pending(current) || kvm_s390_vcpu_has_irq(vcpu, 0))
+	if (signal_pending(current) || kvm_s390_vcpu_has_irq(vcpu, 0) ||
+	    kvm_s390_vcpu_sie_inhibited(vcpu))
 		return 0;
 
 	vsie_page = get_vsie_page(vcpu->kvm, scb_addr);
-- 
1.7.1

