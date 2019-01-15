Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D098C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB4020657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEIvqevw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfAOA2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:28:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34708 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfAOA2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:28:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so423465plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HIdphcsd1VzX5urnUWoRbWr5lYOfgU/bSkeRW/O4hWI=;
        b=CEIvqevwSji8x00QhEF+xK30XN/1JCSrshBELgzA8i3/woHP2pYkhLpLKVFb+LOpNE
         EaX1nZkMVPG8w03gp0W2FopTZmOU/tCpdELIMoC5kjwpUclRKb7WlIr28TW/m6n4SraR
         nqRWORn4Fsro9xjM0dZXVubDS/EzXn2nIzWXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HIdphcsd1VzX5urnUWoRbWr5lYOfgU/bSkeRW/O4hWI=;
        b=s9VkkdS1JApU5Cq6NMopDoHr67ZiTdabgAwGM5R07SDuUxHdNaSiMdNkbyX2elCWLP
         P9Gctwbg8p2fDG2xro/dcgCKiEDijEuomkye0OhJf2XZtDG51ICO8aadtF4FzGIQy6wy
         UJqg7NHXHMeklrEPEnUN2Zr4H1nkjekwpcssmfxmJjHwXTucvz1NYWFAEpCY8FMkprkX
         zquSGUnmrPdWoldL7aULuKLEPWOHsztFIk8mwAr3YH7myZkMVKAtHgxHbOmRjnYQEpd4
         A6qJjf6o+GFHop9bkgx8mgbC+ifze1AKgGJFRuu8DscArAQd2GGvjb9hfahL/pEN8VfL
         w+ew==
X-Gm-Message-State: AJcUukejViD2/Amc0CNPJ7JmLX1yt67eLKhRTbxHU321vTZvyMU1kC5W
        Pl6BH4vzmZjlX2LJ6ZTvcteBSw==
X-Google-Smtp-Source: ALg8bN5qfNbKDd7o4hLA0mK2QSLJwKM2Xgxk61L33PBS6RCgf5YOFuwXnovQD5wjvMnKXwfz2kRABQ==
X-Received: by 2002:a17:902:74cc:: with SMTP id f12mr1237940plt.134.1547512101751;
        Mon, 14 Jan 2019 16:28:21 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h8sm1588844pgv.27.2019.01.14.16.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:28:20 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:28:18 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/14] dt-bindings: pinctrl: qcom-pmic-gpio: add
 qcom,pmi8998-gpio binding
Message-ID: <20190115002818.GH9278@minitux>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113154716.5145-2-masneyb@onstation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 13 Jan 07:47 PST 2019, Brian Masney wrote:

> Add support for the PMI8998 GPIO variant to the Qualcomm PMIC GPIO
> binding document.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> This is a new patch introduced in V4.
> 
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> index 759aa1732e48..7f64a7e92c28 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> @@ -19,6 +19,7 @@ PMIC's from Qualcomm.
>  		    "qcom,pm8998-gpio"
>  		    "qcom,pma8084-gpio"
>  		    "qcom,pmi8994-gpio"
> +		    "qcom,pmi8998-gpio"
>  		    "qcom,pms405-gpio"
>  
>  		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
> -- 
> 2.17.2
> 
