Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11499C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1038218D4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549628048;
	bh=qP83XybS46PolLD4mR6wOzQ+VPKMlcnmMAm+yAoi77Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qarfTeCc/FJQQpTQIBCu1nshs8eD+rFwRVFaXYoFw+RapKZyFgSBp6m7H8MMkzSLd
	 5LYZjc1Ytc1upsnIxG/SyrNPnOPq1LlOOSVvlC8ItJ8C4hONGnxioQwzP9e1M56GIf
	 UJgcL7wBYCGzZW9+TSGgCC17J/vgHdEmzV4szVvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfBHMOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfBHMOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:14:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF5572086C;
        Fri,  8 Feb 2019 12:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549628045;
        bh=qP83XybS46PolLD4mR6wOzQ+VPKMlcnmMAm+yAoi77Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TO4m0BwgyYN7zvSoPOil4fSl0k+2nxrgwGIqzMpxgOuVJpi2OxtK38AHbZv+EFs4n
         H+brCdN+nksra70hdzfrU1ECLyvEWFjAyByX5Gxcrhvm0xiIAOinAmGaLJN+xqZGx2
         +8/NSCjBbyRlIpjaaB2p50Lot+Y/LlJuSrSxT6FY=
Date:   Fri, 8 Feb 2019 13:14:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net, rppt@linux.ibm.com,
        ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: Re: [PATCH v3 09/15] habanalabs: add sysfs and hwmon support
Message-ID: <20190208121402.GB23483@kroah.com>
References: <20190204203254.4026-1-oded.gabbay@gmail.com>
 <20190204203254.4026-10-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204203254.4026-10-oded.gabbay@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:32:48PM +0200, Oded Gabbay wrote:
> This patch add the sysfs and hwmon entries that are exposed by the driver.
> 
> Goya has several sensors, from various categories such as temperature,
> voltage, current, etc. The driver exposes those sensors in the standard
> hwmon mechanism.
> 
> In addition, the driver exposes a couple of interfaces in sysfs, both for
> configuration and for providing status of the device or driver.
> 
> The configuration attributes is for Power Management:
> - Automatic or manual
> - Frequency value when moving to high frequency mode
> - Maximum power the device is allowed to consume
> 
> The rest of the attributes are read-only and provide the following
> information:
> - Versions of the various firmwares running on the device
> - Contents of the device's EEPROM
> - The device type (currently only Goya is supported)
> - PCI address of the device (to allow user-space to connect between
>   /dev/hlX to PCI address)
> - Status of the device (operational, malfunction, in_reset)
> - How many processes are open on the device's file
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  .../ABI/testing/sysfs-driver-habanalabs       | 190 ++++++
>  drivers/misc/habanalabs/Makefile              |   2 +-
>  drivers/misc/habanalabs/device.c              | 146 +++++
>  drivers/misc/habanalabs/goya/Makefile         |   2 +-
>  drivers/misc/habanalabs/goya/goya.c           | 230 +++++++
>  drivers/misc/habanalabs/goya/goyaP.h          |  21 +
>  drivers/misc/habanalabs/goya/goya_hwmgr.c     | 306 +++++++++
>  drivers/misc/habanalabs/habanalabs.h          | 101 +++
>  drivers/misc/habanalabs/habanalabs_drv.c      |   7 +
>  drivers/misc/habanalabs/hwmon.c               | 449 +++++++++++++
>  drivers/misc/habanalabs/sysfs.c               | 589 ++++++++++++++++++
>  11 files changed, 2041 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-habanalabs
>  create mode 100644 drivers/misc/habanalabs/goya/goya_hwmgr.c
>  create mode 100644 drivers/misc/habanalabs/hwmon.c
>  create mode 100644 drivers/misc/habanalabs/sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
> new file mode 100644
> index 000000000000..19edd4da87c1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
> @@ -0,0 +1,190 @@
> +What:           /sys/class/habanalabs/hl<n>/armcp_kernel_ver
> +Date:           Jan 2019
> +KernelVersion:  5.1
> +Contact:        oded.gabbay@gmail.com
> +Description:    Version of the Linux kernel running on the device's CPU

Hey, nice!  We can see how old that kernel gets over time :)

> +What:           /sys/class/habanalabs/hl<n>/soft_reset_cnt
> +Date:           Jan 2019
> +KernelVersion:  5.1
> +Contact:        oded.gabbay@gmail.com
> +Description:    Displays how many times the device have undergone a soft-reset
> +                operation

"how many times" since when?  Power on?  Kernel boot?  Driver load?

> +static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct hl_device *hdev = dev_get_drvdata(dev);
> +	long value;
> +
> +	if (hdev->disabled)
> +		return -ENODEV;
> +
> +	value = hl_get_frequency(hdev, MME_PLL, false);
> +
> +	if (value < 0)
> +		return value;
> +
> +	return snprintf(buf, PAGE_SIZE, "%lu\n", value);

Meta-comment.  You do this in all of your sysfs show functions, and I
understand the "I want to be safe!" feeling here, but you should just
use sprintf().  The size of a sysfs buffer is PAGE_SIZE, and you should
never even get close to it if you are only writing a single numeric
value.

So no need to do anything fancy, just use sprintf() please.

> +static DEVICE_ATTR_RW(mme_clk);
> +static DEVICE_ATTR_RW(tpc_clk);
> +static DEVICE_ATTR_RW(ic_clk);
> +static DEVICE_ATTR_RO(mme_clk_curr);
> +static DEVICE_ATTR_RO(tpc_clk_curr);
> +static DEVICE_ATTR_RO(ic_clk_curr);

Some people like to put the macro right under the show/store functions,
to keep them all in one place.  Makes it easier to change/add things
later over time.

> +int goya_add_device_attr(struct hl_device *hdev)
> +{
> +	int rc;
> +
> +	rc = device_create_file(hdev->dev, &dev_attr_mme_clk);
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to create device file mme_clk\n");
> +		return rc;
> +	}
> +
> +	rc = device_create_file(hdev->dev, &dev_attr_tpc_clk);
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to create device file tpc_clk\n");
> +		goto remove_mme_clk;
> +	}
> +
> +	rc = device_create_file(hdev->dev, &dev_attr_ic_clk);
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to create device file ic_clk\n");
> +		goto remove_tpc_clk;
> +	}
> +
> +	rc = device_create_file(hdev->dev, &dev_attr_mme_clk_curr);
> +	if (rc) {
> +		dev_err(hdev->dev,
> +			"failed to create device file mme_clk_curr\n");
> +		goto remove_ic_clk;
> +	}
> +
> +	rc = device_create_file(hdev->dev, &dev_attr_tpc_clk_curr);
> +	if (rc) {
> +		dev_err(hdev->dev,
> +			"failed to create device file tpc_clk_curr\n");
> +		goto remove_mme_clk_curr;
> +	}
> +
> +	rc = device_create_file(hdev->dev, &dev_attr_ic_clk_curr);
> +	if (rc) {
> +		dev_err(hdev->dev,
> +			"failed to create device file ic_clk_curr\n");
> +		goto remove_tpc_clk_curr;
> +	}


You do know about attribute groups, right?  Please use them so you don't
have to hand-roll the "add a bunch of files" logic here and elsewhere.
The driver core will just automatically add and remove all of the files
when the device is bound properly without you having to do anything.
That saves you a lot of code and debugging logic.

Same for your other lists of attributes, they can all be handled
automatically, no need for this type of logic.

thanks,

greg k-h
