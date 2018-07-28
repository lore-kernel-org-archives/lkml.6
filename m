Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D738C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4ED2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 08:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4ED2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeG1KWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 06:22:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbeG1KWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 06:22:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6S8rsMq026311
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 04:56:35 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kgmp5s1ts-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 04:56:34 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Sat, 28 Jul 2018 09:56:33 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 28 Jul 2018 09:56:29 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6S8uSsL42074162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 28 Jul 2018 08:56:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 001E8A4055;
        Sat, 28 Jul 2018 11:56:40 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6700EA4040;
        Sat, 28 Jul 2018 11:56:38 +0100 (BST)
Received: from localhost.localdomain (unknown [9.122.224.197])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jul 2018 11:56:38 +0100 (BST)
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
        joe@perches.com, elfring@users.sourceforge.net,
        david@gibson.dropbear.id.au, jasowang@redhat.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au, mst@redhat.com,
        hch@infradead.org, linuxram@us.ibm.com, haren@linux.vnet.ibm.com,
        paulus@samba.org, srikar@linux.vnet.ibm.com
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Sat, 28 Jul 2018 14:26:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18072808-0020-0000-0000-000002AD3B6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072808-0021-0000-0000-000020F94B4E
Message-Id: <c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807280095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 09:29 AM, Anshuman Khandual wrote:
> Now that virtio core always needs all virtio devices to have DMA OPS, we
> need to make sure that the structure it points is the right one. In the
> absence of VIRTIO_F_IOMMU_PLATFORM flag QEMU expects GPA from guest kernel.
> In such case, virtio device must use default virtio_direct_dma_ops DMA OPS
> structure which transforms scatter gather buffer addresses as GPA. This
> DMA OPS override must happen as early as possible during virtio device
> initializatin sequence before virtio core starts using given device's DMA
> OPS callbacks for I/O transactions. This change detects device's IOMMU flag
> and does the override in case the flag is cleared.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  drivers/virtio/virtio.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 7907ad3..6b13987 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -166,6 +166,8 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>  }
>  EXPORT_SYMBOL_GPL(virtio_add_status);
> 
> +const struct dma_map_ops virtio_direct_dma_ops;
> +
>  int virtio_finalize_features(struct virtio_device *dev)
>  {
>  	int ret = dev->config->finalize_features(dev);
> @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret)
>  		return ret;


The previous patch removed the code block for XEN guests which forced
the use of DMA API all the time irrespective of VIRTIO_F_IOMMU_PLATFORM
flag on the device. Here is what I have removed with patch 2/4 which
breaks the existing semantics on XEN guests.

-static bool vring_use_dma_api(struct virtio_device *vdev)
-{
-	if (!virtio_has_iommu_quirk(vdev))
-		return true;
-
-	/* Otherwise, we are left to guess. */
-	/*
-	 * In theory, it's possible to have a buggy QEMU-supposed
-	 * emulated Q35 IOMMU and Xen enabled at the same time.  On
-	 * such a configuration, virtio has never worked and will
-	 * not work without an even larger kludge.  Instead, enable
-	 * the DMA API if we're a Xen guest, which at least allows
-	 * all of the sensible Xen configurations to work correctly.
-	 */
-	if (xen_domain())
-		return true;
-
-	return false;
-}

XEN guests would not like override with virtio_direct_dma_ops in any
case irrespective of the flag VIRTIO_F_IOMMU_PLATFORM. So the existing
semantics can be preserved with something like this. It just assumes
that dev->dma_ops is non-NULL and a valid one set by the architecture.
If required we can add those tests here before skipping the override.

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 7907ad3..6b13987 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -166,6 +166,8 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);

+const struct dma_map_ops virtio_direct_dma_ops;
+
 int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
@@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
 	if (ret)
 		return ret;
+
+	if (xen_domain())
+		goto skip_override;
+
+	if (virtio_has_iommu_quirk(dev))
+		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
+
+ skip_override:
+
 	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
 		return 0

Will incorporate these changes in the next version.

