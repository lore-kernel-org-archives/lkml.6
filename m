Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E8C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E862087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfAaIym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:54:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730742AbfAaIxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:53:31 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0V8hq7L122981
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:30 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbwr50cnb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:29 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 31 Jan 2019 08:53:27 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 08:53:23 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0V8rMnq33488976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 08:53:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D88F42041;
        Thu, 31 Jan 2019 08:53:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8A8242047;
        Thu, 31 Jan 2019 08:53:21 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 08:53:21 +0000 (GMT)
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
Subject: [PATCH v7 08/15] s390/cio: add function chsc_sgib()
Date:   Thu, 31 Jan 2019 09:52:39 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20190131085247.13826-1-mimu@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19013108-0028-0000-0000-000003413601
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013108-0029-0000-0000-000023FF3797
Message-Id: <20190131085247.13826-9-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=726 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310070
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

