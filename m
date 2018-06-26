Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01139C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47F324CCB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AhrwvuMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47F324CCB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeFZGsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:48:42 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43753 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeFZGsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:48:40 -0400
Received: by mail-qt0-f195.google.com with SMTP id y89-v6so14220885qtd.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 23:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7yDcpf7sJ9Xg7UzMQXgvfbM6UqPJYGTgeXcXzeLLbEI=;
        b=AhrwvuMiD34XcEdooq2zGa6ued7/lqvOEYGvES8S6TaTFilGKnNujlg71MpFEMAtmN
         W7TBRh1udzXxBifaFX0i24NS2eHpPdpLtXZ//5b1hHZB0Za9k0bKg8tTNuWjCPbHY/08
         Wwm/spHFbO3zE23PnVGH7yaB35refyO458wkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7yDcpf7sJ9Xg7UzMQXgvfbM6UqPJYGTgeXcXzeLLbEI=;
        b=eptolaL+uOfDOMe3j6Oc9FPA+ghU1lm2MDcBDM8EhNs8cc4NEs2/Ya6icdalUgBkEC
         fqrP2X/+oUvDkEjunsZdEoSHBNqjRUoMcy42NnCf4f3O5lG6ujC6FJzvKq1oQSI3R3eP
         zOY9wvVbrDww1oVvE1pm9/wnRMUZC2zLRIuaBr+kSXOPUkMsLs+giwI0itj4JD57LLOy
         upoiB8+cdV6Wbe6DslwWApinVUuXxKB+f92huVfKVLJQpi/uNRieovbcKVXsPFvbllwv
         l0/ZHsFydbYC3wULOaavYB2WuoqiDmuWz196ACoU7IF+IYALEpLLVlURc0Zo+txSvgcf
         ewNA==
X-Gm-Message-State: APt69E1wAPA5WoZhUJpl6DpwN4pDspQxz5Qc7tELTfbgunW4zU+o6gTD
        vScJX80v6iOq7fSOeHqEizYjQjif
X-Google-Smtp-Source: AAOMgpf2VNhfu9QVNgIEoU3Y+ChsIGjZnhMCMzPKa7ORNto1laqYkJwe9OSv0/tEYl7s+AUroyWnNA==
X-Received: by 2002:ac8:230a:: with SMTP id a10-v6mr214268qta.234.1529995719121;
        Mon, 25 Jun 2018 23:48:39 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k30-v6sm776652qtc.31.2018.06.25.23.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 23:48:37 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: controller: Move PCI_DOMAINS selection to arch
 Kconfig
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>
References: <20180619112105.14457-1-lorenzo.pieralisi@arm.com>
 <30bb8a16-f829-a5a4-265f-2d1112d8d0bf@siemens.com>
 <20180621165400.GB14519@e107981-ln.cambridge.arm.com>
 <5e9b0aa4-ded1-725d-c401-49c13b7d5f9d@broadcom.com>
 <1529683148.2729.6.camel@intel.com> <20180625092758.GA6412@red-moon>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <1cf91447-6e17-a7cb-c827-210835179db9@broadcom.com>
Date:   Mon, 25 Jun 2018 23:48:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625092758.GA6412@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,


