Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB02C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC68218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="olp4hUls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfAXKUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:20:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52120 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfAXKUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:20:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0OAJnWX035146;
        Thu, 24 Jan 2019 04:19:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548325189;
        bh=lLgW06B8HXWFIXPwD6DmsaBpUeRnkjI0FRVggopSNQA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=olp4hUlsboDomK7x4S5nfkIjJHi8kVc/pf1JOe9P56K+XCeM7I+lyWpNf9ArhRish
         iN/pIw7N4i7B1oQA0n41pk5ymob5ajVngWnNdGFJ0fCrIn+AyykKCkZbka6XUrOn2i
         v93PQ7ImlMCTwFoDEODzrezYTyfw+eP9WpIVK/3M=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0OAJnpo023610
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 04:19:49 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 04:19:49 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 04:19:49 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0OAJjFW001098;
        Thu, 24 Jan 2019 04:19:46 -0600
Subject: Re: [RFC PATCH v4 08/13] genirq/msi: Add support for allocating
 single MSI for a device
To:     Marc Zyngier <Marc.Zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
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
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <faad8e90-2f97-1dbb-fb98-e0f1462e29c5@ti.com>
Date:   Thu, 24 Jan 2019 15:49:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5be38277-3348-a6d9-4b67-3ead308c009a@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,
	Sorry for the delayed response. Just back from vacation.

On 17/01/19 12:00 AM, Marc Zyngier wrote:
> On 27/12/2018 06:13, Lokesh Vutla wrote:
>> Previously all msi for a device are allocated in one go
>> by calling msi_domain_alloc_irq() from a bus layer. This might
>> not be the case when a device is trying to allocate interrupts
>> dynamically based on a request to it.
>>
>> So introduce msi_domain_alloc/free_irq() apis to allocate a single
>> msi. prepare and activate operations to be handled by bus layer
>> calling msi_domain_alloc/free_irq() apis.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  include/linux/msi.h |  3 +++
>>  kernel/irq/msi.c    | 62 +++++++++++++++++++++++++++++----------------
>>  2 files changed, 43 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>> index 784fb52b9900..474490826f8c 100644
>> --- a/include/linux/msi.h
>> +++ b/include/linux/msi.h
>> @@ -301,8 +301,11 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
>>  struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
>>   struct msi_domain_info *info,
>>   struct irq_domain *parent);
>> +int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
>> + struct msi_desc *desc,  msi_alloc_info_t *arg);
>>  int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>    int nvec);
>> +void msi_domain_free_irq(struct msi_desc *desc);
>>  void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
>>  struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
>>
>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>> index ad26fbcfbfc8..eb7459324113 100644
>> --- a/kernel/irq/msi.c
>> +++ b/kernel/irq/msi.c
>> @@ -387,6 +387,35 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
>>  return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
>>  }
>>
>> +int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
>> + struct msi_desc *desc,  msi_alloc_info_t *arg)
>> +{
>> +struct msi_domain_info *info = domain->host_data;
>> +struct msi_domain_ops *ops = info->ops;
>> +int i, ret, virq;
>> +
>> +ops->set_desc(arg, desc);
>> +
>> +virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
>> +       dev_to_node(dev), arg, false,
>> +       desc->affinity);
>> +if (virq < 0) {
>> +ret = -ENOSPC;
>> +if (ops->handle_error)
>> +ret = ops->handle_error(domain, desc, ret);
>> +if (ops->msi_finish)
>> +ops->msi_finish(arg, ret);
>> +return ret;
>> +}
>> +
>> +for (i = 0; i < desc->nvec_used; i++) {
>> +irq_set_msi_desc_off(virq, i, desc);
>> +irq_debugfs_copy_devname(virq + i, dev);
>> +}
>> +
>> +return 0;
>> +}
>> +
>>  /**
>>   * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
>>   * @domain:The domain to allocate from
>> @@ -404,7 +433,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>  struct irq_data *irq_data;
>>  struct msi_desc *desc;
>>  msi_alloc_info_t arg;
>> -int i, ret, virq;
>> +int ret, virq;
>>  bool can_reserve;
>>
>>  ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
>> @@ -412,24 +441,9 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>  return ret;
>>
>>  for_each_msi_entry(desc, dev) {
>> -ops->set_desc(&arg, desc);
>> -
>> -virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
>> -       dev_to_node(dev), &arg, false,
>> -       desc->affinity);
>> -if (virq < 0) {
>> -ret = -ENOSPC;
>> -if (ops->handle_error)
>> -ret = ops->handle_error(domain, desc, ret);
>> -if (ops->msi_finish)
>> -ops->msi_finish(&arg, ret);
>> +ret = msi_domain_alloc_irq(domain, dev, desc, &arg);
>> +if (ret)
>>  return ret;
>> -}
>> -
>> -for (i = 0; i < desc->nvec_used; i++) {
>> -irq_set_msi_desc_off(virq, i, desc);
>> -irq_debugfs_copy_devname(virq + i, dev);
>> -}
>>  }
>>
>>  if (ops->msi_finish)
>> @@ -487,6 +501,12 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>  return ret;
>>  }
>>
>> +void msi_domain_free_irq(struct msi_desc *desc)
>> +{
>> +irq_domain_free_irqs(desc->irq, desc->nvec_used);
>> +desc->irq = 0;
>> +}
>> +
>>  /**
>>   * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
>>   * @domain:The domain to managing the interrupts
>> @@ -503,10 +523,8 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
>>   * enough that there is no IRQ associated to this
>>   * entry. If that's the case, don't do anything.
>>   */
>> -if (desc->irq) {
>> -irq_domain_free_irqs(desc->irq, desc->nvec_used);
>> -desc->irq = 0;
>> -}
>> +if (desc->irq)
>> +msi_domain_free_irq(desc);
>>  }
>>  }
>>
>>
> 
> I can see some interesting issues with this API.
> 
> At the moment, MSIs are allocated upfront, and that's usually done
> before the driver can do anything else. With what you're suggesting
> here, MSIs can now be allocated at any time, which sounds great. But how
> does it work when MSIs get added/freed in parallel? I can't see any
> locking here...
> 
> It is also pretty nasty that the user of this API has to know about the
> MSI descriptor. Really, nobody should have to deal with this outside of
> the MSI layer.
> 
> The real question is why you need to need to allocate MSIs on demand for
> a given device. Usually, you allocate them because this is a per-CPU
> resource, or something similar. What makes it so variable that you need
> to resort to fine grained MSI allocation?

