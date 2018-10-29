Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D65C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A5A20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A5A20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJ3BtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:49:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44350 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeJ3BtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:49:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3-v6so4183188pgs.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fjp/2LgEz4sreZLvSJt+2RXJB005XlLbCPpz0qp03zA=;
        b=ZaTtsIQq4H/3nWyb7F4QJru0svopYw60RHL34tWJG8P3faM1gxo1VCvwHeTi2NZtCG
         n2gTlLRKqRArLLdiOUCRniY9e0sMB3TiH+un7ZzfF+LiK0RZkcPCJL3VzXvV8urD8C1x
         KPoxT8WedTZ0gSbZN1Yajd5lryiU/4UpXw7OnM4S+/gp4xBBtg/nBw/PQWa1ZPZbslq/
         nrrJC9dgEkAX3Pb4kcIGlAE+ykqpjdKI+YPcsVqN/3kL+VqGolePMrSb9yry8lVn8Ino
         6ZdKbb1MOvOhXp397+X01iw/F9SNl8dSoFo2ZPigw2+7bOnhx0v2iEmgx2KR1bnPxurd
         Xplg==
X-Gm-Message-State: AGRZ1gJZlrbqYKsuWes+4JTMARBKZ+M699g7bMgUIyS8ctLxbAd9i81N
        Md+QhEO6LDiOANdnGXga2JSVMw==
X-Google-Smtp-Source: AJdET5ccAa+v/+TOmpzCgsFlWWFkG+7tFpsrPRFz7AQwV2pcqvpY6errLf0UGx5/JajGdqzchKu9pw==
X-Received: by 2002:a62:460c:: with SMTP id t12-v6mr16272809pfa.206.1540832387320;
        Mon, 29 Oct 2018 09:59:47 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id f13-v6sm23481271pfa.109.2018.10.29.09.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 09:59:46 -0700 (PDT)
Date:   Mon, 29 Oct 2018 09:59:45 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Anatolij Gustschin <agust@denx.de>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Puhm <puhm@oregano.at>
Subject: Re: [PATCH v2] fpga: altera-cvp: Fix registration for CvP incapable
 devices
Message-ID: <20181029165945.GB2453@archbook>
References: <20181029072630.13339-1-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029072630.13339-1-agust@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anatolij, Andreas,

On Mon, Oct 29, 2018 at 08:26:30AM +0100, Anatolij Gustschin wrote:
> From: Andreas Puhm <puhm@oregano.at>
> 
> The probe function needs to verify the CvP enable bit in order to
> properly determine if FPGA Manager functionality can be safely
> enabled.
> 
> Fixes: 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")
> Signed-off-by: Andreas Puhm <puhm@oregano.at>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>

Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> Changes in v2:
>  - improve Fixes tag
>  - wrap lines in commit description
> 
>  drivers/fpga/altera-cvp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 3998d4f0e5e7..196d52558990 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -403,6 +403,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	struct altera_cvp_conf *conf;
>  	struct fpga_manager *mgr;
>  	u16 cmd, val;
> +	u32 regval;
>  	int ret;
>  
>  	/*
> @@ -419,6 +420,14 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  		return -ENODEV;
>  	}
>  
> +	pci_read_config_dword(pdev, VSE_CVP_STATUS, &regval);
> +	if (!(regval & VSE_CVP_STATUS_CVP_EN)) {
> +		dev_err(&pdev->dev,
> +			"CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
> +			regval);
> +		return -ENODEV;
> +	}
> +
>  	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
>  	if (!conf)
>  		return -ENOMEM;
> -- 
> 2.17.1
> 

Thanks,
Moritz
