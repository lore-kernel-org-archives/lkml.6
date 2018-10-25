Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03B7C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68573207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aN9rXl7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68573207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJZGlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:41:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56842 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeJZGlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:41:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9PM6mff013294;
        Thu, 25 Oct 2018 17:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540505208;
        bh=Oac5OK0ut5ch1bJ8yD00lNGlwcUVawYLcuqPIotKc4k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aN9rXl7cpZPMdEf1Ku8c7aSG0LPqUqe1bI1kNfDY4IcrBbvYmgBkMYyX8cusEqfKg
         mjx9QZoVDp7Y01gRGMNsPtYTjIo2qunYbX5CcSUo2O+a2wFwe3z8rPbSVQmgDHJOf4
         iLbqHNc/oZM7hX3LaCJGnHOZi3rqvvzjBWd/X6QE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9PM6mnB003296
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 17:06:48 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 25
 Oct 2018 17:06:48 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 25 Oct 2018 17:06:48 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9PM6mm6004805;
        Thu, 25 Oct 2018 17:06:48 -0500
Subject: Re: [PATCH v4 13/17] remoteproc: create vdev subdevice with specific
 dma memory pool
To:     Loic PALLARDY <loic.pallardy@st.com>,
        Wendy Liang <sunnyliangjy@gmail.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-14-git-send-email-loic.pallardy@st.com>
 <CAA07jV8tJNwQ0RMu_SG=KKjRNNGx=X5XW0Mzu1VFSPgJa-Uwrg@mail.gmail.com>
 <88325716f2a6447a9e12312674be317b@SFHDAG7NODE2.st.com>
 <CAA07jV_=9xGtD70CL9=A553_pL-_HyZbcx-WV9buficNn-eY+g@mail.gmail.com>
 <cd8a9458-7102-2250-b849-a3aadaffa1a0@ti.com>
 <472565ee-1327-a8a4-3b32-224ccafd3daf@ti.com>
 <30fc4389a49244c29c0025b3923dd565@SFHDAG7NODE2.st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <de96016b-cff2-469f-5f85-32a6ed7a7edb@ti.com>
