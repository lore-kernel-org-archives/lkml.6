Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDFVr2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:47:28 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37872 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeDFVr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:47:26 -0400
X-Google-Smtp-Source: AIpwx4+THt7o6iEC553W4PVxjZj/k0tllBAAitcs1ce0CY4u4LRNzzpZZ5+qtQNqTPeZ4RbC1iE8gw==
Reply-To: minyard@acm.org
Subject: Re: [PATCH ipmi/kcs_bmc v1] ipmi: kcs_bmc: optimize the data buffers
 allocation
To: Haiyue Wang <haiyue.wang@linux.intel.com>, minyard@acm.org,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1521116452-4993-1-git-send-email-haiyue.wang@linux.intel.com>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <dd59cf14-e269-6c00-9e33-87316cdc8e8f@gmail.com>
Date: Fri, 6 Apr 2018 16:47:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521116452-4993-1-git-send-email-haiyue.wang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 07:20 AM, Haiyue Wang wrote:
> Allocate a continuous memory block for the three KCS data buffers with
> related index assignment.

I'm finally getting to this.

Is there a reason you want to do this?  In general, it's better to not 
try to
outsmart your base system.  Depending on the memory allocator, in this
case, you might actually use more memory.  You probably won't use any
less.

In the original case, you allocate three 1000 byte buffers, resulting in 3
1024 byte slab allocated.

In the changed case, you will allocate a 3000 byte buffer, resulting in
a single 4096 byte slab allocation, wasting 1024 more bytes of memory.

-corey

> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> ---
>   drivers/char/ipmi/kcs_bmc.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> index fbfc05e..dc19c0d 100644
> --- a/drivers/char/ipmi/kcs_bmc.c
> +++ b/drivers/char/ipmi/kcs_bmc.c
> @@ -435,6 +435,7 @@ static const struct file_operations kcs_bmc_fops = {
>   struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv, u32 channel)
>   {
>   	struct kcs_bmc *kcs_bmc;
> +	void *buf;
>   
>   	kcs_bmc = devm_kzalloc(dev, sizeof(*kcs_bmc) + sizeof_priv, GFP_KERNEL);
>   	if (!kcs_bmc)
> @@ -448,11 +449,12 @@ struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv, u32 channel)
>   	mutex_init(&kcs_bmc->mutex);
>   	init_waitqueue_head(&kcs_bmc->queue);
>   
> -	kcs_bmc->data_in = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
> -	kcs_bmc->data_out = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
> -	kcs_bmc->kbuffer = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
> -	if (!kcs_bmc->data_in || !kcs_bmc->data_out || !kcs_bmc->kbuffer)
> +	buf = devm_kmalloc_array(dev, 3, KCS_MSG_BUFSIZ, GFP_KERNEL);
> +	if (!buf)
>   		return NULL;
> +	kcs_bmc->data_in  = buf;
> +	kcs_bmc->data_out = buf + KCS_MSG_BUFSIZ;
> +	kcs_bmc->kbuffer  = buf + KCS_MSG_BUFSIZ * 2;
>   
>   	kcs_bmc->miscdev.minor = MISC_DYNAMIC_MINOR;
>   	kcs_bmc->miscdev.name = dev_name(dev);
