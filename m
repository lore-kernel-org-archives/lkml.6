Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587DCC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C82208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVMWRXF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C82208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbeGJVOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:14:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35812 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732272AbeGJVOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:14:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id q7-v6so15815133pff.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pIPoQGarde9DbCv04Xv0qCWCTeXyVyEgTz50OzL6N8c=;
        b=DVMWRXF/t+IF3Oso/JOnNba0CNnH+0L2r7979pHL1yFO/f4cTAyODDVkICQ2u/hOxG
         GAFby3iOzdT9iORvoG+4o7LlN0F5Im5i/+Q/Tn+9jrkBkUOIWV5Qx6bDkUmyfPqkM8zg
         9vFXiSjlzGXvq4KFMl5R3zCQxbgUkdbla9X0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pIPoQGarde9DbCv04Xv0qCWCTeXyVyEgTz50OzL6N8c=;
        b=rN1qftnHP0EW4bk7YSnItu2/wmNHWMe4aA/ON5IP2jSWvMtUhTgu6ZYI9/bgmIXtB+
         +S75Qe00NUchuM/WC4Z3EQt/Ym1UPGFR9o6tx+jHXvtzH6mcy1+5ym8HyRIY3liwy1Av
         gtCb2+B0HR8+NRTVQp5iDT2exFAnYSZoy0QmbW1duko7LTf+iD7ZdJfqT+LQ/mRP1I/Z
         7wZsI+M1FenvB5EPyk5x0E5xYS5sGqgegg95JSfo9qQXxmsxu0rvNt2/Uf0RLhsbpJP1
         nVRn7ze7cdhs9l85jD45L8rd/JOT3+61fnKefZV2Qry8a02QcU02Jl8vCYu1l4GVa/1a
         Ckjg==
X-Gm-Message-State: APt69E3Nx9NoxLbBTfQFNuPnKYDmbQncB4xpCAX/g5ei2P4MWiuP48AP
        bYUBtvGcYpkhSce6tk9hd8d33w==
X-Google-Smtp-Source: AAOMgpfU/NauqIAXMuX7AotputwYXpa1VVLUJTrrrWdzWkexnXMByeVMbfFfwapTucCD+pa3vkHHUQ==
X-Received: by 2002:a63:524e:: with SMTP id s14-v6mr23113509pgl.35.1531256885000;
        Tue, 10 Jul 2018 14:08:05 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p3-v6sm1953416pfo.130.2018.07.10.14.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 14:08:04 -0700 (PDT)
Date:   Tue, 10 Jul 2018 14:08:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom q6v5: fix modular build
Message-ID: <20180710210816.GB21402@builder>
References: <20180706125804.3572356-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706125804.3572356-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06 Jul 05:57 PDT 2018, Arnd Bergmann wrote:

> The new driver only works as built-in code at the moment but fails
> with a link error when configured as a loadable module:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/remoteproc/qcom_q6v5.o
> see include/linux/module.h for more information
> ERROR: "qcom_q6v5_init" [drivers/remoteproc/qcom_q6v5_pil.ko] undefined!
> ERROR: "qcom_q6v5_wait_for_start" [drivers/remoteproc/qcom_q6v5_pil.ko] undefined!
> ERROR: "qcom_q6v5_prepare" [drivers/remoteproc/qcom_q6v5_pil.ko] undefined!
> ERROR: "qcom_q6v5_unprepare" [drivers/remoteproc/qcom_q6v5_pil.ko] undefined!
> ERROR: "qcom_q6v5_request_stop" [drivers/remoteproc/qcom_q6v5_pil.ko] undefined!
> ERROR: "qcom_q6v5_init" [drivers/remoteproc/qcom_adsp_pil.ko] undefined!
> ERROR: "qcom_q6v5_wait_for_start" [drivers/remoteproc/qcom_adsp_pil.ko] undefined!
> ERROR: "qcom_q6v5_prepare" [drivers/remoteproc/qcom_adsp_pil.ko] undefined!
> ERROR: "qcom_q6v5_unprepare" [drivers/remoteproc/qcom_adsp_pil.ko] undefined!
> ERROR: "qcom_q6v5_request_stop" [drivers/remoteproc/qcom_adsp_pil.ko] undefined!
> 
> This exports the internal symbols as needed and adds the MODULE_LICENSE()
> and MODULE_DESCRIPTION() tags. I could not figure out the author, so I
> did not add a MODULE_AUTHOR() tag for now.
> 
> Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd.

Regards,
Bjorn

> ---
>  drivers/remoteproc/qcom_q6v5.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 400cdf936f6b..61a760ee4aac 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> +#include <linux/module.h>
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/smem_state.h>
>  #include <linux/remoteproc.h>
> @@ -32,6 +33,7 @@ int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(qcom_q6v5_prepare);
>  
>  /**
>   * qcom_q6v5_unprepare() - unprepare the qcom_q6v5 context after stop
> @@ -45,6 +47,7 @@ int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5)
>  
>  	return !q6v5->handover_issued;
>  }
> +EXPORT_SYMBOL_GPL(qcom_q6v5_unprepare);
>  
>  static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>  {
> @@ -114,6 +117,7 @@ int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout)
>  
>  	return !ret ? -ETIMEDOUT : 0;
>  }
> +EXPORT_SYMBOL_GPL(qcom_q6v5_wait_for_start);
>  
>  static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
>  {
> @@ -157,6 +161,7 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5)
>  
>  	return ret == 0 ? -ETIMEDOUT : 0;
>  }
> +EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
>  
>  /**
>   * qcom_q6v5_init() - initializer of the q6v5 common struct
> @@ -241,3 +246,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(qcom_q6v5_init);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Qualcomm Peripheral Image Loader for Q6V5");
> -- 
> 2.9.0
> 
