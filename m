Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CC4C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238C520848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e5xUTMJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238C520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeJZIvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:51:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40152 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJZIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:51:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q09ktK015863;
        Fri, 26 Oct 2018 00:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=zsEndIDe30EXHR38Q3e2EeTzjrIe1AK04B4MIbNRYlg=;
 b=e5xUTMJTFREnqH1PLfnu2NUzYQcpHGztGYnoBUyLL5GGYOYZ3cXmnrtSP+T+PV0PzfBq
 elhIPILOshnrnAuY8VZ7/2xF3WByLph86VEwBuyofaEEeIxJwyDFSzM31dcunNVxf0Bs
 WyhG51xov+vDR896h877CPdS3VMQpvCoIJzYe2DcGRA7qoHCS6dMxmY+9VPQ5QrhFX57
 VGCoXDC0VOEU6RyFn3xBqRFkq1UyOWKqfoDkmdxrkJjCLl8HOMg2i/7Jre/Dfp7ATP1w
 eUVlNQK0UEAL6vLp8DJHSf6j/kdro2AYWoVMgCLD++EZJeqyMucNLzyikEtSnYF4wfT1 8A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2n7w0r4gdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 00:16:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q0GFuh009942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 00:16:15 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9Q0GELR009515;
        Fri, 26 Oct 2018 00:16:14 GMT
Received: from [10.0.0.83] (/73.231.240.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 17:16:14 -0700
From:   Joe Jin <joe.jin@oracle.com>
Subject: [PATCH] x86/xen: add physically contiguous check to
 xen_destroy_contiguous_region
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "DONGLI.ZHANG" <dongli.zhang@oracle.com>,
        John Sobecki <john.sobecki@oracle.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        konrad@kernel.org
Message-ID: <210fa20d-4abb-413f-7e58-d8079cf3c589@oracle.com>
Date:   Thu, 25 Oct 2018 17:16:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_destroy_contiguous_region() used to exchange physically
contiguous memory with hypervisor, but it does not verify
that the memory is physically contiguous or no, passing
non-contiguous memory to xen_destroy_contiguous_region()
will lead kernel panic.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/mmu_pv.c     | 3 +++
 drivers/xen/swiotlb-xen.c | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 70ea598a37d2..c2f081f8ebe3 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2649,6 +2649,9 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 	if (unlikely(order > MAX_CONTIG_ORDER))
 		return;
 
+	if (range_straddles_page_boundary(pstart, PAGE_SIZE << order))
+		return;
+
 	vstart = (unsigned long)phys_to_virt(pstart);
 	memset((void *) vstart, 0, PAGE_SIZE << order);
 
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index f5c1af4ce9ab..432eeae02d7d 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -357,8 +357,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
 
-	if (((dev_addr + size - 1 <= dma_mask)) ||
-	    range_straddles_page_boundary(phys, size))
+	if (dev_addr + size - 1 <= dma_mask)
 		xen_destroy_contiguous_region(phys, order);
 
 	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
-- 
2.17.1 (Apple Git-112)

