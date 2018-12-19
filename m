Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F15C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837B5218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbeLSTUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:20:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbeLSTSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:18:12 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBJIwhpe084697
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:11 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pft5ypbqj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:11 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Wed, 19 Dec 2018 19:18:09 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Dec 2018 19:18:05 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBJJI4QZ59703348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 19:18:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E68425204E;
        Wed, 19 Dec 2018 19:18:03 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8B9995204F;
        Wed, 19 Dec 2018 19:18:03 +0000 (GMT)
From:   Michael Mueller <mimu@linux.ibm.com>
To:     KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v5 03/15] KVM: s390: factor out nullify_gisa()
Date:   Wed, 19 Dec 2018 20:17:44 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18121919-4275-0000-0000-000002F2F261
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121919-4276-0000-0000-00003800FA74
Message-Id: <20181219191756.57973-4-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=872 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812190150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function will be used by the GISA init and the GISA
clear operation. Thus it gets factored out here.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/interrupt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9a3aed608914..c3a8b2fbbcf2 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2884,12 +2884,17 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 	return n;
 }
 
+static void nullify_gisa(struct kvm_s390_gisa *gisa)
+{
+	memset(gisa, 0, sizeof(struct kvm_s390_gisa));
+	gisa->next_alert = (u32)(u64)gisa;
+}
+
 void kvm_s390_gisa_clear(struct kvm *kvm)
 {
 	if (!kvm->arch.gisa)
 		return;
-	memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
-	kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
+	nullify_gisa(kvm->arch.gisa);
 	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
 }
 
@@ -2898,8 +2903,8 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 	if (!css_general_characteristics.aiv)
 		return;
 	kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
+	nullify_gisa(kvm->arch.gisa);
 	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
-	kvm_s390_gisa_clear(kvm);
 }
 
 void kvm_s390_gisa_destroy(struct kvm *kvm)
-- 
2.13.4

