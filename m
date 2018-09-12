Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D51DC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CB92133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CB92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeIMAtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:49:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbeIMAtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:49:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CJYeQF099231
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:43:39 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf632qrmx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:43:39 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Wed, 12 Sep 2018 13:43:38 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 13:43:35 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CJhWik24379600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 12:43:32 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B32F6A05A;
        Wed, 12 Sep 2018 13:43:32 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56DF66A047;
        Wed, 12 Sep 2018 13:43:29 -0600 (MDT)
Received: from localhost.localdomain (unknown [9.80.213.181])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Sep 2018 13:43:29 -0600 (MDT)
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
Subject: [PATCH v10 02/26] KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
Date:   Wed, 12 Sep 2018 15:42:52 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091219-0016-0000-0000-0000092C78C6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009709; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01087371; UDB=6.00561489; IPR=6.00867383;
 MB=3.00023256; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-12 19:43:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091219-0017-0000-0000-00004054693E
Message-Id: <1536781396-13601-3-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=778 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

When we change the crycb (or execution controls), we also have to make sure
that the vSIE shadow datastructures properly consider the changed
values before rerunning the vSIE. We can achieve that by simply using a
VCPU request now.

This has to be a synchronous request (== handled before entering the
(v)SIE again).

The request will make sure that the vSIE handler is left, and that the
request will be processed (NOP), therefore forcing a reload of all
vSIE data (including rebuilding the crycb) when re-entering the vSIE
interception handler the next time.

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/kvm/kvm-s390.c         |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 29c940b..75d3962 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -44,6 +44,7 @@
 #define KVM_REQ_ICPT_OPEREXC	KVM_ARCH_REQ(2)
 #define KVM_REQ_START_MIGRATION KVM_ARCH_REQ(3)
 #define KVM_REQ_STOP_MIGRATION  KVM_ARCH_REQ(4)
+#define KVM_REQ_VSIE_RESTART	KVM_ARCH_REQ(5)
 
 #define SIGP_CTRL_C		0x80
 #define SIGP_CTRL_SCN_MASK	0x3f
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0b5aff0..876fbb2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -844,8 +844,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
 
 	kvm_s390_vcpu_block_all(kvm);
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_s390_vcpu_crypto_setup(vcpu);
+		/* recreate the shadow crycb by leaving the VSIE handler */
+		kvm_s390_sync_request(KVM_REQ_VSIE_RESTART, vcpu);
+	}
 
 	kvm_s390_vcpu_unblock_all(kvm);
 }
@@ -3203,6 +3206,8 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 
 	/* nothing to do, just clear the request */
 	kvm_clear_request(KVM_REQ_UNHALT, vcpu);
+	/* we left the vsie handler, nothing to do, just clear the request */
+	kvm_clear_request(KVM_REQ_VSIE_RESTART, vcpu);
 
 	return 0;
 }
-- 
1.7.1

