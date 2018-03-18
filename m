Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755040AbeCRWtW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:49:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36783 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754931AbeCRWtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:49:15 -0400
X-Google-Smtp-Source: AG47ELsvDMYFY5IHd+IHd3buJE7hqpWCwyn6VWYUxTQYtzC0KeIiqQKcRJwRv6mrp7w0rkd/4WFnFQ==
Date: Sun, 18 Mar 2018 15:49:16 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Wendy Liang <wendy.liang@xilinx.com>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wendy Liang <jliang@xilinx.com>
Subject: Re: [RFC] rpmsg: virtio rpmsg: Add RPMsg char driver support
Message-ID: <20180318224916.GM5626@tuxbook-pro>
References: <1515107908-5351-1-git-send-email-jliang@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515107908-5351-1-git-send-email-jliang@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04 Jan 15:18 PST 2018, Wendy Liang wrote:

> virtio rpmsg was not implemented to use RPMsg char driver.
> Each virtio ns announcement will create a new RPMsg device which
> is supposed to bound to a RPMsg driver. It doesn't support
> dynamic endpoints with name service per RPMsg device.
> With RPMsg char driver, you can have multiple endpoints per
> RPMsg device.
> 
> Here is the change from this patch:
> * Introduce a macro to indicate if want to use RPMsg char driver
>   for virtio RPMsg. The RPMsg device can either be bounded to
>   a simple RPMsg driver or the RPMsg char driver.
> * Create Virtio RPMsg char device when the virtio RPMsg driver is
>   probed.
> * when there is a remote service announced, keep it in the virtio
>   proc remote services list.
> * when there is an endpoint created, bind it to a remote service
>   from the remote services list. If the service doesn't exist yet,
>   create one and mark the service address as ANY.

I think it would be preferable to split this patch up in one that adds
client support and then one that adds service support - in particular
since the latter isn't something we support in Linux today.

> 
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> ---
> We have different userspace applications to use RPMsg differently,
> what we need is a RPMsg char driver which can supports multiple
> endpoints per remote device.
> The virtio rpmsg driver at the moment doesn't support the RPMsg
> char driver.
> Please advise if this is patch is the right direction. If not,
> any suggestions? Thanks
> ---
>  drivers/rpmsg/Kconfig            |   8 +
>  drivers/rpmsg/virtio_rpmsg_bus.c | 364 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 365 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index 65a9f6b..746f07e 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -52,4 +52,12 @@ config RPMSG_VIRTIO
>  	select RPMSG
>  	select VIRTIO
>  
> +config RPMSG_VIRTIO_CHAR
> +	bool "Enable Virtio RPMSG char device driver support"
> +	default y

Please don't "default" anything.

> +	depends on RPMSG_VIRTIO
> +	depends on RPMSG_CHAR
> +	help
> +	  Say y here to enable to use RPMSG char device interface.
> +

Rather than sprinkling the entire implementation with conditionals on
RPMSG_VIRTIO_CHAR I think we should just add this code unconditionally
and rely on RPMSG_CHAR to make it functional or not.

