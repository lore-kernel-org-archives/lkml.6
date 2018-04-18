Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeDRLF4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:05:56 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:35974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751305AbeDRLFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:05:55 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: "xieyisheng (A)" <xieyisheng1@huawei.com>,
        Neil Leeder <nleeder@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
CC: Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>,
        Timur Tabi <timur@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Mark Salter <msalter@redhat.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
Thread-Topic: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
Thread-Index: AQHTxyw0LxwDEWZW702T4Aqj9sNHRqQGettg
Date: Wed, 18 Apr 2018 11:05:44 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83868C029@FRAEML521-MBX.china.huawei.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
 <883d32ce-6581-ecf6-5088-ecb238322ebe@huawei.com>
In-Reply-To: <883d32ce-6581-ecf6-5088-ecb238322ebe@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Yisheng Xie
> Sent: Thursday, March 29, 2018 8:04 AM
> To: Neil Leeder <nleeder@codeaurora.org>; Will Deacon
> <will.deacon@arm.com>; Mark Rutland <mark.rutland@arm.com>
> Cc: Mark Langsdorf <mlangsdo@redhat.com>; Jon Masters
> <jcm@redhat.com>; Timur Tabi <timur@codeaurora.org>; linux-
> kernel@vger.kernel.org; Mark Brown <broonie@kernel.org>; Mark Salter
> <msalter@redhat.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
> 
> Hi Neil,
> 
> On 2017/8/5 3:59, Neil Leeder wrote:
> > +	mem_resource_0 = platform_get_resource(pdev, IORESOURCE_MEM,
> 0);
> > +	mem_map_0 = devm_ioremap_resource(&pdev->dev,
> mem_resource_0);
> > +
> Can we use devm_ioremap instead? for the reg_base of smmu_pmu is
> IMPLEMENTATION DEFINED. If the reg of smmu_pmu is inside smmu,
> devm_ioremap_resource will failed and return -EBUSY, eg.:
> 
>  smmu reg ranges:		0x180000000 ~ 0x1801fffff
>  its smmu_pmu reg ranges:	0x180001000 ~ 0x180001fff

I think this will not solve the issue completely as the smmu v3 driver 
uses devm_ioremap_resource() currently and that will fail because of
the overlap.

Please find the discussion here:
https://lkml.org/lkml/2018/1/31/235

Thanks,
Shameer

> > +	if (IS_ERR(mem_map_0)) {
> > +		dev_err(&pdev->dev, "Can't map SMMU PMU @%pa\n",
> > +			&mem_resource_0->start);
> > +		return PTR_ERR(mem_map_0);
> > +	}
> > +
> > +	smmu_pmu->reg_base = mem_map_0;
> > +	smmu_pmu->pmu.name =
> > +		devm_kasprintf(&pdev->dev, GFP_KERNEL, "smmu_0_%llx",
> > +			       (mem_resource_0->start) >> SMMU_PA_SHIFT);
> > +
> > +	if (!smmu_pmu->pmu.name) {
> > +		dev_err(&pdev->dev, "Failed to create PMU name");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ceid_64 = readq(smmu_pmu->reg_base + SMMU_PMCG_CEID0);
> > +	ceid[0] = ceid_64 & GENMASK(31, 0);
> > +	ceid[1] = ceid_64 >> 32;
> > +	ceid_64 = readq(smmu_pmu->reg_base + SMMU_PMCG_CEID1);
> > +	ceid[2] = ceid_64 & GENMASK(31, 0);
> > +	ceid[3] = ceid_64 >> 32;
> > +	bitmap_from_u32array(smmu_pmu->supported_events,
> SMMU_MAX_EVENT_ID,
> > +			     ceid, SMMU_NUM_EVENTS_U32);
> > +
> > +	/* Determine if page 1 is present */
> > +	if (readl(smmu_pmu->reg_base + SMMU_PMCG_CFGR) &
> > +	    SMMU_PMCG_CFGR_RELOC_CTRS) {
> > +		mem_resource_1 = platform_get_resource(pdev,
> IORESOURCE_MEM, 1);
> > +		mem_map_1 = devm_ioremap_resource(&pdev->dev,
> mem_resource_1);
> > +
> The same as above.
> 
> Thanks
> Yisheng
> 
> > +		if (IS_ERR(mem_map_1)) {
> > +			dev_err(&pdev->dev, "Can't map SMMU PMU
> @%pa\n",
> > +				&mem_resource_1->start);
> > +			return PTR_ERR(mem_map_1);
> > +		}
> > +		smmu_pmu->reloc_base = mem_map_1;
> > +	} else {
> > +		smmu_pmu->reloc_base = smmu_pmu->reg_base;
> > +	}
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev,
> > +			"Failed to get valid irq for smmu @%pa\n",
> > +			&mem_resource_0->start);
> > +		return irq;
> > +	}
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
