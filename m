Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFE620858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFE620858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbeGWDPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:15:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730798AbeGWDPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:15:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6N28sB4073284
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 22:16:22 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kd50ct0k8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 22:16:22 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Mon, 23 Jul 2018 03:16:20 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 03:16:14 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6N2GDi041746502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 02:16:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E14E542041;
        Mon, 23 Jul 2018 05:16:29 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25F9D42047;
        Mon, 23 Jul 2018 05:16:26 +0100 (BST)
Received: from [9.109.221.92] (unknown [9.109.221.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Jul 2018 05:16:25 +0100 (BST)
Subject: Re: [RFC 4/4] virtio: Add platform specific DMA API translation for
 virito devices
To:     "Michael S. Tsirkin" <mst@redhat.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-5-khandual@linux.vnet.ibm.com>
 <20180720160550-mutt-send-email-mst@kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        hch@infradead.org, linuxram@us.ibm.com, haren@linux.vnet.ibm.com,
        paulus@samba.org, srikar@linux.vnet.ibm.com
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Mon, 23 Jul 2018 07:46:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180720160550-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18072302-0020-0000-0000-000002A9B3A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072302-0021-0000-0000-000020F63A82
Message-Id: <3dd36d8e-3bc8-91ba-cf6d-939495439d2c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 06:45 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 20, 2018 at 09:29:41AM +0530, Anshuman Khandual wrote:
>> Subject: Re: [RFC 4/4] virtio: Add platform specific DMA API translation for
>> virito devices
> 
> s/virito/virtio/

Oops, will fix it. Thanks for pointing out.

> 
>> This adds a hook which a platform can define in order to allow it to
>> override virtio device's DMA OPS irrespective of whether it has the
>> flag VIRTIO_F_IOMMU_PLATFORM set or not. We want to use this to do
>> bounce-buffering of data on the new secure pSeries platform, currently
>> under development, where a KVM host cannot access all of the memory
>> space of a secure KVM guest.  The host can only access the pages which
>> the guest has explicitly requested to be shared with the host, thus
>> the virtio implementation in the guest has to copy data to and from
>> shared pages.
>>
>> With this hook, the platform code in the secure guest can force the
>> use of swiotlb for virtio buffers, with a back-end for swiotlb which
>> will use a pool of pre-allocated shared pages.  Thus all data being
>> sent or received by virtio devices will be copied through pages which
>> the host has access to.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/dma-mapping.h | 6 ++++++
>>  arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
>>  drivers/virtio/virtio.c                | 7 +++++++
>>  3 files changed, 19 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
>> index 8fa3945..bc5a9d3 100644
>> --- a/arch/powerpc/include/asm/dma-mapping.h
>> +++ b/arch/powerpc/include/asm/dma-mapping.h
>> @@ -116,3 +116,9 @@ extern u64 __dma_get_required_mask(struct device *dev);
>>  
>>  #endif /* __KERNEL__ */
>>  #endif	/* _ASM_DMA_MAPPING_H */
>> +
>> +#define platform_override_dma_ops platform_override_dma_ops
>> +
>> +struct virtio_device;
>> +
>> +extern void platform_override_dma_ops(struct virtio_device *vdev);
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index 06f0296..5773bc7 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -38,6 +38,7 @@
>>  #include <linux/of.h>
>>  #include <linux/iommu.h>
>>  #include <linux/rculist.h>
>> +#include <linux/virtio.h>
>>  #include <asm/io.h>
>>  #include <asm/prom.h>
>>  #include <asm/rtas.h>
>> @@ -1396,3 +1397,8 @@ static int __init disable_multitce(char *str)
>>  __setup("multitce=", disable_multitce);
>>  
>>  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
>> +
>> +void platform_override_dma_ops(struct virtio_device *vdev)
>> +{
>> +	/* Override vdev->parent.dma_ops if required */
>> +}
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 6b13987..432c332 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -168,6 +168,12 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
>>  
>>  const struct dma_map_ops virtio_direct_dma_ops;
>>  
>> +#ifndef platform_override_dma_ops
>> +static inline void platform_override_dma_ops(struct virtio_device *vdev)
>> +{
>> +}
>> +#endif
>> +
>>  int virtio_finalize_features(struct virtio_device *dev)
>>  {
>>  	int ret = dev->config->finalize_features(dev);
>> @@ -179,6 +185,7 @@ int virtio_finalize_features(struct virtio_device *dev)
>>  	if (virtio_has_iommu_quirk(dev))
>>  		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
>>  
>> +	platform_override_dma_ops(dev);
> 
> Is there a single place where virtio_has_iommu_quirk is called now?

Not other than this one. But in the proposed implementation of
platform_override_dma_ops on powerpc, we will again check on
virtio_has_iommu_quirk before overriding it with SWIOTLB.

void platform_override_dma_ops(struct virtio_device *vdev)
{
        if (is_ultravisor_platform() && virtio_has_iommu_quirk(vdev))
                set_dma_ops(vdev->dev.parent, &swiotlb_dma_ops);
}

> If so, we could put this into virtio_has_iommu_quirk then.

Did you mean platform_override_dma_ops instead ? If so, yes that
is possible. Default implementation of platform_override_dma_ops
should just check on VIRTIO_F_IOMMU_PLATFORM feature and override
with virtio_direct_dma_ops but arch implementation can check on
what ever else they would like and override appropriately.

Default platform_override_dma_ops will be like this

#ifndef platform_override_dma_ops
static inline void platform_override_dma_ops(struct virtio_device *vdev)
{
	if(!virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
}
#endif

Proposed powerpc implementation will be like this instead

void platform_override_dma_ops(struct virtio_device *vdev)
{
	if (virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
		return;

        if (is_ultravisor_platform())
                set_dma_ops(vdev->dev.parent, &swiotlb_dma_ops);
	else
		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
	
}

There is a redundant definition of virtio_has_iommu_quirk in the tools
directory (tools/virtio/linux/virtio_config.h) which does not seem to
be used any where. I guess that can be removed without problem.

