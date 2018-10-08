Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B95C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC6420882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNx8rEgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC6420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeJHNau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:30:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44776 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHNau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:30:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so7326805pgu.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 23:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GAkjZQTm5FFLHPFx6/v/cGxbUknhY8mc1Q8XmCTMgV8=;
        b=SNx8rEgX/0QMfg7Q9KQP5F89kZQDKZK57+F+wb0lQI06gIsNeq0AmKUWbOHahxuHIr
         U8bN9wZOu41GE9/mVF6ydmNHF+l+D3pIEXpmPLtsOBFzRt9Q3+esxlgqxgXRebGSTc31
         6jlCMid0IdC+VWfUTf1YgrlmZJOUiIbiKje94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAkjZQTm5FFLHPFx6/v/cGxbUknhY8mc1Q8XmCTMgV8=;
        b=G5/lLMc7b3lPltu0Lppu8eXelMyNVmuv0Weae7Am7+CuQ3Pw4EVgm/fNSUVLxJ1CkJ
         4+cwTQryH2M5OHvMvqxxnMU2rN1mXqryreNOLg/4ZqjdxckpVzmVaGXQycZcjjkTAFdr
         D2VLD1janLAgbVoo/zC84ev6IntLKeZMN6thacW2etwpo2JVC/UAG2qlceDHm3+Ey5Gt
         lJHa+q5WXGBFy6m3UEjUbxU+Zsn99K0pfgmY+Jw8pATZDCuzJk7X32xcfywTSiadGtjd
         8Ep4yUy3RUeEYttCWftEWXnzSX8NRcP6YXhyRoY/PASsKV/Rhd/JG3Fcrp634NogA68n
         Hx5Q==
X-Gm-Message-State: ABuFfoi2mGN7/Urh2i/VBCs7M8sY+yZjAc3QGhdMB4jAa97t1ouzfW3d
        iM1bcb+1QHkO721yeKQAN/4UlQ==
X-Google-Smtp-Source: ACcGV63IhrfDbCeF+58FMv8TIqG86xqLo9BJDKBvRZXGCiUewQ54kN7v1xy17wteS/pzgDtgJTBX+Q==
X-Received: by 2002:a63:2d43:: with SMTP id t64-v6mr20158882pgt.128.1538979644585;
        Sun, 07 Oct 2018 23:20:44 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r18-v6sm13822678pgv.17.2018.10.07.23.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 23:20:43 -0700 (PDT)
Date:   Sun, 7 Oct 2018 23:23:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v3 1/6] remoteproc: Introduce custom dump function for
 each remoteproc segment
Message-ID: <20181008062333.GN12063@builder>
References: <20180727152003.11663-1-sibis@codeaurora.org>
 <20180727152003.11663-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727152003.11663-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Jul 08:19 PDT 2018, Sibi Sankar wrote:

> Introduce custom dump function per remoteproc segment. It is responsible
> for filling the device memory segment associated with coredump
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 15 ++++++++++-----
>  include/linux/remoteproc.h           |  3 +++
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 283b258f5e0f..ec56cd822b26 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1183,13 +1183,18 @@ static void rproc_coredump(struct rproc *rproc)
>  		phdr->p_align = 0;
>  
>  		ptr = rproc_da_to_va(rproc, segment->da, segment->size);
> -		if (!ptr) {
> -			dev_err(&rproc->dev,
> +
> +		if (segment->dump) {
> +			segment->dump(rproc, ptr, segment->size, data + offset);

rproc_da_to_va() is an exported symbol, so if you pass segment to the
dump function the driver can, if it needs to, call the function itself.

A typical use case, that I see, is to use the custom dump function to
write out CPU or hardware state to the dump file, in which case the "da"
won't be valid.


So please make this call dump(rproc, segment, data + offset) and move
the rproc_da_to_va() into the else block.

> +		} else {
> +			if (!ptr) {
> +				dev_err(&rproc->dev,
>  				"invalid coredump segment (%pad, %zu)\n",
>  				&segment->da, segment->size);
> -			memset(data + offset, 0xff, segment->size);
> -		} else {
> -			memcpy(data + offset, ptr, segment->size);
> +				memset(data + offset, 0xff, segment->size);
> +			} else {
> +				memcpy(data + offset, ptr, segment->size);
> +			}
>  		}
>  
>  		offset += phdr->p_filesz;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e3c5d856b6da..0fbb01a9955c 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -399,6 +399,8 @@ enum rproc_crash_type {
>   * @node:	list node related to the rproc segment list
>   * @da:		device address of the segment
>   * @size:	size of the segment
> + * @dump:	custom dump function to fill device memory segment associated
> + *		with coredump
>   */
>  struct rproc_dump_segment {
>  	struct list_head node;
> @@ -406,6 +408,7 @@ struct rproc_dump_segment {
>  	dma_addr_t da;
>  	size_t size;
>  
> +	void (*dump)(struct rproc *rproc, void *ptr, size_t len, void *priv);

"priv" isn't the best name to represent the memory to which you expect
dump to write to. Please call it "dest".

>  	loff_t offset;
>  };

Regards,
Bjorn
