Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeEPRPf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:15:35 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45322 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeEPRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:15:33 -0400
X-Google-Smtp-Source: AB8JxZqH2ypyJmX9vFUrAgoF3O37e9EvdeKH6saQrBhR+yzJ53B+HRFlUZta4IlK2EtA++SHJMSICg==
Date: Wed, 16 May 2018 10:15:28 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgross@suse.com, lyan@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH v3 2/2] Input: xen-kbdfront - allow better run-time
 configuration
Message-ID: <20180516171528.GD21971@dtor-ws>
References: <20180514144029.16019-1-andr2000@gmail.com>
 <20180514144029.16019-2-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514144029.16019-2-andr2000@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

On Mon, May 14, 2018 at 05:40:29PM +0300, Oleksandr Andrushchenko wrote:
> @@ -211,93 +220,114 @@ static int xenkbd_probe(struct xenbus_device *dev,
>  	if (!info->page)
>  		goto error_nomem;
>  
> -	/* Set input abs params to match backend screen res */
> -	abs = xenbus_read_unsigned(dev->otherend,
> -				   XENKBD_FIELD_FEAT_ABS_POINTER, 0);
> -	ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend,
> -						  XENKBD_FIELD_WIDTH,
> -						  ptr_size[KPARAM_X]);
> -	ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend,
> -						  XENKBD_FIELD_HEIGHT,
> -						  ptr_size[KPARAM_Y]);
> -	if (abs) {
> -		ret = xenbus_write(XBT_NIL, dev->nodename,
> -				   XENKBD_FIELD_REQ_ABS_POINTER, "1");
> -		if (ret) {
> -			pr_warn("xenkbd: can't request abs-pointer\n");
> -			abs = 0;
> -		}
> -	}
> +	/*
> +	 * The below are reverse logic, e.g. if the feature is set, then
> +	 * do not expose the corresponding virtual device.
> +	 */
> +	with_kbd = !xenbus_read_unsigned(dev->nodename,
> +					 XENKBD_FIELD_FEAT_DSBL_KEYBRD, 0);
>  
> -	touch = xenbus_read_unsigned(dev->nodename,
> -				     XENKBD_FIELD_FEAT_MTOUCH, 0);
> -	if (touch) {
> +	with_ptr = !xenbus_read_unsigned(dev->nodename,
> +					 XENKBD_FIELD_FEAT_DSBL_POINTER, 0);
> +
> +	/* Direct logic: if set, then create multi-touch device. */
> +	with_mtouch = xenbus_read_unsigned(dev->nodename,
> +					   XENKBD_FIELD_FEAT_MTOUCH, 0);
> +	if (with_mtouch) {
>  		ret = xenbus_write(XBT_NIL, dev->nodename,
>  				   XENKBD_FIELD_REQ_MTOUCH, "1");
>  		if (ret) {
>  			pr_warn("xenkbd: can't request multi-touch");
> -			touch = 0;
> +			with_mtouch = 0;
>  		}
>  	}

Does it make sense to still end up calling xenkbd_connect_backend() when
all interfaces (keyboard, pointer, and multitouch) are disabled? Should
we do:

	if (!(with_kbd || || with_ptr || with_mtouch))
		return -ENXIO;

?

Thanks.

-- 
Dmitry
