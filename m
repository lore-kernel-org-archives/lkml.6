Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbeBQQtM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 11:49:12 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43429 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbeBQQtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 11:49:10 -0500
X-Google-Smtp-Source: AH8x225Pmmh+sEQxv34/qiRIIsEd/Jh2OafUL/U3ubDReLhWS1UBArE2zbMbDXxv1ocxm6/BjXwUAw==
Date: Sat, 17 Feb 2018 08:49:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v3,07/11] watchdog/hpwdt: Modify to use watchdog core.
Message-ID: <20180217164907.GA8375@roeck-us.net>
References: <20180215234400.5022-8-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215234400.5022-8-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:43:56PM -0700, Jerry Hoemann wrote:
> Follow Documentation/watchdog/convert_drivers_to_kernel_api.txt to
> convert hpwdt from legacy watchdog driver to use the watchdog core.
> 
> Removed functions: hpwdt_open, hpwdt_release, hpwdt_write, hpwdt_ioctl
> Removed data structures: hpwdt_fops, hpwdt_miscdev, watchdog_device
> Modified functions: hpwdt_start, hpwdt_stop, hpwdt_ping, hpwdt_gettimeleft
> Added functions: hpwdt_settimeout
> Added structures: watchdog_device
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 249 ++++++++++++-----------------------------------
>  1 file changed, 63 insertions(+), 186 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 71e49d0ab789..da9a04101814 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -14,18 +14,13 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/device.h>
> -#include <linux/fs.h>
> -#include <linux/io.h>

The driver still performs direct IO. Why do you remove this
include file ?

> -#include <linux/bitops.h>
>  #include <linux/kernel.h>
> -#include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/pci.h>
> -#include <linux/pci_ids.h>

The PCI vendor IDs used by the driver are declared in this file.
Is there a direction somewhere suggesting that this file
should not be directly included ?

>  #include <linux/types.h>
> -#include <linux/uaccess.h>
>  #include <linux/watchdog.h>
> +
>  #include <asm/nmi.h>
>  
>  #define HPWDT_VERSION			"1.4.0"
> @@ -40,8 +35,6 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
>  #ifdef CONFIG_HPWDT_NMI_DECODING
>  static unsigned int allow_kdump = 1;
>  #endif
> -static char expect_release;
> -static unsigned long hpwdt_is_open;
>  
>  static void __iomem *pci_mem_addr;		/* the PCI-memory address */
>  static unsigned long __iomem *hpwdt_nmistat;
> @@ -55,53 +48,58 @@ static const struct pci_device_id hpwdt_devices[] = {
>  };
>  MODULE_DEVICE_TABLE(pci, hpwdt_devices);
>  
> +static struct watchdog_device hpwdt_dev;

Please no double declarations. This is only needed for the NMI
code to pass to hpwdt_stop where it isn't used. It would be
easy to introduce _hpwdt_stop() with no parameter and call that
function frm hpwdt_stop().

