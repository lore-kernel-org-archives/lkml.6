Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755443AbeDCLWz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:22:55 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:2764 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755121AbeDCLWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:22:54 -0400
X-IronPort-AV: E=Sophos;i="5.48,400,1517875200";
   d="scan'208";a="70964740"
Date: Tue, 3 Apr 2018 12:22:44 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: <xen-devel@lists.xen.org>, <linux-kernel@vger.kernel.org>,
        Bob Liu <bob.liu@oracle.com>,
        Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
Subject: Re: [PATCH v1] xen-blkfront: dynamic configuration of per-vbd
 resources
Message-ID: <20180403112244.vlg7j7ynxwkxwhs7@MacBook-Pro-de-Roger.local>
References: <20180402174232.28642-1-konrad.wilk@oracle.com>
 <20180402174232.28642-2-konrad.wilk@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180402174232.28642-2-konrad.wilk@oracle.com>
User-Agent: NeoMutt/20180323
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 01:42:32PM -0400, Konrad Rzeszutek Wilk wrote:
> From: Bob Liu <bob.liu@oracle.com>
> 
> The current VBD layer reserves buffer space for each attached device based on
> three statically configured settings which are read at boot time.
>  * max_indirect_segs: Maximum amount of segments.
>  * max_ring_page_order: Maximum order of pages to be used for the shared ring.
>  * max_queues: Maximum of queues(rings) to be used.
> 
> But the storage backend, workload, and guest memory result in very different
> tuning requirements. It's impossible to centrally predict application
> characteristics so it's best to leave allow the settings can be dynamiclly
> adjusted based on workload inside the Guest.
> 
> Usage:
> Show current values:
> cat /sys/devices/vbd-xxx/max_indirect_segs
> cat /sys/devices/vbd-xxx/max_ring_page_order
> cat /sys/devices/vbd-xxx/max_queues
> 
> Write new values:
> echo <new value> > /sys/devices/vbd-xxx/max_indirect_segs
> echo <new value> > /sys/devices/vbd-xxx/max_ring_page_order
> echo <new value> > /sys/devices/vbd-xxx/max_queues
> 
> Signed-off-by: Bob Liu <bob.liu@oracle.com>
> Signed-off-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  drivers/block/xen-blkfront.c | 320 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 304 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 92ec1bbece51..4ebd368f4d1a 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -46,6 +46,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/bitmap.h>
>  #include <linux/list.h>
> +#include <linux/delay.h>
>  
>  #include <xen/xen.h>
>  #include <xen/xenbus.h>
> @@ -217,6 +218,11 @@ struct blkfront_info
>  	/* Save uncomplete reqs and bios for migration. */
>  	struct list_head requests;
>  	struct bio_list bio_list;
> +	/* For dynamic configuration. */
> +	unsigned int reconfiguring:1;

bool reconfiguring:1 maybe?

And I would likely place it together with the feature_ fields, so that
no more padding is added to the struct.

> +	int new_max_indirect_segments;
> +	int new_max_ring_page_order;
> +	int new_max_queues;

All the ints should be unsigned ints AFAICT.

