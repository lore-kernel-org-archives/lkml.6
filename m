Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536D3C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1C92147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFwM3fPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1C92147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeJFNM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 09:12:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35018 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbeJFNM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 09:12:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so1661441pff.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 23:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eXyUJcxUKxIfZ18D8V9yTL19MJVlzPeToQWLyuw2dLo=;
        b=iFwM3fPWPv0XeZt6QT+qdKCokT8wjzO4AW3KIO1uv3kDGiEYLDKKpEfz9o5UyipxUA
         W9n73mqfniizW3EmMWxN3TjvQ0fk4ao94XQYrY4zM3y6PnGGvH3YvTQwZ/m9z6D05JNJ
         xrWZOfPpRx3s1V6320KJsWpciKAO2FDmv7IVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eXyUJcxUKxIfZ18D8V9yTL19MJVlzPeToQWLyuw2dLo=;
        b=jwgcG4lzwDg3nqIdjNuwdNVRHsgyndUSWEXpT9HMmdaQPYYF0tJE8Ef+8KrIYjGhhJ
         fKDikDMhkITt5PEky0n5ECzZALrV5gtAdnWNP6rEZcmdZaMo1eX+G8bFIqsCWZiCFz2V
         vrDJI22p/BFohWVeeH6iuH72mPrmYvemSokUVPMWhodN2nbniK+tALMvFrkeKrkesN6m
         3NvAIZ0LWGSENCY0UvoeXurdYpE07BCRk1xPib4p7065tj1rRvMds8+BOdIW/vuk7aRP
         C2Y8g5EgQ33H5pKzbWT/DGhPOyln6bxVvfOuP4oXnPOfunhLs5L05mFlOO62gh+pVYWU
         B/QA==
X-Gm-Message-State: ABuFfohddadSBqgGd65lmjqfGY7UK0SJtCS/zKXCmsOc8v20sBR5PtAG
        OtKWAHOJA00XQHskeu7YfARA+HvKbmPMXQ==
X-Google-Smtp-Source: ACcGV63LlStf2ZJBNbseDnU2w/o6bBbZ+vT+rkemIOcSBeKt0/Lm4vheOexHXpelD90WmiQr6o3r7g==
X-Received: by 2002:a63:4658:: with SMTP id v24-v6mr13112631pgk.425.1538806255625;
        Fri, 05 Oct 2018 23:10:55 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j5-v6sm10369705pgm.79.2018.10.05.23.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 23:10:54 -0700 (PDT)
Date:   Fri, 5 Oct 2018 23:13:41 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] remoteproc: Fix unbalanced boot with sysfs for no
 auto-boot rprocs
Message-ID: <20181006061341.GC12063@builder>
References: <20180915003725.17549-1-s-anna@ti.com>
 <20180915003725.17549-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180915003725.17549-2-s-anna@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14 Sep 17:37 PDT 2018, Suman Anna wrote:

> The remoteproc core performs automatic boot and shutdown of a remote
> processor during rproc_add() and rproc_del() for remote processors
> supporting 'auto-boot'. The remoteproc devices not using 'auto-boot'
> require either a remoteproc client driver or a userspace client to
> use the sysfs 'state' variable to perform the boot and shutdown. The
> in-kernel client drivers hold the corresponding remoteproc driver
> module's reference count when they acquire a rproc handle through
> the rproc_get_by_phandle() API, but there is no such support for
> userspace applications performing the boot through sysfs interface.
> 
> The shutdown of a remoteproc upon removing a remoteproc platform
> driver is automatic only with 'auto-boot' and this can cause a
> remoteproc with no auto-boot to stay powered on and never freed
> up if booted using the sysfs interface without a matching stop,
> and when the remoteproc driver module is removed or unbound from
> the device. This will result in a memory leak as well as the
> corresponding remoteproc ida being never deallocated. Fix this
> by holding a module reference count for the remoteproc's driver
> during a sysfs 'start' and releasing it during the sysfs 'stop'
> operation.
> 

This prevents you from rmmod'ing the remoteproc driver, but it does not
prevent you from issuing an unbind of the driver - resulting in the same
issue.

I would prefer if we made sure that rproc_del() always cleaned up any
resources (and stopped the remoteproc processor), but I'm uncertain of
how to deal with remote processors that are supposed to survive Linux
shutting down.

But I'm also uncertain how we can make the remoteproc core ensure that
no dynamic resources are leaked in such scenario.

Regards,
Bjorn

> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/remoteproc_sysfs.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 47be411400e5..2142b3ea726e 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -11,6 +11,7 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/module.h>
>  #include <linux/remoteproc.h>
>  
>  #include "remoteproc_internal.h"
> @@ -100,14 +101,27 @@ static ssize_t state_store(struct device *dev,
>  		if (rproc->state == RPROC_RUNNING)
>  			return -EBUSY;
>  
> +		/*
> +		 * prevent underlying implementation from being removed
> +		 * when remoteproc does not support auto-boot
> +		 */
> +		if (!rproc->auto_boot &&
> +		    !try_module_get(dev->parent->driver->owner))
> +			return -EINVAL;
> +
>  		ret = rproc_boot(rproc);
> -		if (ret)
> +		if (ret) {
>  			dev_err(&rproc->dev, "Boot failed: %d\n", ret);
> +			if (!rproc->auto_boot)
> +				module_put(dev->parent->driver->owner);
> +		}
>  	} else if (sysfs_streq(buf, "stop")) {
>  		if (rproc->state != RPROC_RUNNING)
>  			return -EINVAL;
>  
>  		rproc_shutdown(rproc);
> +		if (!rproc->auto_boot)
> +			module_put(dev->parent->driver->owner);
>  	} else {
>  		dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
>  		ret = -EINVAL;
> -- 
> 2.18.0
> 
