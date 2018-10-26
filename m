Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71DBC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0C920651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="KweMQV+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0C920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeJZXTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:19:00 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37917 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeJZXTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:19:00 -0400
Received: by mail-yb1-f193.google.com with SMTP id v92-v6so560173ybi.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yiQi/aC+OLSM4Q4ODlaqVjBcti4KXHFG8osa6YORXkI=;
        b=KweMQV+QCH1dRCbvJCQBT9H9fKLS2mSXkyfTZQPSjJeu0UqQBkW68vls5UsdyAIFDL
         oHnj8HDcA1o+37xKx778IBCKes1jPV5rrOaf1EdSRtELlswJitqeqzKdbBEYdQSQYGPA
         rNLotYJRSiAVj5Xo7+9GdJbNHztl/3to16/j0hu9gEvEQ4o+oBfvryXEz/6V2Y/jGUC5
         YLm02bt1LHZNSJGRu2Lt5f6aS2iF1cSOLNqA2eaFNmEd6DzgRrsjc0L+doXsEYHLKUFK
         F2VbMC00Uuv47PbJuSmpPgkd0ou65W9JK9jJjhDyyaZpLmmxyO5SI+iwSHBkVAsvBjBG
         pQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yiQi/aC+OLSM4Q4ODlaqVjBcti4KXHFG8osa6YORXkI=;
        b=UEGZGJDE2XuIYSJ3e5gWxn3xsXnLqMnDJGpD5TjApKX4THxDECrlAVfu6X62d24N95
         nSFm0SqgXz4vSCSVQOC4aABoYwZPMgB8cXYjg/aQHjBZE5bZ8dZ5a7xVkoqi19odVZRD
         PA9JSXPr+L3GlE3qnypGbdJSWUj/Nn5K2EZJKunXlV3NpnHiyEwp7fXgbgw/EX+S8Q4G
         ks3o5+FiVqJRUntG8nTiCbhr4OBf3mTeg6zFEWT8Vrn/a1PoO/AmYqwbfcbRafTgZYmx
         RS2Xt32XN42Q9Two5aM2fCEr8c9lFI2ca//4Xt2bNSedZaulR+yoX5bqZYEViCllsR+5
         GoVg==
X-Gm-Message-State: AGRZ1gJkIg62iXJCb0QhhZoeCmjwTtvRx18rXCqp26oMyqlVGOVYEJeD
        +CiQqmKv+8Pc14hujGx05SHwNQ==
X-Google-Smtp-Source: AJdET5eIyv8+jRXO9JZJQDaJn7veC40QDyAFMOmNgv5CZRQvdCRSuiCPOxB1HfgrdUYus+u8ng5vPQ==
X-Received: by 2002:a25:81c9:: with SMTP id n9-v6mr3734167ybm.314.1540564900386;
        Fri, 26 Oct 2018 07:41:40 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id j2-v6sm3044403ywe.92.2018.10.26.07.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 07:41:39 -0700 (PDT)
Date:   Fri, 26 Oct 2018 10:41:39 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] drm/panel: simple: Add "no-hpd" delay for Innolux
 TV123WAM
Message-ID: <20181026144139.GR154160@art_vandelay>
References: <20181025222134.174583-1-dianders@chromium.org>
 <20181025222134.174583-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025222134.174583-3-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 03:21:31PM -0700, Douglas Anderson wrote:
> If the HPD signal isn't hooked up to this panel we need a 200 ms
> delay.  In the datasheet this is shown as the maximum time that HPD
> will take to be asserted after power is given to the panel.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
> 
> Changes in v2:
> - Use "hpd_absent_delay" property instead of a bool + prepare delay
> 
>  drivers/gpu/drm/panel/panel-simple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 687fd087b9fc..88592f9a0018 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1396,6 +1396,7 @@ static const struct panel_desc innolux_tv123wam = {
>  		.height = 173,
>  	},
>  	.delay = {
> +		.hpd_absent_delay = 200,
>  		.unprepare = 500,
>  	},
>  };
> -- 
> 2.19.1.568.g152ad8e336-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
