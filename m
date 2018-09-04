Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E782C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174462075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UcnmuXBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174462075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeIDWnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:43:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50506 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDWnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:43:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w84IDmhi072067;
        Tue, 4 Sep 2018 18:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=MOzAtUCzbGJINleDrppAg0KgBgjuxtQELv+FFQM2NBM=;
 b=UcnmuXBDLuHqWEDlf5XXD+KfDyye8so7kqqn/SjJBz8CnyMzFIN689AwsXsgShWlV1lP
 X1QqdsJOSER3W+cYvgIpJrCltDsqqs3sSHydfTg50lcJee5vGdvofTDbUwFT6pVK52gu
 M2dc+Qfw9SFBcbpKvKdOcDa40RYDEHVesi1kcjBFI+/fWfguJPhfT2/p4uVM6qAEMq7L
 +3Crg5jNLjxIDruN5Yrq3fWwqe67qsBvdZKwgOO1ncPD+UBFNJx18CCQ5vNhqI6kn4ha
 /31n/rb46kFiJYn40UZTaoU91rp/NwbQAwUs/zxZ36npa9eyGw939/QKImFSNXR3F4aZ 2g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2m7j6teyn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Sep 2018 18:17:00 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w84IH0dZ025809
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Sep 2018 18:17:00 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w84IH0un026785;
        Tue, 4 Sep 2018 18:17:00 GMT
Received: from [10.211.202.81] (/10.211.202.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Sep 2018 11:16:59 -0700
From:   Joe Jin <joe.jin@oracle.com>
Subject: [PATCH] xen-swiotlb: use actually allocated size on check physical
 contiguous
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        John Sobecki <john.sobecki@oracle.com>,
        "DONGLI.ZHANG" <dongli.zhang@oracle.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Message-ID: <d578b69a-848b-2c86-175a-1b1933d82a36@oracle.com>
Date:   Tue, 4 Sep 2018 11:16:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=896
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809040182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_swiotlb_{alloc,free}_coherent() actually allocate/free size by order
but used the required size to check if address is physical contiguous,
if first pages are physical contiguous also passed
range_straddles_page_boundary() check, but others were not it will
lead kernel panic.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/xen/swiotlb-xen.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index a6f9ba85dc4b..aa081f806728 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -303,6 +303,9 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	*/
 	flags &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
+	/* Convert the size to actually allocated. */
+	size = 1UL << (order + XEN_PAGE_SHIFT);
+
 	/* On ARM this function returns an ioremap'ped virtual address for
 	 * which virt_to_phys doesn't return the corresponding physical
 	 * address. In fact on ARM virt_to_phys only works for kernel direct
@@ -351,6 +354,9 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	 * physical address */
 	phys = xen_bus_to_phys(dev_addr);
 
+	/* Convert the size to actually allocated. */
+	size = 1UL << (order + XEN_PAGE_SHIFT);
+
 	if (((dev_addr + size - 1 <= dma_mask)) ||
 	    range_straddles_page_boundary(phys, size))
 		xen_destroy_contiguous_region(phys, order);
-- 
2.15.2 (Apple Git-101.1)


