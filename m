Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4EFC282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C922087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbfAaIxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:53:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730177AbfAaIxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:53:32 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0V8hrpt129102
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:30 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbw8f1w1p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:30 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 31 Jan 2019 08:53:28 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 08:53:25 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0V8rNH250135220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 08:53:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FAAF42047;
        Thu, 31 Jan 2019 08:53:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 235654203F;
        Thu, 31 Jan 2019 08:53:23 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 08:53:23 +0000 (GMT)
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
Subject: [PATCH v7 09/15] KVM: s390: add the GIB and its related life-cyle functions
Date:   Thu, 31 Jan 2019 09:52:40 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20190131085247.13826-1-mimu@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19013108-0028-0000-0000-000003413602
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013108-0029-0000-0000-000023FF3799
Message-Id: <20190131085247.13826-10-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Guest Information Block (GIB) links the GISA of all guests
that have adapter interrupts pending. These interrupts cannot be
delivered because all vcpus of these guests are currently in WAIT
state or have masked the respective Interruption Sub Class (ISC).
If enabled, a GIB alert is issued on the host to schedule these
guests to run suitable vcpus to consume the pending interruptions.

This mechanism allows to process adapter interrupts for currently
not running guests.

The GIB is created during host initialization and associated with
the Adapter Interruption Facility in case an Adapter Interruption
Virtualization Facility is available.

The GIB initialization and thus the activation of the related code
will be done in an upcoming patch of this series.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  9 +++++++++
 arch/s390/kvm/interrupt.c        | 43 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c         |  1 +
 arch/s390/kvm/kvm-s390.h         |  2 ++
 4 files changed, 55 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 0941571d34eb..397af0d33539 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -784,6 +784,15 @@ struct kvm_s390_gisa {
 	};
 };
 
+struct kvm_s390_gib {
+	u32 alert_list_origin;
+	u32 reserved01;
+	u8:5;
+	u8  nisc:3;
+	u8  reserved03[3];
+	u32 reserved04[5];
+};
+
 /*
  * sie_page2 has to be allocated as DMA because fac_list, crycb and
  * gisa need 31bit addresses in the sie control block.
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index ee91d1de0036..5efcd9e2cf8f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -7,6 +7,9 @@
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "kvm-s390"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/interrupt.h>
 #include <linux/kvm_host.h>
 #include <linux/hrtimer.h>
@@ -31,6 +34,8 @@
 #define PFAULT_DONE 0x0680
 #define VIRTIO_PARAM 0x0d00
 
+static struct kvm_s390_gib *gib;
+
 /* handle external calls via sigp interpretation facility */
 static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 {
@@ -2914,3 +2919,41 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
 {
 	kvm->arch.gisa_int.origin = NULL;
 }
+
+void kvm_s390_gib_destroy(void)
+{
+	if (!gib)
+		return;
+	chsc_sgib(0);
+	free_page((unsigned long)gib);
+	gib = NULL;
+}
+
+int kvm_s390_gib_init(u8 nisc)
+{
+	int rc = 0;
+
+	if (!css_general_characteristics.aiv) {
+		KVM_EVENT(3, "%s", "gib not initialized, no AIV facility");
+		goto out;
+	}
+
+	gib = (struct kvm_s390_gib *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!gib) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	gib->nisc = nisc;
+	if (chsc_sgib((u32)(u64)gib)) {
+		pr_err("Associating the GIB with the AIV facility failed\n");
+		free_page((unsigned long)gib);
+		gib = NULL;
+		rc = -EIO;
+		goto out;
+	}
+
+	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
+out:
+	return rc;
+}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4c855cb67699..118d4c0bbb8e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -444,6 +444,7 @@ int kvm_arch_init(void *opaque)
 
 void kvm_arch_exit(void)
 {
+	kvm_s390_gib_destroy();
 	debug_unregister(kvm_s390_dbf);
 }
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 72ef87799593..6d9448dbd052 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -381,6 +381,8 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu,
 void kvm_s390_gisa_init(struct kvm *kvm);
 void kvm_s390_gisa_clear(struct kvm *kvm);
 void kvm_s390_gisa_destroy(struct kvm *kvm);
+int kvm_s390_gib_init(u8 nisc);
+void kvm_s390_gib_destroy(void);
 
 /* implemented in guestdbg.c */
 void kvm_s390_backup_guest_per_regs(struct kvm_vcpu *vcpu);
-- 
2.13.4

