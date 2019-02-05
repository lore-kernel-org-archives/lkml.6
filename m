Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE7FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADA52175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gam58mnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfBENmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:42:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54342 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfBENmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:42:53 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x15DgQKq006849;
        Tue, 5 Feb 2019 07:42:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549374146;
        bh=RHYMo3OkeYdCIxueyQ5gRTTu8UX7Tnicvz9bUlAAwBM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Gam58mnfLMjn4WC5sxsosccVQ4ARtVnY1WPoB+HGe021XseYtDadWuKy4UcaGQRkC
         ItvLaD51bMZPdP0tjS7DZV4IbT7tAvgfI9Tk2hhAT0YFV7sTmfx/0dckN7rvUHNaaK
         T4FHYThrZlpBftHyXJ/iexR2xtw8tMLplMQEVVkU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x15DgQRx112661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 07:42:26 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 5
 Feb 2019 07:42:26 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 5 Feb 2019 07:42:26 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x15DgLjh026492;
        Tue, 5 Feb 2019 07:42:22 -0600
Subject: Re: [RFC PATCH v4 08/13] genirq/msi: Add support for allocating
 single MSI for a device
To:     Marc Zyngier <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-8-lokeshvutla@ti.com>
 <5be38277-3348-a6d9-4b67-3ead308c009a@arm.com>
 <faad8e90-2f97-1dbb-fb98-e0f1462e29c5@ti.com>
 <523c4a23-b5b9-ff10-051d-c90e6e8341d4@arm.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <69699155-49f8-ce1e-3eb4-5b63ab032a94@ti.com>
