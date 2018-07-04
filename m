Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B974CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6950A24687
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gj+A+Vca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6950A24687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933435AbeGDGId (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:08:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36796 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933206AbeGDGIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:08:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so4385404wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+8+bZ134YX1gumSkbKlEFsmwpDlGMzooOh2DgQ4uyTI=;
        b=gj+A+VcaxuW9+J4j991qtyoMAaYnoSuY7FwlRZ7JD7q3ESFPVUlcMCXCoVdLuH+p1f
         Td+mlRA1dznpbl2ZFg3hnq31Yt8Dfk7iGWo8yBPQTN/8RoueknKNX85z1IA4NznnYjI5
         BicVnWyr+0V1BpOu95tt9fiI70c0Y1ky3osK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+8+bZ134YX1gumSkbKlEFsmwpDlGMzooOh2DgQ4uyTI=;
        b=HfTiRqhLlNOk13oksC1lPb9SuZw5ZYw+CbwhW7vmZirIk6sTZoyUsXkuuMDnYu0wU8
         bjCBLlGqUkq8o+qdOn+0HF2drcEuBcjTYKlNWMvnsuA/41Zb7AYFYw7AiKjbgaxfNSNQ
         hUKJvaMlHRmbnm/KDmRJB9rUTxkagMe7pAEDlNORs2xUuJ4q5T8JP6vmsMAOQbs+1pnU
         z7RCZX4rLUXJZJMSKPMkMjrrmtOhAPRg64zR02GtsMaYaiw8Yj91Pb4SbE+DCF7R+yo9
         P5rDjtBJZ2u24wgRvRmBWn72rOMm2wtbBiG0FvFt1Z8EZkM9ys+lLNcIUACdwDg9cITL
         3flg==
X-Gm-Message-State: APt69E29n8fqJoq5fQsUGiN90qaM7aiZCFNACn2aaWsp5Sz9Sbl5m/vv
        BsWRmVc/BRhh3Q6Dt/JlrZjAvw==
X-Google-Smtp-Source: AAOMgpdv+HC4ohBq3C7TDqZQmZvCiFygfdyLvHUo3g7w7KGUKIHkh5gb7xCUHtdeRokxSJ06kUmYyA==
X-Received: by 2002:a1c:d78c:: with SMTP id o134-v6mr589239wmg.115.1530684510296;
        Tue, 03 Jul 2018 23:08:30 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id c7-v6sm5311753wre.73.2018.07.03.23.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 23:08:29 -0700 (PDT)
Date:   Wed, 4 Jul 2018 07:08:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        miguel.ojeda.sandonis@gmail.com, kernel@collabora.com
Subject: Re: [PATCH v4 3/3] mfd: cros_ec_dev: Register cros_usbpd-charger
 driver as a subdevice.
Message-ID: <20180704060828.GU20176@dell>
References: <20180502154418.2153-1-enric.balletbo@collabora.com>
 <20180502154418.2153-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180502154418.2153-4-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 May 2018, Enric Balletbo i Serra wrote:

> Check whether this EC instance has USBPD host command support and
> instatiate the cros_usbpd-charger driver as a subdevice in such case.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> - [3/3] Use ARRAY_SIZE instead of hardcoded 1.
> 
>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
