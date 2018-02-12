Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbeBLJGn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:06:43 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40508 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeBLJGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:06:35 -0500
X-Google-Smtp-Source: AH8x227uLK0dsBNrHmCMYjV7+ldP0nLBI/w0Yq6+ASwZq5tTmz5vXOAxjU4nyTEKeU/Vuq3oq2nYYQ==
Date: Mon, 12 Feb 2018 10:06:21 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 06/11] watchdog/hpwdt: Modify to use watchdog core.
Message-ID: <20180212090621.GA4513@gmail.com>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-7-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20180212052111.12010-7-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jerry,

On Sun, Feb 11, 2018 at 10:21:06PM -0700, Jerry Hoemann wrote:
> Follow Documentation/watchdog/convert_drivers_to_kernel_api.txt to
> convert hpwdt from legacy watchdog driver to use the watchdog core.
>=20
> Removed functions: hpwdt_open, hpwdt_release, hpwdt_write, hpwdt_ioctl
> Removed data structures: hpwdt_fops, hpwdt_miscdev, watchdog_device
> Modified functions: hpwdt_start, hpwdt_stop, hpwdt_ping, hpwdt_gettimeleft
> Added functions: hpwdt_settimeout
> Added structures: watchdog_device
>=20
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

I think it would be better to use
    dev_emerg()
    dev_crit()
    dev_alert()
    dev_err()
    dev_warn()
    dev_notice()

instead of pr_* functions now when we have a device to use.