>  };
>  
>  static unsigned int nr_minors;
> @@ -1355,6 +1361,31 @@ static void blkif_free(struct blkfront_info *info, int suspend)
>  	for (i = 0; i < info->nr_rings; i++)
>  		blkif_free_ring(&info->rinfo[i]);
>  
> +	/* Remove old xenstore nodes. */
> +	if (info->nr_ring_pages > 1)
> +		xenbus_rm(XBT_NIL, info->xbdev->nodename, "ring-page-order");
> +
> +	if (info->nr_rings == 1) {
> +		if (info->nr_ring_pages == 1) {
> +			xenbus_rm(XBT_NIL, info->xbdev->nodename, "ring-ref");
> +		} else {
> +			for (i = 0; i < info->nr_ring_pages; i++) {
> +				char ring_ref_name[RINGREF_NAME_LEN];
> +
> +				snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
> +				xenbus_rm(XBT_NIL, info->xbdev->nodename, ring_ref_name);
> +			}
> +		}
> +	} else {
> +		xenbus_rm(XBT_NIL, info->xbdev->nodename, "multi-queue-num-queues");
> +
> +		for (i = 0; i < info->nr_rings; i++) {
> +			char queuename[QUEUE_NAME_LEN];
> +
> +			snprintf(queuename, QUEUE_NAME_LEN, "queue-%u", i);
> +			xenbus_rm(XBT_NIL, info->xbdev->nodename, queuename);
> +		}
> +	}
>  	kfree(info->rinfo);
>  	info->rinfo = NULL;
>  	info->nr_rings = 0;
> @@ -1778,10 +1809,18 @@ static int talk_to_blkback(struct xenbus_device *dev,
>  	if (!info)
>  		return -ENODEV;
>  
> -	max_page_order = xenbus_read_unsigned(info->xbdev->otherend,
> -					      "max-ring-page-order", 0);
> -	ring_page_order = min(xen_blkif_max_ring_order, max_page_order);
> -	info->nr_ring_pages = 1 << ring_page_order;
> +	err = xenbus_scanf(XBT_NIL, info->xbdev->otherend,
> +			   "max-ring-page-order", "%u", &max_page_order);
> +	if (err != 1)
> +		info->nr_ring_pages = 1;
> +	else {
> +		ring_page_order = min(xen_blkif_max_ring_order, max_page_order);
> +		if (info->new_max_ring_page_order) {
> +			BUG_ON(info->new_max_ring_page_order > max_page_order);
> +			ring_page_order = info->new_max_ring_page_order;
> +		}
> +		info->nr_ring_pages = 1 << ring_page_order;
> +	}

You could likely simply this as:

max_page_order = xenbus_read_unsigned(info->xbdev->otherend,
				      "max-ring-page-order", 0);
if ((info->new_max_ring_page_order) {
	BUG_ON(info->new_max_ring_page_order > max_page_order);
	info->nr_ring_pages = 1 << info->new_max_ring_page_order;
} else
	info->nr_ring_pages = 1 << min(xen_blkif_max_ring_order, max_page_order);

I'm not sure of the benefit of switching the xenbus_read_unsigned to a
xenbus_scanf. IMO it seems to make the code more complex.

>  
>  	err = negotiate_mq(info);
>  	if (err)
> @@ -1903,6 +1942,10 @@ static int negotiate_mq(struct blkfront_info *info)
>  	backend_max_queues = xenbus_read_unsigned(info->xbdev->otherend,
>  						  "multi-queue-max-queues", 1);
>  	info->nr_rings = min(backend_max_queues, xen_blkif_max_queues);
> +	if (info->new_max_queues) {
> +		BUG_ON(info->new_max_queues > backend_max_queues);
> +		info->nr_rings = info->new_max_queues;
> +	}
>  	/* We need at least one ring. */
>  	if (!info->nr_rings)
>  		info->nr_rings = 1;
> @@ -2261,6 +2304,8 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo)
>   */
>  static void blkfront_gather_backend_features(struct blkfront_info *info)
>  {
> +	int err;
> +	int persistent;

unsigned int. You use the '%u' format specifier below.

>  	unsigned int indirect_segments;
>  
>  	info->feature_flush = 0;
> @@ -2291,19 +2336,241 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
>  	if (xenbus_read_unsigned(info->xbdev->otherend, "feature-discard", 0))
>  		blkfront_setup_discard(info);
>  
> -	info->feature_persistent =
> -		!!xenbus_read_unsigned(info->xbdev->otherend,
> -				       "feature-persistent", 0);
> +	err = xenbus_gather(XBT_NIL, info->xbdev->otherend,
> +			"feature-persistent", "%u", &persistent,
> +			NULL);
> +
> +	info->feature_persistent = err ? 0 : persistent;
> +
> +	err = xenbus_gather(XBT_NIL, info->xbdev->otherend,
> +			    "feature-max-indirect-segments", "%u", &indirect_segments,
> +			    NULL);
> +	if (err)
> +		info->max_indirect_segments = 0;
> +	else {
> +		info->max_indirect_segments = min(indirect_segments,
> +						  xen_blkif_max_segments);
> +		if (info->new_max_indirect_segments) {
> +			BUG_ON(info->new_max_indirect_segments > indirect_segments);
> +			info->max_indirect_segments = info->new_max_indirect_segments;
> +		}
> +	}

Again I think using xenbus_read_unsigned makes the code simpler, see
the suggestion regarding new_max_ring_page_order.

> +}
> +
> +static ssize_t max_ring_page_order_show(struct device *dev,
> +					struct device_attribute *attr, char *page)
> +{
> +	struct blkfront_info *info = dev_get_drvdata(dev);
> +
> +	return sprintf(page, "%u\n", get_order(info->nr_ring_pages * XEN_PAGE_SIZE));
> +}
> +
> +static ssize_t max_indirect_segs_show(struct device *dev,
> +				      struct device_attribute *attr, char *page)
> +{
> +	struct blkfront_info *info = dev_get_drvdata(dev);
> +
> +	return sprintf(page, "%u\n", info->max_indirect_segments);
> +}
> +
> +static ssize_t max_queues_show(struct device *dev,
> +			       struct device_attribute *attr, char *page)
> +{
> +	struct blkfront_info *info = dev_get_drvdata(dev);
> +
> +	return sprintf(page, "%u\n", info->nr_rings);
> +}
> +
> +static ssize_t dynamic_reconfig_device(struct blkfront_info *info, ssize_t count)

Not sure you need to pass 'count' here. dynamic_reconfig_device
doesn't care about count at all. This function should just return < 0
for error or 0 on success.

> +{
> +	unsigned int i;
> +	int err = -EBUSY;
> +	unsigned int inflight;
> +
> +	/*
> +	 * Make sure no migration in parallel, device lock is actually a
> +	 * mutex.
> +	 */
> +	if (!device_trylock(&info->xbdev->dev)) {
> +		pr_err("Fail to acquire dev:%s lock, may be in migration.\n",
> +			dev_name(&info->xbdev->dev));
> +		return err;
> +	}
> +
> +	/*
> +	 * Prevent new requests and guarantee no uncompleted reqs.
> +	 */
> +	blk_mq_freeze_queue(info->rq);
> +	inflight = atomic_read(&info->gd->part0.in_flight[0]) +
> +		   atomic_read(&info->gd->part0.in_flight[1]);
> +	if (inflight)
> +		goto out;

Er, I'm not sure I like this approach. Why not just switch the state
to closed, wait for the backend to also switch to closed, reconnect
and then requeue any pending requests on the shadow copy of the ring?

Basically like what is currently done for migration.

> +
> +	/*
> +	 * Front 				Backend
> +	 * Switch to XenbusStateClosed
> +	 *					frontend_changed():
> +	 *					 case XenbusStateClosed:
> +	 *						xen_blkif_disconnect()
> +	 *						Switch to XenbusStateClosed
> +	 * blkfront_resume():
> +	 *					frontend_changed():
> +	 *						reconnect
> +	 * Wait until XenbusStateConnected
> +	 */
> +	info->reconfiguring = true;
> +	xenbus_switch_state(info->xbdev, XenbusStateClosed);
> +
> +	/* Poll every 100ms, 1 minute timeout. */
> +	for (i = 0; i < 600; i++) {
> +		/*
> +		 * Wait backend enter XenbusStateClosed, blkback_changed()
> +		 * will clear reconfiguring.
> +		 */
> +		if (!info->reconfiguring)
> +			goto resume;
> +		schedule_timeout_interruptible(msecs_to_jiffies(100));
> +	}
> +	goto out;

This shouldn't be done with a busy loop. Why not do this in
blkback_changed instead?

> +
> +resume:
> +	if (blkfront_resume(info->xbdev))
> +		goto out;
> +
> +	/* Poll every 100ms, 1 minute timeout. */
> +	for (i = 0; i < 600; i++) {
> +		/* Wait blkfront enter StateConnected which is done by blkif_recover(). */
> +		if (info->xbdev->state == XenbusStateConnected) {
> +			err = count;
> +			goto out;
> +		}
> +		schedule_timeout_interruptible(msecs_to_jiffies(100));
> +	}
> +
> +out:
> +	blk_mq_unfreeze_queue(info->rq);
> +	device_unlock(&info->xbdev->dev);
> +
> +	return err;
> +}
> +
> +static ssize_t max_indirect_segs_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	ssize_t ret;
> +	unsigned int max_segs = 0, backend_max_segs = 0;
> +	struct blkfront_info *info = dev_get_drvdata(dev);
> +	int err;
> +
> +	ret = kstrtouint(buf, 10, &max_segs);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (max_segs == info->max_indirect_segments)
> +		return count;
> +
> +	err = xenbus_gather(XBT_NIL, info->xbdev->otherend,
> +			    "feature-max-indirect-segments", "%u", &backend_max_segs,

Having to read all the backend features every time the user writes to
the device nodes seems inefficient, although I assume this is not
supposed to happen frequently...

> +			    NULL);
> +	if (err) {
> +		pr_err("Backend %s doesn't support feature-indirect-segments.\n",
> +			info->xbdev->otherend);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (max_segs > backend_max_segs) {
> +		pr_err("Invalid max indirect segment (%u), backend-max: %u.\n",
> +			max_segs, backend_max_segs);
> +		return -EINVAL;
> +	}
>  
> -	indirect_segments = xenbus_read_unsigned(info->xbdev->otherend,
> -					"feature-max-indirect-segments", 0);
> -	if (indirect_segments > xen_blkif_max_segments)
> -		indirect_segments = xen_blkif_max_segments;
> -	if (indirect_segments <= BLKIF_MAX_SEGMENTS_PER_REQUEST)
> -		indirect_segments = 0;
> -	info->max_indirect_segments = indirect_segments;
> +	info->new_max_indirect_segments = max_segs;
> +
> +	return dynamic_reconfig_device(info, count);

No need to pass count, just use:

return dynamic_reconfig_device(info) :? count;

(same for all the cases below).

>  }
>  
> +static ssize_t max_ring_page_order_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	ssize_t ret;
> +	unsigned int max_order = 0, backend_max_order = 0;
> +	struct blkfront_info *info = dev_get_drvdata(dev);
> +	int err;
> +
> +	ret = kstrtouint(buf, 10, &max_order);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((1 << max_order) == info->nr_ring_pages)
> +		return count;
> +
> +	if (max_order > XENBUS_MAX_RING_GRANT_ORDER) {
> +		pr_err("Invalid max_ring_page_order (%u), max: %u.\n",
> +			max_order, XENBUS_MAX_RING_GRANT_ORDER);
> +		return -EINVAL;
> +	}
> +
> +	err = xenbus_scanf(XBT_NIL, info->xbdev->otherend,
> +			   "max-ring-page-order", "%u", &backend_max_order);
> +	if (err != 1) {
> +		pr_err("Backend %s doesn't support feature multi-page-ring.\n",
> +			info->xbdev->otherend);
> +		return -EOPNOTSUPP;
> +	}
> +	if (max_order > backend_max_order) {
> +		pr_err("Invalid max_ring_page_order (%u), backend supports max: %u.\n",
> +			max_order, backend_max_order);
> +		return -EINVAL;
> +	}
> +	info->new_max_ring_page_order = max_order;
> +
> +	return dynamic_reconfig_device(info, count);
> +}
> +
> +static ssize_t max_queues_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	ssize_t ret;
> +	unsigned int max_queues = 0, backend_max_queues = 0;
> +	struct blkfront_info *info = dev_get_drvdata(dev);
> +	int err;
> +
> +	ret = kstrtouint(buf, 10, &max_queues);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (max_queues == info->nr_rings)
> +		return count;
> +
> +	if (max_queues > num_online_cpus()) {
> +		pr_err("Invalid max_queues (%u), can't bigger than online cpus: %u.\n",
> +			max_queues, num_online_cpus());
> +		return -EINVAL;
> +	}
> +
> +	err = xenbus_scanf(XBT_NIL, info->xbdev->otherend,
> +			   "multi-queue-max-queues", "%u", &backend_max_queues);
> +	if (err != 1) {
> +		pr_err("Backend %s doesn't support block multi queue.\n",
> +			info->xbdev->otherend);
> +		return -EOPNOTSUPP;
> +	}
> +	if (max_queues > backend_max_queues) {
> +		pr_err("Invalid max_queues (%u), backend supports max: %u.\n",
> +			max_queues, backend_max_queues);
> +		return -EINVAL;
> +	}
> +	info->new_max_queues = max_queues;
> +
> +	return dynamic_reconfig_device(info, count);
> +}
> +
> +static DEVICE_ATTR_RW(max_queues);
> +static DEVICE_ATTR_RW(max_ring_page_order);
> +static DEVICE_ATTR_RW(max_indirect_segs);

Can't you just use the same attribute for all the nodes? Also this
could be:

const static DEVICE_ATTR_RW(node_attr);

Thanks, Roger.
