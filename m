Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B4FC4161B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D1B2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D1B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeKPJrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:47:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:7881 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeKPJrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:47:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 15:37:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,238,1539673200"; 
   d="scan'208";a="86313905"
Received: from sfhansen-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.82])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2018 15:37:17 -0800
Date:   Fri, 16 Nov 2018 01:37:16 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tpm: add support for partial reads
Message-ID: <20181115233716.GA31945@linux.intel.com>
References: <154231454280.17567.455994477207265338.stgit@tstruk-mobl1.jf.intel.com>
 <20181115233158.GA30018@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115233158.GA30018@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 01:31:58AM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 15, 2018 at 12:42:22PM -0800, Tadeusz Struk wrote:
> > Currently to read a response from the TPM device an application needs
> > provide big enough buffer for the whole response and read it in one go.
> > The application doesn't know how big the response it beforehand so it
> > always needs to maintain a 4K buffer and read the max (4K).
> > In case if the user of the TSS library doesn't provide big enough
> > buffer the TCTI spec says that the library should set the required
> > size and return TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that the
> > application could allocate a bigger buffer and call receive again.
> > To make it possible in the TSS library, this requires being able to do
> > partial reads from the driver.
> > The library would read the 10 bytes header first to get the actual size
> > of the response from the header, and then read the rest of the response.
> > 
> > This patch adds support for partial reads, i.e. the user can read the
> > response in one or multiple reads, until the whole response is consumed.
> > The user can also read only part of the response and ignore
> > the rest by issuing a new write to send a new command.
> > 
> > Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> > ---
> > The usecase is implemented in this TSS commit:
> > https://github.com/tpm2-software/tpm2-tss/commit/ce982f67a67dc08e24683d30b05800648d8a264c
> > 
> > Changes in v3:
> >  - Remove link to usecase implemented in TSS out of the commit message.
> >  - Update the conddition in tpm_common_poll() to take into account
> >    the partial_data also.
> > 
> > Changes in v2:
> >  - Allow writes after only partial response is consumed to maintain
> >    backwords compatibility.
> > ---
> >  drivers/char/tpm/tpm-dev-common.c |   41 ++++++++++++++++++++++++++++---------
> >  drivers/char/tpm/tpm-dev.h        |    2 ++
> >  2 files changed, 33 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> > index 99b5133a9d05..5d43b0c28565 100644
> > --- a/drivers/char/tpm/tpm-dev-common.c
> > +++ b/drivers/char/tpm/tpm-dev-common.c
> > @@ -64,6 +64,7 @@ static void tpm_timeout_work(struct work_struct *work)
> >  
> >  	mutex_lock(&priv->buffer_mutex);
> >  	priv->data_pending = 0;
> > +	priv->partial_data = 0;
> >  	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
> >  	mutex_unlock(&priv->buffer_mutex);
> >  	wake_up_interruptible(&priv->async_wait);
> > @@ -90,22 +91,39 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
> >  	ssize_t ret_size = 0;
> >  	int rc;
> >  
> > -	del_singleshot_timer_sync(&priv->user_read_timer);
> > -	flush_work(&priv->timeout_work);
> >  	mutex_lock(&priv->buffer_mutex);
> > +	if (priv->data_pending || priv->partial_data) {
> > +		if (*off == 0)
> > +			priv->partial_data = priv->data_pending;
> > +
> > +		ret_size = min_t(ssize_t, size, priv->partial_data);
> > +		if (ret_size <= 0) {
> > +			ret_size = 0;
> > +			priv->data_pending = 0;
> > +			priv->partial_data = 0;
> > +			goto out;
> > +		}
> >  
> > -	if (priv->data_pending) {
> > -		ret_size = min_t(ssize_t, size, priv->data_pending);
> > -		if (ret_size > 0) {
> > -			rc = copy_to_user(buf, priv->data_buffer, ret_size);
> > -			memset(priv->data_buffer, 0, priv->data_pending);
> > -			if (rc)
> > -				ret_size = -EFAULT;
> > +		rc = copy_to_user(buf, priv->data_buffer + *off, ret_size);
> > +		if (rc) {
> > +			memset(priv->data_buffer, 0, TPM_BUFSIZE);
> > +			priv->partial_data = 0;
> > +			ret_size = -EFAULT;
> > +		} else {
> > +			memset(priv->data_buffer + *off, 0, ret_size);
> > +			priv->partial_data -= ret_size;
> > +			*off += ret_size;
> 
> You could drop these memset() calls and also one from
> tpm_timeout_work(). The call could be done once in the beginning of
> tpm_common_write() instead of having three different call sites.
> 
> Replacing two memsets with one could be a prepending commit.
> 
> >  		}
> >  
> >  		priv->data_pending = 0;
> >  	}
> >  
> > +out:
> > +	if (!priv->partial_data) {
> > +		*off = 0;
> > +		del_singleshot_timer_sync(&priv->user_read_timer);
> > +		flush_work(&priv->timeout_work);
> > +	}
> >  	mutex_unlock(&priv->buffer_mutex);
> >  	return ret_size;
> >  }
> > @@ -150,6 +168,9 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
> >  		goto out;
> >  	}
> >  
> > +	priv->partial_data = 0;
> > +	*off = 0;
> > +
> >  	/*
> >  	 * If in nonblocking mode schedule an async job to send
> >  	 * the command return the size.
> > @@ -184,7 +205,7 @@ __poll_t tpm_common_poll(struct file *file, poll_table *wait)
> >  
> >  	poll_wait(file, &priv->async_wait, wait);
> >  
> > -	if (priv->data_pending)
> > +	if (priv->data_pending || priv->partial_data)
> >  		mask = EPOLLIN | EPOLLRDNORM;
> >  	else
> >  		mask = EPOLLOUT | EPOLLWRNORM;
> > diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
> > index a126b575cb8c..a2ca6a7a06f1 100644
> > --- a/drivers/char/tpm/tpm-dev.h
> > +++ b/drivers/char/tpm/tpm-dev.h
> > @@ -11,6 +11,8 @@ struct file_priv {
> >  
> >  	/* Holds the amount of data passed or an error code from async op */
> >  	ssize_t data_pending;
> > +	/* For partial reads, holds the reminder of a response */
> > +	ssize_t partial_data;
> 
> Naming becomes a mess and the comment for data_pending variable is
> incorrect as it is also used for synchronous operation.
> 
> Maybe add a prepending commit to rename it as
> 
> 	/* Holds the resul of the tpm_transmit() last call. */
> 	ssize_t transmit_result;
> 
> That is at least clear and obvious on what it contains.
> 
> The comment for partial_data is incorrect as the variable does not
> contain any data.
> 
> We could use declare:
> 
> 	/* Holds the count how much of the response is still unread. */
> 	size_t response_pending;
> 
> Observe another remark from your commit: there is no reaso to ssize_t as
> the type as the value should never be a negative number.

In order to correct amazing amount of typos in the last sentence I meant
to say that there is no reason to use ssize_t as response_pending can
hold only positive values.

/Jarkko
