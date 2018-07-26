Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F676C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F136C20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F136C20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeGZBqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:46:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40470 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbeGZBql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:46:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so6364133pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 17:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nep9MsZgb1OCsJ6InF55HNIMdsVgPzPmOmT0jZ9vSKo=;
        b=YxgaSD2aSm6h4QEkUkS3Zll5kGNoYs88BNijvgftqTJ4NK4/l/2I/ugc/9r1SL14gd
         PW7z6GtOmhBucarg/hopCAksEy0Jwg1CnMIiqrz2hZ8DldMZhnu07TwUy2JWIWJ5JaRR
         QFtw/jAH2LY9LfLl/FPEFe8aHNKUpImNG+/iBSPgEEEmz40xtnlg5DbISgtEokC7sF6F
         eNEn8sXj2d3TTDHJKrxdz1dXG+/0+UZ/URVpuaRwUsJkXRPYlBnPKmYagswZVaI6kfP/
         BQLibAKlzYztG6mFf3f/bpx9gExhSV8GVgDQTnHMhQTmvQktQGzgs/RxuM5aj6p/J2Xz
         kVxQ==
X-Gm-Message-State: AOUpUlEdIVxiXgwIYxS+qqOqIjl7Z7xLeGVwkseeAagxiPJuPicVTBdi
        QclmsKGsP9IByvX4coSALQUjauSp
X-Google-Smtp-Source: AAOMgpdcJYNebgH5cISj0KF1fDG/P4j7hzvQFwa3Kb9IecOzez1IvoROX9bMHIMsoliaj37ZqeiMEQ==
X-Received: by 2002:a63:27c1:: with SMTP id n184-v6mr21848425pgn.29.1532565150519;
        Wed, 25 Jul 2018 17:32:30 -0700 (PDT)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id c12-v6sm35904572pfl.20.2018.07.25.17.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 17:32:29 -0700 (PDT)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Wed, 25 Jul 2018 17:32:27 -0700
Date:   Wed, 25 Jul 2018 17:32:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        Vikram Mulukutla <markivx@codeaurora.org>
Subject: Re: [PATCH] firmware: Avoid caching firmware when FW_OPT_NOCACHE is
 set
Message-ID: <20180726003227.GD11574@garbanzo.do-not-panic.com>
References: <1532035521-7917-1-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532035521-7917-1-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 02:25:21PM -0700, Rishabh Bhatnagar wrote:
> When calling request_firmware_into_buf(), we pass the FW_OPT_NOCACHE
> flag with the intent of skipping the caching mechanism of the
> firmware loader. Unfortunately, that doesn't work, because
> alloc_lookup_fw_priv() isn't told to _not_ add the struct
> firmware_buf to the firmware cache (fwc) list. So when we call
> request_firmware_into_buf() the second time, we find the buffer in
> the cache and return it immediately without reloading.

The code in question is not dealing with the firmware cache though, it is
batched requests. Unfortunately the code is not very clear given the
structure used is the struct firmware_cache, however if you look
carefully you will see there are two struct list_head used:

struct firmware_cache {
	/* firmware_buf instance will be added into the below list */
	spinlock_t lock;
	struct list_head head;
	...
#ifdef CONFIG_PM_SLEEP
	/*
	 * Names of firmware images which have been cached successfully
	 * will be added into the below list so that device uncache
	 * helper can trace which firmware images have been cached
	 * before.
	 */
	spinlock_t name_lock;
	struct list_head fw_names;
	...
};

So the first struct list_head is used for batched firmware requests. It
was the first patch of the work, it was introduced via commit one
commit, while the actual firmware cache used for suspend/resume in
another. Respectively they are commits:

1f2b79599ee8f ("firmware loader: always let firmware_buf own the pages buffer")
37276a51f803e ("firmware: introduce device_cache/uncache_fw_images")

The ifdefery above clarifies this is a bit, however it is rather easy
to fall into the trap to easily review this code and think they are the
same thing.

> This may break users of request_firmware_into_buf that are expecting
> a fresh copy of the firmware to be reloaded into memory. 

No, this is not the reason why this will break users of
request_firmware_into_buf(), its because the call is by design
using device driver specific memory, so as a matter of fact, it would
actually be a security issue:

*Any* kernel code which makes a request for the same firmware name, if
the call is carefully timed, could end up getting a pointer to the device's
own memory area used for this firmware, and since
request_firmware_into_buf() was used, and since today's only driver
using this is with IO memory this is a bigger issue.

What you state above alludes that the issue is that we want a fresh
copy, this has nothing to do with a copy, this is device driver specific
memory.

