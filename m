Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88E1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBC12086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBC12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeIZF2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:28:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727395AbeIZF2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:28:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PNEThR144335
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:18:18 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mqvmgm9k6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:18:18 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 17:18:17 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 17:18:13 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PNIAvr43057174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 16:18:10 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A932136051;
        Tue, 25 Sep 2018 17:18:10 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F76713604F;
        Tue, 25 Sep 2018 17:18:07 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.192.224])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Sep 2018 17:18:07 -0600 (MDT)
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
        Pierre Morel <pmorel@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v11 19/26] KVM: s390: vsie: allow CRYCB FORMAT-1
Date:   Tue, 25 Sep 2018 19:16:34 -0400
X-Mailer: git-send-email 2.19.0.221.g150f307
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092523-0004-0000-0000-00001491C01B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009771; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093642; UDB=6.00565266; IPR=6.00873680;
 MB=3.00023503; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 23:18:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092523-0005-0000-0000-000088F06667
Message-Id: <20180925231641.4954-20-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=812 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Morel <pmorel@linux.ibm.com>

When the host and guest both use a FORMAT-1 CRYCB, we copy
the guest's FORMAT-0 APCB to a shadow CRYCB for use by
vSIE.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 3a932781e0b0..0a26814c6efe 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -136,6 +136,19 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
+/* Copy to APCB FORMAT0 from APCB FORMAT0 */
+static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
+			unsigned long apcb_o, unsigned long *apcb_h)
+{
+	if (read_guest_real(vcpu, apcb_o, apcb_s,
+			    sizeof(struct kvm_s390_apcb0)))
+		return -EFAULT;
+
+	bitmap_and(apcb_s, apcb_s, apcb_h, sizeof(struct kvm_s390_apcb0));
+
+	return 0;
+}
+
 /**
  * setup_apcb11 - Copy the FORMAT1 APCB from the guest to the shadow CRYCB
  * @vcpu: pointer to the virtual CPU
@@ -190,6 +203,12 @@ static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
 		return setup_apcb11(vcpu, (unsigned long *)&crycb_s->apcb1,
 				    (unsigned long) &crycb->apcb1,
 				    (unsigned long *)&crycb_h->apcb1);
+	case CRYCB_FORMAT1:
+		if (fmt_h != CRYCB_FORMAT1)
+			return -EINVAL;
+		return setup_apcb00(vcpu, (unsigned long *) &crycb_s->apcb0,
+				    (unsigned long) &crycb->apcb0,
+				    (unsigned long *) &crycb_h->apcb0);
 	}
 	return -EINVAL;
 }
-- 
2.19.0.221.g150f307

