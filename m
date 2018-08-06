Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EA6C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276F521918
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aFyVOE3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276F521918
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbeHGBRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:17:09 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41746 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731432AbeHGBRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:17:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 022ED8EE251;
        Mon,  6 Aug 2018 16:05:50 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MuzXjAAyQYPQ; Mon,  6 Aug 2018 16:05:49 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6B8018EE02B;
        Mon,  6 Aug 2018 16:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533596749;
        bh=Sfzc/0y6A/gC5vy9YnGfhAQg648/mhXBB9zp/asQgtU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aFyVOE3NU2cr3NU/ERsTKWUwSYMBwtoWb5BRriYoo4bZ/g8zDtSuePFqU0vSpfqD7
         hyOooUi57ysqsIslFuRvVHvGIWRDEM6x4t7yRpRi7SSboESgM8nQ6cedZI7QfUrFOi
         e9A3piPbFCpW2hCBReVzzC7AK3CUxNXOQfyi/kms=
Message-ID: <1533596748.3159.19.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Aug 2018 16:05:48 -0700
In-Reply-To: <153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
         <153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 14:14 -0700, Tadeusz Struk wrote:
[...]
> +static void tpm_async_work(struct work_struct *work)
> +{
> +	struct file_priv *priv =
> +			container_of(work, struct file_priv,
> async_work);
> +	ssize_t ret;
> +
> +	ret = tpm_transmit(priv->chip, priv->space, priv-
> >data_buffer,
> +			   sizeof(priv->data_buffer), 0);

Here' you assume the buffer_mutex was taken in write, which is done
(see below).  However, here, since there was no change to tpm_transmit,
you'll sleep in the context of the worker queue waiting for the command
to complete and return.

> +	tpm_put_ops(priv->chip);
> +	if (ret > 0) {
> +		priv->data_pending = ret;
> +		mod_timer(&priv->user_read_timer, jiffies + (120 *
> HZ));
> +	}
> +	mutex_unlock(&priv->buffer_mutex);

But you don't release buffer_mutex here until the tpm command has
completed.

> +	wake_up_interruptible(&priv->async_wait);
> +}
> +

[...]
> @@ -118,25 +155,48 @@ ssize_t tpm_common_write(struct file *file,
> const char __user *buf,
>  	 * the char dev is held open.
>  	 */
>  	if (tpm_try_get_ops(priv->chip)) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EPIPE;
> +		ret = -EPIPE;
> +		goto out;
>  	}
> -	out_size = tpm_transmit(priv->chip, priv->space, priv-
> >data_buffer,
> -				sizeof(priv->data_buffer), 0);
>  
> -	tpm_put_ops(priv->chip);
> -	if (out_size < 0) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return out_size;
> +	/*
> +	 * If in nonblocking mode schedule an async job to send
> +	 * the command return the size.
> +	 * In case of error the err code will be returned in
> +	 * the subsequent read call.
> +	 */
> +	if (file->f_flags & O_NONBLOCK) {
> +		queue_work(tpm_dev_wq, &priv->async_work);
> +		return size;

Here you return holding the buffer_mutex, waiting for tpm_async_work to
release it.

But now I've written my tpm work item and got it queued, I can't write
another one without blocking on the buffer_mutex at the top of
tpm_common_write(), and since that doesn't get released until the
previous command completed, I can only queue one command before I
block.  For an async interface, shouldn't I be able to queue an
arbitrary number of commands without blocking?

James

