Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3687021928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj7gPRrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403990AbeLUX1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:27:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39354 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403840AbeLUX13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:27:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so3129832pld.6;
        Fri, 21 Dec 2018 15:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xCRZlKfvyS6cg47skCLaYmFoZHMCfRO71xBYjwy0dQk=;
        b=cj7gPRrKE15h5gH5FuEf0XRw0MizC8vxKLnc34o6up1HDxRLkdEQ8DuRrUWrcMpifk
         WK2WifX7VUeVHc+O5SKpCgvdOtVDlLLBEWycxMwjcPWemcCC/ni6hvbVQgL1BJQldG65
         Rayz6UGuNmZT8BXRRblgsi6d4dXDEuERSPfiqqWQvsMBGcYlhB5t/G+SR8uu39Zgq0Dq
         dNtoyl4ao8indRpzVoTAB8MTVVtJAhdSOWlMx6b+CxemJOTJqyiBbskJl9gCCmaApTgf
         /YdPrXNaXrv72jwuitSL9pXxNeVnRFuMthtNX7hD9M4FcHrmuOiuMITzgUOCCnZVBOKP
         Mq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=xCRZlKfvyS6cg47skCLaYmFoZHMCfRO71xBYjwy0dQk=;
        b=ZiM7VwDqY2GVP5E0EyIDqF2KIx6R96ksVnYEXXncltoMvh2CJ1iTN1yMiLsxbNqL2c
         ar8W5s117Qf23dxo8sga4PA1Hwfz/pxFjOvfSBE247+FuTcgGWS7kZMjACdndLOs3vcK
         AwMlFPmV1Jx0XxxTo86SzmUod6/Gw94DjAAOXMAvGk8bWzMkhB+YMinE12+J9ae6p+Al
         yl8yUdI5y8MLkTqM5ZhemX9L+EUkZAxZl+KLOLASf1KUDnW7VLK3Lr7I3Di1H6J5hqyl
         PjSdtR1PZwihMqfMM2YJZovcdWGUXM77hAU/HwlQu3T5brFI6jHKO5PgiLhzMUffal7b
         pJGg==
X-Gm-Message-State: AJcUukccGXv7lt2A7gr+iGiKS4l1B4CWU+wQD7Gq5IZr5Px0KIVynG3s
        tZyFeuImopSp0PSzYi8lMl0=
X-Google-Smtp-Source: ALg8bN6Y3MlPU8jWm4SyomAde1zjq9NRq/1x89bAj5uqoTiy+NWGgNGUnsrVG9wxOQZW0YLqi2JIMA==
X-Received: by 2002:a17:902:d202:: with SMTP id t2mr4509191ply.193.1545434849172;
        Fri, 21 Dec 2018 15:27:29 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f20sm29927027pfn.177.2018.12.21.15.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 15:27:28 -0800 (PST)
Date:   Fri, 21 Dec 2018 15:27:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next] staging: octeon: fix build failure with XFRM
 enabled
Message-ID: <20181221232727.GA10639@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:57:26PM +0100, Florian Westphal wrote:
> skb->sp doesn't exist anymore in the next-next tree, so mips defconfig
> no longer builds.  Use helper instead to reset the secpath.
> 
> Not even compile tested.
> 
It does fix the build error.

Tested-by: Guenter Roeck <linux@roeck-us.net>

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 4165079ba328d ("net: switch secpath to use skb extension infrastructure")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  Greg, David:
> 
>  The patch will not break build for a tree that lacks the 'Fixes'
>  commit, so this can also go in via staging tree.
>  OTOH, net-next build is broken for mips/octeon, so I think in
>  this case net-next might make more sense?
> 
> diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
> index df3441b815bb..317c9720467c 100644
> --- a/drivers/staging/octeon/ethernet-tx.c
> +++ b/drivers/staging/octeon/ethernet-tx.c
> @@ -359,8 +359,7 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
>  	dst_release(skb_dst(skb));
>  	skb_dst_set(skb, NULL);
>  #ifdef CONFIG_XFRM
> -	secpath_put(skb->sp);
> -	skb->sp = NULL;
> +	secpath_reset(skb);
>  #endif
>  	nf_reset(skb);
>  
> -- 
> 2.19.2
> 
