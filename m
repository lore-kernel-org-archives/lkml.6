Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE015C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8974E208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8974E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeJEP3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:29:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728669AbeJEP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:29:00 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w958TYJJ060710
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 04:31:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mx20yqh3m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 04:31:20 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 5 Oct 2018 09:31:17 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 09:31:13 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w958VC1m63045694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Oct 2018 08:31:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CC15A4055;
        Fri,  5 Oct 2018 11:30:48 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57C14A4051;
        Fri,  5 Oct 2018 11:30:48 +0100 (BST)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.35])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 11:30:48 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     david@redhat.com, linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v1 1/2] KVM: s390: Tracing APCB changes
Date:   Fri,  5 Oct 2018 10:31:09 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
References: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
 <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18100508-4275-0000-0000-000002C55735
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100508-4276-0000-0000-000037D07299
Message-Id: <1538728270-10340-2-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_arch_crypto_set_masks is a new function to centralize
the setup the APCB masks inside the CRYCB SIE satelite.

To trace APCB mask changes, we add KVM_EVENT() tracing to
both kvm_arch_crypto_set_masks and kvm_arch_crypto_clear_masks.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/kvm-s390.c         | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 36d3531..22aa4da 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -861,6 +861,8 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 				 struct kvm_async_pf *work);
 
 void kvm_arch_crypto_clear_masks(struct kvm *kvm);
+void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
+			       unsigned long *aqm, unsigned long *adm);
 
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d3ea721..e871e5a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2057,6 +2057,46 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
 }
 
+void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
+			       unsigned long *aqm, unsigned long *adm)
+{
+	struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
+
+	mutex_lock(&kvm->lock);
+	kvm_s390_vcpu_block_all(kvm);
+
+	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT2: /* APCB1 use 256 bits */
+		memcpy(crycb->apcb1.apm, apm, 32);
+		VM_EVENT(kvm, 3, "SET CRYCB: apm %016lx %016lx %016lx %016lx",
+			 apm[0], apm[1], apm[2], apm[3]);
+		memcpy(crycb->apcb1.aqm, aqm, 32);
+		VM_EVENT(kvm, 3, "SET CRYCB: aqm %016lx %016lx %016lx %016lx",
+			 aqm[0], aqm[1], aqm[2], aqm[3]);
+		memcpy(crycb->apcb1.adm, adm, 32);
+		VM_EVENT(kvm, 3, "SET CRYCB: adm %016lx %016lx %016lx %016lx",
+			 adm[0], adm[1], adm[2], adm[3]);
+		break;
+	case CRYCB_FORMAT1:
+	case CRYCB_FORMAT0: /* Fall through both use APCB0 */
+		memcpy(crycb->apcb0.apm, apm, 8);
+		memcpy(crycb->apcb0.aqm, aqm, 2);
+		memcpy(crycb->apcb0.adm, adm, 2);
+		VM_EVENT(kvm, 3, "SET CRYCB: apm %016lx aqm %04x adm %04x",
+			 apm[0], *((unsigned short *)aqm),
+			 *((unsigned short *)adm));
+		break;
+	default:	/* Can not happen */
+		break;
+	}
+
+	/* recreate the shadow crycb for each vcpu */
+	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
+	kvm_s390_vcpu_unblock_all(kvm);
+	mutex_unlock(&kvm->lock);
+}
+EXPORT_SYMBOL_GPL(kvm_arch_crypto_set_masks);
+
 void kvm_arch_crypto_clear_masks(struct kvm *kvm)
 {
 	mutex_lock(&kvm->lock);
@@ -2067,6 +2107,7 @@ void kvm_arch_crypto_clear_masks(struct kvm *kvm)
 	memset(&kvm->arch.crypto.crycb->apcb1, 0,
 	       sizeof(kvm->arch.crypto.crycb->apcb1));
 
+	VM_EVENT(kvm, 3, "%s", "CLR CRYCB:");
 	/* recreate the shadow crycb for each vcpu */
 	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
 	kvm_s390_vcpu_unblock_all(kvm);
-- 
2.7.4

