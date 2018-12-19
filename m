Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A3FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F5321841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeLSTST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:18:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729408AbeLSTSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:18:16 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBJIwffK036550
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:15 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pfte359j2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:15 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Wed, 19 Dec 2018 19:18:12 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Dec 2018 19:18:11 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBJJI9vL53280844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 19:18:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75C9A5204F;
        Wed, 19 Dec 2018 19:18:09 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1B0F65204E;
        Wed, 19 Dec 2018 19:18:09 +0000 (GMT)
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
Subject: [PATCH v5 07/15] s390/cio: add function chsc_sgib()
Date:   Wed, 19 Dec 2018 20:17:48 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18121919-0008-0000-0000-000002A3B18F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121919-0009-0000-0000-0000220E4C0C
Message-Id: <20181219191756.57973-8-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=697 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812190150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the Set Guest Information Block operation
to request association or disassociation of a Guest Information
Block (GIB) with the Adapter Interruption Facility. The operation
is required to receive GIB alert interrupts for guest adapters
in conjunction with AIV and GISA.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/cio.h |  1 +
 drivers/s390/cio/chsc.c     | 37 +++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/chsc.h     |  1 +
 3 files changed, 39 insertions(+)

diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index 225667652069..1727180e8ca1 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -331,5 +331,6 @@ extern void css_schedule_reprobe(void);
 /* Function from drivers/s390/cio/chsc.c */
 int chsc_sstpc(void *page, unsigned int op, u16 ctrl, u64 *clock_delta);
 int chsc_sstpi(void *page, void *result, size_t size);
+int chsc_sgib(u32 origin);
 
 #endif
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index a0baee25134c..4159c63a5fd2 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1382,3 +1382,40 @@ int chsc_pnso_brinfo(struct subchannel_id schid,
 	return chsc_error_from_response(brinfo_area->response.code);
 }
 EXPORT_SYMBOL_GPL(chsc_pnso_brinfo);
+
+int chsc_sgib(u32 origin)
+{
+	struct {
+		struct chsc_header request;
+		u16 op;
+		u8  reserved01[2];
+		u8  reserved02:4;
+		u8  fmt:4;
+		u8  reserved03[7];
+		/* operation data area begin */
+		u8  reserved04[4];
+		u32 gib_origin;
+		u8  reserved05[10];
+		u8  aix;
+		u8  reserved06[4029];
+		struct chsc_header response;
+		u8  reserved07[4];
+	} *sgib_area;
+	int ret;
+
+	spin_lock_irq(&chsc_page_lock);
+	memset(chsc_page, 0, PAGE_SIZE);
+	sgib_area = chsc_page;
+	sgib_area->request.length = 0x0fe0;
+	sgib_area->request.code = 0x0021;
+	sgib_area->op = 0x1;
+	sgib_area->gib_origin = origin;
+
+	ret = chsc(sgib_area);
+	if (ret == 0)
+		ret = chsc_error_from_response(sgib_area->response.code);
+	spin_unlock_irq(&chsc_page_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(chsc_sgib);
diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
index 78aba8d94eec..e57d68e325a3 100644
--- a/drivers/s390/cio/chsc.h
+++ b/drivers/s390/cio/chsc.h
@@ -164,6 +164,7 @@ int chsc_get_channel_measurement_chars(struct channel_path *chp);
 int chsc_ssqd(struct subchannel_id schid, struct chsc_ssqd_area *ssqd);
 int chsc_sadc(struct subchannel_id schid, struct chsc_scssc_area *scssc,
 	      u64 summary_indicator_addr, u64 subchannel_indicator_addr);
+int chsc_sgib(u32 origin);
 int chsc_error_from_response(int response);
 
 int chsc_siosl(struct subchannel_id schid);
-- 
2.13.4

