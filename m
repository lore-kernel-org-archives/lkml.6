Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67641C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9202087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfAaIxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:53:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731700AbfAaIxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:53:40 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0V8hsLq006486
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:39 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbur66shx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:39 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 31 Jan 2019 08:53:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 08:53:35 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0V8rY1s62914632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 08:53:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3E7242045;
        Thu, 31 Jan 2019 08:53:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 773E142041;
        Thu, 31 Jan 2019 08:53:33 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 08:53:33 +0000 (GMT)
From:   Michael Mueller <mimu@linux.ibm.com>
To:     KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v7 15/15] KVM: s390: test for non NULL gisa origin in pending_irqs()
Date:   Thu, 31 Jan 2019 09:52:47 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20190131085247.13826-1-mimu@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19013108-0020-0000-0000-0000030F3615
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013108-0021-0000-0000-0000216037FD
Message-Id: <20190131085247.13826-17-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=871 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assure a GISA is in use before accessing the IPM to avoid
a NULL pointer de-referencing issue.

Reported-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index d322400ca587..660ec87b6e60 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -329,9 +329,13 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
 
 static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
 {
-	return pending_irqs_no_gisa(vcpu) |
-		gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<
-			IRQ_PEND_IO_ISC_7;
+	struct kvm_s390_gisa_interrupt *gi = &vcpu->kvm->arch.gisa_int;
+	unsigned long pending_mask;
+
+	pending_mask = pending_irqs_no_gisa(vcpu);
+	if (gi->origin)
+		pending_mask |= gisa_get_ipm(gi->origin) << IRQ_PEND_IO_ISC_7;
+	return pending_mask;
 }
 
 static inline int isc_to_irq_type(unsigned long isc)
-- 
2.13.4