I added this after the discussion we had in the previous version[1] of this
series. Let me provide the details again:

As you must be aware INTR is interrupt re-director and INTA is the interrupt
multiplexer is the SoC. Here we are trying to address the interrupt connection
route as below:
Device(Global event) --> INTA --> INTR --> GIC

For the above case you suggested to have the following sw IRQ domain hierarchy:
INTA multi MSI --> INTA  -->  INTR  --> GIC

The problem here with the INTA MSI is that all the interrupts for a device
should be pre-allocated during the device probe time. But this is not what we
wanted especially for the DMA case.

An example DMA ring connection would look like below[2]:

                      +---------------------+
                       |         IA                |
+--------+        |            +------+   |        +--------+         +------+
| ring 1 +----->evtA+->VintX+-------->+   IR   +-- --->  GIC +-->
+--------+       |             +------+   |        +--------+         +------+
Linux IRQ Y
   evtA            |                             |
                       |                             |
                      +----------------------+

So when a DMA client driver requests a dma channel during probe, the DMA driver
gets a free ring in its allocated range. Then DMA driver requests MSI layer for
an IRQ. This is why I had to introduce on demand allocation of MSIs for a device.

The reason why we avoided DMA driver to allocate interrupts during its probe as
it is not aware of the exact no of channels that are going to be used. Also max
allocation of interrupts will overrun the gic IRQs available to this INTA and
the IPs that are connected to INTR directly will not get any interrupts.

I hope this is clear.

[1] https://lkml.org/lkml/2018/11/5/894
[2] https://pastebin.ubuntu.com/p/RTrgzfCMby/

Thanks and regards,
Lokesh
