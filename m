Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D22C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2F520848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXbvTPaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2F520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeLCPz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:55:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34647 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeLCPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:55:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so6683459plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 07:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hvPt/xVlGWX+uMrv7boCKzd2w9RNx+Xk0MMS9Ja4/hA=;
        b=gXbvTPaFM3HwrOj480Ybjbq5a5D2jqySmh65SKazntlOVnHNCj/SH7/QWeJR0VKT1/
         5r2MFo4QIy5br7G4xo/iU+KP4ilFlvH+lJmLc4DJttv5pD6x/XKdicUnR4ZIGlNvV3yW
         58rMWjbme9LjAmjzuNUxCj1YgE9HkpI/XInPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hvPt/xVlGWX+uMrv7boCKzd2w9RNx+Xk0MMS9Ja4/hA=;
        b=DpKmWZs384zd+qBI41KJsOnj9UXC8lLx45xRJJQ68esEsOiT/vtfNAGGXToYGCer1J
         r1pL73fvNQWqR+g6JNWKHzPjXJWMAxxmdv+tPYY3f7Bng30aHkhHytiiKcGbZ7Qi8BUt
         2+nnDYsYCa3hggjKDq/L3KvJXZtOmRoe62KeK7R6UooXPZ5q1sqGRJVu6pdSz1jo2744
         BAPZzopeexEVt3mPmFVn+v+gRyVJdF5BcDFySVd6lDDU9i0rqmDDj7NCmUafQOmYwdAk
         hXzCYCb5dJ4SxeNyIrYB2cJAcwO6pIvyVhw77Gm/CRfF0J105WzJYZExKpj7lnkW8Kb+
         0UeQ==
X-Gm-Message-State: AA+aEWa1FXsZljttzRnaAbe8KB1XApWEyV6eyIdGgRAM+L0ccVYMD8ju
        FwnD9WTRVzywieOA79ZNG5jgPg==
X-Google-Smtp-Source: AFSGD/VGNvCO5MaFvKvTHWs7JoDP3aEtICzteHkFhU6i96ejLzccvE6HkTvXMLMKxwnUjeDsjVMxIg==
X-Received: by 2002:a17:902:365:: with SMTP id 92mr15626894pld.327.1543852553309;
        Mon, 03 Dec 2018 07:55:53 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l3sm23050411pga.92.2018.12.03.07.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 07:55:52 -0800 (PST)
Date:   Mon, 3 Dec 2018 07:55:38 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Fix MSM8998 resets
Message-ID: <20181203155538.GQ2225@minitux>
References: <1543851298-32320-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543851298-32320-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03 Dec 07:34 PST 2018, Jeffrey Hugo wrote:

> The offsets for the defined BCR reset registers does not match the hardware
> documentation.  Update the values to match the hardware documentation.
> 

Sorry for not spotting this before.

> Fixes: b5f5f525c547 (clk: qcom: Add MSM8998 Global Clock Control (GCC) driver)
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/clk/qcom/gcc-msm8998.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> index 9f0ae40..01cc555 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -2742,25 +2742,25 @@ enum {
>  };
>  
>  static const struct qcom_reset_map gcc_msm8998_resets[] = {
> -	[GCC_BLSP1_QUP1_BCR] = { 0x102400 },
> -	[GCC_BLSP1_QUP2_BCR] = { 0x110592 },
> -	[GCC_BLSP1_QUP3_BCR] = { 0x118784 },
> -	[GCC_BLSP1_QUP4_BCR] = { 0x126976 },
> -	[GCC_BLSP1_QUP5_BCR] = { 0x135168 },
> -	[GCC_BLSP1_QUP6_BCR] = { 0x143360 },
> -	[GCC_BLSP2_QUP1_BCR] = { 0x155648 },
> -	[GCC_BLSP2_QUP2_BCR] = { 0x163840 },
> -	[GCC_BLSP2_QUP3_BCR] = { 0x172032 },
> -	[GCC_BLSP2_QUP4_BCR] = { 0x180224 },
> -	[GCC_BLSP2_QUP5_BCR] = { 0x188416 },
> -	[GCC_BLSP2_QUP6_BCR] = { 0x196608 },
> -	[GCC_PCIE_0_BCR] = { 0x438272 },
> -	[GCC_PDM_BCR] = { 0x208896 },
> -	[GCC_SDCC2_BCR] = { 0x81920 },
> -	[GCC_SDCC4_BCR] = { 0x90112 },
> -	[GCC_TSIF_BCR] = { 0x221184 },
> -	[GCC_UFS_BCR] = { 0x479232 },
> -	[GCC_USB_30_BCR] = { 0x61440 },
> +	[GCC_BLSP1_QUP1_BCR] = { 0x19000 },
> +	[GCC_BLSP1_QUP2_BCR] = { 0x1b000 },
> +	[GCC_BLSP1_QUP3_BCR] = { 0x1d000 },
> +	[GCC_BLSP1_QUP4_BCR] = { 0x1f000 },
> +	[GCC_BLSP1_QUP5_BCR] = { 0x21000 },
> +	[GCC_BLSP1_QUP6_BCR] = { 0x23000 },
> +	[GCC_BLSP2_QUP1_BCR] = { 0x26000 },
> +	[GCC_BLSP2_QUP2_BCR] = { 0x28000 },
> +	[GCC_BLSP2_QUP3_BCR] = { 0x2a000 },
> +	[GCC_BLSP2_QUP4_BCR] = { 0x2c000 },
> +	[GCC_BLSP2_QUP5_BCR] = { 0x2e000 },
> +	[GCC_BLSP2_QUP6_BCR] = { 0x30000 },
> +	[GCC_PCIE_0_BCR] = { 0x6c01c },

I find GCC_PCIE_0_BCR at 0x6b000 and then GCC_PCIE_0_PHY_BCR at 0x6c01c.

> +	[GCC_PDM_BCR] = { 0x33000 },
> +	[GCC_SDCC2_BCR] = { 0x14000 },
> +	[GCC_SDCC4_BCR] = { 0x16000 },
> +	[GCC_TSIF_BCR] = { 0x36000 },
> +	[GCC_UFS_BCR] = { 0x75000 },
> +	[GCC_USB_30_BCR] = { 0xf000 },
>  };

With this updated, you have my

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
