Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeFASei (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:34:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42830 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeFASed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:34:33 -0400
X-Google-Smtp-Source: ADUXVKJvkdYvFy6oKDK+7GwXi5gIDgJsQKFlY5L7lWDGSDS/HI4bH+M0I/IdOOKpJlPThShDsTmfUw==
Date: Fri, 1 Jun 2018 11:34:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] Input: evdev - Switch to bitmap_zalloc()
Message-ID: <20180601183429.GC222005@dtor-ws>
References: <20180601083120.40352-1-andriy.shevchenko@linux.intel.com>
 <20180601083120.40352-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601083120.40352-3-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 11:31:20AM +0300, Andy Shevchenko wrote:
> Switch to bitmap_zalloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/evdev.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index c81c79d01d93..3f87ef973bc7 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -481,7 +481,7 @@ static int evdev_release(struct inode *inode, struct file *file)
>  	evdev_detach_client(evdev, client);
>  
>  	for (i = 0; i < EV_CNT; ++i)
> -		kfree(client->evmasks[i]);
> +		bitmap_free(client->evmasks[i]);
>  
>  	kvfree(client);
>  
> @@ -925,17 +925,15 @@ static int evdev_handle_get_val(struct evdev_client *client,
>  {
>  	int ret;
>  	unsigned long *mem;
> -	size_t len;
>  
> -	len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
> -	mem = kmalloc(len, GFP_KERNEL);
> +	mem = bitmap_malloc(maxbit, GFP_KERNEL);
>  	if (!mem)
>  		return -ENOMEM;
>  
>  	spin_lock_irq(&dev->event_lock);
>  	spin_lock(&client->buffer_lock);
>  
> -	memcpy(mem, bits, len);
> +	bitmap_copy(mem, bits, maxbit);
>  
>  	spin_unlock(&dev->event_lock);
>  
> @@ -947,7 +945,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
>  	if (ret < 0)
>  		evdev_queue_syn_dropped(client);
>  
> -	kfree(mem);
> +	bitmap_free(mem);
>  
>  	return ret;
>  }
> @@ -1003,13 +1001,13 @@ static int evdev_set_mask(struct evdev_client *client,
>  	if (!cnt)
>  		return 0;
>  
> -	mask = kcalloc(sizeof(unsigned long), BITS_TO_LONGS(cnt), GFP_KERNEL);
> +	mask = bitmap_zalloc(cnt, GFP_KERNEL);
>  	if (!mask)
>  		return -ENOMEM;
>  
>  	error = bits_from_user(mask, cnt - 1, codes_size, codes, compat);
>  	if (error < 0) {
> -		kfree(mask);
> +		bitmap_free(mask);
>  		return error;
>  	}
>  
> @@ -1018,7 +1016,7 @@ static int evdev_set_mask(struct evdev_client *client,
>  	client->evmasks[type] = mask;
>  	spin_unlock_irqrestore(&client->buffer_lock, flags);
>  
> -	kfree(oldmask);
> +	bitmap_free(oldmask);
>  
>  	return 0;
>  }
> -- 
> 2.17.0
> 

-- 
Dmitry