>  endmenu
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
[..]
> +#ifdef CONFIG_RPMSG_VIRTIO_CHAR
> +/**
> + * virtio_rpmsg_find_rsvc_by_name - find the announced remote service
> + * @vrp: virtio remote proc information
> + * @name: remote service name
> + *
> + * The caller is supposed to have mutex lock before calling this function
> + *
> + * return NULL if no remote service has been found, otherwise, return
> + * the remote service pointer.

This should be "Return: NULL if no..."

And more succinct "Return: reference to found service, NULL otherwise"

> + */
> +static struct virtio_rpmsg_rsvc *
> +virtio_rpmsg_find_rsvc_by_name(struct virtproc_info *vrp, char *name)
> +{
> +	struct virtio_rpmsg_rsvc *rsvc;
> +
> +	list_for_each_entry(rsvc, &vrp->rsvcs, node) {
> +		if (!strncmp(rsvc->name, name, RPMSG_NAME_SIZE))
> +			/* remote service has found */
> +			return rsvc;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * virtio_rpmsg_create_rsvc_by_name - create remote service
> + * @vrp: virtio remote proc information
> + * @name: remote service name
> + *
> + * The caller is supposed to have mutex lock before calling this function
> + *
> + * return NULL if remote service creation failed. otherwise, return
> + * the remote service pointer.
> + */
> +static struct virtio_rpmsg_rsvc *
> +virtio_rpmsg_create_rsvc_by_name(struct virtproc_info *vrp, char *name)
> +{
> +	struct virtio_rpmsg_rsvc *rsvc;
> +
> +	rsvc = virtio_rpmsg_find_rsvc_by_name(vrp, name);
> +	if (rsvc)
> +		return rsvc;
> +	rsvc = kzalloc(sizeof(*rsvc), GFP_KERNEL);
> +	if (!rsvc)
> +		return NULL;
> +	strncpy(rsvc->name, name, RPMSG_NAME_SIZE);
> +	list_add_tail(&rsvc->node, &vrp->rsvcs);
> +	return rsvc;
> +}
> +
> +/**
> + * virtio_rpmsg_remove_rsvc_by_name - remove remote service
> + * @vrp: virtio remote proc information
> + * @name: remote service name
> + *
> + */
> +static void
> +virtio_rpmsg_remove_rsvc_by_name(struct virtproc_info *vrp, char *name)
> +{
> +	struct virtio_rpmsg_rsvc *rsvc;
> +	struct rpmsg_endpoint *ept;
> +	struct virtio_rpmsg_ept *vept;
> +
> +	mutex_lock(&vrp->endpoints_lock);
> +	list_for_each_entry(rsvc, &vrp->rsvcs, node) {
> +		if (!strncmp(rsvc->name, name, RPMSG_NAME_SIZE)) {
> +			/* remote service has found, no need to
> +			 * create
> +			 */
> +			ept = rsvc->ept;
> +			if (ept) {
> +				vept = to_virtio_rpmsg_ept(ept);
> +				vept->rsvc = NULL;
> +			}
> +			list_del(&rsvc->node);
> +			kfree(rsvc);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&vrp->endpoints_lock);
> +}
> +
> +/**
> + * virtio_rpmsg_create_rsvc - create remote service with channel information
> + * @vrp: virtio remote proc information
> + * @chinfo: channel information
> + *
> + * return remote service pointer if it is successfully created; otherwise,
> + * return NULL.
> + */
> +static struct virtio_rpmsg_rsvc *
> +virtio_rpmsg_create_rsvc(struct virtproc_info *vrp,
> +			 struct rpmsg_channel_info *chinfo)
> +{
> +	struct virtio_rpmsg_rsvc *rsvc;
> +
> +	mutex_lock(&vrp->endpoints_lock);
> +	rsvc = virtio_rpmsg_create_rsvc_by_name(vrp, chinfo->name);
> +	if (rsvc) {
> +		struct virtio_device *vdev = vrp->vdev;
> +
> +		rsvc->addr = chinfo->dst;
> +		dev_info(&vdev->dev, "Remote has announced service %s, %d.\n",
> +			 chinfo->name, rsvc->addr);
> +	}
> +	mutex_unlock(&vrp->endpoints_lock);
> +	return rsvc;
> +}
> +
> +/**
> + * virtio_rpmsg_announce_ept_create - announce endpoint has been created
> + * @ept: RPMsg endpoint
> + *
> + * return 0 if succeeded, otherwise, return error code.
> + */
> +static int virtio_rpmsg_announce_ept_create(struct rpmsg_endpoint *ept)

As described above, move this to a separate patch - as this not only
adds rpmsg_char integration but support for local services.

> +{
> +	struct virtio_rpmsg_ept *vept = to_virtio_rpmsg_ept(ept);
> +	struct virtio_rpmsg_rsvc *rsvc = vept->rsvc;
> +	struct rpmsg_device *rpdev = ept->rpdev;
> +	struct virtio_rpmsg_channel *vch;
> +	struct virtproc_info *vrp;
> +	struct device *dev;
> +	int err = 0;
> +
> +	if (!rpdev)

Is it really possible to get here without ept->rpdev being assigned?

> +		/* If the endpoint is not connected to a RPMsg device,
> +		 * no need to send the announcement.
> +		 */
> +		return 0;
> +	vch = to_virtio_rpmsg_channel(rpdev);
> +	vrp = vch->vrp;
> +	dev = &ept->rpdev->dev;
> +	/* need to tell remote processor's name service about this channel ? */
> +	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {

Flip this around:

if (!has_feature(X))
	return;

...

> +		struct rpmsg_ns_msg nsm;
> +
> +		strncpy(nsm.name, rsvc->name, RPMSG_NAME_SIZE);
> +		nsm.addr = ept->addr;
> +		nsm.flags = RPMSG_NS_CREATE;
> +
> +		err = rpmsg_sendto(ept, &nsm, sizeof(nsm),
> +				   RPMSG_NS_ADDR);
> +		if (err)
> +			dev_err(dev, "failed to announce service %d\n", err);
> +	}
> +
> +	return err;
> +}
> +
> +/**
> + * virtio_rpmsg_announce_ept_destroy - announce endpoint has been destroyed
> + * @ept: RPMsg endpoint
> + *
> + * return 0 if succeeded, otherwise, return error code.
> + */
> +static int virtio_rpmsg_announce_ept_destroy(struct rpmsg_endpoint *ept)
> +{
> +	struct virtio_rpmsg_ept *vept = to_virtio_rpmsg_ept(ept);
> +	struct virtio_rpmsg_rsvc *rsvc = vept->rsvc;
> +	struct rpmsg_device *rpdev = ept->rpdev;
> +	struct virtio_rpmsg_channel *vch;
> +	struct virtproc_info *vrp;
> +	struct device *dev;
> +	int err = 0;
> +
> +	if (!rpdev)

This is only called inside a if (ept->rpdev) region, so no need to spend
5 lines on this...

> +		/* If the endpoint is not connected to a RPMsg device,
> +		 * no need to send the announcement.
> +		 */
> +		return 0;
> +	vch = to_virtio_rpmsg_channel(rpdev);
> +	vrp = vch->vrp;
> +	dev = &ept->rpdev->dev;
> +	/* tell remote processor's name service we're removing this channel */
> +	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
> +		struct rpmsg_ns_msg nsm;
> +
> +		strncpy(nsm.name, rsvc->name, RPMSG_NAME_SIZE);
> +		nsm.addr = ept->addr;
> +		nsm.flags = RPMSG_NS_DESTROY;
> +
> +		err = rpmsg_sendto(ept, &nsm, sizeof(nsm),
> +				   RPMSG_NS_ADDR);
> +		if (err)
> +			dev_err(dev, "failed to announce service %d\n", err);
> +	}
> +
> +	return err;
> +}
> +#endif
> +
>  /**
>   * __ept_release() - deallocate an rpmsg endpoint
>   * @kref: the ept's reference count
> @@ -229,26 +456,53 @@ static void __ept_release(struct kref *kref)
>  {
>  	struct rpmsg_endpoint *ept = container_of(kref, struct rpmsg_endpoint,
>  						  refcount);
> +#ifdef CONFIG_RPMSG_VIRTIO_CHAR
> +	struct virtio_rpmsg_ept *vept = to_virtio_rpmsg_ept(ept);
> +	struct virtio_rpmsg_channel *vch;
> +	struct virtproc_info *vrp;
> +
> +	if (ept->rpdev) {
> +		vch = to_virtio_rpmsg_channel(ept->rpdev);
> +		vrp = vch->vrp;
> +		(void)virtio_rpmsg_announce_ept_destroy(ept);
> +		mutex_lock(&vrp->endpoints_lock);
> +		vept->rsvc->ept = NULL;
> +		mutex_unlock(&vrp->endpoints_lock);
> +	}
> +	kfree(vept);
> +#else
>  	/*
>  	 * At this point no one holds a reference to ept anymore,
>  	 * so we can directly free it
>  	 */
>  	kfree(ept);
> +#endif
>  }
>  
>  /* for more info, see below documentation of rpmsg_create_ept() */
>  static struct rpmsg_endpoint *__rpmsg_create_ept(struct virtproc_info *vrp,
>  						 struct rpmsg_device *rpdev,
>  						 rpmsg_rx_cb_t cb,
> -						 void *priv, u32 addr)
> +						 void *priv,
> +						 struct rpmsg_channel_info *ch)
>  {
>  	int id_min, id_max, id;
>  	struct rpmsg_endpoint *ept;
> +	u32 addr = ch->src;
>  	struct device *dev = rpdev ? &rpdev->dev : &vrp->vdev->dev;
> +#ifdef CONFIG_RPMSG_VIRTIO_CHAR
> +	struct virtio_rpmsg_ept *vept;
> +	struct virtio_rpmsg_rsvc *rsvc;
>  
> +	vept = kzalloc(sizeof(*vept), GFP_KERNEL);
> +	if (!vept)
> +		return NULL;
> +	ept = &vept->ept;
> +#else
>  	ept = kzalloc(sizeof(*ept), GFP_KERNEL);
>  	if (!ept)
>  		return NULL;
> +#endif
>  
>  	kref_init(&ept->refcount);
>  	mutex_init(&ept->cb_lock);
> @@ -259,7 +513,7 @@ static struct rpmsg_endpoint *__rpmsg_create_ept(struct virtproc_info *vrp,
>  	ept->ops = &virtio_endpoint_ops;
>  
>  	/* do we need to allocate a local address ? */
> -	if (addr == RPMSG_ADDR_ANY) {
> +	if (ch->src == RPMSG_ADDR_ANY) {
>  		id_min = RPMSG_RESERVED_ADDRESSES;
>  		id_max = 0;
>  	} else {
> @@ -277,6 +531,19 @@ static struct rpmsg_endpoint *__rpmsg_create_ept(struct virtproc_info *vrp,
>  	}
>  	ept->addr = id;
>  
> +#ifdef CONFIG_RPMSG_VIRTIO_CHAR
> +	if (ept->addr != RPMSG_NS_ADDR) {
> +		rsvc = virtio_rpmsg_create_rsvc_by_name(vrp, ch->name);

Afaict for client endpoints this will never create a new service, just
return the old one so that the vept can be linked to the rsvc. But I
fail to see why the vept needs to be tied to the rsvc.

The only case where it seems to be used is in order to access the addr
of the rsvc because the ept value isn't trusted, but this seems wrong.

> +		if (!rsvc)
> +			goto free_ept;
> +		vept->rsvc = rsvc;
> +		rsvc->ept = ept;
> +		dev_info(&vrp->vdev->dev, "RPMsg ept created, %s:%d,%d.\n",
> +			 ch->name, ept->addr, rsvc->addr);
> +		(void)virtio_rpmsg_announce_ept_create(ept);

Won't this announce back channels that was announced to us by the
remote?


Also, if your only caller to a function has to explicitly discard the
returned value (void), then just make the function void.

> +	}
> +#endif
> +
>  	mutex_unlock(&vrp->endpoints_lock);
>  
>  	return ept;
> @@ -294,7 +561,7 @@ static struct rpmsg_endpoint *virtio_rpmsg_create_ept(struct rpmsg_device *rpdev
>  {
>  	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>  
> -	return __rpmsg_create_ept(vch->vrp, rpdev, cb, priv, chinfo.src);
> +	return __rpmsg_create_ept(vch->vrp, rpdev, cb, priv, &chinfo);
>  }
>  
>  /**
> @@ -392,6 +659,7 @@ static void virtio_rpmsg_release_device(struct device *dev)
>  	kfree(vch);
>  }
>  
> +#ifndef CONFIG_RPMSG_VIRTIO_CHAR
>  /*
>   * create an rpmsg channel using its name and address info.
>   * this function will be used to create both static and dynamic
> @@ -444,6 +712,7 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
>  
>  	return rpdev;
>  }
> +#endif
>  
>  /* super simple buffer "allocator" that is just enough for now */
>  static void *get_a_tx_buf(struct virtproc_info *vrp)
> @@ -660,8 +929,21 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
>  static int virtio_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
>  {
>  	struct rpmsg_device *rpdev = ept->rpdev;
> -	u32 src = ept->addr, dst = rpdev->dst;
> +	u32 src = ept->addr;
> +#ifdef CONFIG_RPMSG_VIRTIO_CHAR
> +	struct virtio_rpmsg_ept *vept = to_virtio_rpmsg_ept(ept);
> +	u32 dst = vept->rsvc->addr;

Why will vept->rsvc->addr != rpdev->dst ?

> +
> +	if (dst == RPMSG_ADDR_ANY)
> +		return -EPIPE;
> +#else
> +	u32 dst = rpdev->dst;
> +#endif
>  
> +	if (!rpdev) {
> +		pr_err("%s, ept %p rpdev is NULL\n", __func__, ept);
> +		return -EINVAL;
> +	}
>  	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
>  }
>  
> @@ -685,7 +967,16 @@ static int virtio_rpmsg_send_offchannel(struct rpmsg_endpoint *ept, u32 src,
>  static int virtio_rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len)
>  {
>  	struct rpmsg_device *rpdev = ept->rpdev;
> -	u32 src = ept->addr, dst = rpdev->dst;
> +	u32 src = ept->addr;
> +#ifdef CONFIG_RPMSG_VIRTIO_CHAR
> +	struct virtio_rpmsg_ept *vept = to_virtio_rpmsg_ept(ept);
> +	u32 dst = vept->rsvc->addr;
> +
> +	if (dst == RPMSG_ADDR_ANY)
> +		return -EPIPE;
> +#else
> +	u32 dst = rpdev->dst;
> +#endif
>  
>  	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
>  }
> @@ -824,11 +1115,13 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
>  		       void *priv, u32 src)
>  {
>  	struct rpmsg_ns_msg *msg = data;
> -	struct rpmsg_device *newch;
>  	struct rpmsg_channel_info chinfo;
>  	struct virtproc_info *vrp = priv;
>  	struct device *dev = &vrp->vdev->dev;
> +#ifndef CONFIG_RPMSG_VIRTIO_CHAR
> +	struct rpmsg_device *newch;
>  	int ret;
> +#endif
>  
>  #if defined(CONFIG_DYNAMIC_DEBUG)
>  	dynamic_hex_dump("NS announcement: ", DUMP_PREFIX_NONE, 16, 1,
> @@ -863,13 +1156,25 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
>  	chinfo.dst = msg->addr;
>  
>  	if (msg->flags & RPMSG_NS_DESTROY) {
> +#ifdef CONFIG_RPMSG_VIRTIO_CHAR
> +		virtio_rpmsg_remove_rsvc_by_name(vrp, chinfo.name);
> +#else
>  		ret = rpmsg_unregister_device(&vrp->vdev->dev, &chinfo);
>  		if (ret)
>  			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
> +#endif
>  	} else {
> +#ifdef CONFIG_RPMSG_VIRTIO_CHAR
> +		struct virtio_rpmsg_rsvc *rsvc;
> +
> +		rsvc = virtio_rpmsg_create_rsvc(vrp, &chinfo);
> +		if (!rsvc)
> +			dev_err(dev, "virtio_rpmsg_create_rsvc failed\n");
> +#else
>  		newch = rpmsg_create_channel(vrp, &chinfo);
>  		if (!newch)
>  			dev_err(dev, "rpmsg_create_channel failed\n");

We most definitely want to rpmsg_create_channel() for newly announced
channels, otherwise you're disabling support for in-kernel rpmsg
devices.

The expectation is that you rpmsg_create_channel() which will attempt to
probe a kernel driver and if none is found it's left dangling and
rpmsg_char can open it. (or if the kernel driver is unbound)

[..]
> +#ifdef CONFIG_RPMSG_VIRTIO_CHAR
> +	vch = kzalloc(sizeof(*vch), GFP_KERNEL);
> +	if (!vch) {
> +		err = -ENOMEM;
> +		goto free_coherent;
> +	}
> +
> +	/* Link the channel to our vrp */
> +	vch->vrp = vrp;
> +	/* Initialize remote services list */
> +	INIT_LIST_HEAD(&vrp->rsvcs);
> +
> +	/* Assign public information to the rpmsg_device */
> +	rp_char_dev = &vch->rpdev;
> +	rp_char_dev->ops = &virtio_rpmsg_ops;
> +
> +	rp_char_dev->dev.parent = &vrp->vdev->dev;
> +	rp_char_dev->dev.release = virtio_rpmsg_release_device;
> +	err = rpmsg_chrdev_register_device(rp_char_dev);
> +	if (err) {
> +		kfree(vch);
> +		goto free_coherent;
> +	}

Break this out into its own helper function.

> +	dev_info(&vdev->dev, "Registered as RPMsg char device.\n");

Please don't spam the logs, use dev_dbg().

> +#endif
> +

Regards,
Bjorn
