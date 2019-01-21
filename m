Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C88C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807BB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="N+0tU9gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfAUIQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:16:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40216 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfAUIQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:16:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so16706614lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rlHaZqfICvXZvssoWUnEoOPJG6mrezGKijxzU6NTe0Q=;
        b=N+0tU9gmJM1zPIAq6rFUdLpyruAJpzOcyvubr3SOCdZq5czdgoVB0tzN6N8NB1SrmN
         P3gWVmi+A0kxAIcKbnqNFr+esfhwkAZC/QOkQ7iRKz69Ru2ReKTrEsZiaK6+V/JAm0rt
         hxrmiFBEXprIfToEmyO4CBdozwNveuJ+r7n7P4r5ZcdIOtH6OszAoELX3uJl87KB2pip
         Zn9+vGGLJIJvv+5KyKOGBlnMo4QOdBjPpzp6gAJFZoZebeU0tD4mRb5yXsXFBJcTZVxi
         ZFUCXemuUVRsUzLtUN53bA+QiBj/6s6ToeanY2QaGcsTfq93ysn0CGO6GX6v6sVGCGS3
         pYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rlHaZqfICvXZvssoWUnEoOPJG6mrezGKijxzU6NTe0Q=;
        b=Q3bp/x8KSSZRdfwPiOBBXikRz9p5elG3myttWNWeROKCaPNkooBsciM7QLY0K7AId2
         /F5Kz0NkiCk1gL3p+PKUfWqFWk370TZTHnfzkqa7/at78KyU5IKalOFrjCMIfLcIMLDN
         GEhl72NjoJXe9wa8nGxfEVLjyDhpapZgKF3/xu09i9L/XKSi2/9L1uqEKjQHb6Ut2mSL
         xk24lIHzDOVxzZFS25m12R3tEKAC9oJ6CYSdN/o246m7w++RzZXHE77QHQgWt+UHp+1y
         5XTIIUogIrqJqKn7lrxs+eFAAO1mKSUpPRsgvuUDKSihaB9AWD+Tz5UhUJUtEq0XSYWl
         Mp0g==
X-Gm-Message-State: AJcUukf/lfzwvEnPNEj+Grg5zXIqX9xBKkuAp2ZPFnuNPbJjWb3L7H/u
        s8suoPBoSpJKbfymtBRXtdcNAsS57fQ=
X-Google-Smtp-Source: ALg8bN7cEI+FiVSVhlP4eVyycsAUitNx/d9C0L7xqLLVQlQ5OpZ/b+vPsSEza6rIaEziPJBsZUlH1A==
X-Received: by 2002:a2e:750a:: with SMTP id q10-v6mr19182435ljc.39.1548058614037;
        Mon, 21 Jan 2019 00:16:54 -0800 (PST)
Received: from [192.168.0.199] ([31.173.84.221])
        by smtp.gmail.com with ESMTPSA id k20sm2157872lfe.3.2019.01.21.00.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 00:16:53 -0800 (PST)
Subject: Re: [PATCH v1 3/6] usb: host: Stops USB controller init if PLL fails
 to lock
To:     Yinbo Zhu <yinbo.zhu@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     xiaobo.xie@nxp.com, jerry.huang@nxp.com, ran.wang_1@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190121031304.31161-1-yinbo.zhu@nxp.com>
 <20190121031304.31161-3-yinbo.zhu@nxp.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <47b5e88e-2886-d8ed-5700-fad31c58f9bd@cogentembedded.com>
Date:   Mon, 21 Jan 2019 11:16:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190121031304.31161-3-yinbo.zhu@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 21.01.2019 6:13, Yinbo Zhu wrote:

> From: yinbo.zhu <yinbo.zhu@nxp.com>
> 
> USB erratum-A006918 workaround tries to start internal PHY inside
> uboot (when PLL fails to lock). However, if the workaround also
> fails, then USB initialization is also stopped inside Linux.
> Erratum-A006918 workaround failure creates "fsl,erratum_a006918"
> node in device-tree. Presence of this node in device-tree is
> used to stop USB controller initialization in Linux
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Suresh Gupta <suresh.gupta@freescale.com>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> ---
>   drivers/usb/host/ehci-fsl.c      |    5 +++++
>   drivers/usb/host/fsl-mph-dr-of.c |    5 +++++
>   2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index a28ec1e..6884130 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -224,6 +224,11 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
>   		portsc |= PORT_PTS_PTW;
>   		/* fall through */
>   	case FSL_USB2_PHY_UTMI:
> +		if (pdata->has_fsl_erratum_a006918) {
> +			pr_warn("fsl-ehci: USB PHY clock invalid\n");
> +			return -EINVAL;
> +		}
> +
>   	case FSL_USB2_PHY_UTMI_DUAL:
>   		/* PHY_CLK_VALID bit is de-featured from all controller
>   		 * versions below 2.4 and is to be checked only for
> diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
> index 677f9d5..7e07701 100644
> --- a/drivers/usb/host/fsl-mph-dr-of.c
> +++ b/drivers/usb/host/fsl-mph-dr-of.c
> @@ -225,6 +225,11 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
>   	pdata->has_fsl_erratum_a005697 =
>   		of_property_read_bool(np, "fsl,usb_erratum-a005697");
>   
> +	if (of_get_property(np, "fsl,erratum_a006918", NULL))

    of_property_read_bool() perhaps?

> +		pdata->has_fsl_erratum_a006918 = 1;
> +	else
> +		pdata->has_fsl_erratum_a006918 = 0;
> +
>   	/*
>   	 * Determine whether phy_clk_valid needs to be checked
>   	 * by reading property in device tree

MBR, Sergei
