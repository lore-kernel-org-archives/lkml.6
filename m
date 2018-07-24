Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769ADC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF9020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSbMzF9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF9020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbeGXMm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:42:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33764 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388289AbeGXMm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:42:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so2722529pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QeeM71aeEdeHqsIApKbxvYSLkWypZV4f3jtXqqmGzz4=;
        b=iSbMzF9iItrsoS+XJ0AOdwgdobMkSU2vZYGFQMMrIII2kctyerpgHHNlhvZG6brBSb
         khxPt03VOLKNP4vUktV72uKA3mPUaG4MRhUgkY+fFAo2i0sLssKDOlzqxP85/Kf+mibX
         9DaeWtUchaaX2CABP+3X9QtwJCC0v6+2rdqrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QeeM71aeEdeHqsIApKbxvYSLkWypZV4f3jtXqqmGzz4=;
        b=bjcjrnBsIeC8jEWESENCpE1k02tY2QLKHYJzelmnM2AnwsNxyygvaI8Oso3I7gN6kz
         CbPdy35oCOEgGdajR9f5oMmAeyIdmAWcnQ5wsrtHvfWW5lq3b4Hb6mJCDoNSdHwVWVKy
         +WGwexy/o3LgXKc55WHw0Q/K6EhRbsJVSQ5/jWbgS9ScN43SiXIi4nJyTelyZOc3O99g
         4/6Ei+dhwsoXZ2bYq/qJUlyBpc0Bg0LMQukbjRRfsKnyQHI/fnEJBkoHQL/ayeYHBwyZ
         nE5U1XPsoCqrpax6+sRGX9VlFjViVWPoet4ZroX+AJQ8OuQGRL+quKalvunfcIwGbSYf
         sX/g==
X-Gm-Message-State: AOUpUlGtyVTT+VKA7IeZVIW2LBlh5L4KIBvcaYVBgzstwv/j/n8af6Es
        o/XOQ+bev43G0gzxjiv+F3VVP+hAk5Q=
X-Google-Smtp-Source: AAOMgpfe+1eRJYnzu7vZAz1tsJ9S4MI2zFs1vF9HRZLjNuOF5dOxMK7LhkiIHRwKth2BFYek1NHIRQ==
X-Received: by 2002:a62:3001:: with SMTP id w1-v6mr17318574pfw.19.1532432216869;
        Tue, 24 Jul 2018 04:36:56 -0700 (PDT)
Received: from localhost ([106.201.120.141])
        by smtp.gmail.com with ESMTPSA id h69-v6sm33359751pfh.13.2018.07.24.04.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 04:36:56 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:06:54 +0530
From:   Vinod Koul <vinod.koul@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Damien Horsley <damien.horsley@imgtec.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/15] dmaengine: img-mdc: Handle early status read
Message-ID: <20180724113654.GL3219@vkoul-mobl>
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-10-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180722212010.3979-10-afaerber@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-18, 23:20, Andreas Färber wrote:
> From: Damien Horsley <damien.horsley@imgtec.com>
> 
> It is possible that mdc_tx_status may be called before the first
> node has been read from memory.
> 
> In this case, the residue value stored in the register is undefined.
> Return the transfer size instead.
> 
> Signed-off-by: Damien Horsley <damien.horsley@imgtec.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  drivers/dma/img-mdc-dma.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
> index 25cec9c243e1..0f2f0f52d83a 100644
> --- a/drivers/dma/img-mdc-dma.c
> +++ b/drivers/dma/img-mdc-dma.c
> @@ -621,25 +621,33 @@ static enum dma_status mdc_tx_status(struct dma_chan *chan,
>  			(MDC_CMDS_PROCESSED_CMDS_DONE_MASK + 1);
>  
>  		/*
> -		 * If the command loaded event hasn't been processed yet, then
> -		 * the difference above includes an extra command.
> +		 * If the first node has not yet been read from memory,
> +		 * the residue register value is undefined

so is this the case when transfer is not started ?

>  		 */
> -		if (!mdesc->cmd_loaded)
> -			cmds--;
> -		else
> -			cmds += mdesc->list_cmds_done;
> -
> -		bytes = mdesc->list_xfer_size;
> -		ldesc = mdesc->list;
> -		for (i = 0; i < cmds; i++) {
> -			bytes -= ldesc->xfer_size + 1;
> -			ldesc = ldesc->next_desc;
> -		}
> -		if (ldesc) {
> -			if (residue != MDC_TRANSFER_SIZE_MASK)
> -				bytes -= ldesc->xfer_size - residue;
> +		if (!mdesc->cmd_loaded && !cmds) {
> +			bytes = mdesc->list_xfer_size;
> +		} else {
> +			/*
> +			 * If the command loaded event hasn't been processed yet, then
> +			 * the difference above includes an extra command.
> +			 */
> +			if (!mdesc->cmd_loaded)
> +				cmds--;
>  			else
> +				cmds += mdesc->list_cmds_done;
> +
> +			bytes = mdesc->list_xfer_size;
> +			ldesc = mdesc->list;
> +			for (i = 0; i < cmds; i++) {
>  				bytes -= ldesc->xfer_size + 1;
> +				ldesc = ldesc->next_desc;
> +			}
> +			if (ldesc) {
> +				if (residue != MDC_TRANSFER_SIZE_MASK)
> +					bytes -= ldesc->xfer_size - residue;
> +				else
> +					bytes -= ldesc->xfer_size + 1;
> +			}
>  		}
>  	}
>  	spin_unlock_irqrestore(&mchan->vc.lock, flags);
> -- 
> 2.16.4

-- 
~Vinod
