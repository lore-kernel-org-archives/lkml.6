Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeBZPvD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:51:03 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42667 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbeBZPvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:51:02 -0500
X-Google-Smtp-Source: AH8x227eSSfGPyoTYMpk/JRwuFgl5sjwY2tRZry/DvM37+WTqRUcQOvkOXxGqrh3SFZ9JNej46yBTA==
Reply-To: minyard@acm.org
Subject: Re: [PATCH ipmi/kcs_bmc v6] ipmi: kcs_bmc: coding-style fixes and use
 new poll type
To: Haiyue Wang <haiyue.wang@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1519660094-9748-1-git-send-email-haiyue.wang@linux.intel.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <3e0822bc-1cb5-f110-c2f2-3ffe7c3c8d3a@acm.org>
Date: Mon, 26 Feb 2018 09:50:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519660094-9748-1-git-send-email-haiyue.wang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/2018 09:48 AM, Haiyue Wang wrote:
> Many for coding-style fixes, and update the poll API with the new
> type '__poll_t', this is new commit from linux-4.16-rc1.
>
> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>

Sorry for the delay, I was on jury duty last week.  But it looks like 
you got
some useful changes in.

I'm hoping you are done with this patch :-).  I've included in my tree, but
I can replace if necessary.

Thanks,

-corey