> The existing
> copy may either be modified by drivers, remote processors or even
> freed.

This is *also* true, specially since the only single Qualcomm driver
using this *also* uses IO memory. And this is a small example of why
also LSMs *should* be abe to have knowledge when this type of memory is
used.

> Fix fw_lookup_and_allocate_buf to not add to the fwc list
> if FW_OPT_NOCACHE is set, and also don't do the lookup in the list.
> 
> Fixes: 0e742e9271 ("firmware: provide infrastructure to make fw caching optional")

This commit does not exist, you made a typo, the last 1 should be a 5:

0e742e9275

NACK for a few reasons:

a) The commit ID identified as it fixing is wrong
b) The commit is not accurate as to the reason why this is an issue
c) The commit does not ackowledge the severity of the issue
d) I was hoping we can make the fix simpler

As for c) and d) -- come to think of it, the fact that we didn't
implement batched firmware requests with a const pointer instead
means we have similar potential issues possible with othe kernel
code also requesting the same firmware and potentially modifying
it on the fly prior to a device processing it, therefore causing
possibly unintended behaviour.

So, initially I was inclined to just rip the batched firmware
implementation completely for all callers. Unfortunately trying to do
this revealed to me just how broken this was. For instance, the private
buf kept around for the firmware when caching it is kept track by the
using the above mentioned struct list head. This means that any firmware
which intends to be used for firmware caching *must* also be added to
the fw cache head list. And unfortunately the search for this entry is
indexed by just the name. So uncache_firmnware() for instance uses
lookup_fw_priv() and that in turn which just look for the first private
buf with the associated firmware name. This means firmware which is
cached assumes only one copy is kept around during suspend/resume cycle,
and the batched firmware feature was collateral.

So I don't think we can easily disable batched firmware requests
without breaking caching, as such I think your patch in turn is
what we need for now. Can you re-spin, fix the commit log with a
proper explanation and commit ID it fixes?

  Luis

> Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/base/firmware_loader/main.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 2e0c37a..db9038c0 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -210,21 +210,24 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
>  static int alloc_lookup_fw_priv(const char *fw_name,
>  				struct firmware_cache *fwc,
>  				struct fw_priv **fw_priv, void *dbuf,
> -				size_t size)
> +				size_t size, enum fw_opt opt_flags)
>  {
>  	struct fw_priv *tmp;
>  
>  	spin_lock(&fwc->lock);
> -	tmp = __lookup_fw_priv(fw_name);
> -	if (tmp) {
> -		kref_get(&tmp->ref);
> -		spin_unlock(&fwc->lock);
> -		*fw_priv = tmp;
> -		pr_debug("batched request - sharing the same struct fw_priv and lookup for multiple requests\n");
> -		return 1;
> +	if (!(opt_flags & FW_OPT_NOCACHE)) {
> +		tmp = __lookup_fw_priv(fw_name);
> +		if (tmp) {
> +			kref_get(&tmp->ref);
> +			spin_unlock(&fwc->lock);
> +			*fw_priv = tmp;
> +			pr_debug("batched request - sharing the same struct fw_priv and lookup for multiple requests\n");
> +			return 1;
> +		}
>  	}
> +
>  	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
> -	if (tmp)
> +	if (tmp && !(opt_flags & FW_OPT_NOCACHE))
>  		list_add(&tmp->list, &fwc->head);
>  	spin_unlock(&fwc->lock);
>  
> @@ -500,7 +503,8 @@ int assign_fw(struct firmware *fw, struct device *device,
>   */
>  static int
>  _request_firmware_prepare(struct firmware **firmware_p, const char *name,
> -			  struct device *device, void *dbuf, size_t size)
> +			  struct device *device, void *dbuf, size_t size,
> +			  enum fw_opt opt_flags)
>  {
>  	struct firmware *firmware;
>  	struct fw_priv *fw_priv;
> @@ -518,7 +522,8 @@ int assign_fw(struct firmware *fw, struct device *device,
>  		return 0; /* assigned */
>  	}
>  
> -	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size);
> +	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
> +				  opt_flags);
>  
>  	/*
>  	 * bind with 'priv' now to avoid warning in failure path
> @@ -578,7 +583,8 @@ static void fw_abort_batch_reqs(struct firmware *fw)
>  		goto out;
>  	}
>  
> -	ret = _request_firmware_prepare(&fw, name, device, buf, size);
> +	ret = _request_firmware_prepare(&fw, name, device, buf, size,
> +					opt_flags);
>  	if (ret <= 0) /* error or already assigned */
>  		goto out;
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
