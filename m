Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeEHLRs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:17:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:47897 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754465AbeEHLRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:17:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,378,1520924400";
   d="scan'208";a="39316415"
Message-ID: <1f8dd53826554a113b03b7c0fb2d131bb315eefd.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/3] HISI LPC ACPI UART support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, xuwei5@huawei.com,
        mika.westerberg@linux.intel.com, lee.jones@linaro.org
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, arnd@arndb.de,
        graeme.gregory@linaro.org, helgaas@kernel.org,
        z.liuxinliang@hisilicon.com, linuxarm@huawei.com
Date: Tue, 08 May 2018 14:17:40 +0300
In-Reply-To: <1525775252-239214-1-git-send-email-john.garry@huawei.com>
References: <1525775252-239214-1-git-send-email-john.garry@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-08 at 18:27 +0800, John Garry wrote:
> This patchset adds ACPI FW support for the UART on
> the LPC bus on the Huawei D03 development board.
> 
> It also drops MFD API usage. It's not right to use MFD
> APIs outside drivers/mfd. As the alternate solution, we
> use platform device APIs directly.
> 
> The UART is 8250-compatible, and has the following
> profile:
> - IO space iotype
> - no interrupt, so polling mode required
> - 16550 type
> 
> Currently no platform driver exists for the UART. Indeed,
> for PNP-compatible devices - like this UART - it would be
> better to create a PNP device so that we may use the
> existing PNP driver. Thus, we should use the 8250 PNP
> driver.
> 
> However this host driver does not support PNP devices.
> An RFC was sent for PNP support in [1]. However it was
> deemed impractical to follow this path.
> 
> So to provide this UART support we use the 8250 generic
> isa driver. For this, we need to set the UART platform
> device name to match the 8250 isa driver. This means
> passing the 8250 serial config in the child pdev platform
> data.
> 
> 1. https://lkml.org/lkml/2018/4/20/278
> 

I'm fine with this least invasive approach. It seems it has minimum
duplication of code, which is anyway unavoidable when we are speaking of
instantiating platform devices.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Differences:
> v1 -> v2:
> - drop MFD API usage and use platform device APIs
>   directly for ACPI support
> 
> RFC -> v1:
> - drop PNP support
> - use static MFD cells
> - add 8250 setup
> 
> John Garry (3):
>   HISI LPC: Stop using MFD APIs
>   HISI LPC: Re-Add ACPI child enumeration support
>   HISI LPC: Add ACPI UART support
> 
>  drivers/bus/Kconfig    |   1 -
>  drivers/bus/hisi_lpc.c | 159 ++++++++++++++++++++++++++++++--------
> -----------
>  2 files changed, 97 insertions(+), 63 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
