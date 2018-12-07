Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD3DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9B22083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ub1GweDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9B22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeLGRgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:36:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40053 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeLGRgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:36:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so2015652pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=InQ3Z4HbCnPz3pvoWdA9mJyPnl/wWHBDkosKcL+xHjA=;
        b=Ub1GweDrbck0HEDikd6VmDp3NZUnXJfgE7yLlUV93wtPtSFfnTLkSQnyW6mI5Bl+wz
         aHBALh5gTRD0kKbyM07Xfs0jE46LZL95LkGluLXcWx9IbKatZtU5GrZkNrfwJ4DMKYK2
         wZY3fHSIxwWFcC8xUqdEDhZs46fwcoxszNNtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=InQ3Z4HbCnPz3pvoWdA9mJyPnl/wWHBDkosKcL+xHjA=;
        b=muiCvABuW+KAZ/Y+z2WVfdYkQ5wEIRz7z8LL3UOuUFyl+mJ6/3JD3l07MJRyHbXtHz
         uIH1moaOT/EDB8ZLsjPa2kSFUvGu5HLSwvDsaAYQ6LfnCw0RxAV5Yxz/6sNuIkhMvypR
         TcDUOLjbnFt9+8MCiZrCN81/8IGu0AqP2E7X3grkUynwASToqa5wn2cmY/fg3IyOqqc5
         nvZE/yLSWV+0po7sJWKi3YN9mpabVXKLZKcMe/V77CpgRS/F7ulrWjU1fld5zgqHYDP+
         BagoutCwJEYmLI0xHbcsw9Mt9j+Ii4MZ/uDEVlI25AdgAPB2/EXtagbKTT806+0R99Vf
         7MkA==
X-Gm-Message-State: AA+aEWZiKGndmoMBIOC+I6x4SqXmgG3M3eR4LECdd99UDif+KKAzOncC
        Ywo05KalrH5tJH1G6POL87nG9A==
X-Google-Smtp-Source: AFSGD/X+/VAWh2v+fQZtH8PGpkgwuQ3tR7+x5gfUjCvsB9wqNUHo9eBf/d7r/2NDadmzD9hiJmkLqA==
X-Received: by 2002:a62:824c:: with SMTP id w73mr3116811pfd.150.1544204175926;
        Fri, 07 Dec 2018 09:36:15 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e86sm6012638pfb.6.2018.12.07.09.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 09:36:15 -0800 (PST)
Date:   Fri, 7 Dec 2018 10:36:13 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: Use of_node_name_eq for node name comparisons
Message-ID: <20181207173613.GA27493@xps15>
References: <20181205195050.4759-34-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205195050.4759-34-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 01:50:50PM -0600, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/hwtracing/coresight/of_coresight.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index 89092f83567e..7045930fc958 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -80,8 +80,8 @@ static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
>  	 * Skip one-level up to the real device node, if we
>  	 * are using the new bindings.
>  	 */
> -	if (!of_node_cmp(parent->name, "in-ports") ||
> -	    !of_node_cmp(parent->name, "out-ports"))
> +	if (of_node_name_eq(parent, "in-ports") ||
> +	    of_node_name_eq(parent, "out-ports"))
>  		parent = of_get_next_parent(parent);

Applied - thanks.

>  
>  	return parent;
> -- 
> 2.19.1
> 