On 18-06-25 02:27 AM, Lorenzo Pieralisi wrote:
> On Fri, Jun 22, 2018 at 11:59:08PM +0800, Ley Foon Tan wrote:
>> On Thu, 2018-06-21 at 22:08 -0700, Scott Branden wrote:
>>>
>>> On 18-06-21 09:54 AM, Lorenzo Pieralisi wrote:
>>>>
>>>> On Wed, Jun 20, 2018 at 10:07:33AM +0200, Jan Kiszka wrote:
>>>>>
>>>>> On 2018-06-19 13:21, Lorenzo Pieralisi wrote:
>>>>>>
>>>>>> Commit 51bc085d6454 ("PCI: Improve host drivers compile test
>>>>>> coverage")
>>>>>> added configuration options to allow PCI host controller
>>>>>> drivers to be
>>>>>> compile tested on all architectures.
>>>>>>
>>>>>> Some host controller drivers (eg PCIE_ALTERA) config entries
>>>>>> select
>>>>>> the PCI_DOMAINS config option to enable PCI domains management
>>>>>> in
>>>>>> the kernel. Now that host controller drivers can be compiled on
>>>>>> all architectures, this triggers build regressions on arches
>>>>>> that
>>>>>> do not implement the PCI_DOMAINS required API (ie
>>>>>> pci_domain_nr()):
>>>>>>
>>>>>> drivers/ata/pata_ali.c: In function 'ali_init_chipset':
>>>>>> drivers/ata/pata_ali.c:469:38: error:
>>>>>>           implicit declaration of function 'pci_domain_nr';
>>>>>>                                             did you mean
>>>>>> 'pci_iomap_wc'?
>>>>>>
>>>>>> Furthemore, some software configurations (ie Jailhouse) require
>>>>>> a
>>>>>> PCI_DOMAINS enabled kernel to configure multiple host
>>>>>> controllers
>>>>>> without having an explicit dependency on the ARM platform on
>>>>>> which
>>>>>> they run.
>>>>>>
>>>>>> Make PCI_DOMAINS a visible configuration option on ARM so that
>>>>>> software
>>>>>> configurations that need it can manually select it and move the
>>>>>> PCI_DOMAINS selection from PCI controllers configuration file
>>>>>> to ARM
>>>>>> sub-arch config entries that currently require it, fixing the
>>>>>> issue.
>>>>>>
>>>>>> Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test
>>>>>> coverage")
>>>>>> Link: https://lkml.kernel.org/r/20180612170229.GA10141@roeck-us
>>>>>> .net
>>>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>>>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>>> Cc: Scott Branden <scott.branden@broadcom.com>
>>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>>>> Cc: Rob Herring <robh@kernel.org>
>>>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>>>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>>>>> Cc: Ley Foon Tan <lftan@altera.com>
>>>>>> ---
>>>>>> v1 -> v2
>>>>>>      - Removed ARCH_VIRT PCI_DOMAINS selection
>>>>>>      - Added PCI_DOMAINS visible config option
>>>>>>
>>>>>> v1: https://marc.info/?l=linux-pci&m=152932092612352&w=2
>>>>>>
>>>>>>    arch/arm/Kconfig               | 8 +++++++-
>>>>>>    arch/arm/mach-bcm/Kconfig      | 1 +
>>>>>>    arch/arm/mach-socfpga/Kconfig  | 1 +
>>>>>>    drivers/pci/controller/Kconfig | 3 ---
>>>>>>    4 files changed, 9 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>>>> index 54eeb8d00bc6..843edfd000be 100644
>>>>>> --- a/arch/arm/Kconfig
>>>>>> +++ b/arch/arm/Kconfig
>>>>>> @@ -1245,8 +1245,14 @@ config PCI
>>>>>>        VESA. If you have PCI, say Y, otherwise N.
>>>>>>
>>>>>>    config PCI_DOMAINS
>>>>>> -   bool
>>>>>> +   bool "Support for multiple PCI domains"
>>>>>>      depends on PCI
>>>>>> +   help
>>>>>> +     Enable PCI domains kernel management. Say Y if your
>>>>>> machine
>>>>>> +     has a PCI bus hierarchy that requires more than one PCI
>>>>>> +     domain (aka segment) to be correctly managed. Say N
>>>>>> otherwise.
>>>>>> +
>>>>>> +     If you don't know what to do here, say N.
>>>>>>
>>>>>>    config PCI_DOMAINS_GENERIC
>>>>>>      def_bool PCI_DOMAINS
>>>>>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-
>>>>>> bcm/Kconfig
>>>>>> index c46a728df44e..25aac6ee2ab1 100644
>>>>>> --- a/arch/arm/mach-bcm/Kconfig
>>>>>> +++ b/arch/arm/mach-bcm/Kconfig
>>>>>> @@ -20,6 +20,7 @@ config ARCH_BCM_IPROC
>>>>>>      select GPIOLIB
>>>>>>      select ARM_AMBA
>>>>>>      select PINCTRL
>>>>>> +   select PCI_DOMAINS if PCI
>>>>>>      help
>>>>>>        This enables support for systems based on Broadcom IPROC
>>>>>> architected SoCs.
>>>>>>        The IPROC complex contains one or more ARM CPUs along
>>>>>> with common
>>>>>> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-
>>>>>> socfpga/Kconfig
>>>>>> index d0f62eacf59d..4adb901dd5eb 100644
>>>>>> --- a/arch/arm/mach-socfpga/Kconfig
>>>>>> +++ b/arch/arm/mach-socfpga/Kconfig
>>>>>> @@ -10,6 +10,7 @@ menuconfig ARCH_SOCFPGA
>>>>>>      select HAVE_ARM_SCU
>>>>>>      select HAVE_ARM_TWD if SMP
>>>>>>      select MFD_SYSCON
>>>>>> +   select PCI_DOMAINS if PCI
>>>>>>
>>>>>>    if ARCH_SOCFPGA
>>>>>>    config SOCFPGA_SUSPEND
>>>>>> diff --git a/drivers/pci/controller/Kconfig
>>>>>> b/drivers/pci/controller/Kconfig
>>>>>> index 18fa09b3ac8f..cc9fa02d32a0 100644
>>>>>> --- a/drivers/pci/controller/Kconfig
>>>>>> +++ b/drivers/pci/controller/Kconfig
>>>>>> @@ -96,7 +96,6 @@ config PCI_HOST_GENERIC
>>>>>>      depends on OF
>>>>>>      select PCI_HOST_COMMON
>>>>>>      select IRQ_DOMAIN
>>>>>> -   select PCI_DOMAINS
>>>>>>      help
>>>>>>        Say Y here if you want to support a simple generic PCI
>>>>>> host
>>>>>>        controller, such as the one emulated by kvmtool.
>>>>>> @@ -138,7 +137,6 @@ config PCI_VERSATILE
>>>>>>
>>>>>>    config PCIE_IPROC
>>>>>>      tristate
>>>>>> -   select PCI_DOMAINS
>>>>>>      help
>>>>>>        This enables the iProc PCIe core controller support for
>>>>>> Broadcom's
>>>>>>        iProc family of SoCs. An appropriate bus interface driver
>>>>>> needs
>>>>>> @@ -176,7 +174,6 @@ config PCIE_IPROC_MSI
>>>>>>    config PCIE_ALTERA
>>>>>>      bool "Altera PCIe controller"
>>>>>>      depends on ARM || NIOS2 || COMPILE_TEST
>>>>>> -   select PCI_DOMAINS
>>>>>>      help
>>>>>>        Say Y here if you want to enable PCIe controller support
>>>>>> on Altera
>>>>>>        FPGA.
>>>>>>
>>>>> Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Thanks a lot. Scott, Ley Foon, does it work for you ? I would like
>>>> to ask Bjorn to send it asap since the build on sparc is still
>>>> broken.
>>> Change will have to be made for arm64 for ARCH_BCM_IPROC as well.
>> Yes, need to add it to arm64 too. Others are okay.
> On arm64 CONFIG_PCI_DOMAINS defaults to CONFIG_PCI so there is no need
> to select it, if that's all you need changed there is nothing to
> change and this patch is read to be merged.
I see that now: arm64 is doing things properly.  The same should be done 
for arm: default to CONFIG_PCI so there is no need to select it.
I didn't like the change to have select to begin with.
>
> Lorenzo

