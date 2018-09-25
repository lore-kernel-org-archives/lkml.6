Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40183C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3FC2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3FC2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbeIZF0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:26:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbeIZF0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:26:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PNEWaV050709
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:17:00 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mqtauhwg3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:17:00 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 17:16:59 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 17:16:55 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PNGqZr56098978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 16:16:52 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C11BA136051;
        Tue, 25 Sep 2018 17:16:52 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1CD213604F;
        Tue, 25 Sep 2018 17:16:49 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.192.224])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Sep 2018 17:16:49 -0600 (MDT)
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
        David Hildenbrand <david@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v11 01/26] KVM: s390: vsie: simulate VCPU SIE entry/exit
Date:   Tue, 25 Sep 2018 19:16:16 -0400
X-Mailer: git-send-email 2.19.0.221.g150f307
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092523-0004-0000-0000-00001491C007
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009771; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093642; UDB=6.00565266; IPR=6.00873679;
 MB=3.00023503; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 23:16:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092523-0005-0000-0000-000088F065B4
Message-Id: <20180925231641.4954-2-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=764 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

VCPU requests and VCPU blocking right now don't take care of the vSIE
(as it was not necessary until now). But we want to have synchronous VCPU
requests that will also be handled before running the vSIE again.

So let's simulate a SIE entry of the VCPU when calling the sie during
vSIE handling and check for PROG_ flags. The existing infrastructure
(e.g. exit_sie()) will then detect that the SIE (in form of the vSIE) is
running and properly kick the vSIE CPU, resulting in it leaving the vSIE
loop and therefore the vSIE interception handler, allowing it to handle
VCPU requests.

E.g. if we want to modify the crycb of the VCPU and make sure that any
masks also get applied to the VSIE crycb shadow (which uses masks from the
VCPU crycb), we will need a way to hinder the vSIE from running and make
sure to process the updated crycb before reentering the vSIE again.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c |  9 ++++++++-
 arch/s390/kvm/kvm-s390.h |  1 +
 arch/s390/kvm/vsie.c     | 21 +++++++++++++++++----
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f69333fd2fa3..0b5aff0e3984 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2768,18 +2768,25 @@ static void kvm_s390_vcpu_request(struct kvm_vcpu *vcpu)
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
index a2b28cd1e3fe..12b970701c26 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -830,7 +830,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 	int guest_bp_isolation;
-	int rc;
+	int rc = 0;
 
 	handle_last_fault(vcpu, vsie_page);
 
@@ -858,7 +858,18 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	guest_enter_irqoff();
 	local_irq_enable();
 
-	rc = sie64a(scb_s, vcpu->run->s.regs.gprs);
+	/*
+	 * Simulate a SIE entry of the VCPU (see sie64a), so VCPU blocking
+	 * and VCPU requests also hinder the vSIE from running and lead
+	 * to an immediate exit. kvm_s390_vsie_kick() has to be used to
+	 * also kick the vSIE.
+	 */
+	vcpu->arch.sie_block->prog0c |= PROG_IN_SIE;
+	barrier();
+	if (!kvm_s390_vcpu_sie_inhibited(vcpu))
+		rc = sie64a(scb_s, vcpu->run->s.regs.gprs);
+	barrier();
+	vcpu->arch.sie_block->prog0c &= ~PROG_IN_SIE;
 
 	local_irq_disable();
 	guest_exit_irqoff();
@@ -1005,7 +1016,8 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		if (rc == -EAGAIN)
 			rc = 0;
 		if (rc || scb_s->icptcode || signal_pending(current) ||
-		    kvm_s390_vcpu_has_irq(vcpu, 0))
+		    kvm_s390_vcpu_has_irq(vcpu, 0) ||
+		    kvm_s390_vcpu_sie_inhibited(vcpu))
 			break;
 	}
 
@@ -1122,7 +1134,8 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 	if (unlikely(scb_addr & 0x1ffUL))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	if (signal_pending(current) || kvm_s390_vcpu_has_irq(vcpu, 0))
+	if (signal_pending(current) || kvm_s390_vcpu_has_irq(vcpu, 0) ||
+	    kvm_s390_vcpu_sie_inhibited(vcpu))
 		return 0;
 
 	vsie_page = get_vsie_page(vcpu->kvm, scb_addr);
-- 
2.19.0.221.g150f307

