Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756505AbeDZOIR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:08:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:41185 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756433AbeDZOIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:08:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="51021926"
Date: Thu, 26 Apr 2018 17:08:08 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: John Garry <john.garry@huawei.com>
Cc: andriy.shevchenko@linux.intel.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org,
        helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: [RFC PATCH 1/2] ACPI / PNP: Don't add "enumeration_by_parent"
 devices
Message-ID: <20180426140808.GK2173@lahna.fi.intel.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-2-git-send-email-john.garry@huawei.com>
 <20180420130727.GV2173@lahna.fi.intel.com>
 <27c3f84e-4d53-4b6b-7382-04908082ed01@huawei.com>
 <20180420135222.GY2173@lahna.fi.intel.com>
 <75eae3ac-228f-d6a4-bb0e-4bd27e35c55d@huawei.com>
 <09e3aa95-86ae-ca30-7bb5-a9704d296b43@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e3aa95-86ae-ca30-7bb5-a9704d296b43@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 02:49:49PM +0100, John Garry wrote:
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 2d4611e..b04425b 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -18,6 +18,8 @@
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> +#include <linux/serial_8250.h>
> +#include "../tty/serial/8250/8250.h"
> 
>  #define DRV_NAME "hisi-lpc"
> 
> @@ -345,6 +347,7 @@ static void hisi_lpc_comm_outs(void *hostdata, unsigned
> long pio,
>  #define MFD_CHILD_NAME_LEN (ACPI_ID_LEN + sizeof(MFD_CHILD_NAME_PREFIX) -
> 1)
> 
>  struct hisi_lpc_mfd_cell {
> +	struct plat_serial8250_port serial8250_port;
>  	struct mfd_cell_acpi_match acpi_match;
>  	char name[MFD_CHILD_NAME_LEN];
>  	char pnpid[ACPI_ID_LEN];
> @@ -513,10 +516,31 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>  		dev_warn(&child->dev, "set resource fail (%d)\n", ret);
>  			return ret;
>  		}
> +	if (!strcmp(acpi_device_hid(child), "HISI1031")) {

Hmm, there is a way in struct mfd_cell to match child devices using _HID
so is there something preventing you from using that?
