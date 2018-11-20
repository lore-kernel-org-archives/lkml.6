Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C468C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9BD20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9BD20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeKTXRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:17:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:10455 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeKTXRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:17:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 04:48:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,257,1539673200"; 
   d="scan'208";a="87850513"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.177])
  by fmsmga008.fm.intel.com with ESMTP; 20 Nov 2018 04:48:10 -0800
Date:   Tue, 20 Nov 2018 14:48:10 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] tpm: add support for partial reads
Message-ID: <20181120124810.GB8813@linux.intel.com>
References: <154265371562.23494.10113870855345906523.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154265371562.23494.10113870855345906523.stgit@tstruk-mobl1.jf.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 10:55:15AM -0800, Tadeusz Struk wrote:
> Currently to read a response from the TPM device an application needs
> provide big enough buffer for the whole response and read it in one go.
> The application doesn't know how big the response it beforehand so it
> always needs to maintain a 4K buffer and read the max (4K).
> In case if the user of the TSS library doesn't provide big enough
> buffer the TCTI spec says that the library should set the required
> size and return TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that the
> application could allocate a bigger buffer and call receive again.
> To make it possible in the TSS library, this requires being able to do
> partial reads from the driver.
> The library would read the 10 bytes header first to get the actual size
> of the response from the header, and then read the rest of the response.
> 
> This patch adds support for partial reads, i.e. the user can read the
> response in one or multiple reads, until the whole response is consumed.
> The user can also read only part of the response and ignore
> the rest by issuing a new write to send a new command.
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
> The usecase is implemented in this TSS commit:
> https://github.com/tpm2-software/tpm2-tss/commit/ce982f67a67dc08e24683d30b05800648d8a264c

Can you implement test for this to

https://github.com/jsakkine-intel/tpm2-scripts

?

Would make it easy to test and also to test in future kernel releases
that doesn't break.

