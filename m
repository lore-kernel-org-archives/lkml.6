Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A44C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475C6204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVdGqto6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475C6204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937538AbeFSNhr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:37:47 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41855 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeFSNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:37:46 -0400
Received: by mail-lf0-f68.google.com with SMTP id d24-v6so30199075lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z8e4Xf7dbXfKNgfDJQMHp3aGI8jABKz+EJzEG6uXDOM=;
        b=jVdGqto6k2zvako83tfDfStmC1BmSjqh+oCvTAmfOrjtUtHaNXU39gPW8PbB6q6eD1
         DFoUzpPBWaqX6e90rothtWpqIH+GNBDglVCNPtuDRHgC8GuwiQ66SDuhFC3k4HixcGhN
         qt0b22rBUoBJce7ujpsBBo8/zLm+VJf4oKdko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z8e4Xf7dbXfKNgfDJQMHp3aGI8jABKz+EJzEG6uXDOM=;
        b=YVL+OpjDmu0p5d+HIu3XBhVxOvFkPxJtsDNhYU2liiZpsemmmbbOcHf8kaSwv1D0j9
         FwP/p7fKXgvv6bY4Wd8HWamfxflUd73elE8YLb1K1DJFm3X41fgsKSxXka2XociGOxAV
         vHAqpPi3608hi5ca+hG9yhH/VDtrrUkUIwAU/x2q772ICfHiRY89WSXBUz+Y5cs0ykbC
         rcUo5uKY21Xk06sikZMtVO4+yqpjWhjEHN3PxUFP+RdgGI73N/gd6fLIe3XW3mnCbcak
         0xP7+6m6lZtMJbRw5VDHA4feq+T9SZBv+TK5njHiIxCY8a6YOOtc5WfNoAUbg8z1t9ZF
         rJtA==
X-Gm-Message-State: APt69E04wnbLX25fuW7y3Kjz05duc5NbzfnAxSKA4FH+BFo5YqBUjRhU
        WEleWrmnSmZc4024e/f9VTOEKw==
X-Google-Smtp-Source: ADUXVKKUHNhHJrJ5kaPsIuR8Cgh7fAeu7UMvZfsNX0eyb2xXZvlgE7P48JivdrI6NGm/zh+Oz9Gi8Q==
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr7932925ljj.49.1529415464963;
        Tue, 19 Jun 2018 06:37:44 -0700 (PDT)
Received: from jax.urgonet (h-84-45.A175.priv.bahnhof.se. [79.136.84.45])
        by smtp.gmail.com with ESMTPSA id p85-v6sm3177902lje.29.2018.06.19.06.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 06:37:44 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:37:42 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Joakim Bech <joakim.bech@linaro.org>,
        Volodymyr Babchuk <vlad.babchuk@gmail.com>,
        tiger-yu99 <tigeryu99@hotmail.com>,
        David Wang <david.wang@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tee: replace getnstimeofday64() with
 ktime_get_real_ts64()
Message-ID: <20180619133741.GA9537@jax.urgonet>
References: <20180618142511.3598193-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180618142511.3598193-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:24:56PM +0200, Arnd Bergmann wrote:
> The two do the same thing, but we want to have a consistent
> naming in the kernel.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tee/optee/rpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index 41aea12e2bcc..b45c73dd37a5 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -48,7 +48,7 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
>  			OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT)
>  		goto bad;
>  
> -	getnstimeofday64(&ts);
> +	ktime_get_real_ts64(&ts);
>  	arg->params[0].u.value.a = ts.tv_sec;
>  	arg->params[0].u.value.b = ts.tv_nsec;
>  
> -- 
> 2.9.0
> 

Looks good.

Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens
