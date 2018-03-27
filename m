Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeC0BJe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:09:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57452 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeC0BJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:09:33 -0400
From: Tushar Dave <tushar.n.dave@oracle.com>
Subject: intel-iommu: Is this a bug?
To: dwmw2@infradead.org, joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <66db7b28-5749-1d13-b228-88b34087f3b6@oracle.com>
Date: Mon, 26 Mar 2018 18:09:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=870
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803270010
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am analyzing network performance with intel-iommu enabled.
And found that running with iommu=pt, for every dma map/unmap it
executes this code:

/*
          * At boot time, we don't yet know if devices will be 64-bit 
capable.
          * Assume that they will — if they turn out not to be, then we can
          * take them out of the 1:1 domain later.
          */
         if (!startup) {
                 /*
                  * If the device's dma_mask is less than the system's 
memory
                  * size then this is not a candidate for identity mapping.
                  */
                 u64 dma_mask = *dev->dma_mask;

                 if (dev->coherent_dma_mask &&
                     dev->coherent_dma_mask < dma_mask)
                         dma_mask = dev->coherent_dma_mask;

                 return dma_mask >= dma_get_required_mask(dev);
         }


Do we really need this check for every dma/unmap?
Considering it should be only during startup, shouldn't it be,

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 582fd01..3c8f14e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2929,7 +2929,7 @@ static int iommu_should_identity_map(struct device 
*dev, int startup)
          * Assume that they will — if they turn out not to be, then we can
          * take them out of the 1:1 domain later.
          */
-       if (!startup) {
+       if (startup) {
                 /*
                  * If the device's dma_mask is less than the system's 
memory
                  * size then this is not a candidate for identity mapping.


Thanks.

-Tushar
