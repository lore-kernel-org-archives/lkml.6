Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967717AbeCALO2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:14:28 -0500
Received: from regular1.263xmail.com ([211.150.99.138]:54042 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967592AbeCALO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:14:26 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: robin.murphy@arm.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <e25ea86df53c75e372460cc3dc975cc8>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A97E082.3020109@rock-chips.com>
Date: Thu, 01 Mar 2018 19:14:10 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
CC: jcliang@chromium.org, xxm@rock-chips.com, tfiga@chromium.org,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v6 14/14] iommu/rockchip: Support sharing IOMMU
 between masters
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com> <20180301101837.27969-15-jeffy.chen@rock-chips.com> <44efebd3-ab48-4e12-cf92-66b6563f7644@arm.com>
In-Reply-To: <44efebd3-ab48-4e12-cf92-66b6563f7644@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 03/01/2018 07:03 PM, Robin Murphy wrote:
>>
>> +static struct iommu_group *rk_iommu_device_group(struct device *dev)
>> +{
>> +    struct rk_iommu *iommu;
>> +
>> +    iommu = rk_iommu_from_dev(dev);
>> +
>> +    return iommu->group;
>
> Oops, seems I overlooked this in my previous review - it should really be:
>
>      return iommu_group_get(iommu->group);
>
> or the refcounting will be unbalanced on those future systems where it
> really will be called more than once.
>
hmmm, right, it should be return iommu_group_ref_get(iommu->group);

i was following omap iommu:
static struct iommu_group *omap_iommu_device_group(struct device *dev)
{
         struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
         struct iommu_group *group = ERR_PTR(-EINVAL);

         if (arch_data->iommu_dev)
                 group = arch_data->iommu_dev->group;

         return group;
}

will fix it too in the version.

> Robin.
