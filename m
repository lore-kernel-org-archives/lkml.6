Date: Fri, 9 Mar 2018 11:33:34 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
	stuyoder@gmail.com, ruxandra.radulescu@nxp.com, arnd@arndb.de,
	upstream-release@linux.freescale.net
Subject: Re: [PATCH 1/3] bus: fsl-mc: add restool userspace support
Message-ID: <20180309193334.GA20133@kroah.com>
References: <cover.1520440367.git.ioana.ciornei@nxp.com>
 <e3d050dcdc575d65f9786eaa1b7a55aaa197dfc3.1520440367.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3d050dcdc575d65f9786eaa1b7a55aaa197dfc3.1520440367.git.ioana.ciornei@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 10:51:35AM -0600, Ioana Ciornei wrote:
> Adding kernel support for restool, a userspace tool for resource
> management, means exporting an ioctl capable device file representing
> the root resource container.
> This new functionality in the fsl-mc bus driver intends to provide
> restool an interface to interact with the MC firmware.
> Commands that are composed in userspace are sent to the MC firmware
> through the RESTOOL_SEND_MC_COMMAND ioctl.
> By default the implicit MC I/O portal is used for this operation,
> but if the implicit one is busy, a dynamic portal is allocated and then
> freed upon execution.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  Documentation/ioctl/ioctl-number.txt        |   1 +
>  Documentation/networking/dpaa2/overview.rst |   4 +
>  drivers/bus/fsl-mc/Kconfig                  |   7 +
>  drivers/bus/fsl-mc/Makefile                 |   3 +
>  drivers/bus/fsl-mc/fsl-mc-allocator.c       |   5 +
>  drivers/bus/fsl-mc/fsl-mc-bus.c             |  19 +++
>  drivers/bus/fsl-mc/fsl-mc-private.h         |  56 +++++++
>  drivers/bus/fsl-mc/fsl-mc-restool.c         | 219 ++++++++++++++++++++++++++++

This is a "tiny" patch, yet I think it needs to be broken up more, as
you are mixing a few different things in the same patch, and you forgot
one big thing...

>  8 files changed, 314 insertions(+)
>  create mode 100644 drivers/bus/fsl-mc/fsl-mc-restool.c
> 
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> index 6501389..d427397 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -170,6 +170,7 @@ Code  Seq#(hex)	Include File		Comments
>  'R'	00-1F	linux/random.h		conflict!
>  'R'	01	linux/rfkill.h		conflict!
>  'R'	C0-DF	net/bluetooth/rfcomm.h
> +'R'	E0	drivers/bus/fsl-mc/fsl-mc-private.h
>  'S'	all	linux/cdrom.h		conflict!
>  'S'	80-81	scsi/scsi_ioctl.h	conflict!
>  'S'	82-FF	scsi/scsi.h		conflict!
> diff --git a/Documentation/networking/dpaa2/overview.rst b/Documentation/networking/dpaa2/overview.rst
> index 79fede4..1056445 100644
> --- a/Documentation/networking/dpaa2/overview.rst
> +++ b/Documentation/networking/dpaa2/overview.rst
> @@ -127,6 +127,10 @@ level.
>  
>  DPRCs can be defined statically and populated with objects
>  via a config file passed to the MC when firmware starts it.
> +There is also a Linux user space tool called "restool" that can be
> +used to create/destroy containers and objects dynamically. The latest
> +version of restool can be found at:
> +        https://github.com/qoriq-open-source/restool
>  
>  DPAA2 Objects for an Ethernet Network Interface
>  -----------------------------------------------
> diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
> index c23c77c..66ec3b9 100644
> --- a/drivers/bus/fsl-mc/Kconfig
> +++ b/drivers/bus/fsl-mc/Kconfig
> @@ -14,3 +14,10 @@ config FSL_MC_BUS
>  	  architecture.  The fsl-mc bus driver handles discovery of
>  	  DPAA2 objects (which are represented as Linux devices) and
>  	  binding objects to drivers.
> +
> +config FSL_MC_RESTOOL
> +	bool "Management Complex (MC) restool support"
> +	depends on FSL_MC_BUS
> +	help
> +	  Provides kernel support for the Management Complex resource
> +	  manager user-space tool - restool.

Why would you want to make this a build option?  Why would you ever
_not_ want this?


> diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
> index 6a97f2c..9a155e3 100644
> --- a/drivers/bus/fsl-mc/Makefile
> +++ b/drivers/bus/fsl-mc/Makefile
> @@ -14,3 +14,6 @@ mc-bus-driver-objs := fsl-mc-bus.o \
>  		      fsl-mc-allocator.o \
>  		      fsl-mc-msi.o \
>  		      dpmcp.o
> +
> +# MC restool kernel support
> +obj-$(CONFIG_FSL_MC_RESTOOL) += fsl-mc-restool.o
> diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> index 452c5d7..fb1442b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> @@ -646,3 +646,8 @@ int __init fsl_mc_allocator_driver_init(void)
>  {
>  	return fsl_mc_driver_register(&fsl_mc_allocator_driver);
>  }
> +
> +void fsl_mc_allocator_driver_exit(void)
> +{
> +	fsl_mc_driver_unregister(&fsl_mc_allocator_driver);
> +}

Why are you mixing the bus/driver changes in with the addition of the
ioctl?  That should be broken out into the "first" patch of this series,
to make the addition of the ioctl easier to see and review.

> +#define RESTOOL_IOCTL_TYPE	'R'
> +#define RESTOOL_IOCTL_SEQ	0xE0
> +
> +#define RESTOOL_SEND_MC_COMMAND \
> +	_IOWR(RESTOOL_IOCTL_TYPE, RESTOOL_IOCTL_SEQ, struct mc_command)

"struct mc_command" is not defined as a structure that can cross the
user/kernel boundry at all.  At the least it is not in a public uapi
header file.  It also does not use the correct variable types, and it is
a very generic name for a global kernel structure that the whole world
is now going to be able to see.

Please fix all of that up first, before adding the ioctl itself :)

> +static int fsl_mc_restool_send_command(unsigned long arg,
> +				       struct fsl_mc_io *mc_io)
> +{
> +	struct mc_command mc_cmd;
> +	int error;
> +
> +	error = copy_from_user(&mc_cmd, (void __user *)arg, sizeof(mc_cmd));
> +	if (error)
> +		return -EFAULT;
> +
> +	error = mc_send_command(mc_io, &mc_cmd);

are you doing correct error and validation checking of this
user-provided structure?  Remember, you can not trust this data at all.

All input is evil.

thanks,

greg k-h