> ---
>  drivers/watchdog/hpwdt.c | 251 ++++++++++++-----------------------------=
------
>  1 file changed, 63 insertions(+), 188 deletions(-)
>=20
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index dead59f9ca80..740d0c633204 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -14,18 +14,13 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
>  #include <linux/device.h>
> -#include <linux/fs.h>
> -#include <linux/io.h>
> -#include <linux/bitops.h>
>  #include <linux/kernel.h>
> -#include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/pci.h>
> -#include <linux/pci_ids.h>
>  #include <linux/types.h>
> -#include <linux/uaccess.h>
>  #include <linux/watchdog.h>
> +
>  #include <asm/nmi.h>
> =20
>  #define HPWDT_VERSION			"1.4.0"
> @@ -40,8 +35,6 @@ static bool nowayout =3D WATCHDOG_NOWAYOUT;
>  #ifdef CONFIG_HPWDT_NMI_DECODING
>  static unsigned int allow_kdump =3D 1;
>  #endif
> -static char expect_release;
> -static unsigned long hpwdt_is_open;
> =20
>  static void __iomem *pci_mem_addr;		/* the PCI-memory address */
>  static unsigned long __iomem *hpwdt_nmistat;
> @@ -55,53 +48,58 @@ static const struct pci_device_id hpwdt_devices[] =3D=
 {
>  };
>  MODULE_DEVICE_TABLE(pci, hpwdt_devices);
> =20
> +static struct watchdog_device hpwdt_dev;
> =20
>  /*
>   *	Watchdog operations
>   */
> -static void hpwdt_start(void)
> +static int hpwdt_start(struct watchdog_device *dev)
>  {
> -	reload =3D SECS_TO_TICKS(soft_margin);
> +	reload =3D SECS_TO_TICKS(dev->timeout);
> +
>  	iowrite16(reload, hpwdt_timer_reg);
>  	iowrite8(0x85, hpwdt_timer_con);
> +
> +	return 0;
>  }
> =20
> -static void hpwdt_stop(void)
> +static int hpwdt_stop(struct watchdog_device *dev)
>  {
>  	unsigned long data;
> =20
>  	data =3D ioread8(hpwdt_timer_con);
>  	data &=3D 0xFE;
>  	iowrite8(data, hpwdt_timer_con);
> +	return 0;
>  }
> =20
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
> +	reload =3D SECS_TO_TICKS(dev->timeout);
> =20
> -	soft_margin =3D new_margin;
> -	pr_debug("New timer passed in is %d seconds\n", new_margin);
> -	reload =3D SECS_TO_TICKS(soft_margin);
> +	iowrite16(reload, hpwdt_timer_reg);
> =20
>  	return 0;
>  }
> =20
> -static int hpwdt_time_left(void)
> +static unsigned int hpwdt_gettimeleft(struct watchdog_device *dev)
>  {
>  	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
>  }
> =20
> +static int hpwdt_settimeout(struct watchdog_device *dev, unsigned int va=
l)
> +{
> +	pr_debug("settimeout =3D %d\n", val);

dev_dbg()


> +
> +	soft_margin =3D dev->timeout =3D val;

No need to update soft_margin

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
> @@ -128,8 +126,10 @@ static int hpwdt_pretimeout(unsigned int ulReason, s=
truct pt_regs *regs)
>  	if ((ulReason =3D=3D NMI_UNKNOWN) && !mynmi)
>  		return NMI_DONE;
> =20
> +	pr_debug("nmi: ulReason=3D%d, mynmi=3D0x%0x\n", ulReason, mynmi);

dev_dbg()

> +
>  	if (allow_kdump)
> -		hpwdt_stop();
> +		hpwdt_stop(&hpwdt_dev);
> =20
>  	panic_msg[0] =3D hexdigit((mynmi>>4)&0xf);
>  	panic_msg[1] =3D hexdigit(mynmi&0xf);
> @@ -140,68 +140,6 @@ static int hpwdt_pretimeout(unsigned int ulReason, s=
truct pt_regs *regs)
>  }
>  #endif					/* } */
> =20
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
> -	if (expect_release =3D=3D 42) {
> -		hpwdt_stop();
> -	} else {
> -		pr_crit("Unexpected close, not stopping watchdog!\n");
> -		hpwdt_ping();
> -	}
> -
> -	expect_release =3D 0;
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
> -			expect_release =3D 0;
> -
> -			/* scan to see whether or not we got the magic char. */
> -			for (i =3D 0; i !=3D len; i++) {
> -				char c;
> -				if (get_user(c, data + i))
> -					return -EFAULT;
> -				if (c =3D=3D 'V')
> -					expect_release =3D 42;
> -			}
> -		}
> -
> -		/* someone wrote to us, we should reload the timer */
> -		hpwdt_ping();
> -	}
> -
> -	return len;
> -}
> =20
>  static const struct watchdog_info hpwdt_info =3D {
>  	.options	=3D WDIOF_SETTIMEOUT    |
> @@ -210,90 +148,10 @@ static const struct watchdog_info hpwdt_info =3D {
>  	.identity	=3D "HPE iLO2+ HW Watchdog Timer",
>  };
> =20
> -static long hpwdt_ioctl(struct file *file, unsigned int cmd,
> -	unsigned long arg)
> -{
> -	void __user *argp =3D (void __user *)arg;
> -	int __user *p =3D argp;
> -	int new_margin, options;
> -	int ret =3D -ENOTTY;
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		ret =3D 0;
> -		if (copy_to_user(argp, &hpwdt_info, sizeof(hpwdt_info)))
> -			ret =3D -EFAULT;
> -		break;
> -
> -	case WDIOC_GETSTATUS:
> -	case WDIOC_GETBOOTSTATUS:
> -		ret =3D put_user(0, p);
> -		break;
> -
> -	case WDIOC_KEEPALIVE:
> -		hpwdt_ping();
> -		ret =3D 0;
> -		break;
> -
> -	case WDIOC_SETOPTIONS:
> -		ret =3D get_user(options, p);
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
> -		ret =3D get_user(new_margin, p);
> -		if (ret)
> -			break;
> -
> -		ret =3D hpwdt_change_timer(new_margin);
> -		if (ret)
> -			break;
> -
> -		hpwdt_ping();
> -		/* Fall */
> -	case WDIOC_GETTIMEOUT:
> -		ret =3D put_user(soft_margin, p);
> -		break;
> -
> -	case WDIOC_GETTIMELEFT:
> -		ret =3D put_user(hpwdt_time_left(), p);
> -		break;
> -	}
> -	return ret;
> -}
> -
> -/*
> - *	Kernel interfaces
> - */
> -static const struct file_operations hpwdt_fops =3D {
> -	.owner =3D THIS_MODULE,
> -	.llseek =3D no_llseek,
> -	.write =3D hpwdt_write,
> -	.unlocked_ioctl =3D hpwdt_ioctl,
> -	.open =3D hpwdt_open,
> -	.release =3D hpwdt_release,
> -};
> -
> -static struct miscdevice hpwdt_miscdev =3D {
> -	.minor =3D WATCHDOG_MINOR,
> -	.name =3D "watchdog",
> -	.fops =3D &hpwdt_fops,
> -};
> -
>  /*
>   *	Init & Exit
>   */
> =20
> -
>  static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
>  {
>  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> @@ -311,10 +169,7 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *d=
ev)
>  	if (retval)
>  		goto error2;
> =20
> -	dev_info(&dev->dev,
> -			"HPE Watchdog Timer Driver: NMI decoding initialized"
> -			", allow kernel dump: %s (default =3D 1/ON)\n",
> -			(allow_kdump =3D=3D 0) ? "OFF" : "ON");
> +	dev_info(&dev->dev, "HPE Watchdog Timer Driver: NMI decoding initialize=
d");
>  	return 0;
> =20
>  error2:
> @@ -381,31 +236,32 @@ static int hpwdt_probe(struct pci_dev *dev, const s=
truct pci_device_id *ent)
>  	hpwdt_timer_con =3D pci_mem_addr + 0x72;
> =20
>  	/* Make sure that timer is disabled until /dev/watchdog is opened */
> -	hpwdt_stop();
> -
> -	/* Make sure that we have a valid soft_margin */
> -	if (hpwdt_change_timer(soft_margin))
> -		hpwdt_change_timer(DEFAULT_MARGIN);
> +	hpwdt_stop(&hpwdt_dev);
> =20
>  	/* Initialize NMI Decoding functionality */
>  	retval =3D hpwdt_init_nmi_decoding(dev);
>  	if (retval !=3D 0)
>  		goto error_init_nmi_decoding;
> =20
> -	retval =3D misc_register(&hpwdt_miscdev);
> +	retval =3D watchdog_register_device(&hpwdt_dev);
>  	if (retval < 0) {
> -		dev_warn(&dev->dev,
> -			"Unable to register miscdev on minor=3D%d (err=3D%d).\n",
> -			WATCHDOG_MINOR, retval);
> -		goto error_misc_register;
> +		dev_warn(&dev->dev, "Unable to register hpe watchdog (err=3D%d).\n", r=
etval);
> +		goto error_wd_register;
> +	}
> +
> +	watchdog_set_nowayout(&hpwdt_dev, nowayout);
> +	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL)) {
> +		dev_warn(&dev->dev, "Invalid soft_margin: %d. Using default\n", soft_m=
argin);
> +		soft_margin =3D DEFAULT_MARGIN;
>  	}

