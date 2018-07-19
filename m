Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD00EECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F8120693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F8120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeGSKUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:20:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeGSKUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:20:05 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B2131BD1;
        Thu, 19 Jul 2018 09:37:45 +0000 (UTC)
Date:   Thu, 19 Jul 2018 11:37:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 17/32] staging: gasket: annotate ioctl arg with __user
Message-ID: <20180719093743.GC14301@kroah.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
 <20180717205712.29495-18-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717205712.29495-18-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 01:56:57PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> For sparse checking.

Close, but you can do better :)

> 
> Reported-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Zhongze Hu <frankhu@chromium.org>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  drivers/staging/gasket/apex_driver.c  | 11 ++--
>  drivers/staging/gasket/gasket_core.c  |  6 ++-
>  drivers/staging/gasket/gasket_core.h  |  4 +-
>  drivers/staging/gasket/gasket_ioctl.c | 72 ++++++++++++++-------------
>  drivers/staging/gasket/gasket_ioctl.h |  4 +-
>  5 files changed, 52 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> index 612b3ab803196..c91c5aff5ab9c 100644
> --- a/drivers/staging/gasket/apex_driver.c
> +++ b/drivers/staging/gasket/apex_driver.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2018 Google, Inc.
>   */
>  
> +#include <linux/compiler.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
>  #include <linux/init.h>
> @@ -142,9 +143,9 @@ static int apex_get_status(struct gasket_dev *gasket_dev);
>  
>  static uint apex_ioctl_check_permissions(struct file *file, uint cmd);
>  
> -static long apex_ioctl(struct file *file, uint cmd, ulong arg);
> +static long apex_ioctl(struct file *file, uint cmd, void __user *arg);
> 
> -static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg);
> +static long apex_clock_gating(struct gasket_dev *gasket_dev, void __user *arg);

Make this a __user pointer to the correct struct type you are handling
here.  You know what the type is, use it.

