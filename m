Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEACC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C03D20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C03D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeKJDBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:01:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:32834 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728115AbeKJDBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:01:51 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 09F3467893910;
        Sat, 10 Nov 2018 01:20:13 +0800 (CST)
Received: from [127.0.0.1] (10.210.169.145) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Sat, 10 Nov 2018
 01:20:03 +0800
Subject: Re: [PATCH 00/10] irqdomain, gic-v3-its: Implement late irq domain
 initialization
To:     Robert Richter <rrichter@cavium.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20181107220254.6116-1-rrichter@cavium.com>
CC:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Linuxarm <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e93e7a95-bd12-5695-18da-1ac80b8d595d@huawei.com>
Date:   Fri, 9 Nov 2018 17:19:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181107220254.6116-1-rrichter@cavium.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 22:03, Robert Richter wrote:
> This patch series is a rework of the gic-v3-its initialization. It is
> in preparation of a further series that uses CMA memory allocation for
> ITS tables. For this the CMA framework must be available and thus ITS
> needs to be initialized after the arch_initcalls. This requires two
> major reworks.
>
> First we must remove all irq domain init order dependencies (patches
> #1-#5), second the ITS initialization must be split into an early
> probe and a later init part (patches #6-#10).
>
> Patch #1 introduces a new interface to request an irq domain, see the
> patch description for details. In patches #2-#5 all ITS related irq
> domains are converted to use the new interface. There are no order
> dependencies for parent and client irq domain initialization anymore
> which allows us to initialize all ITS irq domains in the same initcall
> (moving to the later subsys_initcall). Note that I do not have fsl
> hardware available, the code should work, but is only carefully
> reviewed and compile tested, please test on that hardware.
>
> The remaining patches #6-#10 are an incremental rework of the ITS
> initialization, basically splitting probe and init (patch #7) and
> separating it from gic-v3 code (patch #8). Patches #9 and #10 change
> initcall levels for various drivers.
>
> Patches have been tested with Cavium ThunderX and ThunderX2. I have an
> implementation of CMA ITS table allocation on top of this series
> available, I will send out patches for this in a couple of days.

Hi,

For this follow-on patchset, will it conflict with this:
https://lkml.org/lkml/2017/6/25/75

We were planning on reposting with some results.

Thanks,
John

>
> Robert Richter (10):
>   irqdomain: Add interface to request an irq domain
>   irqchip/gic-v3-its-platform-msi: Remove domain init order dependencies
>   irqchip/irq-gic-v3-its-pci-msi: Remove domain init order dependencies
>   irqchip/irq-gic-v3-its-fsl-mc-msi: Remove domain init order
>     dependencies
>   fsl-mc/dprc-driver: Remove domain init order dependencies
>   irqchip/gic-v3-its: Initialize its nodes in probe order
>   irqchip/gic-v3-its: Split probing from its node initialization
>   irqchip/gic-v3-its: Decouple its initialization from gic
>   irqchip/gic-v3-its: Initialize its nodes later
>   irqchip/gic-v3-its: Initialize MSIs with subsys_initcalls
>
>  drivers/bus/fsl-mc/dprc-driver.c              |  41 +++++++
>  drivers/bus/fsl-mc/fsl-mc-msi.c               |   6 +-
>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   |  49 +++++---
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c      |  68 ++++++-----
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |  56 ++++++---
>  drivers/irqchip/irq-gic-v3-its.c              | 160 +++++++++++++++++---------
>  drivers/irqchip/irq-gic-v3.c                  |  12 +-
>  include/linux/cpuhotplug.h                    |   1 +
>  include/linux/irqchip/arm-gic-v3.h            |   5 +-
>  include/linux/irqdomain.h                     |  15 +++
>  kernel/irq/irqdomain.c                        | 158 +++++++++++++++++++++++++
>  11 files changed, 441 insertions(+), 130 deletions(-)
>


