Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0BFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94112083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kPCkBciE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94112083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeHaM7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:59:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46677 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbeHaM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:59:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id k14-v6so8471468edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MTt1+2U2E0DdTUssUEn7ADuHjHd36PiEQAsVOv/n1mg=;
        b=kPCkBciEVsz9fwqm8SHFoduQxFXg29Qu4msOfhImJY5fKEu2QspukJAoFlfdqiYPTi
         fhxJNZVWcUt27SjuUoIPZChIZGJD51Riu0Mb3yjF9bdUPLnRDFZq23uHv0Vo4aKr8Zi+
         sX9WE82ymbLelXz4HGljgmV5lFrVEgRF/1oeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=MTt1+2U2E0DdTUssUEn7ADuHjHd36PiEQAsVOv/n1mg=;
        b=OGGbFC9mT/eZa1FF9fUdoq+szczdXJNS0lzrXIz0I9F3K5mhawwurPFWXZCU2cygHa
         5nSgU2CzR13mnq99G/G8BaiiNX6uPyzBFuw6TKrPngdwfqBifpoNfvgSe7hC/3sly3mp
         nqqGgGkbVaAjeBe4U6WTpCk+jXSrI865dLdeTcxvpHywku8XAiYwDd189KPNRS79S7/b
         zJwgL8dWa9EmROIyVBXeD02zSYa+o66c3ZYblJNGf+1S1W8E4KfKyJ7M9JbPpiDB9oq5
         ucNgYjpT52LVRAhua/n+3hHBVTDuUPDKQPRHp/m9GGRGBxLfDM2k5MITeMVTA+GakTU4
         WkXQ==
X-Gm-Message-State: APzg51CoN7BdN9+9Vw3DBkqr5j7kj3ya0rxMt1vugHA7vxXAHtyvtYz1
        cetzzxlOTJKdyJpqDLITGOi66w==
X-Google-Smtp-Source: ANB0VdZgPW8UM/rDYy3JHcz/pmrXEctbY8yuuthbzf3ygpiLnuhqSdp4QprrMeNQK7x54yvZzH454g==
X-Received: by 2002:a50:a402:: with SMTP id u2-v6mr16372581edb.237.1535705600465;
        Fri, 31 Aug 2018 01:53:20 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id z19-v6sm4967342edd.77.2018.08.31.01.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 01:53:19 -0700 (PDT)
Date:   Fri, 31 Aug 2018 10:53:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 1/4] drm/debugfs: Add support for dynamic debugfs
 initialization
Message-ID: <20180831085317.GQ21634@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>
References: <20180828003635.8200-1-lyude@redhat.com>
 <20180828003635.8200-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828003635.8200-2-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:36:24PM -0400, Lyude Paul wrote:
> Currently all debugfs related initialization for the DRM core happens in
> drm_debugfs_init(), which is called when registering the minor device.
> While this works fine for features such as atomic modesetting and GEM,
> this doesn't work at all for resources like DP MST topology managers
> which can potentially be created both before and after the minor
> device has been registered.
> 
> So, in order to add driver-wide debugfs files for MST we'll need to be
> able to handle debugfs initialization for such resources. We do so by
> introducing drm_debugfs_callback_register() and
> drm_debugfs_callback_unregister(). These functions allow driver-agnostic
> parts of DRM to add additional debugfs initialization callbacks at any
> point during a DRM driver's lifetime.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Daniel Stone <daniel@fooishbar.org>

So the debugfs lifetime rules are indeed silly and broken. I'm not sure
this is what we want to do though:

- Thanks to Noralf's cleanup you don't need a debugfs cleanup callback
  anymore really, it will auto-clean-up on device unregistration.

- For stuff tied to connectors we have the connector->register/unregister
  callbacks. Imo connector-related debugfs stuff, like for mst, should be
  put there.

- debugfs_init is a dead idea, as you point out it's fundamentally racy.

