Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753820AbeC0Qxd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbeC0Qxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:53:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EEE217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AIpwx49W8vFjt2VQUKgbhPN/YfAwtDNUTyPM+A5hdSbC2sWNbpFl+ucBr1RN5UUeT5XBYMJLxAMMNgBsI0yYZEu+c0E=
MIME-Version: 1.0
In-Reply-To: <20180326195336.GB224629@bhelgaas-glaptop.roam.corp.google.com>
References: <20180326123143.38630ea3@canb.auug.org.au> <20180326195336.GB224629@bhelgaas-glaptop.roam.corp.google.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 27 Mar 2018 11:53:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL_VuUH0MZ72zz5QZRj_8SjgcG8f22yYD7ntB5XBEmJOA@mail.gmail.com>
Message-ID: <CAL_JsqL_VuUH0MZ72zz5QZRj_8SjgcG8f22yYD7ntB5XBEmJOA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pci tree
To: Bjorn Helgaas <helgaas@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 2:53 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Mar 26, 2018 at 12:31:43PM +1100, Stephen Rothwell wrote:
>> Hi Bjorn,
>>
>> After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
>> failed like this:
>>
>> In file included from /home/sfr/next/next/drivers/pci/host/pcie-iproc.c:16:0:
>> /home/sfr/next/next/include/linux/irqchip/arm-gic-v3.h:560:10: fatal error: asm/arch_gicv3.h: No such file or directory
>>  #include <asm/arch_gicv3.h>
>>           ^~~~~~~~~~~~~~~~~~
>>
>> Caused by commit
>>
>>   af3c73473d10 ("PCI: Improve host drivers compile test coverage")
>>
>> I used the pci tree from next-20180323 for today.
>
> Thanks, I updated my tree to drop af3c73473d10 ("PCI: Improve host
> drivers compile test coverage") for now.
>
> I know Lorenzo is out this week, so he may not be able to do an
> update, but if you post a new version, Rob, I'll see if I can pull it
> in.

The simple fix is to just drop this hunk. Alternatively, we can add a
"depends on ARM_GIC_V3" and keep the compile coverage for arm64.

@@ -128,7 +128,7 @@ config PCIE_IPROC_PLATFORM

 config PCIE_IPROC_BCMA
        tristate "Broadcom iProc PCIe BCMA bus driver"
-       depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
+       depends on (ARM && ARCH_BCM_IPROC) || COMPILE_TEST
        select PCIE_IPROC
        select BCMA
        default ARCH_BCM_5301X
