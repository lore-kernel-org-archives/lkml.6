Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756237AbeDZNuW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:50:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754847AbeDZNuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:50:21 -0400
Subject: Re: [RFC PATCH 1/2] ACPI / PNP: Don't add "enumeration_by_parent"
 devices
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-2-git-send-email-john.garry@huawei.com>
 <20180420130727.GV2173@lahna.fi.intel.com>
 <27c3f84e-4d53-4b6b-7382-04908082ed01@huawei.com>
 <20180420135222.GY2173@lahna.fi.intel.com>
 <75eae3ac-228f-d6a4-bb0e-4bd27e35c55d@huawei.com>
CC: <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>, <lenb@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <linuxarm@huawei.com>, <z.liuxinliang@hisilicon.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <09e3aa95-86ae-ca30-7bb5-a9704d296b43@huawei.com>
Date: Thu, 26 Apr 2018 14:49:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <75eae3ac-228f-d6a4-bb0e-4bd27e35c55d@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2018 15:09, John Garry wrote:
> On 20/04/2018 14:52, Mika Westerberg wrote:
>> On Fri, Apr 20, 2018 at 02:24:18PM +0100, John Garry wrote:
>>> Hi Mika,
>>>
>>> On 20/04/2018 14:07, Mika Westerberg wrote:
>>>> On Fri, Apr 20, 2018 at 06:07:25PM +0800, John Garry wrote:
>>>>> +    } else {
>>>>> +        device->driver_data = dev;
>>>>
>>>> I think this deserves a comment explaining why we (ab)use driver_data
>>>> like this.
>>>
>>> Sure, could add. I didn't see any other way for the acpi_device
>>> structure to
>>> reference the derived PNP device.
>>>
>>> TBH, This overall approach is not good since we are creating the PNP
>>> device
>>> in the scan, and then leaving the device in limbo, waiting for the
>>> parent to
>>> add it, if at all. There's no rule for this.
>>>
>>> So I'm looking for ideas on how to improve this.
>>
>
> Hi Mika,
>
>> One idea is to make pnpacpi_add_device() available outside of PNP and
>> call it directly (or some variation) in hisi_lpc.c when it walks over
>> its children.
>>
>
> I did consider this initially and it seems quite straightforward.
>
> However I think the problem is that we would need to modify the
> acpi_device child resources from FW with kernel-specific resources,
> which does not seem right (I think that is what you meant). As I see,
> this is one reason that we went in the direction of modelling the host
> as an MFD, as we could set the resources of the mfd_cells.
>
> So adding a variant of pnpacpi_add_device() could work, or modifying
> pnpacpi_add_device() to accept a callback to translate the resources.
> But this feature is specific to our very special requirement...
>

Hi Andy, Mika,

I have spent a bit of time looking at this PNP support issue, and I 
still can't find a good solution.

So - as  discussed - I could add the call to pnpacpi_add_device(), but I 
would need a method to defer the pnp dev probe before resources fixup. 
As a alternative solution, I could add a callback pointer to 
pnpacpi_add_device(), for the caller to do the fixup, but this is quite 
arbitrary in the PNP code.

As an alternative, I am strongly considering this patch instead of 
adding PNP support:

-->8

Subject: [PATCH] HISI LPC: Add special handling for 8250-compatible UART

For APCI support, for each each child device on the host
LPC bus we create an mfd_cell, and, as such, we create a
platform device per ACPI child. This creates a problem
in 8250-compatible device support.

Currently the kernel does not support an suitable 8250-
compatible driver for the UART device on the LPC bus on
the Huawei D03 board, which has the following profile/
requirements:
- 16550 device
- platform_driver for ACPI device
- IO space iotype
- polling mode

In principle we should use the 8250_pnp driver for 8250-
compatible devices with ACPI firmware. However the host
driver does not support PNP devices, and the work is not
worth the effort to rework the host driver and PNP code
to support such a device.

As a alternate solution, add special UART handling to use
the 8250 isa generic driver for this one-off device.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 2d4611e..b04425b 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -18,6 +18,8 @@
  #include <linux/of_platform.h>
  #include <linux/pci.h>
  #include <linux/slab.h>
+#include <linux/serial_8250.h>
+#include "../tty/serial/8250/8250.h"

  #define DRV_NAME "hisi-lpc"

@@ -345,6 +347,7 @@ static void hisi_lpc_comm_outs(void *hostdata, 
unsigned long pio,
  #define MFD_CHILD_NAME_LEN (ACPI_ID_LEN + 
sizeof(MFD_CHILD_NAME_PREFIX) - 1)

  struct hisi_lpc_mfd_cell {
+	struct plat_serial8250_port serial8250_port;
  	struct mfd_cell_acpi_match acpi_match;
  	char name[MFD_CHILD_NAME_LEN];
  	char pnpid[ACPI_ID_LEN];
@@ -513,10 +516,31 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
  		dev_warn(&child->dev, "set resource fail (%d)\n", ret);
  			return ret;
  		}
+	if (!strcmp(acpi_device_hid(child), "HISI1031")) {
+		/*
+		 * Special handling for HISI1031 8250-compatible UART:
+		 * Since currently no platform driver exists for this
+		 * ACPI device, the generic 8250 isa driver instead.
+		 * For this, change cell name and add associated
+		 * serial port data.
+		 */
+		const struct resource * const io_base_resource =
+			mfd_cell->resources;
+		struct plat_serial8250_port ref =
+		SERIAL8250_PORT(io_base_resource->start, 0);
+
+		memcpy(&hisi_lpc_mfd_cell->serial8250_port,
+		       &ref, sizeof(ref));
+
+		mfd_cell->name = "serial8250";
+		mfd_cell->platform_data =
+			&hisi_lpc_mfd_cell->serial8250_port;
+		mfd_cell->pdata_size = sizeof(ref);
+	}
  	count++;
  	}

-	ret = mfd_add_devices(hostdev, PLATFORM_DEVID_NONE,
+	ret = mfd_add_devices(hostdev, PLATFORM_DEVID_AUTO,
  			      mfd_cells, cell_num, NULL, 0, NULL);
  	if (ret) {
  		dev_err(hostdev, "failed to add mfd cells (%d)\n", ret);

Any issue?

Thanks,
John

> Thanks,
> John
>
>> .
>>
>