> 
> Changes in v5:
>  - Merge the two patches back into one.
>  - Change variable 'partial_data' to a new flag 'response_read'.
>  - Update the logic around partial_data to reflect the new flag.
>  - Add a new variable response_length that keeps track of how much
>    of the response is left.
> 
> Changes in v4:
>  - Use unsigned type for response_pending as it will never be negative.
>  - Rebased on top of name change data_pending to transmit_result patch.
> 
> Changes in v3:
>  - Remove link to usecase implemented in TSS out of the commit message.
>  - Update the conddition in tpm_common_poll() to take into account
>    the partial_data also.
> 
> Changes in v2:
>  - Allow writes after only partial response is consumed to maintain
>    backwords compatibility.
> ---
>  drivers/char/tpm/tpm-dev-common.c |   51 +++++++++++++++++++++++++------------
>  drivers/char/tpm/tpm-dev.h        |    7 +++--
>  2 files changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index 99b5133a9d05..344739223451 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -40,7 +40,7 @@ static void tpm_async_work(struct work_struct *work)
>  
>  	tpm_put_ops(priv->chip);
>  	if (ret > 0) {
> -		priv->data_pending = ret;
> +		priv->response_length = ret;
>  		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
>  	}
>  	mutex_unlock(&priv->buffer_mutex);
> @@ -63,7 +63,8 @@ static void tpm_timeout_work(struct work_struct *work)
>  					      timeout_work);
>  
>  	mutex_lock(&priv->buffer_mutex);
> -	priv->data_pending = 0;
> +	priv->response_read = true;
> +	priv->response_length = 0;
>  	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
>  	mutex_unlock(&priv->buffer_mutex);
>  	wake_up_interruptible(&priv->async_wait);
> @@ -74,6 +75,7 @@ void tpm_common_open(struct file *file, struct tpm_chip *chip,
>  {
>  	priv->chip = chip;
>  	priv->space = space;
> +	priv->response_read = true;
>  
>  	mutex_init(&priv->buffer_mutex);
>  	timer_setup(&priv->user_read_timer, user_reader_timeout, 0);
> @@ -90,22 +92,35 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>  	ssize_t ret_size = 0;
>  	int rc;
>  
> -	del_singleshot_timer_sync(&priv->user_read_timer);
> -	flush_work(&priv->timeout_work);
>  	mutex_lock(&priv->buffer_mutex);
>  
> -	if (priv->data_pending) {
> -		ret_size = min_t(ssize_t, size, priv->data_pending);
> -		if (ret_size > 0) {
> -			rc = copy_to_user(buf, priv->data_buffer, ret_size);
> -			memset(priv->data_buffer, 0, priv->data_pending);
> -			if (rc)
> -				ret_size = -EFAULT;
> +	if (priv->response_length) {
> +		priv->response_read = true;
> +
> +		ret_size = min_t(ssize_t, size, priv->response_length);
> +		if (!ret_size) {
> +			priv->response_length = 0;
> +			goto out;
>  		}
>  
> -		priv->data_pending = 0;
> +		rc = copy_to_user(buf, priv->data_buffer + *off, ret_size);
> +		if (rc) {
> +			memset(priv->data_buffer, 0, TPM_BUFSIZE);
> +			priv->response_length = 0;
> +			ret_size = -EFAULT;
> +		} else {
> +			memset(priv->data_buffer + *off, 0, ret_size);
> +			priv->response_length -= ret_size;
> +			*off += ret_size;
> +		}
>  	}
>  
> +out:
> +	if (!priv->response_length) {
> +		*off = 0;
> +		del_singleshot_timer_sync(&priv->user_read_timer);
> +		flush_work(&priv->timeout_work);
> +	}
>  	mutex_unlock(&priv->buffer_mutex);
>  	return ret_size;
>  }
> @@ -125,7 +140,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  	 * tpm_read or a user_read_timer timeout. This also prevents split
>  	 * buffered writes from blocking here.
>  	 */
> -	if (priv->data_pending != 0 || priv->command_enqueued) {
> +	if (!priv->response_read || priv->command_enqueued) {
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -150,6 +165,10 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  		goto out;
>  	}
>  
> +	priv->response_length = 0;
> +	priv->response_read = false;
> +	*off = 0;
> +
>  	/*
>  	 * If in nonblocking mode schedule an async job to send
>  	 * the command return the size.
> @@ -168,7 +187,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  	tpm_put_ops(priv->chip);
>  
>  	if (ret > 0) {
> -		priv->data_pending = ret;
> +		priv->response_length = ret;
>  		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
>  		ret = size;
>  	}
> @@ -184,7 +203,7 @@ __poll_t tpm_common_poll(struct file *file, poll_table *wait)
>  
>  	poll_wait(file, &priv->async_wait, wait);
>  
> -	if (priv->data_pending)
> +	if (!priv->response_read || priv->response_length)
>  		mask = EPOLLIN | EPOLLRDNORM;
>  	else
>  		mask = EPOLLOUT | EPOLLWRNORM;
> @@ -201,7 +220,7 @@ void tpm_common_release(struct file *file, struct file_priv *priv)
>  	del_singleshot_timer_sync(&priv->user_read_timer);
>  	flush_work(&priv->timeout_work);
>  	file->private_data = NULL;
> -	priv->data_pending = 0;
> +	priv->response_length = 0;
>  }
>  
>  int __init tpm_dev_common_init(void)
> diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
> index a126b575cb8c..a744d9bec7b6 100644
> --- a/drivers/char/tpm/tpm-dev.h
> +++ b/drivers/char/tpm/tpm-dev.h
> @@ -9,14 +9,15 @@ struct file_priv {
>  	struct tpm_chip *chip;
>  	struct tpm_space *space;
>  
> -	/* Holds the amount of data passed or an error code from async op */
> -	ssize_t data_pending;
>  	struct mutex buffer_mutex;
> -
>  	struct timer_list user_read_timer;      /* user needs to claim result */
>  	struct work_struct timeout_work;
>  	struct work_struct async_work;
>  	wait_queue_head_t async_wait;
> +	/* Holds the resul of the last successful call to tpm_transmit() */

This comment is cruft.

> +	size_t response_length;

data_pending would be now perfectly fine name now that we concluded
that the original length is not needed to be stored. Better than this
as once you decrease it the variable name and contents mismatch.

> +	/* Becomes true when the response (or part of it) is consumed */
> +	bool response_read;

/* Tell whether response been consumed (read at least once). */

>  	bool command_enqueued;
>  
>  	u8 data_buffer[TPM_BUFSIZE];
>

Otherwise, starts to look pretty much acceptable.

/Jarkko
