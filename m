Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeD3FgR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 01:36:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36419 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbeD3FgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 01:36:15 -0400
X-Google-Smtp-Source: AB8JxZqPxz9ixbyAgpYtqKCsjkydSu+9ZEzU24sAk05B67pL1MNzweYrCZZlAlUpi535emD3Uhh13w==
Date: Mon, 30 Apr 2018 06:36:11 +0100
From: Lee Jones <lee.jones@linaro.org>
To: John Garry <john.garry@huawei.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        andriy.shevchenko@linux.intel.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org,
        helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: [RFC PATCH 1/2] ACPI / PNP: Don't add "enumeration_by_parent"
 devices
Message-ID: <20180430053611.GA11990@dell>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-2-git-send-email-john.garry@huawei.com>
 <20180420130727.GV2173@lahna.fi.intel.com>
 <27c3f84e-4d53-4b6b-7382-04908082ed01@huawei.com>
 <20180420135222.GY2173@lahna.fi.intel.com>
 <75eae3ac-228f-d6a4-bb0e-4bd27e35c55d@huawei.com>
 <09e3aa95-86ae-ca30-7bb5-a9704d296b43@huawei.com>
 <20180426140808.GK2173@lahna.fi.intel.com>
 <15443a87-2622-01ee-f7f2-426a51ca0f11@huawei.com>
 <44e047a2-93e1-9eff-45b8-d538a7ae9092@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44e047a2-93e1-9eff-45b8-d538a7ae9092@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018, John Garry wrote:
> On 26/04/2018 15:23, John Garry wrote:
> > On 26/04/2018 15:08, Mika Westerberg wrote:
> > > On Thu, Apr 26, 2018 at 02:49:49PM +0100, John Garry wrote:
> > > > diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> > > > index 2d4611e..b04425b 100644
> > > > --- a/drivers/bus/hisi_lpc.c
> > > > +++ b/drivers/bus/hisi_lpc.c
> > > > @@ -18,6 +18,8 @@
> > > >  #include <linux/of_platform.h>
> > > >  #include <linux/pci.h>
> > > >  #include <linux/slab.h>
> > > > +#include <linux/serial_8250.h>
> > > > +#include "../tty/serial/8250/8250.h"
> > > > 
> > > >  #define DRV_NAME "hisi-lpc"
> > > > 
> > > > @@ -345,6 +347,7 @@ static void hisi_lpc_comm_outs(void *hostdata,
> > > > unsigned
> > > > long pio,
> > > >  #define MFD_CHILD_NAME_LEN (ACPI_ID_LEN +
> > > > sizeof(MFD_CHILD_NAME_PREFIX) -
> > > > 1)
> > > > 
> > > >  struct hisi_lpc_mfd_cell {
> > > > +    struct plat_serial8250_port serial8250_port;
> > > >      struct mfd_cell_acpi_match acpi_match;
> > > >      char name[MFD_CHILD_NAME_LEN];
> > > >      char pnpid[ACPI_ID_LEN];
> > > > @@ -513,10 +516,31 @@ static int hisi_lpc_acpi_probe(struct device
> > > > *hostdev)
> > > >          dev_warn(&child->dev, "set resource fail (%d)\n", ret);
> > > >              return ret;
> > > >          }
> > > > +    if (!strcmp(acpi_device_hid(child), "HISI1031")) {
> > > 
> > 
> > Hi Mika,
> > 
> > > Hmm, there is a way in struct mfd_cell to match child devices using _HID
> > > so is there something preventing you from using that?
> > 
> > Not that I know about. Can you describe this method? I guess I also
> > don't need to set the mfd_cell pnpid either for this special case device.
> > 
> 
> So we using the mfd_cell to match child devices using _HID. At a glance, I
> don't actually see other drivers to use mfd_cell_acpi_match.pnpid .
> 
> Anyway we don't use static tables as we need to update the resources of the
> cell dynamically. However I do look at a driver like intel_quark_i2c_gpio.c,
> and this dynamically modifies the value of global mfd_cell array here:
> https://elixir.bootlin.com/linux/latest/source/drivers/mfd/intel_quark_i2c_gpio.c#L266
> 
> I know the cell array is only used at probe time, but this did not look to
> be good standard practice to me.

Lots of drivers do this to supply dynamic data.  If there is no other
sane way of providing such data, it's fine to do.  Although each
situation should be dealt with on a case-by-case basis.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
