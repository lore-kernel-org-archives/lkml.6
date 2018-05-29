Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966492AbeE2Tmt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:42:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965980AbeE2Tmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:42:47 -0400
Date: Tue, 29 May 2018 13:42:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, kvm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vfio: platform: Fix using devices in PM Domains
Message-ID: <20180529134244.40f7f6f4@w520.home>
In-Reply-To: <8bcadbb5-064c-0ad2-30a2-4aeec6253dd1@redhat.com>
References: <1527614128-30196-1-git-send-email-geert+renesas@glider.be>
        <8bcadbb5-064c-0ad2-30a2-4aeec6253dd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 21:06:08 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi,
> On 05/29/2018 07:15 PM, Geert Uytterhoeven wrote:
> > If a device is part of a PM Domain (e.g. power and/or clock domain), its
> > power state is managed using Runtime PM.  Without Runtime PM, the device
> > may not be powered up or clocked, causing subtle failures, crashes, or
> > system lock-ups when the device is accessed by the guest.
> > 
> > Fix this by adding Runtime PM support, powering the device when the VFIO
> > device is opened by the guest.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>  
> Acked-by: Eric Auger <eric.auger@redhat.com>

Looks ok to me too, applied with Eric's ack to vfio next branch for
v4.18.  Thanks,

Alex

> > ---
> > Against linux-vfio/next
> > 
> > v4:
> >   - Keep device powered while issuing reset,
> > 
> > v3:
> >   - Drop controversial note about unsafeness of exporting fine-grained
> >     power management from host to guest,
> > 
> > v2:
> >   - Improve wording,
> >   - Add Reviewed-by.
> > ---
> >  drivers/vfio/platform/vfio_platform_common.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> > index b60bb5326668498c..c0cd824be2b767be 100644
> > --- a/drivers/vfio/platform/vfio_platform_common.c
> > +++ b/drivers/vfio/platform/vfio_platform_common.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> >  #include <linux/uaccess.h>
> > @@ -239,6 +240,7 @@ static void vfio_platform_release(void *device_data)
> >  				 ret, extra_dbg ? extra_dbg : "");
> >  			WARN_ON(1);
> >  		}
> > +		pm_runtime_put(vdev->device);
> >  		vfio_platform_regions_cleanup(vdev);
> >  		vfio_platform_irq_cleanup(vdev);
> >  	}
> > @@ -269,6 +271,10 @@ static int vfio_platform_open(void *device_data)
> >  		if (ret)
> >  			goto err_irq;
> >  
> > +		ret = pm_runtime_get_sync(vdev->device);
> > +		if (ret < 0)
> > +			goto err_pm;
> > +
> >  		ret = vfio_platform_call_reset(vdev, &extra_dbg);
> >  		if (ret && vdev->reset_required) {
> >  			dev_warn(vdev->device, "reset driver is required and reset call failed in open (%d) %s\n",
> > @@ -283,6 +289,8 @@ static int vfio_platform_open(void *device_data)
> >  	return 0;
> >  
> >  err_rst:
> > +	pm_runtime_put(vdev->device);
> > +err_pm:
> >  	vfio_platform_irq_cleanup(vdev);
> >  err_irq:
> >  	vfio_platform_regions_cleanup(vdev);
> > @@ -690,6 +698,7 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
> >  
> >  	mutex_init(&vdev->igate);
> >  
> > +	pm_runtime_enable(vdev->device);
> >  	return 0;
> >  
> >  put_iommu:
> > @@ -707,6 +716,7 @@ struct vfio_platform_device *vfio_platform_remove_common(struct device *dev)
> >  	vdev = vfio_del_group_dev(dev);
> >  
> >  	if (vdev) {
> > +		pm_runtime_disable(vdev->device);
> >  		vfio_platform_put_reset(vdev);
> >  		vfio_iommu_group_put(dev->iommu_group, dev);
> >  	}
> >   