>  
>  /*
>   *	Watchdog operations
>   */
> -static void hpwdt_start(void)
> +static int hpwdt_start(struct watchdog_device *dev)
>  {
> -	reload = SECS_TO_TICKS(soft_margin);
> +	reload = SECS_TO_TICKS(dev->timeout);
> +
>  	iowrite16(reload, hpwdt_timer_reg);
>  	iowrite8(0x85, hpwdt_timer_con);
> +
> +	return 0;
>  }
>  
> -static void hpwdt_stop(void)
> +static int hpwdt_stop(struct watchdog_device *dev)
>  {
>  	unsigned long data;
>  
>  	data = ioread8(hpwdt_timer_con);
>  	data &= 0xFE;
>  	iowrite8(data, hpwdt_timer_con);
> +	return 0;
>  }
>  
> -static void hpwdt_ping(void)
> -{
> -	iowrite16(reload, hpwdt_timer_reg);
> -}
> -
> -static int hpwdt_change_timer(int new_margin)
> +static int hpwdt_ping(struct watchdog_device *dev)
>  {
> -	if (new_margin < 1 || new_margin > HPWDT_MAX_TIMER) {
> -		pr_warn("New value passed in is invalid: %d seconds\n",
> -			new_margin);
> -		return -EINVAL;
> -	}
> +	reload = SECS_TO_TICKS(dev->timeout);
>  
> -	soft_margin = new_margin;
> -	pr_debug("New timer passed in is %d seconds\n", new_margin);
> -	reload = SECS_TO_TICKS(soft_margin);
> +	iowrite16(reload, hpwdt_timer_reg);
>  
>  	return 0;
>  }
>  
> -static int hpwdt_time_left(void)
> +static unsigned int hpwdt_gettimeleft(struct watchdog_device *dev)
>  {
>  	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
>  }
>  
> +static int hpwdt_settimeout(struct watchdog_device *dev, unsigned int val)
> +{
> +	dev_dbg(dev->parent, "settimeout = %d\n", val);
> +
> +	dev->timeout = val;
> +	hpwdt_ping(dev);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> -static int hpwdt_my_nmi(void)
> +
> +static unsigned int hpwdt_my_nmi(void)
>  {
>  	return ioread8(hpwdt_nmistat) & 0x6;
>  }
> @@ -123,8 +121,10 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  	if ((ulReason == NMI_UNKNOWN) && !mynmi)
>  		return NMI_DONE;
>  
> +	pr_debug("nmi: ulReason=%d, mynmi=0x%0x\n", ulReason, mynmi);
> +
>  	if (allow_kdump)
> -		hpwdt_stop();
> +		hpwdt_stop(&hpwdt_dev);
>  
>  	hex_byte_pack(panic_msg, mynmi);
>  	nmi_panic(regs, panic_msg);
> @@ -133,68 +133,6 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  }
>  #endif					/* } */
>  
> -/*
> - *	/dev/watchdog handling
> - */
> -static int hpwdt_open(struct inode *inode, struct file *file)
> -{
> -	/* /dev/watchdog can only be opened once */
> -	if (test_and_set_bit(0, &hpwdt_is_open))
> -		return -EBUSY;
> -
> -	/* Start the watchdog */
> -	hpwdt_start();
> -	hpwdt_ping();
> -
> -	return nonseekable_open(inode, file);
> -}
> -
> -static int hpwdt_release(struct inode *inode, struct file *file)
> -{
> -	/* Stop the watchdog */
> -	if (expect_release == 42) {
> -		hpwdt_stop();
> -	} else {
> -		pr_crit("Unexpected close, not stopping watchdog!\n");
> -		hpwdt_ping();
> -	}
> -
> -	expect_release = 0;
> -
> -	/* /dev/watchdog is being closed, make sure it can be re-opened */
> -	clear_bit(0, &hpwdt_is_open);
> -
> -	return 0;
> -}
> -
> -static ssize_t hpwdt_write(struct file *file, const char __user *data,
> -	size_t len, loff_t *ppos)
> -{
> -	/* See if we got the magic character 'V' and reload the timer */
> -	if (len) {
> -		if (!nowayout) {
> -			size_t i;
> -
> -			/* note: just in case someone wrote the magic character
> -			 * five months ago... */
> -			expect_release = 0;
> -
> -			/* scan to see whether or not we got the magic char. */
> -			for (i = 0; i != len; i++) {
> -				char c;
> -				if (get_user(c, data + i))
> -					return -EFAULT;
> -				if (c == 'V')
> -					expect_release = 42;
> -			}
> -		}
> -
> -		/* someone wrote to us, we should reload the timer */
> -		hpwdt_ping();
> -	}
> -
> -	return len;
> -}
>  
>  static const struct watchdog_info hpwdt_info = {
>  	.options	= WDIOF_SETTIMEOUT    |
> @@ -203,90 +141,10 @@ static const struct watchdog_info hpwdt_info = {
>  	.identity	= "HPE iLO2+ HW Watchdog Timer",
>  };
>  
> -static long hpwdt_ioctl(struct file *file, unsigned int cmd,
> -	unsigned long arg)
> -{
> -	void __user *argp = (void __user *)arg;
> -	int __user *p = argp;
> -	int new_margin, options;
> -	int ret = -ENOTTY;
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		ret = 0;
> -		if (copy_to_user(argp, &hpwdt_info, sizeof(hpwdt_info)))
> -			ret = -EFAULT;
> -		break;
> -
> -	case WDIOC_GETSTATUS:
> -	case WDIOC_GETBOOTSTATUS:
> -		ret = put_user(0, p);
> -		break;
> -
> -	case WDIOC_KEEPALIVE:
> -		hpwdt_ping();
> -		ret = 0;
> -		break;
> -
> -	case WDIOC_SETOPTIONS:
> -		ret = get_user(options, p);
> -		if (ret)
> -			break;
> -
> -		if (options & WDIOS_DISABLECARD)
> -			hpwdt_stop();
> -
> -		if (options & WDIOS_ENABLECARD) {
> -			hpwdt_start();
> -			hpwdt_ping();
> -		}
> -		break;
> -
> -	case WDIOC_SETTIMEOUT:
> -		ret = get_user(new_margin, p);
> -		if (ret)
> -			break;
> -
> -		ret = hpwdt_change_timer(new_margin);
> -		if (ret)
> -			break;
> -
> -		hpwdt_ping();
> -		/* Fall */
> -	case WDIOC_GETTIMEOUT:
> -		ret = put_user(soft_margin, p);
> -		break;
> -
> -	case WDIOC_GETTIMELEFT:
> -		ret = put_user(hpwdt_time_left(), p);
> -		break;
> -	}
> -	return ret;
> -}
> -
> -/*
> - *	Kernel interfaces
> - */
> -static const struct file_operations hpwdt_fops = {
> -	.owner = THIS_MODULE,
> -	.llseek = no_llseek,
> -	.write = hpwdt_write,
> -	.unlocked_ioctl = hpwdt_ioctl,
> -	.open = hpwdt_open,
> -	.release = hpwdt_release,
> -};
> -
> -static struct miscdevice hpwdt_miscdev = {
> -	.minor = WATCHDOG_MINOR,
> -	.name = "watchdog",
> -	.fops = &hpwdt_fops,
> -};
> -
>  /*
>   *	Init & Exit
>   */
>  
> -
>  static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
>  {
>  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> @@ -373,32 +231,32 @@ static int hpwdt_probe(struct pci_dev *dev, const struct pci_device_id *ent)
>  	hpwdt_timer_reg = pci_mem_addr + 0x70;
>  	hpwdt_timer_con = pci_mem_addr + 0x72;
>  
> -	/* Make sure that timer is disabled until /dev/watchdog is opened */
> -	hpwdt_stop();
> -
> -	/* Make sure that we have a valid soft_margin */
> -	if (hpwdt_change_timer(soft_margin))
> -		hpwdt_change_timer(DEFAULT_MARGIN);
> -
>  	/* Initialize NMI Decoding functionality */
>  	retval = hpwdt_init_nmi_decoding(dev);
>  	if (retval != 0)
>  		goto error_init_nmi_decoding;
>  
> -	retval = misc_register(&hpwdt_miscdev);
> +	hpwdt_dev.parent = &dev->dev;
> +	retval = watchdog_register_device(&hpwdt_dev);
>  	if (retval < 0) {
> -		dev_warn(&dev->dev,
> -			"Unable to register miscdev on minor=%d (err=%d).\n",
> -			WATCHDOG_MINOR, retval);
> -		goto error_misc_register;
> +		dev_warn(&dev->dev, "Unable to register hpe watchdog (err=%d).\n", retval);

checkpatch warning. Also, this should be dev_err() since it is fatal.

> +		goto error_wd_register;
>  	}
>  
> +	/* Make sure that timer is disabled until /dev/watchdog is opened */
> +	hpwdt_stop(&hpwdt_dev);

The watchdog is already registered and the device can already have been
opened at this point. The watchdog would have to be stopped before
registering the watchdog.

A better approach would be to detect if the watchdog is running and inform
the watchdog core about it. The code in the stop function suggests that
this would be possible. This would ensure that the watchdog protection
during boot is retained.

> +
> +	watchdog_set_nowayout(&hpwdt_dev, nowayout);
> +	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
> +		dev_warn(&dev->dev, "Invalid soft_margin: %d. Using default\n", soft_margin);
> +
Those two functions should be called before registering the watchdog.
Also, there is a checkpatch warning.

>  	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
>  			", timer margin: %d seconds (nowayout=%d).\n",
> -			HPWDT_VERSION, soft_margin, nowayout);
> +			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
> +
>  	return 0;
>  
> -error_misc_register:
> +error_wd_register:
>  	hpwdt_exit_nmi_decoding();
>  error_init_nmi_decoding:
>  	pci_iounmap(dev, pci_mem_addr);
> @@ -410,9 +268,9 @@ static int hpwdt_probe(struct pci_dev *dev, const struct pci_device_id *ent)
>  static void hpwdt_exit(struct pci_dev *dev)
>  {
>  	if (!nowayout)
> -		hpwdt_stop();
> +		hpwdt_stop(&hpwdt_dev);
>  
> -	misc_deregister(&hpwdt_miscdev);
> +	watchdog_unregister_device(&hpwdt_dev);
>  	hpwdt_exit_nmi_decoding();
>  	pci_iounmap(dev, pci_mem_addr);
>  	pci_disable_device(dev);
> @@ -425,6 +283,25 @@ static struct pci_driver hpwdt_driver = {
>  	.remove		= hpwdt_exit,
>  };
>  
> +
> +static const struct watchdog_ops hpwdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= hpwdt_start,
> +	.stop		= hpwdt_stop,
> +	.ping		= hpwdt_ping,
> +	.set_timeout	= hpwdt_settimeout,
> +	.get_timeleft	= hpwdt_gettimeleft,
> +};
> +
> +static struct watchdog_device hpwdt_dev = {
> +	.info		= &hpwdt_info,
> +	.ops		= &hpwdt_ops,
> +	.min_timeout	= 1,
> +	.max_timeout	= HPWDT_MAX_TIMER,
> +	.timeout	= DEFAULT_MARGIN,
> +};
> +
> +
>  MODULE_AUTHOR("Jerry Hoemann");
>  MODULE_DESCRIPTION("hpe watchdog driver");
>  MODULE_LICENSE("GPL");