In this case watchdog_init_timout() will:
1) Check if soft_margin is valid
2) if not, keep hpwdt_dev.timout intact (which is already set in
declaration of hpwdt_dev)

So we could remove the condition and only keep
watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL);


Also, we need to set an invalid initial value for soft_margin to make
the logic for watchdog_init_timeout work.=20

i.e
- static unsigned int soft_margin =3D DEFAULT_MARGIN;	/* in seconds */
+ static unsigned int soft_margin;

> =20
>  	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
>  			", timer margin: %d seconds (nowayout=3D%d).\n",
> -			HPWDT_VERSION, soft_margin, nowayout);

print hpwdt_dev.timeout instead of soft_margin

> +			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
> +
>  	return 0;
> =20
> -error_misc_register:
> +error_wd_register:
>  	hpwdt_exit_nmi_decoding();
>  error_init_nmi_decoding:
>  	pci_iounmap(dev, pci_mem_addr);
> @@ -417,9 +273,9 @@ static int hpwdt_probe(struct pci_dev *dev, const str=
uct pci_device_id *ent)
>  static void hpwdt_exit(struct pci_dev *dev)
>  {
>  	if (!nowayout)
> -		hpwdt_stop();
> +		hpwdt_stop(&hpwdt_dev);
> =20
> -	misc_deregister(&hpwdt_miscdev);
> +	watchdog_unregister_device(&hpwdt_dev);
>  	hpwdt_exit_nmi_decoding();
>  	pci_iounmap(dev, pci_mem_addr);
>  	pci_disable_device(dev);
> @@ -432,6 +288,25 @@ static struct pci_driver hpwdt_driver =3D {
>  	.remove		=3D hpwdt_exit,
>  };
> =20
> +
> +static const struct watchdog_ops hpwdt_ops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.start		=3D hpwdt_start,
> +	.stop		=3D hpwdt_stop,
> +	.ping		=3D hpwdt_ping,
> +	.set_timeout	=3D hpwdt_settimeout,
> +	.get_timeleft	=3D hpwdt_gettimeleft,
> +};
> +
> +static struct watchdog_device hpwdt_dev =3D {
> +	.info		=3D &hpwdt_info,
> +	.ops		=3D &hpwdt_ops,
> +	.min_timeout	=3D 1,
> +	.max_timeout	=3D HPWDT_MAX_TIMER,
> +	.timeout	=3D DEFAULT_MARGIN,
> +};
> +
> +
>  MODULE_AUTHOR("Jerry Hoemann");
>  MODULE_DESCRIPTION("hpe watchdog driver");
>  MODULE_LICENSE("GPL");
> --=20
> 2.13.6
>=20

