Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeECJW3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:22:29 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:37271 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750945AbeECJW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:22:27 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Agustin Vega-Frias <agustinv@codeaurora.org>,
        "xieyisheng (A)" <xieyisheng1@huawei.com>
CC: Mark Rutland <mark.rutland@arm.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Neil Leeder <neil.m.leeder@gmail.com>, Jon Masters <jcm@redhat.com>,
        "Timur Tabi" <timur@codeaurora.org>, Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Mark Salter <msalter@redhat.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
Thread-Topic: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
Thread-Index: AQHTxyw0LxwDEWZW702T4Aqj9sNHRqPrauftgAF/YwCAL6c8gIABXEOA
Date: Thu, 3 May 2018 09:22:17 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8386AE941@FRAEML521-MBX.china.huawei.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
 <883d32ce-6581-ecf6-5088-ecb238322ebe@huawei.com>
 <e55ab4404143ea0b3cc4795a93e37480@codeaurora.org>
 <14f90cc6-f2c1-5a63-67c6-a5c8ddb4799e@gmail.com>
 <c1f9230b-8ff0-5b2e-def9-cbf6b2e2e99c@huawei.com>
 <93b3738c386c528193b158da0f85fd27@codeaurora.org>
In-Reply-To: <93b3738c386c528193b158da0f85fd27@codeaurora.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w439MY2s004089



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Agustin Vega-Frias
> Sent: Wednesday, May 02, 2018 3:20 PM
> To: xieyisheng (A) <xieyisheng1@huawei.com>
> Cc: Mark Rutland <mark.rutland@arm.com>; Mark Langsdorf
> <mlangsdo@redhat.com>; Neil Leeder <neil.m.leeder@gmail.com>; Jon
> Masters <jcm@redhat.com>; Timur Tabi <timur@codeaurora.org>; Will
> Deacon <will.deacon@arm.com>; linux-kernel@vger.kernel.org; Mark Brown
> <broonie@kernel.org>; Mark Salter <msalter@redhat.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
> 
> On 2018-04-02 02:37, Yisheng Xie wrote:
> > Hi Neil,
> >
> > On 2018/4/1 13:44, Neil Leeder wrote:
> >> Hi Yisheng Xie,
> >>
> >> On 3/29/2018 03:03 AM, Yisheng Xie wrote:
> >>>
> >>> Hi Neil,
> >>>
> >>> On 2017/8/5 3:59, Neil Leeder wrote:
> >>>> +    mem_resource_0 = platform_get_resource(pdev,
> IORESOURCE_MEM,
> >>>> 0);
> >>>> +    mem_map_0 = devm_ioremap_resource(&pdev->dev,
> mem_resource_0);
> >>>> +
> >>> Can we use devm_ioremap instead? for the reg_base of smmu_pmu is
> >>> IMPLEMENTATION DEFINED. If the reg of smmu_pmu is inside smmu,
> >>> devm_ioremap_resource will failed and return -EBUSY, eg.:
> >>>
> >>>   smmu reg ranges:        0x180000000 ~ 0x1801fffff
> >>>   its smmu_pmu reg ranges:    0x180001000 ~ 0x180001fff
> >>>
> >> Just to let you know that I no longer work at Qualcomm and I won't be
> >> able to provide updates to this patchset. I expect that others from my
> >> former team at Qualcomm will pick up ownership.
> >
> > Thanks for this infomation.
> >
> > hi Agustin and Timur,
> >
> > Is there any new status about this patchset?
> >
> 
> Hi,
> 
> Apologies for the slow response.
> We are having some internal discussions about when/if to do this.
> I expect to have more clarity within a few weeks.
> 
> For what is worth let me take the opportunity to outline the approach
> we would like to see for a V2 either developed by us or somebody else
> in the community:
> 
> 1. Rework to comply with the IORT spec changes.
> 
> 2. Rework probing to extract extra information from the IORT table
>     about SMMU/device associations.

Thanks for coming back on this. It would be good to address cases where
the PMCG base address is at a IMP DEF address offset within the associated
SMMUv3 page address space. As things stands with pmu v1 currently, the
SMMUv3 driver probe will fail. Please find the discussion here[1].

Thanks,
Shameer
[1] https://lkml.org/lkml/2018/1/31/235

>    With this information and some perf user space work I think it's
> possible
>    to have a single dynamic PMU node and use a similar approach to what
> is
>    used in the Coresight drivers to pass the device we want to monitor
> and
>    for the driver to find the PMU/PMCG. E.g.:
> 
>    $ lspci
>    0001:00:00.0 PCI bridge: Airgo Networks, Inc. Device 0401
>    0002:00:00.0 PCI bridge: Airgo Networks, Inc. Device 0401
>    0002:01:00.0 Ethernet controller: Mellanox Technologies MT27500 Family
> [ConnectX-3]
>    0003:00:00.0 PCI bridge: Airgo Networks, Inc. Device 0401
>    0003:01:00.0 Ethernet controller: Mellanox Technologies MT27500 Family
> [ConnectX-3]
> 
>    # Monitor TLB misses on root complex 2 (no stream filter is applied)
>    perf stat -a -e smmu/tlb_miss,@0002:00:00.0/ <workload>
> 
>    # Monitor TLB misses on a device on root complex 2 (derive the stream
> number from the RID)
>    perf stat -a -e smmu/tlb_miss,@0002:01:00.0/ <workload>
> Thanks,
> Agustín
> 
> --
> Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm
> Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a
> Linux Foundation Collaborative Project.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
