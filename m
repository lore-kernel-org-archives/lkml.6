Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CFFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ECA205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnHy+TY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfAQG03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:26:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41157 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729884AbfAQG01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:26:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so4307028pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZcjbTI5xOS96dovzHOGssmsgn7mTRNgCB4K7GgUyByY=;
        b=MnHy+TY/VmeF9spGWlNq55ho73HCUz2OKKcfxan9stjPxB2sYV+SJipJqa1nfdO3hP
         CVbBNP7ePOats3cAlA1Cm24oHcC7huN6JKq14mnl4naZw6jWb3Qbj7pj7kMaEqztxpIX
         frYQJ6J4csGmo8UGWPzxu2eVnGJ9oKr/UrRlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZcjbTI5xOS96dovzHOGssmsgn7mTRNgCB4K7GgUyByY=;
        b=g1FBcCsbIs1bIAMefElTpSjPgd2Lkos1CdMmjTHq7FO475K9sQA/ejIVoExV7TQEGX
         V4HlfLP7N+DmzfzvXg98WM0p9hvkrVyWV4SEtkl4E2wsyEZWY8TptDYQ+rtebJjRK1To
         bpruk8eDlctgFhhFCi1BDd/to9II+J/Sr03Te1YxBSzkP6+31GGM1OyOV/W6pxQ3t+z6
         RJOxmuDcyF5BJNGj0DrX7FctdneWnabT0AXtOc0J9ZJ/sAiLllkpHcRF6BEj08D7BWl5
         ZCNMyzJRSd7rcs5qKrV0piq26XyIu97a65jTdO0JiJCpCdI+eNP+d26UIR7egr75mcpX
         gePA==
X-Gm-Message-State: AJcUukcAQCFIRchhO4lfsRA23HC9G0II05WZkLqx1hqdz/BLb4jfaBSm
        O+tgItIYivtspjDUdEto3/JdFQ==
X-Google-Smtp-Source: ALg8bN5mrh3N/A4MxMIkKcRkj6aiVYA7i4NhIOmAk1S90S0Fhgs+/TbzRCntsH+zpd1QaOoSq9Q3eQ==
X-Received: by 2002:a63:d904:: with SMTP id r4mr12362368pgg.207.1547706386482;
        Wed, 16 Jan 2019 22:26:26 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i5sm997815pfg.34.2019.01.16.22.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 22:26:25 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:25:45 -0800
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
Subject: Re: [PATCH 03/13] mbox: qcom: replace integer with valid macro
Message-ID: <20190117062545.GB25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-4-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545039990-19984-4-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> Use the correct macro when registering the platform device.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index dc8fdab1..b782173 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -108,7 +108,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  register_clk:
>  	apcs->clk = platform_device_register_data(&pdev->dev,
>  						  "qcom-apcs-msm8916-clk",
> -						  -1, NULL, 0);
> +						  PLATFORM_DEVID_NONE, NULL, 0);
>  	if (IS_ERR(apcs->clk))
>  		dev_err(&pdev->dev, "failed to register APCS clk\n");
>  
> -- 
> 2.7.4
> 
