Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938681AbeE1MML (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:12:11 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:50596 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938670AbeE1MMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:12:00 -0400
From: Prabu Thangamuthu <Prabu.T@synopsys.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Manjunath M Bettegowda <Manjunath.MB@synopsys.com>
Subject: Re: [PATCH 1/1] mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc support
Thread-Topic: [PATCH 1/1] mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc support
Thread-Index: AdPxmBIFOmCk2CVqRi+baz/mIdVd7Q==
Date: Mon, 28 May 2018 12:10:12 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A9B659F@IN01WEMBXB.internal.synopsys.com>
References: <705D14B1C7978B40A723277C067CEDE2010A9B43CC@IN01WEMBXB.internal.synopsys.com>
 <abe62da4-3ef9-5660-94e1-a3f919df06cd@intel.com>
 <705D14B1C7978B40A723277C067CEDE2010A9B5491@IN01WEMBXB.internal.synopsys.com>
 <1f766ad9-481e-89cc-c0be-d9aea05e890b@intel.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.239.235]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4SCCKGk022913

Hi Adrian,

On 5/24/2018 5:43 PM, Adrian Hunter wrote:
> On 24/05/18 14:28, Prabu Thangamuthu wrote:
>> Hi Adrian,
>>
>> On 5/24/2018 2:06 PM, Adrian Hunter wrote:
>>> Hi
>>>
>>> This patch is mangled.
>> We will check it.
>>> On 22/05/18 09:42, Prabu Thangamuthu wrote:
>>>> To enable Synopsys DWC MSHC controller on HPAS-DX platform connected using
>>>> PCIe interface. As Clock generation logic is implemented in MMCM module of
>>>> HAPS-DX platform, we have separate functions to control the MMCM to
>>>> generate required clocks with respect to speed mode. Also we have platform
>>>> specific set_power function to support different VDD of eMMC devices.
>>>>
>>>> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
>>>> ---
>>>>  MAINTAINERS                           |   7 ++
>>>>  drivers/mmc/host/Makefile             |   3 +-
>>>>  drivers/mmc/host/sdhci-pci-core.c     |   1 +
>>>>  drivers/mmc/host/sdhci-pci-dwc-mshc.c | 146
>>>> ++++++++++++++++++++++++++++++++++
>>>>  drivers/mmc/host/sdhci-pci-dwc-mshc.h |  37 +++++++++
>>>>  drivers/mmc/host/sdhci-pci.h          |   3 +
>>>>  6 files changed, 196 insertions(+), 1 deletion(-)
>>>>  create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.c
>>>>  create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 9051a9c..f1749c4 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -12643,6 +12643,13 @@ S:    Maintained
>>>>  F:    drivers/mmc/host/sdhci*
>>>>  F:    include/linux/mmc/sdhci*
>>>>  
>>>> +SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER
>>>> +M:    Prabu Thangamuthu <prabu.t@synopsys.com>
>>>> +M:    Manjunath M B <manjumb@synopsys.com>
>>>> +L:    linux-mmc@vger.kernel.org
>>>> +S:    Maintained
>>>> +F:    drivers/mmc/host/sdhci-pci-dwc-mshc*
>>>> +
>>>>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
>>>>  M:    Ben Dooks <ben-linux@fluff.org>
>>>>  M:    Jaehoon Chung <jh80.chung@samsung.com>
>>>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>>>> index 6aead24..6c0d3fb 100644
>>>> --- a/drivers/mmc/host/Makefile
>>>> +++ b/drivers/mmc/host/Makefile
>>>> @@ -11,7 +11,8 @@ obj-$(CONFIG_MMC_MXC)        += mxcmmc.o
>>>>  obj-$(CONFIG_MMC_MXS)        += mxs-mmc.o
>>>>  obj-$(CONFIG_MMC_SDHCI)        += sdhci.o
>>>>  obj-$(CONFIG_MMC_SDHCI_PCI)    += sdhci-pci.o
>>>> -sdhci-pci-y            += sdhci-pci-core.o sdhci-pci-o2micro.o
>>>> sdhci-pci-arasan.o
>>>> +sdhci-pci-y            += sdhci-pci-core.o sdhci-pci-o2micro.o
>>>> sdhci-pci-arasan.o \
>>>> +                   sdhci-pci-dwc-mshc.o
>>>>  obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))    += sdhci-pci-data.o
>>>>  obj-$(CONFIG_MMC_SDHCI_ACPI)    += sdhci-acpi.o
>>>>  obj-$(CONFIG_MMC_SDHCI_PXAV3)    += sdhci-pxav3.o
>>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c
>>>> b/drivers/mmc/host/sdhci-pci-core.c
>>>> index 77dd352..96b6963 100644
>>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>>> @@ -1511,6 +1511,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>>>>      SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),
>>>>      SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
>>>>      SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
>>>> +    SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC,  snps),
>>>>      SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>>>>      /* Generic SD host controller */
>>>>      {PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
>>>> diff --git a/drivers/mmc/host/sdhci-pci-dwc-mshc.c
>>>> b/drivers/mmc/host/sdhci-pci-dwc-mshc.c
>>>> new file mode 100644
>>>> index 0000000..bca3db4
>>>> --- /dev/null
>>>> +++ b/drivers/mmc/host/sdhci-pci-dwc-mshc.c
>>>> @@ -0,0 +1,146 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * SDHCI driver for Synopsys DWC_MSHC controller
>>>> + *
>>>> + * Copyright (C) 2018 Synopsys, Inc. (www.synopsys.com)
>>>> + *
>>>> + * Authors:
>>>> + *    Prabu Thangamuthu <prabu.t@synopsys.com>
>>>> + *    Manjunath M B <manjumb@synopsys.com>
>>>> + *
>>>> + */
>>>> +
>>>> +#include <linux/pci.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/moduleparam.h>
>>>> +
>>>> +#include "sdhci.h"
>>>> +#include "sdhci-pci.h"
>>>> +#include "sdhci-pci-dwc-mshc.h"
>>>> +
>>>> +/* Default emmc vdd is set to 3.3V */
>>>> +static unsigned int emmc_vdd = SDHC_EMMC_VDD_330V;
>>>> +module_param(emmc_vdd, int, 0444);
>>> Why a module parameter?
>> Our platform has slots for eMMC devices which can supports both 1.8 V
>> and 3.3 V
>> operating modes. We want this module parameter to control the operating
>> voltage
>> of eMMC devices.
> So why not use firmware device properties?
We are assuming as you are referring  EXT_CSD register of eMMC device to
understand 1.8V/3.3V support. But we need to fix the voltage before
enumeration of the eMMC device.
Please help us to understand more if you are not referring EXT_CSD register.
>
>>>> +
>>>> +static void sdhci_snps_set_clock(struct sdhci_host *host, unsigned int
>>>> clock)
>>>> +{
>>>> +    u16 clk = 0;
>>>> +    u32 reg = 0;
>>>> +    u32 vendor_ptr = 0;
>>>> +
>>>> +    vendor_ptr = sdhci_readw(host, SDHCI_VENDOR_PTR_R);
>>>> +
>>>> +    /* Disable Software managed rx tuning */
>>>> +    reg = sdhci_readl(host, (SDHC_AT_CTRL_R + vendor_ptr));
>>>> +    reg &= ~SDHC_SW_TUNE_EN;
>>>> +    sdhci_writel(host, reg, (SDHC_AT_CTRL_R + vendor_ptr));
>>>> +
>>>> +    if (clock <= 52000000) {
>>>> +        sdhci_set_clock(host, clock);
>>>> +    } else {
>>>> +        /* Assert reset to MMCM */
>>>> +        reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
>>>> +        reg |= SDHC_CCLK_MMCM_RST;
>>>> +        sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
>>>> +
>>>> +        /* Configure MMCM*/
>>> Space between MMCM and *
>> Okay.
>>>> +        sdhci_writel(host, DIV_REG_100_MHZ, SDHC_MMCM_DIV_REG);
>>>> +        sdhci_writel(host, CLKFBOUT_100_MHZ,
>>>> +                SDHC_MMCM_CLKFBOUT);
>>>> +
>>>> +        /* De-assert reset to MMCM*/
>>> Space between MMCM and *
>> Okay.
>>>
>>>> +        reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
>>>> +        reg &= ~SDHC_CCLK_MMCM_RST;
>>>> +        sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
>>>> +
>>>> +        /* Enable clock */
>>>> +        clk = SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN |
>>>> +            SDHCI_CLOCK_CARD_EN;
>>>> +        sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void sdhci_snps_set_power(struct sdhci_host *host, unsigned char
>>>> mode,
>>>> +             unsigned short vdd)
>>>> +{
>>>> +    u8 pwr = 0;
>>>> +    u16 ctrl;
>>>> +
>>>> +    if (mode != MMC_POWER_OFF) {
>>>> +        switch (1 << vdd) {
>>>> +        case MMC_VDD_165_195:
>>>> +            pwr = SDHCI_POWER_180;
>>>> +            break;
>>>> +        case MMC_VDD_29_30:
>>>> +        case MMC_VDD_30_31:
>>>> +            pwr = SDHCI_POWER_300;
>>>> +            break;
>>>> +        case MMC_VDD_32_33:
>>>> +        case MMC_VDD_33_34:
>>>> +            pwr = SDHCI_POWER_330;
>>>> +            break;
>>>> +        default:
>>>> +            WARN(1, "%s: Invalid vdd %#x\n",
>>>> +                 mmc_hostname(host->mmc), vdd);
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (host->pwr == pwr)
>>>> +        return;
>>>> +
>>>> +    host->pwr = pwr;
>>>> +
>>>> +    if (pwr == 0) {
>>>> +        sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>>>> +    } else {
>>>> +        sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>>>> +
>>>> +        /*
>>>> +         * Enable it for eMMC phy cfg1 test with 1.8V mode
>>>> +         */
>>>> +        if (emmc_vdd == SDHC_EMMC_VDD_180V) {
>>>> +            pwr = SDHCI_POWER_180;
>>>> +            sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
>>>> +
>>>> +            ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>> +            /*
>>>> +             * Enable 1.8V Signal Enable in the Host Control2
>>>> +             * register
>>>> +             */
>>>> +            ctrl |= SDHCI_CTRL_VDD_180;
>>>> +            sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>>> +        }
>>>> +        pwr |= SDHCI_POWER_ON;
>>>> +
>>>> +        sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
>>>> +    }
>>>> +}
>>>> +
>>>> +static int sdhci_snps_pci_probe_slot(struct sdhci_pci_slot *slot)
>>>> +{
>>>> +    struct sdhci_host *host = slot->host;
>>>> +
>>>> +    host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>>>> +    host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>> Why read caps here?
>> We had it for logging purpose. we will remove it.
> To prevent 3.0V or 3.3V clear the corresponding capabilities bits.  There
> are DT bindings for overriding the capabilities.
>
> To use only 1.8V signaling clear SDHCI_SIGNALING_330 from host->flags.
>
> Then you shouldn't need sdhci_snps_set_power().
Agree your point. we will test with this approach and share the patches.

Thanks,
Prabu