Date:   Tue, 5 Feb 2019 19:12:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <523c4a23-b5b9-ff10-051d-c90e6e8341d4@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 04/02/19 4:03 PM, Marc Zyngier wrote:
> On 24/01/2019 10:19, Lokesh Vutla wrote:
>> Hi Marc,
>> 	Sorry for the delayed response. Just back from vacation.
>>
>> On 17/01/19 12:00 AM, Marc Zyngier wrote:
>>> On 27/12/2018 06:13, Lokesh Vutla wrote:
>>>> Previously all msi for a device are allocated in one go
>>>> by calling msi_domain_alloc_irq() from a bus layer. This might
>>>> not be the case when a device is trying to allocate interrupts
>>>> dynamically based on a request to it.
>>>>
>>>> So introduce msi_domain_alloc/free_irq() apis to allocate a single
>>>> msi. prepare and activate operations to be handled by bus layer
>>>> calling msi_domain_alloc/free_irq() apis.
>>>>
>>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>>> ---
>>>>  include/linux/msi.h |  3 +++
>>>>  kernel/irq/msi.c    | 62 +++++++++++++++++++++++++++++----------------
>>>>  2 files changed, 43 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>>>> index 784fb52b9900..474490826f8c 100644
>>>> --- a/include/linux/msi.h
>>>> +++ b/include/linux/msi.h
>>>> @@ -301,8 +301,11 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
>>>>  struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
>>>>   struct msi_domain_info *info,
>>>>   struct irq_domain *parent);
>>>> +int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
>>>> + struct msi_desc *desc,  msi_alloc_info_t *arg);
>>>>  int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>>>    int nvec);
>>>> +void msi_domain_free_irq(struct msi_desc *desc);
>>>>  void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
>>>>  struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
>>>>
>>>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>>>> index ad26fbcfbfc8..eb7459324113 100644
>>>> --- a/kernel/irq/msi.c
>>>> +++ b/kernel/irq/msi.c
>>>> @@ -387,6 +387,35 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
>>>>  return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
>>>>  }
>>>>
>>>> +int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
>>>> + struct msi_desc *desc,  msi_alloc_info_t *arg)
>>>> +{
>>>> +struct msi_domain_info *info = domain->host_data;
>>>> +struct msi_domain_ops *ops = info->ops;
>>>> +int i, ret, virq;
>>>> +
>>>> +ops->set_desc(arg, desc);
>>>> +
>>>> +virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
>>>> +       dev_to_node(dev), arg, false,
>>>> +       desc->affinity);
>>>> +if (virq < 0) {
>>>> +ret = -ENOSPC;
>>>> +if (ops->handle_error)
>>>> +ret = ops->handle_error(domain, desc, ret);
>>>> +if (ops->msi_finish)
>>>> +ops->msi_finish(arg, ret);
>>>> +return ret;
>>>> +}
>>>> +
>>>> +for (i = 0; i < desc->nvec_used; i++) {
>>>> +irq_set_msi_desc_off(virq, i, desc);
>>>> +irq_debugfs_copy_devname(virq + i, dev);
>>>> +}
>>>> +
>>>> +return 0;
>>>> +}
>>>> +
>>>>  /**
>>>>   * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
>>>>   * @domain:The domain to allocate from
>>>> @@ -404,7 +433,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>>>  struct irq_data *irq_data;
>>>>  struct msi_desc *desc;
>>>>  msi_alloc_info_t arg;
>>>> -int i, ret, virq;
>>>> +int ret, virq;
>>>>  bool can_reserve;
>>>>
>>>>  ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
>>>> @@ -412,24 +441,9 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>>>  return ret;
>>>>
>>>>  for_each_msi_entry(desc, dev) {
>>>> -ops->set_desc(&arg, desc);
>>>> -
>>>> -virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
>>>> -       dev_to_node(dev), &arg, false,
>>>> -       desc->affinity);
>>>> -if (virq < 0) {
>>>> -ret = -ENOSPC;
>>>> -if (ops->handle_error)
>>>> -ret = ops->handle_error(domain, desc, ret);
>>>> -if (ops->msi_finish)
>>>> -ops->msi_finish(&arg, ret);
>>>> +ret = msi_domain_alloc_irq(domain, dev, desc, &arg);
>>>> +if (ret)
>>>>  return ret;
>>>> -}
>>>> -
>>>> -for (i = 0; i < desc->nvec_used; i++) {
>>>> -irq_set_msi_desc_off(virq, i, desc);
>>>> -irq_debugfs_copy_devname(virq + i, dev);
>>>> -}
>>>>  }
>>>>
>>>>  if (ops->msi_finish)
>>>> @@ -487,6 +501,12 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>>>  return ret;
>>>>  }
>>>>
>>>> +void msi_domain_free_irq(struct msi_desc *desc)
>>>> +{
>>>> +irq_domain_free_irqs(desc->irq, desc->nvec_used);
>>>> +desc->irq = 0;
>>>> +}
>>>> +
>>>>  /**
>>>>   * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
>>>>   * @domain:The domain to managing the interrupts
>>>> @@ -503,10 +523,8 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
>>>>   * enough that there is no IRQ associated to this
>>>>   * entry. If that's the case, don't do anything.
>>>>   */
>>>> -if (desc->irq) {
>>>> -irq_domain_free_irqs(desc->irq, desc->nvec_used);
>>>> -desc->irq = 0;
>>>> -}
>>>> +if (desc->irq)
>>>> +msi_domain_free_irq(desc);
>>>>  }
>>>>  }
>>>>
>>>>
>>>
>>> I can see some interesting issues with this API.
>>>
>>> At the moment, MSIs are allocated upfront, and that's usually done
>>> before the driver can do anything else. With what you're suggesting
>>> here, MSIs can now be allocated at any time, which sounds great. But how
>>> does it work when MSIs get added/freed in parallel? I can't see any
>>> locking here...
>>>
>>> It is also pretty nasty that the user of this API has to know about the
>>> MSI descriptor. Really, nobody should have to deal with this outside of
>>> the MSI layer.
>>>
>>> The real question is why you need to need to allocate MSIs on demand for
>>> a given device. Usually, you allocate them because this is a per-CPU
>>> resource, or something similar. What makes it so variable that you need
>>> to resort to fine grained MSI allocation?
>>
>> I added this after the discussion we had in the previous version[1] of this
>> series. Let me provide the details again:
>>
>> As you must be aware INTR is interrupt re-director and INTA is the interrupt
>> multiplexer is the SoC. Here we are trying to address the interrupt connection
>> route as below:
>> Device(Global event) --> INTA --> INTR --> GIC
>>
>> For the above case you suggested to have the following sw IRQ domain hierarchy:
>> INTA multi MSI --> INTA  -->  INTR  --> GIC
>>
>> The problem here with the INTA MSI is that all the interrupts for a device
>> should be pre-allocated during the device probe time. But this is not what we
>> wanted especially for the DMA case.
>>
>> An example DMA ring connection would look like below[2]:
>>
>>                       +---------------------+
>>                        |         IA                |
>> +--------+        |            +------+   |        +--------+         +------+
>> | ring 1 +----->evtA+->VintX+-------->+   IR   +-- --->  GIC +-->
>> +--------+       |             +------+   |        +--------+         +------+
>> Linux IRQ Y
>>    evtA            |                             |
>>                        |                             |
>>                       +----------------------+
>>
>> So when a DMA client driver requests a dma channel during probe, the DMA driver
>> gets a free ring in its allocated range. Then DMA driver requests MSI layer for
>> an IRQ. This is why I had to introduce on demand allocation of MSIs for a device.
>>
>> The reason why we avoided DMA driver to allocate interrupts during its probe as
>> it is not aware of the exact no of channels that are going to be used. Also max
>> allocation of interrupts will overrun the gic IRQs available to this INTA and
>> the IPs that are connected to INTR directly will not get any interrupts.
> 
> But surely there is an upper bound that does exist for a given system,
> right?  DMA rings are not allocated out of nowhere. Or are you saying

