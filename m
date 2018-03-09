Date: Fri, 9 Mar 2018 11:34:29 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
	stuyoder@gmail.com, ruxandra.radulescu@nxp.com, arnd@arndb.de,
	upstream-release@linux.freescale.net
Subject: Re: [PATCH 2/3] bus: fsl-mc: add root dprc rescan attribute
Message-ID: <20180309193429.GB20133@kroah.com>
References: <cover.1520440367.git.ioana.ciornei@nxp.com>
 <0705c56d5b4c4cf0b4d9bacbd160982f12c7f953.1520440367.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0705c56d5b4c4cf0b4d9bacbd160982f12c7f953.1520440367.git.ioana.ciornei@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 10:51:36AM -0600, Ioana Ciornei wrote:
> Introduce the rescan attribute as a device attribute to
> synchronize the fsl-mc bus objects and the MC firmware.
> 
> To rescan the root dprc only, e.g.
> echo 1 > /sys/bus/fsl-mc/devices/dprc.1/rescan
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/bus/fsl-mc/dprc-driver.c    |  4 ++--
>  drivers/bus/fsl-mc/fsl-mc-bus.c     | 28 ++++++++++++++++++++++++++++
>  drivers/bus/fsl-mc/fsl-mc-private.h |  3 +++
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
> index 52c7e15..be80e3a 100644
> --- a/drivers/bus/fsl-mc/dprc-driver.c
> +++ b/drivers/bus/fsl-mc/dprc-driver.c
> @@ -214,8 +214,8 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
>   * populated before they can get allocation requests from probe callbacks
>   * of the device drivers for the non-allocatable devices.
>   */
> -static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
> -			     unsigned int *total_irq_count)
> +int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
> +		      unsigned int *total_irq_count)
>  {
>  	int num_child_objects;
>  	int dprc_get_obj_failures;
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 240b99d..763cbeb 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -137,8 +137,36 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(modalias);
>  
> +static ssize_t rescan_store(struct device *dev,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct fsl_mc_device *root_mc_dev;
> +	struct fsl_mc_bus *root_mc_bus;
> +	unsigned long val;
> +
> +	if (!fsl_mc_is_root_dprc(dev))
> +		return -EINVAL;
> +
> +	root_mc_dev = to_fsl_mc_device(dev);
> +	root_mc_bus = to_fsl_mc_bus(root_mc_dev);
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val) {
> +		mutex_lock(&root_mc_bus->scan_mutex);
> +		dprc_scan_objects(root_mc_dev, NULL);
> +		mutex_unlock(&root_mc_bus->scan_mutex);
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(rescan);

You did not add the correct new documentation in Documentation/ABI/ for
the new sysfs attributes you are creating.  Please do so as part of this
patch series.

thanks,

greg k-h