Date:   Thu, 25 Oct 2018 17:06:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <30fc4389a49244c29c0025b3923dd565@SFHDAG7NODE2.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 7:42 AM, Loic PALLARDY wrote:
> 
> 
>> -----Original Message-----
>> From: Suman Anna <s-anna@ti.com>
>> Sent: mercredi 24 octobre 2018 03:49
>> To: Wendy Liang <sunnyliangjy@gmail.com>; Loic PALLARDY
>> <loic.pallardy@st.com>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>; Ohad Ben-Cohen
>> <ohad@wizery.com>; linux-remoteproc@vger.kernel.org; Linux Kernel
>> Mailing List <linux-kernel@vger.kernel.org>; Arnaud POULIQUEN
>> <arnaud.pouliquen@st.com>; benjamin.gaignard@linaro.org
>> Subject: Re: [PATCH v4 13/17] remoteproc: create vdev subdevice with
>> specific dma memory pool
>>
>> On 10/23/18 8:22 PM, Suman Anna wrote:
>>> On 9/27/18 3:18 PM, Wendy Liang wrote:
>>>> Hi Loic,
>>>>
>>>>
>>>> On Thu, Sep 27, 2018 at 12:22 PM Loic PALLARDY <loic.pallardy@st.com>
>> wrote:
>>>>>
>>>>> Hi Wendy
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Wendy Liang <sunnyliangjy@gmail.com>
>>>>>> Sent: Thursday, September 27, 2018 7:17 PM
>>>>>> To: Loic PALLARDY <loic.pallardy@st.com>
>>>>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>; Ohad Ben-Cohen
>>>>>> <ohad@wizery.com>; linux-remoteproc@vger.kernel.org; Linux Kernel
>>>>>> Mailing List <linux-kernel@vger.kernel.org>; Arnaud POULIQUEN
>>>>>> <arnaud.pouliquen@st.com>; benjamin.gaignard@linaro.org; Suman
>> Anna
>>>>>> <s-anna@ti.com>
>>>>>> Subject: Re: [PATCH v4 13/17] remoteproc: create vdev subdevice with
>>>>>> specific dma memory pool
>>>>>>
>>>>>> On Fri, Jul 27, 2018 at 6:16 AM Loic Pallardy <loic.pallardy@st.com>
>> wrote:
>>>>>>>
>>>>>>> This patch creates a dedicated vdev subdevice for each vdev declared
>>>>>>> in firmware resource table and associates carveout named
>> "vdev%dbuffer"
>>>>>>> (with %d vdev index in resource table) if any as dma coherent
>> memory
>>>>>> pool.
>>>>>>>
>>>>>>> Then vdev subdevice is used as parent for virtio device.
>>>>>>>
>>>>>>> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
>>>>>>> ---
>>>>>>>  drivers/remoteproc/remoteproc_core.c     | 35
>>>>>> +++++++++++++++++++++++---
>>>>>>>  drivers/remoteproc/remoteproc_internal.h |  1 +
>>>>>>>  drivers/remoteproc/remoteproc_virtio.c   | 42
>>>>>> +++++++++++++++++++++++++++++++-
>>>>>>>  include/linux/remoteproc.h               |  1 +
>>>>>>>  4 files changed, 75 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>>>>> b/drivers/remoteproc/remoteproc_core.c
>>>>>>> index 4edc6f0..adcc66e 100644
>>>>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>>>>> @@ -39,6 +39,7 @@
>>>>>>>  #include <linux/idr.h>
>>>>>>>  #include <linux/elf.h>
>>>>>>>  #include <linux/crc32.h>
>>>>>>> +#include <linux/of_reserved_mem.h>
>>>>>>>  #include <linux/virtio_ids.h>
>>>>>>>  #include <linux/virtio_ring.h>
>>>>>>>  #include <asm/byteorder.h>
>>>>>>> @@ -145,7 +146,7 @@ static void rproc_disable_iommu(struct rproc
>>>>>> *rproc)
>>>>>>>         iommu_domain_free(domain);
>>>>>>>  }
>>>>>>>
>>>>>>> -static phys_addr_t rproc_va_to_pa(void *cpu_addr)
>>>>>>> +phys_addr_t rproc_va_to_pa(void *cpu_addr)
>>>>>>>  {
>>>>>>>         /*
>>>>>>>          * Return physical address according to virtual address location
>>>>>>> @@ -160,6 +161,7 @@ static phys_addr_t rproc_va_to_pa(void
>>>>>> *cpu_addr)
>>>>>>>         WARN_ON(!virt_addr_valid(cpu_addr));
>>>>>>>         return virt_to_phys(cpu_addr);
>>>>>>>  }
>>>>>>> +EXPORT_SYMBOL(rproc_va_to_pa);
>>>>>>>
>>>>>>>  /**
>>>>>>>   * rproc_da_to_va() - lookup the kernel virtual address for a
>> remoteproc
>>>>>> address
>>>>>>> @@ -423,6 +425,20 @@ static void rproc_vdev_do_stop(struct
>>>>>> rproc_subdev *subdev, bool crashed)
>>>>>>>  }
>>>>>>>
>>>>>>>  /**
>>>>>>> + * rproc_rvdev_release() - release the existence of a rvdev
>>>>>>> + *
>>>>>>> + * @dev: the subdevice's dev
>>>>>>> + */
>>>>>>> +static void rproc_rvdev_release(struct device *dev)
>>>>>>> +{
>>>>>>> +       struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev,
>> dev);
>>>>>>> +
>>>>>>> +       of_reserved_mem_device_release(dev);
>>>>>>> +
>>>>>>> +       kfree(rvdev);
>>>>>>> +}
>>>>>>> +
>>>>>>> +/**
>>>>>>>   * rproc_handle_vdev() - handle a vdev fw resource
>>>>>>>   * @rproc: the remote processor
>>>>>>>   * @rsc: the vring resource descriptor
>>>>>>> @@ -455,6 +471,7 @@ static int rproc_handle_vdev(struct rproc
>> *rproc,
>>>>>> struct fw_rsc_vdev *rsc,
>>>>>>>         struct device *dev = &rproc->dev;
>>>>>>>         struct rproc_vdev *rvdev;
>>>>>>>         int i, ret;
>>>>>>> +       char name[16];
>>>>>>>
>>>>>>>         /* make sure resource isn't truncated */
>>>>>>>         if (sizeof(*rsc) + rsc->num_of_vrings * sizeof(struct
>>>>>> fw_rsc_vdev_vring)
>>>>>>> @@ -488,6 +505,18 @@ static int rproc_handle_vdev(struct rproc
>> *rproc,
>>>>>> struct fw_rsc_vdev *rsc,
>>>>>>>         rvdev->rproc = rproc;
>>>>>>>         rvdev->index = rproc->nb_vdev++;
>>>>>>>
>>>>>>> +       /* Initialise vdev subdevice */
>>>>>>> +       snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
>>>>>>> +       rvdev->dev.parent = rproc->dev.parent;
>>>>>>> +       rvdev->dev.release = rproc_rvdev_release;
>>>>>>> +       dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev-
>>>>>>> dev.parent), name);
>>>>>>> +       dev_set_drvdata(&rvdev->dev, rvdev);
>>>>>>> +       dma_set_coherent_mask(&rvdev->dev, DMA_BIT_MASK(32));
>>>>>> I tried the latest kernel, this function will not set the DMA coherent
>> mask as
>>>>>> dma_supported() of the &rvdev->dev will return false.
>>>>>> As this is a device created at run time, should it be force to support
>> DMA?
>>>>>> should it directly set the dma_coherent_mask?
>>>>>
>>>>> Thanks for pointing me this issue. I tested on top of 4.18-rc1 few months
>> ago...
>>>>> Could you please give me kernel version on which you are testing the
>> series?
>>>>> Is you platform 32bit or 64bit ?
>>>>> I'll rebase and check on my side.
>>>>
>>>> I am testing with 4.19-rc4 on aarch64 platform.
>>>
>>> Btw, I ran into this on my v7 platform as well (4.19-rc6). The
>>> dma_set_coherent_mask fails with error EIO. I did get my allocations
>>> through though.
>>
>> Correction, that was before Patch 17. With patch 17, this fails.
> 
> Yes normal as device for allocation is changed Patch17. 

