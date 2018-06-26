Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77919C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1531B21BC7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuglPlnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1531B21BC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755077AbeFZUyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:54:44 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35427 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbeFZUym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:54:42 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so9117884plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/nwxPNwJFphxdtI9dq+6Zok5KnCs4rNQjErDzOD6xac=;
        b=KuglPlnviMvA0L6V8Vke705IG6CjVFP8f2E1Ap+oH42tx+RhyDx+oLEM7UDkTjkFsa
         TwL+MjzgULhAJQwRv1Y4KztZtxHCa+Btzkue/qW3lDp10hCPCIC3qp5HDqRPPiqEb+Q8
         r7yf3DE7mv8l+5zxP4vmTalpluhMfb7JqWveU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/nwxPNwJFphxdtI9dq+6Zok5KnCs4rNQjErDzOD6xac=;
        b=PD6NvTy2oXKINOg0ZfEVWhlL9aviSKfW/7T8WI9LD2eS4lP1mINBSHY/QfsTz+JuY+
         ryGbAgzf/A1IebKF7aKcd0TH1thvHlcgYgaBAO9saD90qD0EogXa/+EO6S1ZEpT6KXiQ
         iTQtP8aiKQ8zQs1+DpEQVuRhslPAA2YFK5EVE1Vd83X8MMDLOBAmPyVkBMGhcVdU72X3
         Trk9mLvLr62SBd5+e9d/FUkdbvEBhgeYtjxE2diorUdp9YnUy781mqDQA6X7sgGnkGzQ
         kLs9S51LCpo6iPjjS3nhocu/M20nTqRjaBA6Qn0bAtDAr7LqxZkz1rQCMPYAQBjLh2A6
         osnw==
X-Gm-Message-State: APt69E26GlR8/KMuug5djftYBSjRsnM0/n+sX4rcHsqlTd4yIWlt90Tz
        lGNTePVkLPsbkYjPTK+4gWod0IncuDQ=
X-Google-Smtp-Source: ADUXVKLWufNzmQUz8ypmH1fpodz9pgJJC7X+ldUBwTlpWHaD/cBj1TITdRPD74+hFX37tbuMl4ghNQ==
X-Received: by 2002:a17:902:8210:: with SMTP id x16-v6mr3107783pln.307.1530046481516;
        Tue, 26 Jun 2018 13:54:41 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e10-v6sm3033052pgv.48.2018.06.26.13.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:54:40 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:54:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     ohad@wizery.com, broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] hwspinlock: Add one new API to support getting a
 specific hwlock by the name
Message-ID: <20180626205438.GG3206@builder>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22 Jun 01:08 PDT 2018, Baolin Wang wrote:

> The hardware spinlock binding already supplied the 'hwlock-names' property
> to match and get a specific hwlock, but did not supply one API for users
> to get a specific hwlock by the hwlock name. So this patch introduces one
> API to support this requirement.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Thanks Baolin,

Picked up all but patch 6 from the series; including 7 and 8 with Mark's
ack.

Regards,
Bjorn

> ---
>  drivers/hwspinlock/hwspinlock_core.c |   29 +++++++++++++++++++++++++++++
>  include/linux/hwspinlock.h           |    7 +++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
> index d16e6a3..bea3586 100644
> --- a/drivers/hwspinlock/hwspinlock_core.c
> +++ b/drivers/hwspinlock/hwspinlock_core.c
> @@ -367,6 +367,35 @@ int of_hwspin_lock_get_id(struct device_node *np, int index)
>  }
>  EXPORT_SYMBOL_GPL(of_hwspin_lock_get_id);
>  
> +/**
> + * of_hwspin_lock_get_id_byname() - get lock id for an specified hwlock name
> + * @np: device node from which to request the specific hwlock
> + * @name: hwlock name
> + *
> + * This function provides a means for DT users of the hwspinlock module to
> + * get the global lock id of a specific hwspinlock using the specified name of
> + * the hwspinlock device, so that it can be requested using the normal
> + * hwspin_lock_request_specific() API.
> + *
> + * Returns the global lock id number on success, -EPROBE_DEFER if the hwspinlock
> + * device is not yet registered, -EINVAL on invalid args specifier value or an
> + * appropriate error as returned from the OF parsing of the DT client node.
> + */
> +int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name)
> +{
> +	int index;
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	index = of_property_match_string(np, "hwlock-names", name);
> +	if (index < 0)
> +		return index;
> +
> +	return of_hwspin_lock_get_id(np, index);
> +}
> +EXPORT_SYMBOL_GPL(of_hwspin_lock_get_id_byname);
> +
>  static int hwspin_lock_register_single(struct hwspinlock *hwlock, int id)
>  {
>  	struct hwspinlock *tmp;
> diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
> index 57537e6..2b6f389 100644
> --- a/include/linux/hwspinlock.h
> +++ b/include/linux/hwspinlock.h
> @@ -66,6 +66,7 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned int, int,
>  							unsigned long *);
>  int __hwspin_trylock(struct hwspinlock *, int, unsigned long *);
>  void __hwspin_unlock(struct hwspinlock *, int, unsigned long *);
> +int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name);
>  
>  #else /* !CONFIG_HWSPINLOCK */
>  
> @@ -125,6 +126,12 @@ static inline int hwspin_lock_get_id(struct hwspinlock *hwlock)
>  	return 0;
>  }
>  
> +static inline
> +int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name)
> +{
> +	return 0;
> +}
> +
>  #endif /* !CONFIG_HWSPINLOCK */
>  
>  /**
> -- 
> 1.7.9.5
> 
