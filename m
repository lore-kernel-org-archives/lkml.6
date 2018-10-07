Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96271C65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E3E20882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E3E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeJGPih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 11:38:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726402AbeJGPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 11:38:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w978TLdL062845
        for <linux-kernel@vger.kernel.org>; Sun, 7 Oct 2018 04:32:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2myah3yp64-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 04:32:04 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sun, 7 Oct 2018 09:32:03 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 7 Oct 2018 09:32:00 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w978VxB966977954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 7 Oct 2018 08:31:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99AECAE045;
        Sun,  7 Oct 2018 11:30:46 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06BBFAE04D;
        Sun,  7 Oct 2018 11:30:45 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.161])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  7 Oct 2018 11:30:44 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Sun, 07 Oct 2018 11:31:56 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] percpu: stop leaking bitmap metadata blocks
Date:   Sun,  7 Oct 2018 11:31:51 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18100708-0008-0000-0000-0000027C0E21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100708-0009-0000-0000-000021E53EB9
Message-Id: <1538901111-22823-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810070089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit ca460b3c9627 ("percpu: introduce bitmap metadata blocks")
introduced bitmap metadata blocks. These metadata blocks are allocated
whenever a new chunk is created, but they are never freed. Fix it.

Fixes: ca460b3c9627 ("percpu: introduce bitmap metadata blocks")

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
---
 mm/percpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index d21cb13..25104cd 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1212,6 +1212,7 @@ static void pcpu_free_chunk(struct pcpu_chunk *chunk)
 {
 	if (!chunk)
 		return;
+	pcpu_mem_free(chunk->md_blocks);
 	pcpu_mem_free(chunk->bound_map);
 	pcpu_mem_free(chunk->alloc_map);
 	pcpu_mem_free(chunk);
-- 
2.7.4

