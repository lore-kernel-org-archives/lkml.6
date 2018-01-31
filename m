Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeAaMeo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:34:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37544 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbeAaMem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:34:42 -0500
Date: Wed, 31 Jan 2018 12:34:34 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Neil Leeder <nleeder@codeaurora.org>,
        Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>,
        Timur Tabi <timur@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Mark Salter <msalter@redhat.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH 1/2] acpi: arm64: add iort support for PMCG
Message-ID: <20180131123434.GA933@e107981-ln.cambridge.arm.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-2-git-send-email-nleeder@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA8386400F7@FRAEML521-MBX.china.huawei.com>
 <20180130180013.GA16154@e107981-ln.cambridge.arm.com>
 <5FC3163CFD30C246ABAA99954A238FA838641882@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838641882@FRAEML521-MBX.china.huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 12:10:47PM +0000, Shameerali Kolothum Thodi wrote:

[...]

> > I went back and re-read the patches, I think the point here is that the
> > perf driver (ie PATCH 2 that, by the way, is not maiinline) uses
> > devm_ioremap_resource() to map the counters and that's what is causing
> > failures when PMCG is part of SMMUv3 registers.
> 
> Thanks for going through this.  No, this is not where we are seeing the failure.
> May be I was not clear in my earlier mail. The failure happens in SMMUv3
> driver probe function when it calls devm_ioremap_resource().

Understood - because the PMU PMCG driver calls it first, that's what
I was referring to.

My point is that:

- the PMCG platform device resources should be built with the correct
  resource hierarchy
- and even then, I do not think that using devm_ioremap_resource() in
  the PMCG PMU driver is the correct way of handling its resource
  reservation (ie the kernel must be able to detect that a resource is
  contained in a parent one but I am not sure devm_ioremap_resource()
  is the way to handle this correctly)

> > It is the resources hierarchy that is wrong and in turn, I do not think
> > devm_request_mem_region() is the right way of requesting it for the
> > PMCG driver.
> > 
> > I need to look into this but I suspect that's something that should
> > be handled in the PMCG driver, that has to request the memory region
> > _differently_ (ie ioremap copes with this overlap - it is the
> > devm_request_mem_region() in devm_ioremap_resource() that fails, correct
> > ?).
> 
> It looks like, in IORT code,
> 
> iort_add_platform_device()--> platform_device_add()-->insert_resource(), inserts
> both SMMUv3 and PMCG resources into the resource tree and then when the probe
> of SMMUv3 is called, it detects the conflict.
> 
> [   85.548749] arm-smmu-v3 arm-smmu-v3.0.auto: can't request region for resource [mem 0x148000000-0x14801ffff]                      
> 
> Of course, changing devm_ioremap_resource() to devm_ioremap() in SMMv3
> driver probe solves the issue for us, but not sure that's the right approach or not.

See above.

Lorenzo
