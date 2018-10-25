Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB45ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 03:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A9320831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 03:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dOVn9YdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A9320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJYLju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 07:39:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50880 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeJYLju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 07:39:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9P341xD168996;
        Thu, 25 Oct 2018 03:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=ngpa6kVzJuePMpQXbPo2OMrIiGwVoeurU5iJOUakZPA=;
 b=dOVn9YdFE1FIP8MAqRAALGlOqVfiG1Iwm9MWdUkzbHcXgaAOTW+FQyr7rHWthoT18zYF
 g9ERH7POTJoEmfTsQRJd9Adid7C8Or4Z/PcV0pbogqi65GOsbLgD0H3rO9UJPMoG9IPb
 qFUCjHyb50p9jKkCQE0Q45Jlio1zZ4V0VOGcIVwAoskpXQ98ssCAJwUPi2eRC0pSbRB7
 JIE1QoMBGfezquCTD2Gd/EraCYnJXycsLOitw3abSg3sCoq9EIQVtvLkcXtMYh2FtCUP
 0Dy+BixP2hzyRrTOOCdM3pnOba1QEYnrzSWG15oerGjMHM17VAfrUCtDW4vqWPEiiB5c OQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0qxw86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 03:08:57 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9P38vM6012508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 03:08:57 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9P38uDH017179;
        Thu, 25 Oct 2018 03:08:56 GMT
Received: from [10.0.0.83] (/73.231.240.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 20:08:56 -0700
From:   Joe Jin <joe.jin@oracle.com>
Subject: [PATCH V2] xen-swiotlb: exchange memory with Xen only when pages are
 contiguous
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "DONGLI.ZHANG" <dongli.zhang@oracle.com>, konrad@kernel.org,
        Christoph Helwig <hch@lst.de>,
        John Sobecki <john.sobecki@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>
Message-ID: <57f726b7-0ecf-cb12-f7d0-b7a22dd42d11@oracle.com>
Date:   Wed, 24 Oct 2018 20:08:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4855c92dbb7 "xen-swiotlb: fix the check condition for
xen_swiotlb_free_coherent" only fixed memory address check condition
on xen_swiotlb_free_coherent(), when memory was not physically
contiguous and tried to exchanged with Xen via
xen_destroy_contiguous_region which lead to kernel panic.

The correct check conditions to make Xen hypercall to revert the
memory back from its 32-bit pool are:
1) Above its DMA bit mask (for example 32-bit devices can only address
up to 4GB, and we may want 4GB+2K), and
2) It's physically contiguous.

Thank you Boris for pointing it out.

Fixes: 4855c92dbb7 ("xen-swiotlb: fix the check condition for
xen_swiotlb_free_coherent"

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Reported-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Helwig <hch@lst.de>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: John Sobecki <john.sobecki@oracle.com>
---
 drivers/xen/swiotlb-xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index f5c1af4ce9ab..aed92fa019f9 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -357,8 +357,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
 
-	if (((dev_addr + size - 1 <= dma_mask)) ||
-	    range_straddles_page_boundary(phys, size))
+	if ((dev_addr + size - 1 <= dma_mask) &&
+	    !range_straddles_page_boundary(phys, size))
 		xen_destroy_contiguous_region(phys, order);
 
 	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
-- 
2.17.1 (Apple Git-112)

