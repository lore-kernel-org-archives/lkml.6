Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5806C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7027320840
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdJ+PXqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7027320840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeGaFx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:53:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39296 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGaFx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:53:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id a11-v6so8390161pgw.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MxpVKuEw/hc40ww97UYcgH0BI2KmITs21QmWXUnHBSs=;
        b=gdJ+PXqpY6HnRHFogXWwh3FGa7bXQWBLKz3LBZhuo0xu7xEjccbVd1PR8eI9NVJjtW
         9JUEtBp+p2Ovq6xIv5jCnIB/8NdwQTTD9ACY9oJNQpX1IGQov7zwJMQqBdV1ONgiI964
         zAdP7S2YuClT7qq44J77tSoUK3Z/GpugrqV90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MxpVKuEw/hc40ww97UYcgH0BI2KmITs21QmWXUnHBSs=;
        b=QITYnCEvGrLBxFGkZ0XqFoqpx6EEy5Wzjg9Lx/N1xg4cp9OMNIP3sjx4HQfzWWGQ4w
         iDSIWrWnLj1zMSV1OodGz256eJEMeeuyMXt/yItJ+xMXn7oQW0Ub3yu+lNX7ObTVgjtv
         kM+oFJ01E3lDVLjblhZZags5qgPW/+m8IF9zCzNfrVh3pgrFpmjZrW1EaMOdBrs1z14K
         Hpzhjlgd9JBSHRfXglsPuHpyWTmZ0NelvnRcsO1tfR264VFUvUdqxP/sF4SVadHYOUg1
         qbbVXRk48dCtCCAvV1ZL7QsIvwsu9OhdgkygCZAmPPr0jSxrxw+A/0tXwY3pIteliDYZ
         88aw==
X-Gm-Message-State: AOUpUlH+eXSf2dP54El/KQ5ZP9N+XXMYnUl113ZuQ6ScDDwXxPS3nVVz
        SJz72Af1B4MQmbnsnICFQUo6rg==
X-Google-Smtp-Source: AAOMgpfe7TvAHqkKQmsRBkTEbSJhIWQWsq1Hob0zkE0abOwbAQN5AeQ19mrzNtr8+6Nr11hoPC18Xg==
X-Received: by 2002:a63:fb07:: with SMTP id o7-v6mr19175027pgh.333.1533010511821;
        Mon, 30 Jul 2018 21:15:11 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o3-v6sm15588299pgv.53.2018.07.30.21.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 21:15:11 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:15:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: Reset table_ptr in rproc_start() failure
 paths
Message-ID: <20180731041559.GC5090@builder>
References: <20180727011535.21729-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727011535.21729-1-s-anna@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Jul 18:15 PDT 2018, Suman Anna wrote:

> Unwind the modified table_ptr and restore it to the local copy
> upon any subsequent failures in the rproc_start() function. This
> keeps the function to remain balanced on failures without the need
> to balance any modified variables elsewhere.
> 

Good catch.

> While at this, do some minor cleanup of the extra lines between
> the failure labels as well.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index eadff6ce2f7f..afef2d491c5b 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -953,7 +953,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	if (ret) {
>  		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
>  			rproc->name, ret);
> -		return ret;
> +		goto reset_table_ptr;
>  	}
>  
>  	/* power up the remote processor */
> @@ -979,10 +979,11 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  
>  stop_rproc:
>  	rproc->ops->stop(rproc);
> -
>  unprepare_subdevices:
>  	rproc_unprepare_subdevices(rproc);
> -
> +reset_table_ptr:
> +	if (loaded_table)

Regardless of us having a loaded_table it should have the same value as
cached_table when we return - which might be NULL if we don't have a
resource table.

So I applied this without the conditional, please object if I missed
something.

Regards,
Bjorn

> +		rproc->table_ptr = rproc->cached_table;
>  	return ret;
>  }
>  
> -- 
> 2.18.0
> 
