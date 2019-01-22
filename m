Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52766C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD8820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfAVVSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:18:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbfAVVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:18:54 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MLIrxU042111
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:18:53 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q682cexke-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:18:52 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 22 Jan 2019 21:18:44 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 22 Jan 2019 21:18:38 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0MLIbFY18940068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 21:18:37 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87D1CBE058;
        Tue, 22 Jan 2019 21:18:37 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49DC5BE053;
        Tue, 22 Jan 2019 21:18:33 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.185.73])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 22 Jan 2019 21:18:32 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     x86@kernel.org
Cc:     kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 2/2] x86/kvmclock: set_memory_decrypted() takes number of pages
Date:   Tue, 22 Jan 2019 19:17:58 -0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190122211758.8317-1-bauerman@linux.ibm.com>
References: <20190122211758.8317-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012221-0020-0000-0000-00000EAFA7B1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010457; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01150302; UDB=6.00599446; IPR=6.00930634;
 MB=3.00025244; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-22 21:18:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012221-0021-0000-0000-00006484B392
Message-Id: <20190122211758.8317-2-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=917 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

set_memory_decrypted() expects the number of PAGE_SIZE pages to decrypt.
kvmclock_init_mem() instead passes number of bytes. This decrypts a huge
number of pages resulting in data corruption.

Fixed it.

[ bauermann: Slightly reworded commit message and added Fixes: tag. ]
Fixes: 6a1cac56f41f ("x86/kvm: Use __bss_decrypted attribute in shared variables")
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/x86/kernel/kvmclock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Note: Found by code inspection. I don't have a way to test.

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index e811d4d1c824..b5c867dd2c8d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -251,8 +251,7 @@ static void __init kvmclock_init_mem(void)
 	 * be mapped decrypted.
 	 */
 	if (sev_active()) {
-		r = set_memory_decrypted((unsigned long) hvclock_mem,
-					 1UL << order);
+		r = set_memory_decrypted((unsigned long) hvclock_mem, 1);
 		if (r) {
 			__free_pages(p, order);
 			hvclock_mem = NULL;

