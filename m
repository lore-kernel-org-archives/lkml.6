Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E528C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2C423D58
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FXt3VjqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2C423D58
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeFVFIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 01:08:38 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42017 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeFVFIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 01:08:36 -0400
Received: by mail-qk0-f194.google.com with SMTP id u62-v6so547537qkf.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eCJlyAf1W9uBUQflwc+ZIZuw2hJc3V34rTZsjWFhcug=;
        b=FXt3VjqOFskqzbQFtxW9QvsiHKFpg2DrpkK34jop2pC/S5OWazLyV07WRISVnDeuV/
         MMabl3PASG9xXnL8CncoaIhW0XEa6jgRVCrC/dqlf620txH9cgBXK06em8Y5cCyzmUSk
         D91/UXTGh2BqIB4gq1aXWYKo6pq0Bfk9Kmr8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eCJlyAf1W9uBUQflwc+ZIZuw2hJc3V34rTZsjWFhcug=;
        b=RR3F15IUkMqmdDEtjCWpkCKur8smXLeH5qnQUa06Rr9fz5RO/d99ukyoJy2wGulA+C
         WzqxpmgBI1ofALy8/Mec5lvuTR0z4SjcRzVHzXMygii2BxALbZv36VJ1FpOX9G1HoVni
         xbU3dBitwp+gbD+KddXLZRhFK12T0AFYXM/LWmA1tDYLeVJNLQPr8wPlI0FzmBqrPep6
         kSN+n5ssN6mI7PNHpgaFrU13WV3Ax61gzwJ8VNXDh8K8bpBByoFoHJzLLlzf3lEFZat0
         oPKrrX/JlBruOxwPPqscZUtLmAjkcsJ4He4uKQiGdGuhez43pBt8Lrcryp9xcrvlb5VD
         LZyg==
X-Gm-Message-State: APt69E1d88b2HugN0IuxffezGgC4hc6M0wGxaikbWIo98mTIr+Ttm2/u
        +vpvL6wk1y2c5qRXKaK7zreNbA==
X-Google-Smtp-Source: ADUXVKKQNmxxO7i+ZIOp+xtk8jAHFNf8tgZPtpGVIzsOFmyD1IumCZOXAV/mPvnD/W5PSUgNVJrNKA==
X-Received: by 2002:a37:b001:: with SMTP id z1-v6mr81683qke.225.1529644115794;
        Thu, 21 Jun 2018 22:08:35 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l25-v6sm3852501qkk.49.2018.06.21.22.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 22:08:34 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: controller: Move PCI_DOMAINS selection to arch
 Kconfig
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Ley Foon Tan <lftan@altera.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>
References: <20180619112105.14457-1-lorenzo.pieralisi@arm.com>
 <30bb8a16-f829-a5a4-265f-2d1112d8d0bf@siemens.com>
 <20180621165400.GB14519@e107981-ln.cambridge.arm.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <5e9b0aa4-ded1-725d-c401-49c13b7d5f9d@broadcom.com>
