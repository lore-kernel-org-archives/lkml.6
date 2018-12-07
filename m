Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC67DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E43920892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544224737;
	bh=CwKPvJ9qZAXKWtJ6e02JDhtI1x643FEDO8Itz8g3ltM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S59OSmgLLOIxpZY7aRzHLJtZTyiMJf/RrW5TStfj4abdk5SqjlsHtW9Zum9eRNLkE
	 An7e7fqCIfWl3FHFAIgmWrI4Ag4Tw12Kq0SQVOESrDvS/kUbN4yTplCAGPx9mY4x5n
	 YQ93FGGYMmh+yS3Iu0j9HT+3VMwTkMinvppP1WOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E43920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeLGXS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:18:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42348 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLGXS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:18:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so5351113otk.9;
        Fri, 07 Dec 2018 15:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jvr0jTPUx+07pe1yLVNEH0HjCh+hqwWss2C6ZhoMVRY=;
        b=RYZ/pDTBR6OIeG8bvEuiP24WsEsVaXQBpYB1wQRU29ijAThE2G23oI+PhEXoO7Win8
         SHTRtNHxmmbgEDwUjmYQ+IvMgg6/c4Jwdz3Y8IxMDB6ov6e84zk8MmcGplgL4Teag2dP
         d0EASBtUgFNG9YY5uBDplwN38+NMXHTPrO3OnE008TYWPIwZ7P461SgJbFdZ/MUjLrpC
         g9xY+U7clIvx2N30CQeFVV03j1WuJkfreW0ujgsHhiu4L5+vER5rAeCmPFVpVxvdinJC
         BHvrmFkYIoKqEPNIcTPs9/bl/q59mCW/ZzMgN5Tf+7i+2vpc5syL2AYd8M3BDmIWxW3a
         5eJQ==
X-Gm-Message-State: AA+aEWYgPJqx+hYJGJyQQXvYpd5zTaRzpB0QlUMpKig16Rtqxxdh44CG
        UsE30BAkvfTF8MwgtjV/pg==
X-Google-Smtp-Source: AFSGD/WhBhwUuxcUOasd0MD7p36ERvThyfw2hUtSwLSH7yjjdU0W+C3Z1Qz5BHhZcV1Xccy3XG+u3g==
X-Received: by 2002:a9d:3d61:: with SMTP id a88mr2946307otc.103.1544224734352;
        Fri, 07 Dec 2018 15:18:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t201sm2245657oie.37.2018.12.07.15.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:18:53 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:18:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: msm/dsi: Add ref clock for PHYs
Message-ID: <20181207231853.GA18012@bogus>
References: <20181204224234.62619-1-mka@chromium.org>
 <20181204224234.62619-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204224234.62619-2-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Dec 2018 14:42:27 -0800, Matthias Kaehlcke wrote:
> Allow the PHY drivers to get the ref clock from the DT.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Chnages in v4:
> - added "Reviewed-by" tags from Stephen and Doug
> 
> Changes in v3:
> - added note that the ref clock is only required for new DTS
>   files/entries
> 
> Changes in v2:
> - add the ref clock for all PHYs, not only the 10nm one
> - updated commit message
> ---
>  Documentation/devicetree/bindings/display/msm/dsi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
