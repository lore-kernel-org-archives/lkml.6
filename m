Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED515C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB88520657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="MW8QzNZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405687AbfAPQcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:32:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40368 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfAPQcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:32:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so5372441lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RZZIgPrKLthjkpKC//fazdxPP6sX8agGVzPgcQ+p6jU=;
        b=MW8QzNZsW+t6qfO4kGC+pp2mRlpVX0sfFlX5O0rpuPPP8YVThY00A2YA56jEKZiDOw
         CqGEHcGOTQje38Y/2pxW57sqsKYuNkP3P77U83F3MYCbtmsL+ScdHmMeT1NtKq5Wrqc/
         7FefTjMmzl/1VrOMqVti8WwCzzM17tAFRnt7rs8q63S3BfrbYx+EA6x1YFDF8JVQFzO6
         DN36Y0QPwi5XBhH+uvZUZkcpaMwR1sK6X8y+OHNFbdqpNbR6ovMR4XjQJPhVe5MKYN0U
         jeLLAXUl+jmUragf4svzp5VydqPR8C3R96kiM5+Vq8buquOkgFL6Ib5CdfbryJG3kLRy
         8wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RZZIgPrKLthjkpKC//fazdxPP6sX8agGVzPgcQ+p6jU=;
        b=D+EnlJ0JweTwTvrPoRiBYcBEOKnEms0B+4vLkbA5Q9ujc2LrUBOwQVZXF6Kt28UIUY
         ugcyWpPTCc1aC7eS6gmJzHG1flKc6Wv/6x6nj4qGKIMrW5IIOU6IsCaerPIntIOCqJDX
         edGVQwaKnil5lNsJPNVhLFY4WmHJzLOThnYaPoh3297NUHvB+3oNVdkj/cg8IIKRwbtq
         kX+bhbHz0zkDGgXjiWZX1HWXPKslwWRlFyrHBbL70ZwCFDzKgbwZGkswHj2yloBgmIy8
         bYLknC5B8c5Ba8HHlzzQabkAEjYlIfglpaXWZn3S+JSIlwb+8JJJ+/8tYmqfzd9oPx3B
         dJQw==
X-Gm-Message-State: AJcUukeiIIEKN+hgWIUrWcBzfQOk8xLk0cRkSXoOcXF7h6yWYNLwGqCA
        CFK1shiWNad0BoEIBP7CLcWqFHs3C7w=
X-Google-Smtp-Source: ALg8bN6r8zRZ5u+cpBQe5jWKY72NR3/4QE56fZ+ZT6rPPA2b9fDiCCOuCaKnCCsVSP4vj3slpeSPQA==
X-Received: by 2002:a19:a302:: with SMTP id m2mr7922257lfe.108.1547656331381;
        Wed, 16 Jan 2019 08:32:11 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.123])
        by smtp.gmail.com with ESMTPSA id k11-v6sm1124143ljk.40.2019.01.16.08.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 08:32:10 -0800 (PST)
Subject: Re: [PATCH v2,2/2] usb: chipidea: imx: set power polarity
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, Peter.Chen@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190115123113.20577-1-philipp.puschmann@emlix.com>
 <20190116105103.28842-1-philipp.puschmann@emlix.com>
 <20190116105103.28842-2-philipp.puschmann@emlix.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <22968f8c-0a62-7046-c46f-ce7dc8981499@cogentembedded.com>
Date:   Wed, 16 Jan 2019 19:32:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190116105103.28842-2-philipp.puschmann@emlix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01/16/2019 01:51 PM, Philipp Puschmann wrote:

> This patch adds support to set the power line polarity for i.MX6q/dl.
> 
> To let the USB controller control the power it may be necessary to configure
> the polarity of the power line. So far the polarity was configured
> by Bootloader or alternatively the power line was muxed as gpio and
> driven by a regulator.
> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> ---
> 
> V2: fixed wrong variable name ...
> 
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 3 +++
>  drivers/usb/chipidea/ci_hdrc_imx.h | 1 +
>  drivers/usb/chipidea/usbmisc_imx.c | 4 ++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index e81de9ca8729..32dc120680fa 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -152,6 +152,9 @@ static struct imx_usbmisc_data *usbmisc_get_init_data(struct device *dev)
>  		dev_warn(dev, "No over current polarity defined\n");
>  	}
>  
> +	if (of_find_property(np, "power-active-high", NULL))

   How about of_property_read_bool()?

> +		data->pwr_pol = 1;
> +
>  	if (of_find_property(np, "external-vbus-divider", NULL))
>  		data->evdo = 1;
>  
[...]

MBR, Sergei
