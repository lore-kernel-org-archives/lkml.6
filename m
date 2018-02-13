Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965484AbeBMSFV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:05:21 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46428 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965344AbeBMSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:05:19 -0500
X-Google-Smtp-Source: AH8x227iHbQnkb5eK8MS0y9RfZTzTSXFqQgDXV0MUgYXqQNATVZIqZlUIDTQhKL0rpeLsV8Q7RSxnQ==
Date: Tue, 13 Feb 2018 10:05:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 06/11] watchdog/hpwdt: Modify to use watchdog core.
Message-ID: <20180213180517.GC19405@roeck-us.net>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-7-jerry.hoemann@hpe.com>
 <20180212090621.GA4513@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212090621.GA4513@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 10:06:21AM +0100, Marcus Folkesson wrote:
> Hi Jerry,
> 
> On Sun, Feb 11, 2018 at 10:21:06PM -0700, Jerry Hoemann wrote:
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
> 
I second Marcus' feedback.

Thanks,
Guenter

> I think it would be better to use
>     dev_emerg()
>     dev_crit()
>     dev_alert()
>     dev_err()
>     dev_warn()
>     dev_notice()
> 
> instead of pr_* functions now when we have a device to use.
> 
> > ---
> >  drivers/watchdog/hpwdt.c | 251 ++++++++++++-----------------------------------
> >  1 file changed, 63 insertions(+), 188 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index dead59f9ca80..740d0c633204 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -14,18 +14,13 @@
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> >  #include <linux/device.h>
> > -#include <linux/fs.h>
> > -#include <linux/io.h>
> > -#include <linux/bitops.h>
> >  #include <linux/kernel.h>
> > -#include <linux/miscdevice.h>
> >  #include <linux/module.h>
> >  #include <linux/moduleparam.h>
> >  #include <linux/pci.h>
> > -#include <linux/pci_ids.h>
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
> >  
> >  /*
> >   *	Watchdog operations
> >   */
> > -static void hpwdt_start(void)
> > +static int hpwdt_start(struct watchdog_device *dev)
> >  {
> > -	reload = SECS_TO_TICKS(soft_margin);
> > +	reload = SECS_TO_TICKS(dev->timeout);
> > +
> >  	iowrite16(reload, hpwdt_timer_reg);
> >  	iowrite8(0x85, hpwdt_timer_con);
> > +
> > +	return 0;
> >  }
> >  
> > -static void hpwdt_stop(void)
> > +static int hpwdt_stop(struct watchdog_device *dev)
> >  {
> >  	unsigned long data;
> >  
> >  	data = ioread8(hpwdt_timer_con);
> >  	data &= 0xFE;
> >  	iowrite8(data, hpwdt_timer_con);
> > +	return 0;
> >  }
> >  
> > -static void hpwdt_ping(void)
> > -{
> > -	iowrite16(reload, hpwdt_timer_reg);
> > -}
> > -
> > -static int hpwdt_change_timer(int new_margin)
> > +static int hpwdt_ping(struct watchdog_device *dev)
> >  {
> > -	if (new_margin < 1 || new_margin > HPWDT_MAX_TIMER) {
> > -		pr_warn("New value passed in is invalid: %d seconds\n",
> > -			new_margin);
> > -		return -EINVAL;
> > -	}
> > +	reload = SECS_TO_TICKS(dev->timeout);
> >  
> > -	soft_margin = new_margin;
> > -	pr_debug("New timer passed in is %d seconds\n", new_margin);
> > -	reload = SECS_TO_TICKS(soft_margin);
> > +	iowrite16(reload, hpwdt_timer_reg);
> >  
> >  	return 0;
> >  }
> >  
> > -static int hpwdt_time_left(void)
> > +static unsigned int hpwdt_gettimeleft(struct watchdog_device *dev)
> >  {
> >  	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
> >  }
> >  
> > +static int hpwdt_settimeout(struct watchdog_device *dev, unsigned int val)
> > +{
> > +	pr_debug("settimeout = %d\n", val);
> 
> dev_dbg()
> 
> 
> > +
> > +	soft_margin = dev->timeout = val;
> 
> No need to update soft_margin
> 
> > +	hpwdt_ping(dev);
> > +
> > +	return 0;
> > +}
> > +
> >  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> > -static int hpwdt_my_nmi(void)
> > +
> > +static unsigned int hpwdt_my_nmi(void)
> >  {
> >  	return ioread8(hpwdt_nmistat) & 0x6;
> >  }
> > @@ -128,8 +126,10 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
> >  	if ((ulReason == NMI_UNKNOWN) && !mynmi)
> >  		return NMI_DONE;
> >  
> > +	pr_debug("nmi: ulReason=%d, mynmi=0x%0x\n", ulReason, mynmi);
> 
> dev_dbg()
> 
> > +
> >  	if (allow_kdump)
> > -		hpwdt_stop();
> > +		hpwdt_stop(&hpwdt_dev);
> >  
> >  	panic_msg[0] = hexdigit((mynmi>>4)&0xf);
> >  	panic_msg[1] = hexdigit(mynmi&0xf);
> > @@ -140,68 +140,6 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
> >  }
> >  #endif					/* } */
> >  
> > -/*
> > - *	/dev/watchdog handling
> > - */
> > -static int hpwdt_open(struct inode *inode, struct file *file)
> > -{
> > -	/* /dev/watchdog can only be opened once */
> > -	if (test_and_set_bit(0, &hpwdt_is_open))
> > -		return -EBUSY;
> > -
> > -	/* Start the watchdog */
> > -	hpwdt_start();
> > -	hpwdt_ping();
> > -
> > -	return nonseekable_open(inode, file);
> > -}
> > -
> > -static int hpwdt_release(struct inode *inode, struct file *file)
> > -{
> > -	/* Stop the watchdog */
> > -	if (expect_release == 42) {
> > -		hpwdt_stop();
> > -	} else {
> > -		pr_crit("Unexpected close, not stopping watchdog!\n");
> > -		hpwdt_ping();
> > -	}
> > -
> > -	expect_release = 0;
> > -
> > -	/* /dev/watchdog is being closed, make sure it can be re-opened */
> > -	clear_bit(0, &hpwdt_is_open);
> > -
> > -	return 0;
> > -}
> > -
> > -static ssize_t hpwdt_write(struct file *file, const char __user *data,
> > -	size_t len, loff_t *ppos)
> > -{
> > -	/* See if we got the magic character 'V' and reload the timer */
> > -	if (len) {
> > -		if (!nowayout) {
> > -			size_t i;
> > -
> > -			/* note: just in case someone wrote the magic character
> > -			 * five months ago... */
> > -			expect_release = 0;
> > -
> > -			/* scan to see whether or not we got the magic char. */
> > -			for (i = 0; i != len; i++) {
> > -				char c;
> > -				if (get_user(c, data + i))
> > -					return -EFAULT;
> > -				if (c == 'V')
> > -					expect_release = 42;
> > -			}
> > -		}
> > -
> > -		/* someone wrote to us, we should reload the timer */
> > -		hpwdt_ping();
> > -	}
> > -
> > -	return len;
> > -}
> >  
> >  static const struct watchdog_info hpwdt_info = {
> >  	.options	= WDIOF_SETTIMEOUT    |
> > @@ -210,90 +148,10 @@ static const struct watchdog_info hpwdt_info = {
> >  	.identity	= "HPE iLO2+ HW Watchdog Timer",
> >  };
> >  
> > -static long hpwdt_ioctl(struct file *file, unsigned int cmd,
> > -	unsigned long arg)
> > -{
> > -	void __user *argp = (void __user *)arg;
> > -	int __user *p = argp;
> > -	int new_margin, options;
> > -	int ret = -ENOTTY;
> > -
> > -	switch (cmd) {
> > -	case WDIOC_GETSUPPORT:
> > -		ret = 0;
> > -		if (copy_to_user(argp, &hpwdt_info, sizeof(hpwdt_info)))
> > -			ret = -EFAULT;
> > -		break;
> > -
> > -	case WDIOC_GETSTATUS:
> > -	case WDIOC_GETBOOTSTATUS:
> > -		ret = put_user(0, p);
> > -		break;
> > -
> > -	case WDIOC_KEEPALIVE:
> > -		hpwdt_ping();
> > -		ret = 0;
> > -		break;
> > -
> > -	case WDIOC_SETOPTIONS:
> > -		ret = get_user(options, p);
> > -		if (ret)
> > -			break;
> > -
> > -		if (options & WDIOS_DISABLECARD)
> > -			hpwdt_stop();
> > -
> > -		if (options & WDIOS_ENABLECARD) {
> > -			hpwdt_start();
> > -			hpwdt_ping();
> > -		}
> > -		break;
> > -
> > -	case WDIOC_SETTIMEOUT:
> > -		ret = get_user(new_margin, p);
> > -		if (ret)
> > -			break;
> > -
> > -		ret = hpwdt_change_timer(new_margin);
> > -		if (ret)
> > -			break;
> > -
> > -		hpwdt_ping();
> > -		/* Fall */
> > -	case WDIOC_GETTIMEOUT:
> > -		ret = put_user(soft_margin, p);
> > -		break;
> > -
> > -	case WDIOC_GETTIMELEFT:
> > -		ret = put_user(hpwdt_time_left(), p);
> > -		break;
> > -	}
> > -	return ret;
> > -}
> > -
> > -/*
> > - *	Kernel interfaces
> > - */
> > -static const struct file_operations hpwdt_fops = {
> > -	.owner = THIS_MODULE,
> > -	.llseek = no_llseek,
> > -	.write = hpwdt_write,
> > -	.unlocked_ioctl = hpwdt_ioctl,
> > -	.open = hpwdt_open,
> > -	.release = hpwdt_release,
> > -};
> > -
> > -static struct miscdevice hpwdt_miscdev = {
> > -	.minor = WATCHDOG_MINOR,
> > -	.name = "watchdog",
> > -	.fops = &hpwdt_fops,
> > -};
> > -
> >  /*
> >   *	Init & Exit
> >   */
> >  
> > -
> >  static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
> >  {
> >  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> > @@ -311,10 +169,7 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
> >  	if (retval)
> >  		goto error2;
> >  
> > -	dev_info(&dev->dev,
> > -			"HPE Watchdog Timer Driver: NMI decoding initialized"
> > -			", allow kernel dump: %s (default = 1/ON)\n",
> > -			(allow_kdump == 0) ? "OFF" : "ON");
> > +	dev_info(&dev->dev, "HPE Watchdog Timer Driver: NMI decoding initialized");
> >  	return 0;
> >  
> >  error2:
> > @@ -381,31 +236,32 @@ static int hpwdt_probe(struct pci_dev *dev, const struct pci_device_id *ent)
> >  	hpwdt_timer_con = pci_mem_addr + 0x72;
> >  
> >  	/* Make sure that timer is disabled until /dev/watchdog is opened */
> > -	hpwdt_stop();
> > -
> > -	/* Make sure that we have a valid soft_margin */
> > -	if (hpwdt_change_timer(soft_margin))
> > -		hpwdt_change_timer(DEFAULT_MARGIN);
> > +	hpwdt_stop(&hpwdt_dev);
> >  
> >  	/* Initialize NMI Decoding functionality */
> >  	retval = hpwdt_init_nmi_decoding(dev);
> >  	if (retval != 0)
> >  		goto error_init_nmi_decoding;
> >  
> > -	retval = misc_register(&hpwdt_miscdev);
> > +	retval = watchdog_register_device(&hpwdt_dev);
> >  	if (retval < 0) {
> > -		dev_warn(&dev->dev,
> > -			"Unable to register miscdev on minor=%d (err=%d).\n",
> > -			WATCHDOG_MINOR, retval);
> > -		goto error_misc_register;
> > +		dev_warn(&dev->dev, "Unable to register hpe watchdog (err=%d).\n", retval);
> > +		goto error_wd_register;
> > +	}
> > +
> > +	watchdog_set_nowayout(&hpwdt_dev, nowayout);
> > +	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL)) {
> > +		dev_warn(&dev->dev, "Invalid soft_margin: %d. Using default\n", soft_margin);
> > +		soft_margin = DEFAULT_MARGIN;
> >  	}
> 
> In this case watchdog_init_timout() will:
> 1) Check if soft_margin is valid
> 2) if not, keep hpwdt_dev.timout intact (which is already set in
> declaration of hpwdt_dev)
> 
> So we could remove the condition and only keep
> watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL);
> 
> 
> Also, we need to set an invalid initial value for soft_margin to make
> the logic for watchdog_init_timeout work. 
> 
> i.e
> - static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
> + static unsigned int soft_margin;
> 
> >  
> >  	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
> >  			", timer margin: %d seconds (nowayout=%d).\n",
> > -			HPWDT_VERSION, soft_margin, nowayout);
> 
> print hpwdt_dev.timeout instead of soft_margin
> 
> > +			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
> > +
> >  	return 0;
> >  
> > -error_misc_register:
> > +error_wd_register:
> >  	hpwdt_exit_nmi_decoding();
> >  error_init_nmi_decoding:
> >  	pci_iounmap(dev, pci_mem_addr);
> > @@ -417,9 +273,9 @@ static int hpwdt_probe(struct pci_dev *dev, const struct pci_device_id *ent)
> >  static void hpwdt_exit(struct pci_dev *dev)
> >  {
> >  	if (!nowayout)
> > -		hpwdt_stop();
> > +		hpwdt_stop(&hpwdt_dev);
> >  
> > -	misc_deregister(&hpwdt_miscdev);
> > +	watchdog_unregister_device(&hpwdt_dev);
> >  	hpwdt_exit_nmi_decoding();
> >  	pci_iounmap(dev, pci_mem_addr);
> >  	pci_disable_device(dev);
> > @@ -432,6 +288,25 @@ static struct pci_driver hpwdt_driver = {
> >  	.remove		= hpwdt_exit,
> >  };
> >  
> > +
> > +static const struct watchdog_ops hpwdt_ops = {
> > +	.owner		= THIS_MODULE,
> > +	.start		= hpwdt_start,
> > +	.stop		= hpwdt_stop,
> > +	.ping		= hpwdt_ping,
> > +	.set_timeout	= hpwdt_settimeout,
> > +	.get_timeleft	= hpwdt_gettimeleft,
> > +};
> > +
> > +static struct watchdog_device hpwdt_dev = {
> > +	.info		= &hpwdt_info,
> > +	.ops		= &hpwdt_ops,
> > +	.min_timeout	= 1,
> > +	.max_timeout	= HPWDT_MAX_TIMER,
> > +	.timeout	= DEFAULT_MARGIN,
> > +};
> > +
> > +
> >  MODULE_AUTHOR("Jerry Hoemann");
> >  MODULE_DESCRIPTION("hpe watchdog driver");
> >  MODULE_LICENSE("GPL");
> > -- 
> > 2.13.6
> > 
> 
> Best regards
> Marcus Folkesson