Right, there is an upper limit on the DMA rings and DMA driver knows it. But
when an MSI is requested for each ring then the global events allocated for the
IA gets exhausted and MSI allocation gets failed.

Either I did not explain the the complete picture properly or I must be missing
something very badly here. Sorry for being dumb here. Let me give a pure
software perspective:

In the IRQ route we have the following variables:
1) source id
2) source index.
3) global events
4) vint
5) vint status bit(global event mapping to vint)
6) gic_irqs

- Source id and source index are managed by MSI client driver.
- Global event, vint and vint_status_bit allocation is managed by INTA driver
- Grouping of global event and mapping to vint is handled by INTA driver(chained
IRQ)
- gic_irqs allocation is managed by INTR driver.

When MSI client tries to allocate MSI for each source_index(rings for eg.)
available in a source, msi domain tries to allocate parent IRQs. Then INTA
driver will try to allocate a global event to each source index and fails when
the global events are exhausted. What am I missing here?

keeping in mind the above scenario, I started with single MSI allocations. I
agree there are issues with $patch. But before doing that I was hoping if the
above problem can be solved easily.

Also the same problem occurs for INTA parent IRQ allocation. INTA probe cannot
do a irq_create_fwspec_mapping() for all the available vints as gic_irqs will be
exhausted. Where do you think is the best place to create parent IRQs for INTA?
In the current implementation I am allocating it during msi_prepare(). So I had
to introduce msi_unprepare for freeing parent IRQs.

Thanks and regards,
Lokesh

> that when a DMA client requests DMA rings, it doesn't know how many it
> wants? Or does it? I don't think this is new in any of TI's design (the
> crossbar already had such limitation).
> 
> That being said, I'm open to revisiting this, but you must then
> introduce the right level of mutual exclusion in core code, as the
> msi_desc list now becomes much more dynamic and things would otherwise
> break badly. This has implications all over the place, and probably
> requires quite a bit of work (things like for_each_msi_desc_entry will
> break).
> 
> Between the two solutions outlined above, the first one is much easier
> to achieve than the second one.
> 
> Another avenue to explore would be to let the clients allocate as many
> MSIs as they want upfront, and use the "activate" callback to actually
> perform the assignment when such interrupt gets requested. In a way,
> this is not that different from what x86 does with the "early
> reservation, late assignment" type mechanism.
> 
> Thanks,
> 
> 	M.
> 
