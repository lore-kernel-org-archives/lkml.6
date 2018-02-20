Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBTN3Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:29:25 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46032 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeBTN3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:29:22 -0500
X-Google-Smtp-Source: AH8x2262l8h0vHneq7iTir3MwcyRR2tsa0b8XqoHfznK47oyK4ffkrt0N9U1ycyVyN8j4YAtphIV6g==
Reply-To: minyard@acm.org
Subject: Re: [PATCH ipmi/kcs_bmc v2] ipmi: kcs_bmc: make the code be more
 clean
To: Haiyue Wang <haiyue.wang@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1519055731-18923-1-git-send-email-haiyue.wang@linux.intel.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <9b5afddc-1c28-d5cf-d7ee-71a389592073@acm.org>
Date: Tue, 20 Feb 2018 07:29:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519055731-18923-1-git-send-email-haiyue.wang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/2018 09:55 AM, Haiyue Wang wrote:
> ---
When you use ---, it means everything following is not in the commit text,
including your signature.

> v1 -> v2:

Do you want me to fold this into the previous patch?  That's generally
not how things work, a new patch is fine for this, with a list of things
done like below.

One comment inline below...

>
> Add 'SPDX-License-Identifier' style for header files modification.
> ---
>
> 1. Add the missed key word '__user' for read / write.
> 2. Remove the prefix 'file' of 'file_to_kcs_bmc', no need this
> duplicated word as its parameter has 'struct file *filp'.
> 3. Change the 'unsigned int' to '__poll_t' to meet the new 'poll'
> definition.
> 4. Correct the 'SPDX-License-Identifier' style for header files.
>
> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> ---
>   drivers/char/ipmi/kcs_bmc.c        | 32 +++++++++++++++++---------------
>   drivers/char/ipmi/kcs_bmc.h        |  6 ++++--
>   drivers/char/ipmi/kcs_bmc_aspeed.c |  4 +++-
>   include/uapi/linux/ipmi_bmc.h      |  6 ++++--
>   4 files changed, 28 insertions(+), 20 deletions(-)
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

I get this:

   CC [M]  drivers/char/ipmi/kcs_bmc.o
../drivers/char/ipmi/kcs_bmc.c: In function ‘kcs_bmc_poll’:
../drivers/char/ipmi/kcs_bmc.c:276:11: error: ‘EPOLLIN’ undeclared 
(first use in this function)
    mask |= EPOLLIN;
            ^
../drivers/char/ipmi/kcs_bmc.c:276:11: note: each undeclared identifier 
is reported only once for each function it appears in

probably need to include linux/eventpoll.h

-corey

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
> index c19501d..69d9a70 100644
> --- a/drivers/char/ipmi/kcs_bmc.h
> +++ b/drivers/char/ipmi/kcs_bmc.h
> @@ -1,5 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2015-2018, Intel Corporation.
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2015-2018, Intel Corporation.
> + */
>   
>   #ifndef __KCS_BMC_H__
>   #define __KCS_BMC_H__
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index 0c4d1a3..dba6075 100644
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
> diff --git a/include/uapi/linux/ipmi_bmc.h b/include/uapi/linux/ipmi_bmc.h
> index 2f9f97e..d3efacd 100644
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