Date:   Thu, 21 Jun 2018 22:08:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621165400.GB14519@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-06-21 09:54 AM, Lorenzo Pieralisi wrote:
> On Wed, Jun 20, 2018 at 10:07:33AM +0200, Jan Kiszka wrote:
>> On 2018-06-19 13:21, Lorenzo Pieralisi wrote:
>>> Commit 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
>>> added configuration options to allow PCI host controller drivers to be
>>> compile tested on all architectures.
>>>
>>> Some host controller drivers (eg PCIE_ALTERA) config entries select
>>> the PCI_DOMAINS config option to enable PCI domains management in
>>> the kernel. Now that host controller drivers can be compiled on
>>> all architectures, this triggers build regressions on arches that
>>> do not implement the PCI_DOMAINS required API (ie pci_domain_nr()):
>>>
>>> drivers/ata/pata_ali.c: In function 'ali_init_chipset':
>>> drivers/ata/pata_ali.c:469:38: error:
>>>          implicit declaration of function 'pci_domain_nr';
>>>                                            did you mean 'pci_iomap_wc'?
>>>
>>> Furthemore, some software configurations (ie Jailhouse) require a
>>> PCI_DOMAINS enabled kernel to configure multiple host controllers
>>> without having an explicit dependency on the ARM platform on which
>>> they run.
>>>
>>> Make PCI_DOMAINS a visible configuration option on ARM so that software
>>> configurations that need it can manually select it and move the
>>> PCI_DOMAINS selection from PCI controllers configuration file to ARM
>>> sub-arch config entries that currently require it, fixing the issue.
>>>
>>> Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
>>> Link: https://lkml.kernel.org/r/20180612170229.GA10141@roeck-us.net
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Cc: Scott Branden <scott.branden@broadcom.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Ley Foon Tan <lftan@altera.com>
>>> ---
>>> v1 -> v2
>>> 	- Removed ARCH_VIRT PCI_DOMAINS selection
>>> 	- Added PCI_DOMAINS visible config option
>>>
>>> v1: https://marc.info/?l=linux-pci&m=152932092612352&w=2
>>>
>>>   arch/arm/Kconfig               | 8 +++++++-
>>>   arch/arm/mach-bcm/Kconfig      | 1 +
>>>   arch/arm/mach-socfpga/Kconfig  | 1 +
>>>   drivers/pci/controller/Kconfig | 3 ---
>>>   4 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 54eeb8d00bc6..843edfd000be 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -1245,8 +1245,14 @@ config PCI
>>>   	  VESA. If you have PCI, say Y, otherwise N.
>>>   
>>>   config PCI_DOMAINS
>>> -	bool
>>> +	bool "Support for multiple PCI domains"
>>>   	depends on PCI
>>> +	help
>>> +	  Enable PCI domains kernel management. Say Y if your machine
>>> +	  has a PCI bus hierarchy that requires more than one PCI
>>> +	  domain (aka segment) to be correctly managed. Say N otherwise.
>>> +
>>> +	  If you don't know what to do here, say N.
>>>   
>>>   config PCI_DOMAINS_GENERIC
>>>   	def_bool PCI_DOMAINS
>>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>>> index c46a728df44e..25aac6ee2ab1 100644
>>> --- a/arch/arm/mach-bcm/Kconfig
>>> +++ b/arch/arm/mach-bcm/Kconfig
>>> @@ -20,6 +20,7 @@ config ARCH_BCM_IPROC
>>>   	select GPIOLIB
>>>   	select ARM_AMBA
>>>   	select PINCTRL
>>> +	select PCI_DOMAINS if PCI
>>>   	help
>>>   	  This enables support for systems based on Broadcom IPROC architected SoCs.
>>>   	  The IPROC complex contains one or more ARM CPUs along with common
>>> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
>>> index d0f62eacf59d..4adb901dd5eb 100644
>>> --- a/arch/arm/mach-socfpga/Kconfig
>>> +++ b/arch/arm/mach-socfpga/Kconfig
>>> @@ -10,6 +10,7 @@ menuconfig ARCH_SOCFPGA
>>>   	select HAVE_ARM_SCU
>>>   	select HAVE_ARM_TWD if SMP
>>>   	select MFD_SYSCON
>>> +	select PCI_DOMAINS if PCI
>>>   
>>>   if ARCH_SOCFPGA
>>>   config SOCFPGA_SUSPEND
>>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>>> index 18fa09b3ac8f..cc9fa02d32a0 100644
>>> --- a/drivers/pci/controller/Kconfig
>>> +++ b/drivers/pci/controller/Kconfig
>>> @@ -96,7 +96,6 @@ config PCI_HOST_GENERIC
>>>   	depends on OF
>>>   	select PCI_HOST_COMMON
>>>   	select IRQ_DOMAIN
>>> -	select PCI_DOMAINS
>>>   	help
>>>   	  Say Y here if you want to support a simple generic PCI host
>>>   	  controller, such as the one emulated by kvmtool.
>>> @@ -138,7 +137,6 @@ config PCI_VERSATILE
>>>   
>>>   config PCIE_IPROC
>>>   	tristate
>>> -	select PCI_DOMAINS
>>>   	help
>>>   	  This enables the iProc PCIe core controller support for Broadcom's
>>>   	  iProc family of SoCs. An appropriate bus interface driver needs
>>> @@ -176,7 +174,6 @@ config PCIE_IPROC_MSI
>>>   config PCIE_ALTERA
>>>   	bool "Altera PCIe controller"
>>>   	depends on ARM || NIOS2 || COMPILE_TEST
>>> -	select PCI_DOMAINS
>>>   	help
>>>   	  Say Y here if you want to enable PCIe controller support on Altera
>>>   	  FPGA.
>>>
>> Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
> Thanks a lot. Scott, Ley Foon, does it work for you ? I would like
> to ask Bjorn to send it asap since the build on sparc is still broken.
Change will have to be made for arm64 for ARCH_BCM_IPROC as well.
>
> Thanks,
> Lorenzo