The failure was due to dma_alloc failure in rpmsg_probe, your patch13
should have registered the DMA pool for this, and I think the root-cause
is back to the dma_set_coherent_mask failure and unsupported dma_ops on
this device.

regards
Suman

> Regards,
> Loic
>>
>> regards
>> Suman
>>
>>>
>>> regards
>>> Suman
>>>
>>>>
>>>> Best Regards,
>>>> Wendy
>>>>>
>>>>> Regards,
>>>>> Loic
>>>>>
>>>>>>
>>>>>>> +
>>>>>>> +       ret = device_register(&rvdev->dev);
>>>>>>> +       if (ret)
>>>>>>> +               goto free_rvdev;
>>>>>>> +
>>>>>>>         /* parse the vrings */
>>>>>>>         for (i = 0; i < rsc->num_of_vrings; i++) {
>>>>>>>                 ret = rproc_parse_vring(rvdev, rsc, i);
>>>>>>> @@ -518,7 +547,7 @@ static int rproc_handle_vdev(struct rproc
>> *rproc,
>>>>>> struct fw_rsc_vdev *rsc,
>>>>>>>         for (i--; i >= 0; i--)
>>>>>>>                 rproc_free_vring(&rvdev->vring[i]);
>>>>>>>  free_rvdev:
>>>>>>> -       kfree(rvdev);
>>>>>>> +       device_unregister(&rvdev->dev);
>>>>>>>         return ret;
>>>>>>>  }
>>>>>>>
>>>>>>> @@ -536,7 +565,7 @@ void rproc_vdev_release(struct kref *ref)
>>>>>>>
>>>>>>>         rproc_remove_subdev(rproc, &rvdev->subdev);
>>>>>>>         list_del(&rvdev->node);
>>>>>>> -       kfree(rvdev);
>>>>>>> +       device_unregister(&rvdev->dev);
>>>>>>>  }
>>>>>>>
>>>>>>>  /**
>>>>>>> diff --git a/drivers/remoteproc/remoteproc_internal.h
>>>>>> b/drivers/remoteproc/remoteproc_internal.h
>>>>>>> index f6cad24..bfeacfd 100644
>>>>>>> --- a/drivers/remoteproc/remoteproc_internal.h
>>>>>>> +++ b/drivers/remoteproc/remoteproc_internal.h
>>>>>>> @@ -52,6 +52,7 @@ struct dentry *rproc_create_trace_file(const
>> char
>>>>>> *name, struct rproc *rproc,
>>>>>>>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>>>>>>>
>>>>>>>  void *rproc_da_to_va(struct rproc *rproc, u64 da, int len);
>>>>>>> +phys_addr_t rproc_va_to_pa(void *cpu_addr);
>>>>>>>  int rproc_trigger_recovery(struct rproc *rproc);
>>>>>>>
>>>>>>>  int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware
>> *fw);
>>>>>>> diff --git a/drivers/remoteproc/remoteproc_virtio.c
>>>>>> b/drivers/remoteproc/remoteproc_virtio.c
>>>>>>> index de21f62..9ee63c0 100644
>>>>>>> --- a/drivers/remoteproc/remoteproc_virtio.c
>>>>>>> +++ b/drivers/remoteproc/remoteproc_virtio.c
>>>>>>> @@ -17,7 +17,9 @@
>>>>>>>   * GNU General Public License for more details.
>>>>>>>   */
>>>>>>>
>>>>>>> +#include <linux/dma-mapping.h>
>>>>>>>  #include <linux/export.h>
>>>>>>> +#include <linux/of_reserved_mem.h>
>>>>>>>  #include <linux/remoteproc.h>
>>>>>>>  #include <linux/virtio.h>
>>>>>>>  #include <linux/virtio_config.h>
>>>>>>> @@ -315,10 +317,48 @@ static void rproc_virtio_dev_release(struct
>> device
>>>>>> *dev)
>>>>>>>  int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>>>>>>>  {
>>>>>>>         struct rproc *rproc = rvdev->rproc;
>>>>>>> -       struct device *dev = &rproc->dev;
>>>>>>> +       struct device *dev = &rvdev->dev;
>>>>>>>         struct virtio_device *vdev = &rvdev->vdev;
>>>>>>> +       struct rproc_mem_entry *mem;
>>>>>>>         int ret;
>>>>>>>
>>>>>>> +       /* Try to find dedicated vdev buffer carveout */
>>>>>>> +       mem = rproc_find_carveout_by_name(rproc, "vdev%dbuffer",
>> rvdev-
>>>>>>> index);
>>>>>>> +       if (mem) {
>>>>>>> +               phys_addr_t pa;
>>>>>>> +
>>>>>>> +               if (mem->of_resm_idx != -1) {
>>>>>>> +                       struct device_node *np = rproc->dev.parent->of_node;
>>>>>>> +
>>>>>>> +                       /* Associate reserved memory to vdev device */
>>>>>>> +                       ret = of_reserved_mem_device_init_by_idx(dev, np,
>>>>>>> +                                                                mem->of_resm_idx);
>>>>>>> +                       if (ret) {
>>>>>>> +                               dev_err(dev, "Can't associate reserved memory\n");
>>>>>>> +                               goto out;
>>>>>>> +                       }
>>>>>>> +               } else {
>>>>>>> +                       if (mem->va) {
>>>>>>> +                               dev_warn(dev, "vdev %d buffer already mapped\n",
>>>>>>> +                                        rvdev->index);
>>>>>>> +                               pa = rproc_va_to_pa(mem->va);
>>>>>>> +                       } else {
>>>>>>> +                               /* Use dma address as carveout no memmapped yet
>> */
>>>>>>> +                               pa = (phys_addr_t)mem->dma;
>>>>>>> +                       }
>>>>>>> +
>>>>>>> +                       /* Associate vdev buffer memory pool to vdev subdev */
>>>>>>> +                       ret = dmam_declare_coherent_memory(dev, pa,
>>>>>>> +                                                          mem->da,
>>>>>>> +                                                          mem->len,
>>>>>>> +                                                          DMA_MEMORY_EXCLUSIVE);
>>>>>>> +                       if (ret < 0) {
>>>>>>> +                               dev_err(dev, "Failed to associate buffer\n");
>>>>>>> +                               goto out;
>>>>>>> +                       }
>>>>>>> +               }
>>>>>>> +       }
>>>>>>> +
>>>>>>>         vdev->id.device = id,
>>>>>>>         vdev->config = &rproc_virtio_config_ops,
>>>>>>>         vdev->dev.parent = dev;
>>>>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>>>>> index 6b3a234..2921dd2 100644
>>>>>>> --- a/include/linux/remoteproc.h
>>>>>>> +++ b/include/linux/remoteproc.h
>>>>>>> @@ -547,6 +547,7 @@ struct rproc_vdev {
>>>>>>>         struct kref refcount;
>>>>>>>
>>>>>>>         struct rproc_subdev subdev;
>>>>>>> +       struct device dev;
>>>>>>>
>>>>>>>         unsigned int id;
>>>>>>>         struct list_head node;
>>>>>>> --
>>>>>>> 1.9.1
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-
>> remoteproc"
>>>>>> in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-
>> info.html
>>>
> 

