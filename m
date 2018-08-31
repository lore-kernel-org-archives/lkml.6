Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FBAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3495820837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3495820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeHaNLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:11:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:5677 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbeHaNLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:11:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 02:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,309,1531810800"; 
   d="scan'208";a="253427205"
Received: from ssirohi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.112])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2018 02:02:16 -0700
Date:   Fri, 31 Aug 2018 12:02:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] tpm: add support for nonblocking operation
Message-ID: <20180831090215.GE12908@linux.intel.com>
References: <153419236870.8189.15489652816512817246.stgit@tstruk-mobl1.jf.intel.com>
 <153419237887.8189.7276823203064056845.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153419237887.8189.7276823203064056845.stgit@tstruk-mobl1.jf.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Aug 13, 2018 at 01:32:58PM -0700, Tadeusz Struk wrote:
> Currently the TPM driver only supports blocking calls, which doesn't allow
> asynchronous IO operations to the TPM hardware.
> This patch changes it and adds support for nonblocking write and a new poll
> function to enable applications, which want to take advantage of this.
> 
> Tested-by: Philip Tricca <philip.b.tricca@intel.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
>  drivers/char/tpm/tpm-dev-common.c |  142 ++++++++++++++++++++++++++++---------
>  drivers/char/tpm/tpm-dev.c        |    1 
>  drivers/char/tpm/tpm-dev.h        |   13 ++-
>  drivers/char/tpm/tpm-interface.c  |   24 +++++-
>  drivers/char/tpm/tpm.h            |    2 +
>  drivers/char/tpm/tpmrm-dev.c      |    1 
>  6 files changed, 138 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index f0c033b69b62..a7ae0072044b 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -17,11 +17,36 @@
>   * License.
>   *
>   */
> +#include <linux/poll.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/workqueue.h>
>  #include "tpm.h"
>  #include "tpm-dev.h"
>  
> +static struct workqueue_struct *tpm_dev_wq;
> +static DEFINE_MUTEX(tpm_dev_wq_lock);
> +
> +static void tpm_async_work(struct work_struct *work)
> +{
> +	struct file_priv *priv =
> +			container_of(work, struct file_priv, async_work);
> +	ssize_t ret;
> +
> +	mutex_lock(&priv->buffer_mutex);
> +	priv->command_enqueued = false;
> +	ret = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
> +			   sizeof(priv->data_buffer), 0);
> +
> +	tpm_put_ops(priv->chip);
> +	if (ret > 0) {
> +		priv->data_pending = ret;
> +		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
> +	}
> +	mutex_unlock(&priv->buffer_mutex);
> +	wake_up_interruptible(&priv->async_wait);
> +}
> +
>  static void user_reader_timeout(struct timer_list *t)
>  {
>  	struct file_priv *priv = from_timer(priv, t, user_read_timer);
> @@ -29,17 +54,19 @@ static void user_reader_timeout(struct timer_list *t)
>  	pr_warn("TPM user space timeout is deprecated (pid=%d)\n",
>  		task_tgid_nr(current));
>  
> -	schedule_work(&priv->work);
> +	schedule_work(&priv->timeout_work);
>  }
>  
> -static void timeout_work(struct work_struct *work)
> +static void tpm_timeout_work(struct work_struct *work)
>  {
> -	struct file_priv *priv = container_of(work, struct file_priv, work);
> +	struct file_priv *priv = container_of(work, struct file_priv,
> +					      timeout_work);
>  
>  	mutex_lock(&priv->buffer_mutex);
>  	priv->data_pending = 0;
>  	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
>  	mutex_unlock(&priv->buffer_mutex);
> +	wake_up_interruptible(&priv->async_wait);
>  }
>  
>  void tpm_common_open(struct file *file, struct tpm_chip *chip,
> @@ -50,8 +77,9 @@ void tpm_common_open(struct file *file, struct tpm_chip *chip,
>  
>  	mutex_init(&priv->buffer_mutex);
>  	timer_setup(&priv->user_read_timer, user_reader_timeout, 0);
> -	INIT_WORK(&priv->work, timeout_work);
> -
> +	INIT_WORK(&priv->timeout_work, tpm_timeout_work);
> +	INIT_WORK(&priv->async_work, tpm_async_work);
> +	init_waitqueue_head(&priv->async_wait);
>  	file->private_data = priv;
>  }
>  
> @@ -63,15 +91,17 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>  	int rc;
>  
>  	del_singleshot_timer_sync(&priv->user_read_timer);
> -	flush_work(&priv->work);
> +	flush_work(&priv->timeout_work);
>  	mutex_lock(&priv->buffer_mutex);
>  
>  	if (priv->data_pending) {
>  		ret_size = min_t(ssize_t, size, priv->data_pending);
> -		rc = copy_to_user(buf, priv->data_buffer, ret_size);
> -		memset(priv->data_buffer, 0, priv->data_pending);
> -		if (rc)
> -			ret_size = -EFAULT;
> +		if (ret_size > 0) {
> +			rc = copy_to_user(buf, priv->data_buffer, ret_size);
> +			memset(priv->data_buffer, 0, priv->data_pending);
> +			if (rc)
> +				ret_size = -EFAULT;
> +		}
>  
>  		priv->data_pending = 0;
>  	}
> @@ -84,10 +114,9 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  			 size_t size, loff_t *off)
>  {
>  	struct file_priv *priv = file->private_data;
> -	size_t in_size = size;
> -	ssize_t out_size;
> +	int ret = 0;
>  
> -	if (in_size > TPM_BUFSIZE)
> +	if (size > TPM_BUFSIZE)
>  		return -E2BIG;
>  
>  	mutex_lock(&priv->buffer_mutex);
> @@ -96,21 +125,20 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  	 * tpm_read or a user_read_timer timeout. This also prevents split
>  	 * buffered writes from blocking here.
>  	 */
> -	if (priv->data_pending != 0) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EBUSY;
> +	if (priv->data_pending != 0 || priv->command_enqueued) {
> +		ret = -EBUSY;
> +		goto out;
>  	}
>  
> -	if (copy_from_user
> -	    (priv->data_buffer, (void __user *) buf, in_size)) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EFAULT;
> +	if (copy_from_user(priv->data_buffer, buf, size)) {
> +		ret = -EFAULT;
> +		goto out;
>  	}
>  
> -	if (in_size < 6 ||
> -	    in_size < be32_to_cpu(*((__be32 *) (priv->data_buffer + 2)))) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EINVAL;
> +	if (size < 6 ||
> +	    size < be32_to_cpu(*((__be32 *)(priv->data_buffer + 2)))) {
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  
>  	/* atomic tpm command send and result receive. We only hold the ops
> @@ -118,25 +146,50 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  	 * the char dev is held open.
>  	 */
>  	if (tpm_try_get_ops(priv->chip)) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EPIPE;
> +		ret = -EPIPE;
> +		goto out;
>  	}
> -	out_size = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
> -				sizeof(priv->data_buffer), 0);
>  
> -	tpm_put_ops(priv->chip);
> -	if (out_size < 0) {
> +	/*
> +	 * If in nonblocking mode schedule an async job to send
> +	 * the command return the size.
> +	 * In case of error the err code will be returned in
> +	 * the subsequent read call.
> +	 */
> +	if (file->f_flags & O_NONBLOCK) {
> +		priv->command_enqueued = true;
> +		queue_work(tpm_dev_wq, &priv->async_work);
>  		mutex_unlock(&priv->buffer_mutex);
> -		return out_size;
> +		return size;
>  	}
>  
> -	priv->data_pending = out_size;
> +	ret = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
> +			   sizeof(priv->data_buffer), 0);
> +	tpm_put_ops(priv->chip);
> +
> +	if (ret > 0) {
> +		priv->data_pending = ret;
> +		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
> +		ret = size;
> +	}
> +out:
>  	mutex_unlock(&priv->buffer_mutex);
> +	return ret;
> +}
>  
> -	/* Set a timeout by which the reader must come claim the result */
> -	mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
> +__poll_t tpm_common_poll(struct file *file, poll_table *wait)
> +{
> +	struct file_priv *priv = file->private_data;
> +	__poll_t mask = 0;
> +
> +	poll_wait(file, &priv->async_wait, wait);
>  
> -	return in_size;
> +	if (priv->data_pending)
> +		mask = EPOLLIN | EPOLLRDNORM;
> +	else
> +		mask = EPOLLOUT | EPOLLWRNORM;
> +
> +	return mask;
>  }
>  
>  /*
> @@ -144,8 +197,25 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>   */
>  void tpm_common_release(struct file *file, struct file_priv *priv)
>  {
> +	flush_work(&priv->async_work);
>  	del_singleshot_timer_sync(&priv->user_read_timer);
> -	flush_work(&priv->work);
> +	flush_work(&priv->timeout_work);
>  	file->private_data = NULL;
>  	priv->data_pending = 0;
>  }
> +
> +
> +int __init tpm_dev_common_init(void)
> +{
> +	tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
> +
> +	return !tpm_dev_wq ? -ENOMEM : 0;
> +}
> +
> +void __exit tpm_dev_common_exit(void)
> +{
> +	if (tpm_dev_wq) {
> +		destroy_workqueue(tpm_dev_wq);
> +		tpm_dev_wq = NULL;
> +	}
> +}
> diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
> index 98b9630c3a36..32f9738f1cb2 100644
> --- a/drivers/char/tpm/tpm-dev.c
> +++ b/drivers/char/tpm/tpm-dev.c
> @@ -68,5 +68,6 @@ const struct file_operations tpm_fops = {
>  	.open = tpm_open,
>  	.read = tpm_common_read,
>  	.write = tpm_common_write,
> +	.poll = tpm_common_poll,
>  	.release = tpm_release,
>  };
> diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
> index 4048677bbd78..a126b575cb8c 100644
> --- a/drivers/char/tpm/tpm-dev.h
> +++ b/drivers/char/tpm/tpm-dev.h
> @@ -2,18 +2,22 @@
>  #ifndef _TPM_DEV_H
>  #define _TPM_DEV_H
>  
> +#include <linux/poll.h>
>  #include "tpm.h"
>  
>  struct file_priv {
>  	struct tpm_chip *chip;
>  	struct tpm_space *space;
>  
> -	/* Data passed to and from the tpm via the read/write calls */
> -	size_t data_pending;
> +	/* Holds the amount of data passed or an error code from async op */
> +	ssize_t data_pending;
>  	struct mutex buffer_mutex;
>  
>  	struct timer_list user_read_timer;      /* user needs to claim result */
> -	struct work_struct work;
> +	struct work_struct timeout_work;
> +	struct work_struct async_work;
> +	wait_queue_head_t async_wait;
> +	bool command_enqueued;
>  
>  	u8 data_buffer[TPM_BUFSIZE];
>  };
> @@ -24,6 +28,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>  			size_t size, loff_t *off);
>  ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  			 size_t size, loff_t *off);
> -void tpm_common_release(struct file *file, struct file_priv *priv);
> +__poll_t tpm_common_poll(struct file *file, poll_table *wait);
>  
> +void tpm_common_release(struct file *file, struct file_priv *priv);
>  #endif
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1a803b0cf980..9e280e9b4c5b 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -1407,19 +1407,32 @@ static int __init tpm_init(void)
>  	tpmrm_class = class_create(THIS_MODULE, "tpmrm");
>  	if (IS_ERR(tpmrm_class)) {
>  		pr_err("couldn't create tpmrm class\n");
> -		class_destroy(tpm_class);
> -		return PTR_ERR(tpmrm_class);
> +		rc = PTR_ERR(tpmrm_class);
> +		goto destroy_tpm_class;
>  	}
>  
>  	rc = alloc_chrdev_region(&tpm_devt, 0, 2*TPM_NUM_DEVICES, "tpm");
>  	if (rc < 0) {
>  		pr_err("tpm: failed to allocate char dev region\n");
> -		class_destroy(tpmrm_class);
> -		class_destroy(tpm_class);
> -		return rc;
> +		goto destroy_tpmrm_class;
> +	}
> +
> +	rc = tpm_dev_common_init();
> +	if (rc) {
> +		pr_err("tpm: failed to allocate char dev region\n");
> +		goto unreg_chrdev;
>  	}
>  
>  	return 0;
> +
> +unreg_chrdev:
> +	unregister_chrdev_region(tpm_devt, 2*TPM_NUM_DEVICES);
> +destroy_tpmrm_class:
> +	class_destroy(tpmrm_class);
> +destroy_tpm_class:
> +	class_destroy(tpm_class);

