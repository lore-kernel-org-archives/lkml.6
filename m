Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE4CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFBE20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFBE20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbeGXO35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:29:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388297AbeGXO35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:29:57 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6ODIasr121863
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:23:28 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ke49wa0fa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:23:27 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 24 Jul 2018 14:23:26 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 14:23:22 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6ODNLch40894590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 13:23:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39E6711C04C;
        Tue, 24 Jul 2018 16:23:36 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8D5D11C054;
        Tue, 24 Jul 2018 16:23:34 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.56])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 24 Jul 2018 16:23:34 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Tue, 24 Jul 2018 16:23:19 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-um@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 1/2] um: setup_physmem: stop using global variables
Date:   Tue, 24 Jul 2018 16:23:13 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532438594-4530-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1532438594-4530-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072413-0028-0000-0000-000002DF8A11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072413-0029-0000-0000-00002397702C
Message-Id: <1532438594-4530-2-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=804 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_physmem() function receives uml_physmem and uml_reserved as
parameters and still used these global variables. Replace such usage with
local variables.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/um/kernel/physmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index f02596e..0eaec0e 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -86,7 +86,7 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	long map_size;
 	int err;
 
-	offset = uml_reserved - uml_physmem;
+	offset = reserve_end - start;
 	map_size = len - offset;
 	if(map_size <= 0) {
 		os_warn("Too few physical memory! Needed=%lu, given=%lu\n",
@@ -96,12 +96,12 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 
 	physmem_fd = create_mem_file(len + highmem);
 
-	err = os_map_memory((void *) uml_reserved, physmem_fd, offset,
+	err = os_map_memory((void *) reserve_end, physmem_fd, offset,
 			    map_size, 1, 1, 1);
 	if (err < 0) {
 		os_warn("setup_physmem - mapping %ld bytes of memory at 0x%p "
 			"failed - errno = %d\n", map_size,
-			(void *) uml_reserved, err);
+			(void *) reserve_end, err);
 		exit(1);
 	}
 
-- 
2.7.4

