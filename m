Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbeAaMK7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:10:59 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:24095 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751788AbeAaMK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:10:58 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Neil Leeder <nleeder@codeaurora.org>,
        Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>,
        Timur Tabi <timur@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Mark Salter <msalter@redhat.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 1/2] acpi: arm64: add iort support for PMCG
Thread-Topic: [PATCH 1/2] acpi: arm64: add iort support for PMCG
Thread-Index: AQHTDV2/CQ/dFwJGo0+KDC6Dtk3j06ONSjEggAByqYCAASH10A==
Date: Wed, 31 Jan 2018 12:10:47 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838641882@FRAEML521-MBX.china.huawei.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-2-git-send-email-nleeder@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA8386400F7@FRAEML521-MBX.china.huawei.com>
 <20180130180013.GA16154@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180130180013.GA16154@e107981-ln.cambridge.arm.com>
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

Hi Lorenzo,

> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: Tuesday, January 30, 2018 6:00 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Neil Leeder <nleeder@codeaurora.org>; Mark Langsdorf
> <mlangsdo@redhat.com>; Jon Masters <jcm@redhat.com>; Timur Tabi
> <timur@codeaurora.org>; linux-kernel@vger.kernel.org; Mark Brown
> <broonie@kernel.org>; Mark Salter <msalter@redhat.com>; linux-arm-
> kernel@lists.infradead.org; Will Deacon <will.deacon@arm.com>; Mark
> Rutland <mark.rutland@arm.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH 1/2] acpi: arm64: add iort support for PMCG
> 
> On Tue, Jan 30, 2018 at 10:39:20AM +0000, Shameerali Kolothum Thodi wrote:
> > Hi Neil/Lorenzo,
> >
> > > -----Original Message-----
> > > From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces@lists.infradead.org]
> > > On Behalf Of Neil Leeder
> > > Sent: Friday, August 04, 2017 8:59 PM
> > > To: Will Deacon <will.deacon@arm.com>; Mark Rutland
> > > <mark.rutland@arm.com>
> > > Cc: Mark Langsdorf <mlangsdo@redhat.com>; Jon Masters
> > > <jcm@redhat.com>; Timur Tabi <timur@codeaurora.org>; linux-
> > > kernel@vger.kernel.org; Mark Brown <broonie@kernel.org>; Mark Salter
> > > <msalter@redhat.com>; nleeder@codeaurora.org; linux-arm-
> > > kernel@lists.infradead.org
> > > Subject: [PATCH 1/2] acpi: arm64: add iort support for PMCG
> > >
> > > Add support for the SMMU Performance Monitor Counter Group
> > > information from ACPI. This is in preparation for its use
> > > in the SMMU v3 PMU driver.
> >
> > [...]
> >
> > >  static __init
> > >  const struct iort_iommu_config *iort_get_iommu_cfg(struct
> acpi_iort_node
> > > *node)
> > >  {
> > > @@ -1001,6 +1041,8 @@ const struct iort_iommu_config
> > > *iort_get_iommu_cfg(struct acpi_iort_node *node)
> > >  		return &iort_arm_smmu_v3_cfg;
> > >  	case ACPI_IORT_NODE_SMMU:
> > >  		return &iort_arm_smmu_cfg;
> > > +	case ACPI_IORT_NODE_PMCG:
> > > +		return &iort_arm_smmu_pmcg_cfg;
> >
> > I understand this series will be revised based on the iort spec update.
> >
> > This Is to clarify few queries we have with respect to one of our hisilicon
> > platform which has support for SMMU v3 PMCG. In our implementation
> > the base address for the PMCG is defined at a IMP DEF address offset
> > within the SMMUv3 page 0 address space. And as per SMMU spec,
> >
> > " The Performance Monitor Counter Groups are standalone monitoring
> > facilities  and, as such, can be implemented in separate components that
> > are all associated with (but not necessarily part of) an SMMU"
> >
> > It looks like PMCG can be part of SMMU,  it is not clear whether this kind
> > of address mapping is forbidden or not. If this is an accepted  scenario, then
> > the devm_ioremap_resource() call in SMMv3 probe will fail as it reports
> conflict.
> >
> > As far as I can see, the above code just checks the iort node type is PMCG
> > and assumes that its SMMU PMCG. As per IORT spec, it make sense to check
> > the node reference filed and make that call.
> >
> > And to fix the resource conflict issue we have, is it possible to treat the PMCG
> > node as the child of the SMMU and call the platform_device_add()
> appropriately
> > to avoid the conflict? I am not sure this will fix the issue and also about the
> order
> > in which SMMU and PMCG devices will be populated will have an impact on
> this.
> >
> > Please let me know your thoughts on this.
> 
> I went back and re-read the patches, I think the point here is that the
> perf driver (ie PATCH 2 that, by the way, is not maiinline) uses
> devm_ioremap_resource() to map the counters and that's what is causing
> failures when PMCG is part of SMMUv3 registers.

Thanks for going through this.  No, this is not where we are seeing the failure.
May be I was not clear in my earlier mail. The failure happens in SMMUv3
driver probe function when it calls devm_ioremap_resource().

> It is the resources hierarchy that is wrong and in turn, I do not think
> devm_request_mem_region() is the right way of requesting it for the
> PMCG driver.
> 
> I need to look into this but I suspect that's something that should
> be handled in the PMCG driver, that has to request the memory region
> _differently_ (ie ioremap copes with this overlap - it is the
> devm_request_mem_region() in devm_ioremap_resource() that fails, correct
> ?).

It looks like, in IORT code,

iort_add_platform_device()--> platform_device_add()-->insert_resource(), inserts
both SMMUv3 and PMCG resources into the resource tree and then when the probe
of SMMUv3 is called, it detects the conflict.

[   85.548749] arm-smmu-v3 arm-smmu-v3.0.auto: can't request region for resource [mem 0x148000000-0x14801ffff]                      

Of course, changing devm_ioremap_resource() to devm_ioremap() in SMMv3
driver probe solves the issue for us, but not sure that's the right approach or not.

Thanks,
Shameer

> Certainly we need to create in IORT the resources with the correct
> hierarchy (I reckon DT does it already if the right device hierarchy is
> specified).
 