>  static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type);
>  
> @@ -635,7 +636,7 @@ static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
>  /*
>   * Apex-specific ioctl handler.
>   */
> -static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
> +static long apex_ioctl(struct file *filp, uint cmd, void __user *arg)
>  {
>  	struct gasket_dev *gasket_dev = filp->private_data;
>  
> @@ -655,7 +656,7 @@ static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
>   * @gasket_dev: Gasket device pointer.
>   * @arg: User ioctl arg, in this case to a apex_gate_clock_ioctl struct.
>   */
> -static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
> +static long apex_clock_gating(struct gasket_dev *gasket_dev, void __user *arg)

As above, this should be a different type.

>  {
>  	struct apex_gate_clock_ioctl ibuf;
>  
> @@ -663,7 +664,7 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
>  		return 0;
>  
>  	if (allow_sw_clock_gating) {
> -		if (copy_from_user(&ibuf, (void __user *)arg, sizeof(ibuf)))
> +		if (copy_from_user(&ibuf, arg, sizeof(ibuf)))
>  			return -EFAULT;
>  
>  		gasket_log_error(
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index 947b4fcc76970..ff34af42bbe7c 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -14,6 +14,7 @@
>  #include "gasket_page_table.h"
>  #include "gasket_sysfs.h"
>  
> +#include <linux/compiler.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
>  #include <linux/init.h>
> @@ -1823,14 +1824,15 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
>  		 * check_and_invoke_callback.
>  		 */
>  		if (driver_desc->ioctl_handler_cb)
> -			return driver_desc->ioctl_handler_cb(filp, cmd, arg);
> +			return driver_desc->ioctl_handler_cb(
> +			    filp, cmd, (void __user *)arg);

You can use a temp variable and then only have to cast things once then,
instead of twice, if you care.  Not a big deal.

>  
>  		gasket_log_error(
>  			gasket_dev, "Received unknown ioctl 0x%x", cmd);

This is a fun way to cause a DoS on your system, you should fix this up
in later changes.

>  		return -EINVAL;
>  	}
>  
> -	return gasket_handle_ioctl(filp, cmd, arg);
> +	return gasket_handle_ioctl(filp, cmd, (void __user *)arg);
>  }
>  
>  int gasket_reset(struct gasket_dev *gasket_dev, uint reset_type)
> diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
> index 50ad0c8853183..68b4d2ac9fd6c 100644
> --- a/drivers/staging/gasket/gasket_core.h
> +++ b/drivers/staging/gasket/gasket_core.h
> @@ -315,7 +315,7 @@ struct gasket_dev {
>  
>  /* Type of the ioctl permissions check callback. See below. */
>  typedef int (*gasket_ioctl_permissions_cb_t)(
> -	struct file *filp, uint cmd, ulong arg);
> +	struct file *filp, uint cmd, void __user *arg);
>  
>  /*
>   * Device type descriptor.
> @@ -549,7 +549,7 @@ struct gasket_driver_desc {
>  	 * return -EINVAL. Should return an error status (either -EINVAL or
>  	 * the error result of the ioctl being handled).
>  	 */
> -	long (*ioctl_handler_cb)(struct file *filp, uint cmd, ulong arg);
> +	long (*ioctl_handler_cb)(struct file *filp, uint cmd, void __user *arg);

Why are you not using the typedef above?

>  
>  	/*
>  	 * device_status_cb: Callback to determine device health.
> diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
> index d0fa05b8bf1d3..ab2376c32c00b 100644
> --- a/drivers/staging/gasket/gasket_ioctl.c
> +++ b/drivers/staging/gasket/gasket_ioctl.c
> @@ -7,6 +7,7 @@
>  #include "gasket_interrupt.h"
>  #include "gasket_logging.h"
>  #include "gasket_page_table.h"
> +#include <linux/compiler.h>
>  #include <linux/fs.h>
>  #include <linux/uaccess.h>
>  
> @@ -23,17 +24,18 @@
>  #endif
>  
>  static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd);
> -static int gasket_set_event_fd(struct gasket_dev *dev, ulong arg);
> +static int gasket_set_event_fd(struct gasket_dev *dev, void __user *arg);
>  static int gasket_read_page_table_size(
> -	struct gasket_dev *gasket_dev, ulong arg);
> +	struct gasket_dev *gasket_dev, void __user *arg);
>  static int gasket_read_simple_page_table_size(
> -	struct gasket_dev *gasket_dev, ulong arg);
> +	struct gasket_dev *gasket_dev, void __user *arg);
>  static int gasket_partition_page_table(
> -	struct gasket_dev *gasket_dev, ulong arg);
> -static int gasket_map_buffers(struct gasket_dev *gasket_dev, ulong arg);
> -static int gasket_unmap_buffers(struct gasket_dev *gasket_dev, ulong arg);
> +	struct gasket_dev *gasket_dev, void __user *arg);
> +static int gasket_map_buffers(struct gasket_dev *gasket_dev, void __user *arg);
> +static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
> +				void __user *arg);
>  static int gasket_config_coherent_allocator(
> -	struct gasket_dev *gasket_dev, ulong arg);
> +	struct gasket_dev *gasket_dev, void __user *arg);


For most of these you know the real type, please just use it.

>  /*
>   * standard ioctl dispatch function.
> @@ -43,9 +45,10 @@ static int gasket_config_coherent_allocator(
>   *
>   * Standard ioctl dispatcher; forwards operations to individual handlers.
>   */
> -long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
> +long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *arg)
>  {
>  	struct gasket_dev *gasket_dev;
> +	ulong intarg = (ulong)arg;

Ick, really?  That's a horrible name for a variable, especially as it
doesn't describe what it is...

and "unsigned long" please, ulong is not a "real" kernel type.

>  	int retval;
>  
>  	gasket_dev = (struct gasket_dev *)filp->private_data;
> @@ -74,16 +77,16 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
>  	 */
>  	switch (cmd) {
>  	case GASKET_IOCTL_RESET:
> -		trace_gasket_ioctl_integer_data(arg);
> -		retval = gasket_reset(gasket_dev, arg);
> +		trace_gasket_ioctl_integer_data(intarg);
> +		retval = gasket_reset(gasket_dev, intarg);
>  		break;
>  	case GASKET_IOCTL_SET_EVENTFD:
>  		retval = gasket_set_event_fd(gasket_dev, arg);
>  		break;
>  	case GASKET_IOCTL_CLEAR_EVENTFD:
> -		trace_gasket_ioctl_integer_data(arg);
> +		trace_gasket_ioctl_integer_data(intarg);
>  		retval = gasket_interrupt_clear_eventfd(
> -			gasket_dev->interrupt_data, (int)arg);
> +			gasket_dev->interrupt_data, (int)intarg);

See, look at that cast, why would you ever think to cast a variabled
with "int" in the name of it, to an int?  Naming is hard :(


>  		break;
>  	case GASKET_IOCTL_PARTITION_PAGE_TABLE:
>  		trace_gasket_ioctl_integer_data(arg);
> @@ -91,7 +94,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
>  		break;
>  	case GASKET_IOCTL_NUMBER_PAGE_TABLES:
>  		trace_gasket_ioctl_integer_data(gasket_dev->num_page_tables);
> -		if (copy_to_user((void __user *)arg,
> +		if (copy_to_user(arg,
>  				 &gasket_dev->num_page_tables,

Nit, you can move this line up one now.

I'll stop now, you get the idea.  This should be broken up a lot.

thanks,

greg k-h
