Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeDEL2m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:28:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750835AbeDEL2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:28:41 -0400
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
To: Balbir Singh <bsingharora@gmail.com>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
 <CAKTCnz=3b56bGKrqCcZOwBsu0yngS_Rw-9TieNLyHgix4eZrAQ@mail.gmail.com>
Cc: robh@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Joe Perches <joe@perches.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
        <linuxppc-dev@lists.ozlabs.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        David Gibson <david@gibson.dropbear.id.au>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 5 Apr 2018 16:58:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAKTCnz=3b56bGKrqCcZOwBsu0yngS_Rw-9TieNLyHgix4eZrAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040511-0020-0000-0000-0000040E61B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040511-0021-0000-0000-000042A27515
Message-Id: <cd5a975b-87a9-6c2b-3c65-a1c4f54311ef@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804050123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 04:44 PM, Balbir Singh wrote:
> On Thu, Apr 5, 2018 at 8:56 PM, Anshuman Khandual
> <khandual@linux.vnet.ibm.com> wrote:
>> There are certian platforms which would like to use SWIOTLB based DMA API
>> for bouncing purpose without actually requiring an IOMMU back end. But the
>> virtio core does not allow such mechanism. Right now DMA MAP API is only
>> selected for devices which have an IOMMU and then the QEMU/host back end
>> will process all incoming SG buffer addresses as IOVA instead of simple
>> GPA which is the case for simple bounce buffers after being processed with
>> SWIOTLB API. To enable this usage, it introduces an architecture specific
>> function which will just make virtio core front end select DMA operations
>> structure.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>> This RFC is just to get some feedback. Please ignore the function call
>> back into the architecture. It can be worked out properly later on. But
>> the question is can we have virtio devices in the guest which would like
>> to use SWIOTLB based (or any custom DMA API based) bounce buffering with
>> out actually being an IOMMU devices emulated by QEMU/host as been with
>> the current VIRTIO_F_IOMMU_PLATFORM virtio flag ?
>>
>>  arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
>>  drivers/virtio/virtio_ring.c           | 4 ++++
>>  include/linux/virtio.h                 | 2 ++
>>  3 files changed, 12 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index 06f02960b439..dd15fbddbe89 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -1396,3 +1396,9 @@ static int __init disable_multitce(char *str)
>>  __setup("multitce=", disable_multitce);
>>
>>  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
>> +
>> +bool is_virtio_dma_platform(void)
>> +{
>> +       return true;
>> +}
>> +EXPORT_SYMBOL(is_virtio_dma_platform);
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 71458f493cf8..9f205a79d378 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -144,6 +144,10 @@ struct vring_virtqueue {
>>
>>  static bool vring_use_dma_api(struct virtio_device *vdev)
>>  {
>> +       /* Use DMA API even for virtio devices without an IOMMU */
>> +       if (is_virtio_dma_platform())
>> +               return true;
>> +
>>         if (!virtio_has_iommu_quirk(vdev))
>>                 return true;
>>
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 988c7355bc22..d8bb83d753ea 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -200,6 +200,8 @@ static inline struct virtio_driver *drv_to_virtio(struct device_driver *drv)
>>  int register_virtio_driver(struct virtio_driver *drv);
>>  void unregister_virtio_driver(struct virtio_driver *drv);
>>
>> +extern bool is_virtio_dma_platform(void);
>> +
> 
> Where is the default implementation for non-pseries platforms? Will they compile
> after these changes?

No they wont. This is just a RFC asking for suggestion/feedback on a
particular direction, will clean up the code later on once we agree
on this.