- Dropping the silly notion that we have to duplicate all debugfs entries
  per-minor would be really sweet (last time I checked there's not a
  single debugfs file that's actually different per minor).

Cheers, Daniel

> ---
>  drivers/gpu/drm/drm_debugfs.c  | 173 +++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/drm_drv.c      |   3 +
>  drivers/gpu/drm/drm_internal.h |   5 +
>  include/drm/drm_debugfs.h      |  27 +++++
>  include/drm/drm_file.h         |   4 +
>  5 files changed, 203 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index 6f28fe58f169..a53a454b167f 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -39,6 +39,13 @@
>  
>  #if defined(CONFIG_DEBUG_FS)
>  
> +struct drm_debugfs_callback {
> +	void (*init)(void *data);
> +	void (*cleanup_cb)(void *data);
> +	void *data;
> +	struct list_head list;
> +};
> +
>  /***************************************************
>   * Initialization, etc.
>   **************************************************/
> @@ -67,6 +74,113 @@ static const struct file_operations drm_debugfs_fops = {
>  	.release = single_release,
>  };
>  
> +/**
> + * drm_debugfs_register_callback - Register a callback for initializing
> + *                                 dynamic driver-agnostic debugfs files
> + * @minor: device minor number
> + * @init: The callback to invoke to perform the debugfs initialization
> + * @cleanup_cb: The callback to invoke to cleanup any resources for the
> + * callback
> + * @data: Data to pass to @init and @cleanup_cb
> + * @out: Where to store the pointer to the callback struct
> + *
> + * Register an initialization callback with debugfs. This callback can be used
> + * to creating debugfs nodes for DRM resources that might get created before
> + * the debugfs node for @minor has been created.
> + *
> + * When a callback is registered with this function before the debugfs root
> + * has been created, the callback's execution will be delayed until all other
> + * debugfs nodes (including those owned by the DRM device's driver) have been
> + * instantiated. If a callback is registered with this function after the
> + * debugfs root has been created, @init and @cleanup_cb will be executed
> + * immediately without creating a &struct drm_debugfs_callback.
> + *
> + * In the event that debugfs creation for the device fails; all registered
> + * debugfs callbacks will have their @cleanup_cb callbacks invoked without
> + * having their @init callbacks invoked. This is to ensure that no resources
> + * are leaked during initialization of debugfs, even if the initialization
> + * process fails. Likewise; any callbacks that are registered after DRM has
> + * failed to initialize it's debugfs files will have their @cleanup_cb
> + * callbacks invoked immediately and all of their respective resources
> + * destroyed.
> + *
> + * Implementations of @cleanup_cb should clean up all resources for the
> + * callback, with the exception of freeing the memory for @out. Freeing @out
> + * will be handled by the DRM core automatically.
> + *
> + * Users of this function should take care to add a symmetric call to
> + * @drm_debugfs_unregister_callback to handle destroying a registered callback
> + * in case the resources for the user of this function are destroyed before
> + * debugfs root is initialized.
> + *
> + */
> +int
> +drm_debugfs_register_callback(struct drm_minor *minor,
> +			      void (*init)(void *),
> +			      void (*cleanup_cb)(void *),
> +			      void *data, struct drm_debugfs_callback **out)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&minor->debugfs_callback_lock);
> +	if (minor->debugfs_callbacks_done) {
> +		/* debugfs is already setup, so just handle the callback
> +		 * immediately
> +		 */
> +		if (minor->debugfs_root)
> +			(*init)(data);
> +		(*cleanup_cb)(data);
> +		goto out_unlock;
> +	}
> +
> +	*out = kzalloc(sizeof(**out), GFP_KERNEL);
> +	if (!*out) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	(*out)->init = init;
> +	(*out)->cleanup_cb = cleanup_cb;
> +	(*out)->data = data;
> +	list_add(&(*out)->list, &minor->debugfs_callback_list);
> +
> +out_unlock:
> +	mutex_unlock(&minor->debugfs_callback_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_debugfs_register_callback);
> +
> +/**
> + * drm_debugfs_unregister_callback - Unregister and release the resources
> + *                                   associated with a debugfs init callback
> + * @minor: device minor number
> + * @cb: A pointer to the &struct drm_debugfs_callback struct returned by
> + * drm_debugfs_register_callback(). May be NULL
> + *
> + * Unregisters a &struct drm_debugfs_callback struct with debugfs and destroys
> + * all of it's associated resources. This includes a call to the callback's
> + * @cleanup_cb implementation.
> + *
> + * Once the debugfs root is initialized or has failed initialization, all
> + * registered callbacks are automatically destroyed. If this function is
> + * called after that point; it will automatically be a no-op.
> + */
> +void
> +drm_debugfs_unregister_callback(struct drm_minor *minor,
> +				struct drm_debugfs_callback *cb)
> +{
> +	mutex_lock(&minor->debugfs_callback_lock);
> +	/* We don't have to do anything if we've already completed any
> +	 * registered callbacks, as they will have already been destroyed
> +	 */
> +	if (!minor->debugfs_callbacks_done) {
> +		cb->cleanup_cb(cb->data);
> +		list_del(&cb->list);
> +		kfree(cb);
> +	}
> +	mutex_unlock(&minor->debugfs_callback_lock);
> +}
> +EXPORT_SYMBOL(drm_debugfs_unregister_callback);
>  
>  /**
>   * drm_debugfs_create_files - Initialize a given set of debugfs files for DRM
> @@ -126,12 +240,24 @@ int drm_debugfs_create_files(const struct drm_info_list *files, int count,
>  }
>  EXPORT_SYMBOL(drm_debugfs_create_files);
>  
> +int drm_debugfs_alloc(struct drm_minor *minor)
> +{
> +	INIT_LIST_HEAD(&minor->debugfs_callback_list);
> +	mutex_init(&minor->debugfs_callback_lock);
> +	return 0;
> +}
> +
>  int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>  		     struct dentry *root)
>  {
>  	struct drm_device *dev = minor->dev;
> +	struct drm_debugfs_callback *pos, *tmp;
>  	char name[64];
> -	int ret;
> +	int ret = 0;
> +
> +	/* Don't allow any more callbacks to be registered while we setup */
> +	mutex_lock(&minor->debugfs_callback_lock);
> +	minor->debugfs_callbacks_done = true;
>  
>  	INIT_LIST_HEAD(&minor->debugfs_list);
>  	mutex_init(&minor->debugfs_lock);
> @@ -139,7 +265,8 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>  	minor->debugfs_root = debugfs_create_dir(name, root);
>  	if (!minor->debugfs_root) {
>  		DRM_ERROR("Cannot create /sys/kernel/debug/dri/%s\n", name);
> -		return -1;
> +		ret = -1;
> +		goto out_unlock;
>  	}
>  
>  	ret = drm_debugfs_create_files(drm_debugfs_list, DRM_DEBUGFS_ENTRIES,
> @@ -148,14 +275,14 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>  		debugfs_remove(minor->debugfs_root);
>  		minor->debugfs_root = NULL;
>  		DRM_ERROR("Failed to create core drm debugfs files\n");
> -		return ret;
> +		goto out_unlock;
>  	}
>  
>  	if (drm_core_check_feature(dev, DRIVER_ATOMIC)) {
>  		ret = drm_atomic_debugfs_init(minor);
>  		if (ret) {
>  			DRM_ERROR("Failed to create atomic debugfs files\n");
> -			return ret;
> +			goto out_unlock;
>  		}
>  	}
>  
> @@ -163,13 +290,13 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>  		ret = drm_framebuffer_debugfs_init(minor);
>  		if (ret) {
>  			DRM_ERROR("Failed to create framebuffer debugfs file\n");
> -			return ret;
> +			goto out_unlock;
>  		}
>  
>  		ret = drm_client_debugfs_init(minor);
>  		if (ret) {
>  			DRM_ERROR("Failed to create client debugfs file\n");
> -			return ret;
> +			goto out_unlock;
>  		}
>  	}
>  
> @@ -178,10 +305,23 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>  		if (ret) {
>  			DRM_ERROR("DRM: Driver failed to initialize "
>  				  "/sys/kernel/debug/dri.\n");
> -			return ret;
> +			goto out_unlock;
>  		}
>  	}
> -	return 0;
> +
> +out_unlock:
> +	/* Execute any delayed callbacks if we succeeded, or just clean them
> +	 * up without running them if we failed
> +	 */
> +	list_for_each_entry_safe(pos, tmp, &minor->debugfs_callback_list,
> +				 list) {
> +		if (!ret)
> +			pos->init(pos->data);
> +		pos->cleanup_cb(pos->data);
> +		kfree(pos);
> +	}
> +	mutex_unlock(&minor->debugfs_callback_lock);
> +	return ret;
>  }
>  
>  
> @@ -223,14 +363,29 @@ static void drm_debugfs_remove_all_files(struct drm_minor *minor)
>  
>  int drm_debugfs_cleanup(struct drm_minor *minor)
>  {
> +	struct drm_debugfs_callback *pos, *tmp;
> +
> +	mutex_lock(&minor->debugfs_callback_lock);
> +	if (!minor->debugfs_callbacks_done) {
> +		list_for_each_entry_safe(pos, tmp,
> +					 &minor->debugfs_callback_list,
> +					 list) {
> +			pos->cleanup_cb(pos->data);
> +			kfree(pos);
> +		}
> +	}
> +	minor->debugfs_callbacks_done = true;
> +
>  	if (!minor->debugfs_root)
> -		return 0;
> +		goto out;
>  
>  	drm_debugfs_remove_all_files(minor);
>  
>  	debugfs_remove_recursive(minor->debugfs_root);
>  	minor->debugfs_root = NULL;
>  
> +out:
> +	mutex_unlock(&minor->debugfs_callback_lock);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index ea4941da9b27..7041b3137229 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -118,6 +118,9 @@ static int drm_minor_alloc(struct drm_device *dev, unsigned int type)
>  
>  	minor->type = type;
>  	minor->dev = dev;
> +	r = drm_debugfs_alloc(minor);
> +	if (r)
> +		goto err_free;
>  
>  	idr_preload(GFP_KERNEL);
>  	spin_lock_irqsave(&drm_minor_lock, flags);
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index 40179c5fc6b8..d6394246967d 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -118,6 +118,7 @@ void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
>  
>  /* drm_debugfs.c drm_debugfs_crc.c */
>  #if defined(CONFIG_DEBUG_FS)
> +int drm_debugfs_alloc(struct drm_minor *minor);
>  int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>  		     struct dentry *root);
>  int drm_debugfs_cleanup(struct drm_minor *minor);
> @@ -127,6 +128,10 @@ int drm_debugfs_crtc_add(struct drm_crtc *crtc);
>  void drm_debugfs_crtc_remove(struct drm_crtc *crtc);
>  int drm_debugfs_crtc_crc_add(struct drm_crtc *crtc);
>  #else
> +static inline int drm_debugfs_alloc(struct drm_minor *minor)
> +{
> +	return 0;
> +}
>  static inline int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>  				   struct dentry *root)
>  {
> diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
> index ac0f75df1ac9..6ac45d96fcd1 100644
> --- a/include/drm/drm_debugfs.h
> +++ b/include/drm/drm_debugfs.h
> @@ -77,12 +77,23 @@ struct drm_info_node {
>  	struct dentry *dent;
>  };
>  
> +struct drm_debugfs_callback;
> +
>  #if defined(CONFIG_DEBUG_FS)
>  int drm_debugfs_create_files(const struct drm_info_list *files,
>  			     int count, struct dentry *root,
>  			     struct drm_minor *minor);
>  int drm_debugfs_remove_files(const struct drm_info_list *files,
>  			     int count, struct drm_minor *minor);
> +
> +int drm_debugfs_register_callback(struct drm_minor *minor,
> +				  void (*init)(void *),
> +				  void (*cleanup_cb)(void *),
> +				  void *data,
> +				  struct drm_debugfs_callback **out);
> +void drm_debugfs_unregister_callback(struct drm_minor *minor,
> +				     struct drm_debugfs_callback *cb);
> +
>  #else
>  static inline int drm_debugfs_create_files(const struct drm_info_list *files,
>  					   int count, struct dentry *root,
> @@ -96,6 +107,22 @@ static inline int drm_debugfs_remove_files(const struct drm_info_list *files,
>  {
>  	return 0;
>  }
> +
> +static inline int
> +drm_debugfs_register_callback(struct drm_minor *minor,
> +			      void (*init)(void *),
> +			      void (*cleanup_cb)(void *),
> +			      void *data,
> +			      struct drm_debugfs_callback **out)
> +{
> +	return 0;
> +}
> +
> +static inline void
> +drm_debugfs_unregister_callback(struct drm_minor *minor,
> +				struct drm_debugfs_callback *cb)
> +{
> +}
>  #endif
>  
>  #endif /* _DRM_DEBUGFS_H_ */
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 26485acc51d7..180052b51712 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -74,6 +74,10 @@ struct drm_minor {
>  
>  	struct dentry *debugfs_root;
>  
> +	bool debugfs_callbacks_done;
> +	struct list_head debugfs_callback_list;
> +	struct mutex debugfs_callback_lock;
> +
>  	struct list_head debugfs_list;
>  	struct mutex debugfs_lock; /* Protects debugfs_list. */
>  };
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
