Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A329FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C44220856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwjJnC/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfAQG0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:26:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40396 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbfAQG0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:26:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so3972097pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b6oO4hJkrokTcoyK5DzVWM2dwkV29FZtWLlVvwJwlU0=;
        b=WwjJnC/VD2ffmy1KuOcgUPjpS1m4sX2+Oe0ygvF+4Exsd86SYih8UqvNisckxbtqdX
         NuLgMv4GAZgL8Eoqtejn0cs3dggqLfLVfcx2q/C97QFua1OfNZF5rtHdwm+3lp/pLjHP
         f0AAydrkxqcVnVoqHNpOAgcSm4ErWbDD5kbj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b6oO4hJkrokTcoyK5DzVWM2dwkV29FZtWLlVvwJwlU0=;
        b=diftXAXuyvPy26VGBG2uNu9TJxOIBnSlqBLOGuofOgLSYMRYLEVx06nNMR6F1WFiss
         k5SHipbWxcH3CNqPgEH5NGBPFncm61ahtw9kvmk9pmTXRnQfS5VlC13VjK1LX/dLRqsT
         qziWQqLxs2vX85UR433PFw6ZA0JRcBM1NN6cyfwBZFQa0/DZVP+I88DZLduIyuvueOA7
         XNEO9r6WOeBcq9bLsrQk97x95E6nJ2iUfBNk7V9tBqZHHJUP5n4lVyTJ+DJ0JjO1DMKu
         KLd5WeniNgfZzDo0ZJZQfL2MwlxfbFpDE3TmNSMxGQm+LliZ2URxcSiTjY/pF9qARQYk
         +k6w==
X-Gm-Message-State: AJcUukfj3LJOAUpioy0BuKVoobYIL1aTjDQ4cM4A21VXuu+s5XgMISvv
        aYZtVcDablwgKfEV7GNrsFaY2A==
X-Google-Smtp-Source: ALg8bN4o6v2C4wRkw9EJ8UWK1ReUBkRAibfXPLX+4mL7IPo64cLU1BMxGKk/QVkH+yqrBe6pkNbWCQ==
X-Received: by 2002:a63:7306:: with SMTP id o6mr12096593pgc.343.1547706372118;
        Wed, 16 Jan 2019 22:26:12 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d69sm1178833pfg.168.2019.01.16.22.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 22:26:11 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:25:31 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        vkoul@kernel.org, niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 02/13] mbox: qcom: add APCS child device for QCS404
Message-ID: <20190117062531.GA25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545039990-19984-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> There is clock controller functionality in the APCS hardware block of
> qcs404 devices similar to msm8916.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index aed23ac..dc8fdab1 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -97,16 +97,21 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global")) {
> -		apcs->clk = platform_device_register_data(&pdev->dev,
> -							  "qcom-apcs-msm8916-clk",
> -							  -1, NULL, 0);
> -		if (IS_ERR(apcs->clk))
> -			dev_err(&pdev->dev, "failed to register APCS clk\n");
> -	}
> -
>  	platform_set_drvdata(pdev, apcs);
>  
> +	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global") ||
> +	    of_device_is_compatible(np, "qcom,qcs404-apcs-apps-global"))
> +		goto register_clk;
> +
> +	return 0;
> +
> +register_clk:
> +	apcs->clk = platform_device_register_data(&pdev->dev,
> +						  "qcom-apcs-msm8916-clk",
> +						  -1, NULL, 0);
> +	if (IS_ERR(apcs->clk))
> +		dev_err(&pdev->dev, "failed to register APCS clk\n");
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
