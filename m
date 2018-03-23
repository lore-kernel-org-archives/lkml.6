Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeCWPt5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:49:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeCWPtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:49:55 -0400
Date: Fri, 23 Mar 2018 16:49:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        stuyoder@gmail.com, ruxandra.radulescu@nxp.com, arnd@arndb.de,
        razvan.stefanescu@nxp.com, Roy.Pledge@nxp.com
Subject: Re: [PATCH v3 4/4] bus: fsl-mc: add bus rescan attribute
Message-ID: <20180323154953.GC382@kroah.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <2ea1db0e7d43255f8d13f6c3cb4ce3d12df89eef.1521818403.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea1db0e7d43255f8d13f6c3cb4ce3d12df89eef.1521818403.git.ioana.ciornei@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:38:58AM -0500, Ioana Ciornei wrote:
> Introduce the rescan attribute as a bus attribute to
> synchronize the fsl-mc bus objects and the MC firmware.
> 
> To rescan the fsl-mc bus, e.g.,
> echo 1 > /sys/bus/fsl-mc/rescan
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
>   - added proper documentation in /Documentation/ABI/
>   - updated the MAINTAINERS file
> Changes in v3:
>   - no change
> 
>  Documentation/ABI/stable/sysfs-bus-fsl-mc |  7 +++++
>  drivers/bus/fsl-mc/fsl-mc-bus.c           | 48 +++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc b/Documentation/ABI/stable/sysfs-bus-fsl-mc
> index e530e8c..0663fbd 100644
> --- a/Documentation/ABI/stable/sysfs-bus-fsl-mc
> +++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
> @@ -4,3 +4,10 @@ KernelVersion:	4.16
>  Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
>  Description:	Root dprc rescan attribute
>  Users:		Userspace drivers and management tools
> +
> +What:		/sys/bus/fsl-mc/rescan
> +Date:		March. 2018
> +KernelVersion:	4.16

Same comments as previous review.

> +Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
> +Description:	Bus rescan attribute

Again, describe this better please.

> +Users:		Userspace drivers and management tools
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 9d02984..80010d1 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -172,11 +172,59 @@ static ssize_t rescan_store(struct device *dev,
>  
>  ATTRIBUTE_GROUPS(fsl_mc_dev);
>  
> +static int scan_fsl_mc_bus(struct device *dev, void *data)
> +{
> +	struct fsl_mc_device *root_mc_dev;
> +	struct fsl_mc_bus *root_mc_bus;
> +
> +	if (!fsl_mc_is_root_dprc(dev))
> +		goto exit;
> +
> +	root_mc_dev = to_fsl_mc_device(dev);
> +	root_mc_bus = to_fsl_mc_bus(root_mc_dev);
> +	mutex_lock(&root_mc_bus->scan_mutex);
> +	dprc_scan_objects(root_mc_dev, NULL);
> +	mutex_unlock(&root_mc_bus->scan_mutex);
> +
> +exit:
> +	return 0;
> +}
> +
> +static ssize_t bus_rescan_store(struct bus_type *bus,
> +				const char *buf, size_t count)
> +{
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val)
> +		bus_for_each_dev(bus, NULL, NULL, scan_fsl_mc_bus);
> +
> +	return count;
> +}
> +static BUS_ATTR(rescan, 0220, NULL, bus_rescan_store);

BUS_ATTR_RO()?



> +
> +static struct attribute *fsl_mc_bus_attrs[] = {
> +	&bus_attr_rescan.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group fsl_mc_bus_group = {
> +	.attrs = fsl_mc_bus_attrs,
> +};
> +
> +static const struct attribute_group *fsl_mc_bus_groups[] = {
> +	&fsl_mc_bus_group,
> +	NULL,
> +};

ATTRIBUTE_GROUPS()?

thanks,

greg k-h
