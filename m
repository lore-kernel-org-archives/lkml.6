Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeBQUvW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:51:22 -0500
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:40012 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeBQUvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:51:21 -0500
Date: Sat, 17 Feb 2018 13:51:19 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v3,07/11] watchdog/hpwdt: Modify to use watchdog core.
Message-ID: <20180217205119.GE27788@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180215234400.5022-8-jerry.hoemann@hpe.com>
 <20180217164907.GA8375@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217164907.GA8375@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 08:49:07AM -0800, Guenter Roeck wrote:
> On Thu, Feb 15, 2018 at 04:43:56PM -0700, Jerry Hoemann wrote:
> > Follow Documentation/watchdog/convert_drivers_to_kernel_api.txt to
> > convert hpwdt from legacy watchdog driver to use the watchdog core.
> > 
> > Removed functions: hpwdt_open, hpwdt_release, hpwdt_write, hpwdt_ioctl
> > Removed data structures: hpwdt_fops, hpwdt_miscdev, watchdog_device
> > Modified functions: hpwdt_start, hpwdt_stop, hpwdt_ping, hpwdt_gettimeleft
> > Added functions: hpwdt_settimeout
> > Added structures: watchdog_device
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >  drivers/watchdog/hpwdt.c | 249 ++++++++++++-----------------------------------
> >  1 file changed, 63 insertions(+), 186 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index 71e49d0ab789..da9a04101814 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -14,18 +14,13 @@
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> >  #include <linux/device.h>
> > -#include <linux/fs.h>
> > -#include <linux/io.h>
> 
> The driver still performs direct IO. Why do you remove this
> include file ?

I was just removing file includes no longer needed to compile
the module.  While there are sential ifdef protecting against
compile errors for multiply including the same file, the extra
open and parsing of the file does add a little bit of overhead
to the build time.  Probably not as important today as it used
to be.

I will redact the change.

> 
> > -#include <linux/bitops.h>
> >  #include <linux/kernel.h>
> > -#include <linux/miscdevice.h>
> >  #include <linux/module.h>
> >  #include <linux/moduleparam.h>
> >  #include <linux/pci.h>
> > -#include <linux/pci_ids.h>
> 
> The PCI vendor IDs used by the driver are declared in this file.
> Is there a direction somewhere suggesting that this file
> should not be directly included ?

See above.

> 
> >  #include <linux/types.h>
> > -#include <linux/uaccess.h>
> >  #include <linux/watchdog.h>
> > +
> >  #include <asm/nmi.h>
> >  
> >  #define HPWDT_VERSION			"1.4.0"
> > @@ -40,8 +35,6 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
> >  #ifdef CONFIG_HPWDT_NMI_DECODING
> >  static unsigned int allow_kdump = 1;
> >  #endif
> > -static char expect_release;
> > -static unsigned long hpwdt_is_open;
> >  
> >  static void __iomem *pci_mem_addr;		/* the PCI-memory address */
> >  static unsigned long __iomem *hpwdt_nmistat;
> > @@ -55,53 +48,58 @@ static const struct pci_device_id hpwdt_devices[] = {
> >  };
> >  MODULE_DEVICE_TABLE(pci, hpwdt_devices);
> >  
> > +static struct watchdog_device hpwdt_dev;
> 
> Please no double declarations. This is only needed for the NMI
> code to pass to hpwdt_stop where it isn't used. It would be
> easy to introduce _hpwdt_stop() with no parameter and call that
> function frm hpwdt_stop().

I'll redact this change.

I'll add a new function hpwdt_stop_new (or something like that) which
takes the watchdog_devices as input and it will call current upstream
hpwdt_stop.

> 
> >  
> > -	retval = misc_register(&hpwdt_miscdev);
> > +	hpwdt_dev.parent = &dev->dev;
> > +	retval = watchdog_register_device(&hpwdt_dev);
> >  	if (retval < 0) {
> > -		dev_warn(&dev->dev,
> > -			"Unable to register miscdev on minor=%d (err=%d).\n",
> > -			WATCHDOG_MINOR, retval);
> > -		goto error_misc_register;
> > +		dev_warn(&dev->dev, "Unable to register hpe watchdog (err=%d).\n", retval);
> 
> checkpatch warning. Also, this should be dev_err() since it is fatal.

i'll change to dev_err.  i'll shorten the message to something similar.

> 
> > +		goto error_wd_register;
> >  	}
> >  
> > +	/* Make sure that timer is disabled until /dev/watchdog is opened */
> > +	hpwdt_stop(&hpwdt_dev);
> 
> The watchdog is already registered and the device can already have been
> opened at this point. The watchdog would have to be stopped before
> registering the watchdog.
> 
> A better approach would be to detect if the watchdog is running and inform
> the watchdog core about it. The code in the stop function suggests that
> this would be possible. This would ensure that the watchdog protection
> during boot is retained.

I will redact this change as it will no longer be necessary. See above.

> 
> > +
> > +	watchdog_set_nowayout(&hpwdt_dev, nowayout);
> > +	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
> > +		dev_warn(&dev->dev, "Invalid soft_margin: %d. Using default\n", soft_margin);
> > +
> Those two functions should be called before registering the watchdog.
> Also, there is a checkpatch warning.
> 

Will change.

Please update the Documentation/watchdog/watchdog-kernel-api.txt.

It is not clear from the documentation which interfaces are to be
called before watchdog_register_device and which ones are to be
called after.




-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