> ---
> v5 -> v6:
>   - Add the missed change to EPOLLIN.
>
> v4 -> v5:
>   - Simplify the commit title and message.
>   - Change the 'MODULE_DEVICE_TABLE' position.
>
> v3 -> v4:
>   - Correct the header file's macro defination end comment which is old
>     file name, I forgot to change it after changing the file name.
>   - Remove the space between the comment words and colon.
>
> v2 -> v3:
>   - Make the commit message be more understandable.
>
> v1 -> v2:
>   - Add 'SPDX-License-Identifier' style for header files modification.
> ---
>   drivers/char/ipmi/kcs_bmc.c        | 32 +++++++++++++++++---------------
>   drivers/char/ipmi/kcs_bmc.h        | 36 +++++++++++++++++++-----------------
>   drivers/char/ipmi/kcs_bmc_aspeed.c |  9 +++++----
>   include/uapi/linux/ipmi_bmc.h      |  8 +++++---
>   4 files changed, 46 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> index 6476bfb..fbfc05e 100644
> --- a/drivers/char/ipmi/kcs_bmc.c
> +++ b/drivers/char/ipmi/kcs_bmc.c
> @@ -1,5 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2015-2018, Intel Corporation.
> +/*
> + * Copyright (c) 2015-2018, Intel Corporation.
> + */
>   
>   #define pr_fmt(fmt) "kcs-bmc: " fmt
>   
> @@ -242,14 +244,14 @@ int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
>   }
>   EXPORT_SYMBOL(kcs_bmc_handle_event);
>   
> -static inline struct kcs_bmc *file_to_kcs_bmc(struct file *filp)
> +static inline struct kcs_bmc *to_kcs_bmc(struct file *filp)
>   {
>   	return container_of(filp->private_data, struct kcs_bmc, miscdev);
>   }
>   
>   static int kcs_bmc_open(struct inode *inode, struct file *filp)
>   {
> -	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
> +	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
>   	int ret = 0;
>   
>   	spin_lock_irq(&kcs_bmc->lock);
> @@ -262,25 +264,25 @@ static int kcs_bmc_open(struct inode *inode, struct file *filp)
>   	return ret;
>   }
>   
> -static unsigned int kcs_bmc_poll(struct file *filp, poll_table *wait)
> +static __poll_t kcs_bmc_poll(struct file *filp, poll_table *wait)
>   {
> -	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
> -	unsigned int mask = 0;
> +	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
> +	__poll_t mask = 0;
>   
>   	poll_wait(filp, &kcs_bmc->queue, wait);
>   
>   	spin_lock_irq(&kcs_bmc->lock);
>   	if (kcs_bmc->data_in_avail)
> -		mask |= POLLIN;
> +		mask |= EPOLLIN;
>   	spin_unlock_irq(&kcs_bmc->lock);
>   
>   	return mask;
>   }
>   
> -static ssize_t kcs_bmc_read(struct file *filp, char *buf,
> -			    size_t count, loff_t *offset)
> +static ssize_t kcs_bmc_read(struct file *filp, char __user *buf,
> +			    size_t count, loff_t *ppos)
>   {
> -	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
> +	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
>   	bool data_avail;
>   	size_t data_len;
>   	ssize_t ret;
> @@ -339,10 +341,10 @@ static ssize_t kcs_bmc_read(struct file *filp, char *buf,
>   	return ret;
>   }
>   
> -static ssize_t kcs_bmc_write(struct file *filp, const char *buf,
> -			     size_t count, loff_t *offset)
> +static ssize_t kcs_bmc_write(struct file *filp, const char __user *buf,
> +			     size_t count, loff_t *ppos)
>   {
> -	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
> +	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
>   	ssize_t ret;
>   
>   	/* a minimum response size '3' : netfn + cmd + ccode */
> @@ -378,7 +380,7 @@ static ssize_t kcs_bmc_write(struct file *filp, const char *buf,
>   static long kcs_bmc_ioctl(struct file *filp, unsigned int cmd,
>   			  unsigned long arg)
>   {
> -	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
> +	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
>   	long ret = 0;
>   
>   	spin_lock_irq(&kcs_bmc->lock);
> @@ -410,7 +412,7 @@ static long kcs_bmc_ioctl(struct file *filp, unsigned int cmd,
>   
>   static int kcs_bmc_release(struct inode *inode, struct file *filp)
>   {
> -	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
> +	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
>   
>   	spin_lock_irq(&kcs_bmc->lock);
>   	kcs_bmc->running = 0;
> diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
> index c19501d..eb9ea4c 100644
> --- a/drivers/char/ipmi/kcs_bmc.h
> +++ b/drivers/char/ipmi/kcs_bmc.h
> @@ -1,31 +1,33 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2015-2018, Intel Corporation.
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2015-2018, Intel Corporation.
> + */
>   
>   #ifndef __KCS_BMC_H__
>   #define __KCS_BMC_H__
>   
>   #include <linux/miscdevice.h>
>   
> -/* Different phases of the KCS BMC module :
> - *  KCS_PHASE_IDLE :
> +/* Different phases of the KCS BMC module.
> + *  KCS_PHASE_IDLE:
>    *            BMC should not be expecting nor sending any data.
> - *  KCS_PHASE_WRITE_START :
> + *  KCS_PHASE_WRITE_START:
>    *            BMC is receiving a WRITE_START command from system software.
> - *  KCS_PHASE_WRITE_DATA :
> + *  KCS_PHASE_WRITE_DATA:
>    *            BMC is receiving a data byte from system software.
> - *  KCS_PHASE_WRITE_END_CMD :
> + *  KCS_PHASE_WRITE_END_CMD:
>    *            BMC is waiting a last data byte from system software.
> - *  KCS_PHASE_WRITE_DONE :
> + *  KCS_PHASE_WRITE_DONE:
>    *            BMC has received the whole request from system software.
> - *  KCS_PHASE_WAIT_READ :
> + *  KCS_PHASE_WAIT_READ:
>    *            BMC is waiting the response from the upper IPMI service.
> - *  KCS_PHASE_READ :
> + *  KCS_PHASE_READ:
>    *            BMC is transferring the response to system software.
> - *  KCS_PHASE_ABORT_ERROR1 :
> + *  KCS_PHASE_ABORT_ERROR1:
>    *            BMC is waiting error status request from system software.
> - *  KCS_PHASE_ABORT_ERROR2 :
> + *  KCS_PHASE_ABORT_ERROR2:
>    *            BMC is waiting for idle status afer error from system software.
> - *  KCS_PHASE_ERROR :
> + *  KCS_PHASE_ERROR:
>    *            BMC has detected a protocol violation at the interface level.
>    */
>   enum kcs_phases {
> @@ -54,9 +56,9 @@ enum kcs_errors {
>   };
>   
>   /* IPMI 2.0 - 9.5, KCS Interface Registers
> - * @idr : Input Data Register
> - * @odr : Output Data Register
> - * @str : Status Register
> + * @idr: Input Data Register
> + * @odr: Output Data Register
> + * @str: Status Register
>    */
>   struct kcs_ioreg {
>   	u32 idr;
> @@ -103,4 +105,4 @@ static inline void *kcs_bmc_priv(struct kcs_bmc *kcs_bmc)
>   int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc);
>   struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv,
>   					u32 channel);
> -#endif
> +#endif /* __KCS_BMC_H__ */
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index 0c4d1a3..3c95594 100644
> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> @@ -1,5 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2015-2018, Intel Corporation.
> +/*
> + * Copyright (c) 2015-2018, Intel Corporation.
> + */
>   
>   #define pr_fmt(fmt) "aspeed-kcs-bmc: " fmt
>   
> @@ -301,19 +303,18 @@ static const struct of_device_id ast_kcs_bmc_match[] = {
>   	{ .compatible = "aspeed,ast2500-kcs-bmc" },
>   	{ }
>   };
> +MODULE_DEVICE_TABLE(of, ast_kcs_bmc_match);
>   
>   static struct platform_driver ast_kcs_bmc_driver = {
>   	.driver = {
>   		.name           = DEVICE_NAME,
>   		.of_match_table = ast_kcs_bmc_match,
>   	},
> -	.probe = aspeed_kcs_probe,
> +	.probe  = aspeed_kcs_probe,
>   	.remove = aspeed_kcs_remove,
>   };
> -
>   module_platform_driver(ast_kcs_bmc_driver);
>   
> -MODULE_DEVICE_TABLE(of, ast_kcs_bmc_match);
>   MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
>   MODULE_DESCRIPTION("Aspeed device interface to the KCS BMC device");
> diff --git a/include/uapi/linux/ipmi_bmc.h b/include/uapi/linux/ipmi_bmc.h
> index 2f9f97e..1670f09 100644
> --- a/include/uapi/linux/ipmi_bmc.h
> +++ b/include/uapi/linux/ipmi_bmc.h
> @@ -1,5 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2015-2018, Intel Corporation.
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2015-2018, Intel Corporation.
> + */
>   
>   #ifndef _UAPI_LINUX_IPMI_BMC_H
>   #define _UAPI_LINUX_IPMI_BMC_H
> @@ -11,4 +13,4 @@
>   #define IPMI_BMC_IOCTL_CLEAR_SMS_ATN  _IO(__IPMI_BMC_IOCTL_MAGIC, 0x01)
>   #define IPMI_BMC_IOCTL_FORCE_ABORT    _IO(__IPMI_BMC_IOCTL_MAGIC, 0x02)
>   
> -#endif /* _UAPI_LINUX_KCS_BMC_H */
> +#endif /* _UAPI_LINUX_IPMI_BMC_H */
