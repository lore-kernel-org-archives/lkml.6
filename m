Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0341C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E3C213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYaz8iY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E3C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJDHpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:45:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35846 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeJDHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:45:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id b7-v6so2500129pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 17:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ABMhAV/wQYAX7YsQXcF6ItaCBUorFc3bFz1Cdfn2xk0=;
        b=DYaz8iY5Oh48w5HAxrgCKYHVOrOj5pw2nXHPXv+vmUZcgityBpYbbbotsTjwEAhJSB
         lMt+Spmoh9Vs7i0/K/dCCtdS9kHXX/V2Tt1eAUEKTeoFfKzz//LCnF76j9YgD137bFj4
         r/6CXle/D6eaTG71rT78PY9FPJAe5o1YScEX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ABMhAV/wQYAX7YsQXcF6ItaCBUorFc3bFz1Cdfn2xk0=;
        b=GyYmTYNyrShfxVGVuoyfeJUqZMWVuNvhmLd6ZCAtInM/w6CtnoMVEpD3VSlMOGARnU
         alKdePLrEeYJSMOb6bE3Jj2Ee6wQ+LfB27IivbSOyZS8rZVwyLw1nA36iSRmCQ23ZtKu
         J7teSmsdQvCPYxd274TFyT+LqopS5twCJtjMvdairJtXl8/WNMmAbObRP9a99Q9o9PWW
         GPnnjvIqYFsyBR7Ki0Vk+RDMkqh8yj8GSsS5XFMXeOuP+tVeIKdSFcgaG64wU5jA2X7a
         qDkaqpFHYQiNHjyIDc2BF9Jb/Img4k6CCwQtJ1FPtuYteEyqAOXDKyLD6is1cCbN/G6A
         r+4Q==
X-Gm-Message-State: ABuFfoi2B7wy06pFU4RtGE1yS9eDIKL+Ea0TSEmPb2jjHkq+GOfz8TEw
        MTTK1JDpu11+ShiLYuSNPEQxSYuGOoep9g==
X-Google-Smtp-Source: ACcGV62PPAqGXKXq7fUIg8rjYTUAfvBKACyQD7WxzZ/Faa7o9GEGhqSUCY3pG9RYGO2wpMf59FK0BA==
X-Received: by 2002:a63:904a:: with SMTP id a71-v6mr3653236pge.264.1538614476221;
        Wed, 03 Oct 2018 17:54:36 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s195-v6sm5533336pgs.76.2018.10.03.17.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 17:54:35 -0700 (PDT)
Date:   Wed, 3 Oct 2018 17:54:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     ohad@wizery.com, clew@codeaurora.org, sricharan@codeaurora.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] rpmsg: Add TIOCMGET/TIOCMSET ioctl support
Message-ID: <20181004005433.GX2523@minitux>
References: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
 <1538566463-24627-4-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538566463-24627-4-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03 Oct 04:34 PDT 2018, Arun Kumar Neelakantam wrote:

> Add TICOMGET and TIOCMSET ioctl support for rpmsg char device nodes
> to get/set the low level transport signals.
> 
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
> ---
>  drivers/rpmsg/rpmsg_char.c | 54 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 86003d5..c983d6c 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -20,6 +20,7 @@
>  #include <linux/rpmsg.h>
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
> +#include <linux/termios.h>
>  #include <linux/uaccess.h>
>  #include <uapi/linux/rpmsg.h>
>  
> @@ -274,15 +275,62 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
>  	return mask;
>  }
>  
> +static int rpmsg_eptdev_tiocmset(struct file *fp, unsigned int cmd,
> +				 unsigned long arg)

Make arg type int __user *

> +{
> +	struct rpmsg_eptdev *eptdev = fp->private_data;
> +	u32 lsigs, rsigs, val;
> +	int ret;
> +
> +	ret = get_user(val, (u32 *)arg);
> +	if (ret)
> +		return ret;
> +
> +	ret = rpmsg_get_sigs(eptdev->ept, &lsigs, &rsigs);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (cmd) {
> +	case TIOCMBIS:
> +		lsigs |= val;
> +		break;
> +	case TIOCMBIC:
> +		lsigs &= ~val;
> +		break;
> +	case TIOCMSET:
> +		lsigs = val;
> +		break;
> +	}
> +
> +	ret = rpmsg_set_sigs(eptdev->ept, lsigs);

This is racy, as the signals might change while we update them. Mimic
tty_tiocmset() instead and make rpmsg_set_sigs() take a clear and set
mask.

And please do spell out rpmsg_set_signal() and rpmsg_get_signal().

> +	return ret;

return rpmsg_set_signals();

> +}
> +
>  static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>  			       unsigned long arg)
>  {
>  	struct rpmsg_eptdev *eptdev = fp->private_data;
> +	u32 lsigs, rsigs;
> +	int ret;
>  
> -	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
> -		return -EINVAL;
> +	switch (cmd) {
> +	case TIOCMGET:
> +		ret = rpmsg_get_sigs(eptdev->ept, &lsigs, &rsigs);
> +		if (!ret)
> +			ret = put_user(rsigs, (u32 *)arg);

Cast to int __user *

> +		break;
> +	case TIOCMSET:
> +	case TIOCMBIS:
> +	case TIOCMBIC:
> +		ret = rpmsg_eptdev_tiocmset(fp, cmd, arg);
> +		break;
> +	case RPMSG_DESTROY_EPT_IOCTL:
> +		ret = rpmsg_eptdev_destroy(&eptdev->dev, NULL);
> +	default:
> +		ret = -EINVAL;
> +	}
>  
> -	return rpmsg_eptdev_destroy(&eptdev->dev, NULL);
> +	return ret;
>  }

Regards,
Bjorn
