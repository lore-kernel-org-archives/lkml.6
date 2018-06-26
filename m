Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38931C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C802643B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Be2W2N9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C802643B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965280AbeFZCUg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:20:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34616 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965195AbeFZCUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:20:34 -0400
Received: by mail-pf0-f196.google.com with SMTP id g3-v6so2597422pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 19:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kf/Fqw+xoG5gLjneSYKH1a0BvJxDVhq6dz9ar7nv1HA=;
        b=Be2W2N9av7pUCDZs9Nv3iNxnEYcJxzCcdPeeOOxYYW1GkxXgWguvEE+4ShvI8eIZDf
         /csF0ACNU6xoENAcQYZrUi/J+BLAVBpY/6R3+PNo5tV6+yFknqG26EbhxnS/dtT3Vfzb
         t9o8wT9RUYMNifHqlgqYMhO/AxqSnTiAVCd3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kf/Fqw+xoG5gLjneSYKH1a0BvJxDVhq6dz9ar7nv1HA=;
        b=SSHNzQvfQiVx4bYwGFOyIiQhKt7oE78Hhx9DuXdakq357aHYhS38LK6T9xgWC1Agtj
         ag5dwwrnixq6E9yVRSajSYpyy4W0bYW9Bm/59aKEHhe/T2XHEkr96WPpybUv2U3tfXXE
         2H4n9NTa0AKu2ghZ68tYf9UZPKU3DQpj+VlshCPVACKJc/b6DJooui4s07OCN+gOB4X3
         9WLO2lDSkLXv/UsQUI7Jys0H11gs6q/WzILa0I3ftG/I0XZRSvrdp8LYuS/hXuPuGBH0
         eR854xmg62Qo1/mkv47MXuht6KWjLbhXx7rorxoaCJ3zWr7dHu7gthVbkES/BhnZg/mL
         LVLg==
X-Gm-Message-State: APt69E0t/5Qx2EuI7IS/bprXfd/qkHgRsk7l7GBS/66p/TrLYyXpM6Ir
        b0nHhW5k/W6vBuKUF559DO+AVqDrql4=
X-Google-Smtp-Source: ADUXVKKnNJHPjz6wx1vy6NavXGt4/4FsW5ZEjIAtZhv6yXcK1DnYREZLWMbCkMfOURg2YNDEuLTVFw==
X-Received: by 2002:a65:5144:: with SMTP id g4-v6mr3855925pgq.21.1529979634044;
        Mon, 25 Jun 2018 19:20:34 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y22-v6sm504626pfi.166.2018.06.25.19.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 19:20:33 -0700 (PDT)
Date:   Mon, 25 Jun 2018 19:22:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 1/5] remoteproc: Rename subdev functions to
 start/stop
Message-ID: <20180626022259.GH1860@tuxbook-pro>
References: <20180626013409.5125-1-elder@linaro.org>
 <20180626013409.5125-2-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626013409.5125-2-elder@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Jun 18:34 PDT 2018, Alex Elder wrote:

> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> "start" and "stop" are more suitable names for how these two operations
> are used, and they fit better with the upcoming introduction of two
> additional operations in the struct.
> 
> [elder@linaro.org: minor comment edits]
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Alex Elder <elder@linaro.org>
> Tested-by: Fabien Dessenne <fabien.dessenne@st.com>

Sorry for not spotting this before, but per section 11 of
Documentation/process/submitting-patches.rst the tag part should read:


Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[elder@linaro.org: minor comment edits]
Signed-off-by: Alex Elder <elder@linaro.org>