out_*

> +
> +	return rc;
>  }
>  
>  static void __exit tpm_exit(void)
> @@ -1428,6 +1441,7 @@ static void __exit tpm_exit(void)
>  	class_destroy(tpm_class);
>  	class_destroy(tpmrm_class);
>  	unregister_chrdev_region(tpm_devt, 2*TPM_NUM_DEVICES);
> +	tpm_dev_common_exit();
>  }
>  
>  subsys_initcall(tpm_init);
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index f3501d05264f..f20dc8ece348 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -604,4 +604,6 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
>  
>  int tpm_bios_log_setup(struct tpm_chip *chip);
>  void tpm_bios_log_teardown(struct tpm_chip *chip);
> +int tpm_dev_common_init(void);
> +void tpm_dev_common_exit(void);
>  #endif
> diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
> index 96006c6b9696..0c751a79bbed 100644
> --- a/drivers/char/tpm/tpmrm-dev.c
> +++ b/drivers/char/tpm/tpmrm-dev.c
> @@ -51,5 +51,6 @@ const struct file_operations tpmrm_fops = {
>  	.open = tpmrm_open,
>  	.read = tpm_common_read,
>  	.write = tpm_common_write,
> +	.poll = tpm_common_poll,
>  	.release = tpmrm_release,
>  };
> 

Otherwise, I did not spot anything obviously wrong. I guess this patch
set is about ready to be taken soon...

/Jarkko