Best regards
Marcus Folkesson

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqBWQgACgkQiIBOb1ld
UjLfpQ/9HkkUNDSK79T3d4ck9wARgnuh7KRBcUXHTsTlh/vL/7HLAsbLq7aaGEM/
3mY2Z/982Ks0qEZhdU2gMEVqkj7J18mP4yLRNO7Tv7oOO+IR4LjXwHn8P39rzGQZ
kRJhYqDgCcySfbQS+6YRaaz0vLUVsp+TiPxOevBNGJX/rVdH4oZO8a4FOduY9RBD
cGiBqv0IXWL0C82J0hWHZV69m5cNrkESkdu/BvRCvut1HdEy+4v5fWz3tovrnW4C
UZ85KN1vIKLoVhkOsX7o/IuX8VUh7MDP6Wlty5aIEEuZnKGD312/debv0yKWCUGu
HdKOuZr41ZhKu9CFpFpW5mtf8MyFRhOvyf7X89usQl0hLU1BsL43m7PlmeCOrKXo
ww9QlDJK2TliN8v7Tnf/3pAonSAp+3advBubxbTXNM/L8R5mbg1W5R7xWiw1GvPl
G+r1IDtT6J5ipNReR+816jlEABm829Dym9ennD+5UMQAua6bwz0XmO7Nx1pr4/Mx
PF+DNKJ9+l1+3tdvmY2KMFhcZETpE4/kuPARjWdW+0jBhbl9sU4z2ME8etVHKwj3
CotDQIUca46EuRBlqJsD2xBQkERy6CIkImHXi0WU/yuSpfE12/3FOfR/nd/i5CYi
4w+kvILSyuq5Z3Sy1T6XL8LCs6xn5UHYTg/QN3L86Juwu/pB5pA=
=I4yf
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