I.e. as you're sending the email you must be the last one certifying the
origin of the patch.

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 30 ++++++++++++++--------------
>  include/linux/remoteproc.h           | 14 ++++++-------
>  2 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index a9609d971f7f..5dd58e6bea88 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -774,13 +774,13 @@ static int rproc_handle_resources(struct rproc *rproc,
>  	return ret;
>  }
>  
> -static int rproc_probe_subdevices(struct rproc *rproc)
> +static int rproc_start_subdevices(struct rproc *rproc)
>  {
>  	struct rproc_subdev *subdev;
>  	int ret;
>  
>  	list_for_each_entry(subdev, &rproc->subdevs, node) {
> -		ret = subdev->probe(subdev);
> +		ret = subdev->start(subdev);
>  		if (ret)
>  			goto unroll_registration;
>  	}
> @@ -789,17 +789,17 @@ static int rproc_probe_subdevices(struct rproc *rproc)
>  
>  unroll_registration:
>  	list_for_each_entry_continue_reverse(subdev, &rproc->subdevs, node)
> -		subdev->remove(subdev, true);
> +		subdev->stop(subdev, true);
>  
>  	return ret;
>  }
>  
> -static void rproc_remove_subdevices(struct rproc *rproc, bool crashed)
> +static void rproc_stop_subdevices(struct rproc *rproc, bool crashed)
>  {
>  	struct rproc_subdev *subdev;
>  
>  	list_for_each_entry_reverse(subdev, &rproc->subdevs, node)
> -		subdev->remove(subdev, crashed);
> +		subdev->stop(subdev, crashed);
>  }
>  
>  /**
> @@ -901,8 +901,8 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  		return ret;
>  	}
>  
> -	/* probe any subdevices for the remote processor */
> -	ret = rproc_probe_subdevices(rproc);
> +	/* Start any subdevices for the remote processor */
> +	ret = rproc_start_subdevices(rproc);
>  	if (ret) {
>  		dev_err(dev, "failed to probe subdevices for %s: %d\n",
>  			rproc->name, ret);
> @@ -1014,8 +1014,8 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> -	/* remove any subdevices for the remote processor */
> -	rproc_remove_subdevices(rproc, crashed);
> +	/* Stop any subdevices for the remote processor */
> +	rproc_stop_subdevices(rproc, crashed);
>  
>  	/* the installed resource table is no longer accessible */
>  	rproc->table_ptr = rproc->cached_table;
> @@ -1657,16 +1657,16 @@ EXPORT_SYMBOL(rproc_del);
>   * rproc_add_subdev() - add a subdevice to a remoteproc
>   * @rproc: rproc handle to add the subdevice to
>   * @subdev: subdev handle to register
> - * @probe: function to call when the rproc boots
> - * @remove: function to call when the rproc shuts down
> + * @start: function to call after the rproc is started
> + * @stop: function to call before the rproc is stopped
>   */
>  void rproc_add_subdev(struct rproc *rproc,
>  		      struct rproc_subdev *subdev,
> -		      int (*probe)(struct rproc_subdev *subdev),
> -		      void (*remove)(struct rproc_subdev *subdev, bool crashed))
> +		      int (*start)(struct rproc_subdev *subdev),
> +		      void (*stop)(struct rproc_subdev *subdev, bool crashed))
>  {
> -	subdev->probe = probe;
> -	subdev->remove = remove;
> +	subdev->start = start;
> +	subdev->stop = stop;
>  
>  	list_add_tail(&subdev->node, &rproc->subdevs);
>  }
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index dfdaede9139e..bf55bf2a5ee1 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -477,15 +477,15 @@ struct rproc {
>  /**
>   * struct rproc_subdev - subdevice tied to a remoteproc
>   * @node: list node related to the rproc subdevs list
> - * @probe: probe function, called as the rproc is started
> - * @remove: remove function, called as the rproc is being stopped, the @crashed
> - *	    parameter indicates if this originates from the a recovery
> + * @start: start function, called after the rproc has been started
> + * @stop: stop function, called before the rproc is stopped; the @crashed
> + *	    parameter indicates if this originates from a recovery
>   */
>  struct rproc_subdev {
>  	struct list_head node;
>  
> -	int (*probe)(struct rproc_subdev *subdev);
> -	void (*remove)(struct rproc_subdev *subdev, bool crashed);
> +	int (*start)(struct rproc_subdev *subdev);
> +	void (*stop)(struct rproc_subdev *subdev, bool crashed);
>  };
>  
>  /* we currently support only two vrings per rvdev */
> @@ -568,8 +568,8 @@ static inline struct rproc *vdev_to_rproc(struct virtio_device *vdev)
>  
>  void rproc_add_subdev(struct rproc *rproc,
>  		      struct rproc_subdev *subdev,
> -		      int (*probe)(struct rproc_subdev *subdev),
> -		      void (*remove)(struct rproc_subdev *subdev, bool crashed));
> +		      int (*start)(struct rproc_subdev *subdev),
> +		      void (*stop)(struct rproc_subdev *subdev, bool crashed));
>  
>  void rproc_remove_subdev(struct rproc *rproc, struct rproc_subdev *subdev);
>  
> -- 
> 2.17.1
> 
