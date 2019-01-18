Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FBBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE3C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T22PYKo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfARHIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:08:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53486 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfARHIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:08:35 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0I74fCh091884;
        Fri, 18 Jan 2019 07:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=tgxKLYIOTtTJae48OZZZCv2XxhdZLT84wNofYlg82YI=;
 b=T22PYKo8rhkqV6c6HjAWEwdKFgjkt4Cd1uMVhRZna7i0bR9ygqqRhKGn4yzChMDDd52u
 9027Z1JTItMdPKQVEBVKw870tyhgRjzp0rduwnHlkc3y3G5X4jhABrj1HzJB+G2Yy4bg
 kr0jt31J9N7WoTwduzdoK2KiPVNNcrtZEXF/qfy/qU5lQguCMsTB8vt/mEka0Ubw0u4j
 1D9VMbfkQj7h43ZJdSolY4H3yL91y9pMOavj/Qc0O2RAgtbXLgeF/xXWvTWE3gF27XNe
 2K6RkQiJWXO1vNPQZsys5BcuWkPr6INFr5Y4lHVbGzwD1NAtE7+aW8Z0du33+wbOTF9b Og== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2pybjp3x0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 07:08:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0I78KAp032728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 07:08:20 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0I78KHk023932;
        Fri, 18 Jan 2019 07:08:20 GMT
Received: from linux.cn.oracle.com (/10.182.71.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jan 2019 23:08:19 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joe.jin@oracle.com, dongli.zhang@oracle.com
Subject: [PATCH v3 3/3] swiotlb: checking whether swiotlb buffer is full with io_tlb_used
Date:   Fri, 18 Jan 2019 15:10:28 +0800
Message-Id: <1547795428-10595-3-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
References: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9139 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=686
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901180054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses io_tlb_used to help check whether swiotlb buffer is full.
io_tlb_used is no longer used for only debugfs. It is also used to help
optimize swiotlb_tbl_map_single().

Suggested-by: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v2:
  * move #ifdef folding to previous patch (suggested by Konrad Rzeszutek Wilk)

 kernel/dma/swiotlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index bedc9f9..a01b83e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -483,6 +483,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	 * request and allocate a buffer from that IO TLB pool.
 	 */
 	spin_lock_irqsave(&io_tlb_lock, flags);
+
+	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
+		goto not_found;
+
 	index = ALIGN(io_tlb_index, stride);
 	if (index >= io_tlb_nslabs)
 		index = 0;
-- 
2.7.4

