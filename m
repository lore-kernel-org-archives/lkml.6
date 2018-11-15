Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A80DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464D121582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4tW+MFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464D121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeKONvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:51:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45578 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeKONvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 08:51:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so8344880pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 19:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=imccg2ewpJs6oLtt3RPLMW8IyhFOh86qnQ7UBAbDzmg=;
        b=F4tW+MFYxjHll51ooXAlD7JXBWW+fNl+4MuoiIIwPYKkKWiENg0+jAD1pNJ/zICtov
         zCJ1LQ6AcPWX4MoQ/NMwoT2E8n28B24pePxKqQoXQ+W2UYWr2G1G9ZQhOHdg7Sr2Dl50
         Qxi6JetT5hUwqr62s4GOvpFXFf2ENel7lKt8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=imccg2ewpJs6oLtt3RPLMW8IyhFOh86qnQ7UBAbDzmg=;
        b=osf1A+SXaIF9tu+Tv+X0ykA9JJ5c2fFEBAQCbS8JXEOOIasa2YlV7xw07jygyY+wmR
         ah75Az0yiMYSyY+36/u2DzB/46lb38eKPDYq9VUHkQD8Vr3stkkYSX3xG2u5Xi6Z/84k
         9LVwChxv1GIKmpjQ0vqMQwTEvf3+NsTmr0QFUu+vL2GVl7hBML9Tgn3aa6fhCcwAvHJi
         TEu2JomLrom5hpjBvLIXEFZQ62Zgk84wrEMlIfNlvJFiGESZTvpG9gKUiK1Z5bpmPpb2
         +XGs7NzubWVcQQkC6TLg9dOkyHEp6Ft7CZIU9205rPDd3gDkowuIrYCO/4gMdMhgjOoA
         GI7A==
X-Gm-Message-State: AGRZ1gKZVWteTCxj0ZgQAo6RJd6kKO7aA6NNeRJr8uSs/k/nErkyckGu
        9NLMZBdXliq/txkFFe/LzQNMCg==
X-Google-Smtp-Source: AJdET5fomqtNd12V2dh9mEfo7wR9zy7eS0y7tuuy/PVPcJpRqc9IPKX+Bm6m5ICaOiNZYcF2jkPWpQ==
X-Received: by 2002:a62:e704:: with SMTP id s4mr4549121pfh.124.1542253524502;
        Wed, 14 Nov 2018 19:45:24 -0800 (PST)
Received: from localhost ([106.223.115.173])
        by smtp.gmail.com with ESMTPSA id e23sm23557808pfh.68.2018.11.14.19.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 19:45:23 -0800 (PST)
Date:   Thu, 15 Nov 2018 09:15:18 +0530
From:   Vinod Koul <vinod.koul@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v6 0/2] arm64: dts: add prng-ee nodes
Message-ID: <20181115034518.GG3060@vkoul-mobl>
References: <20181001062151.27607-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001062151.27607-1-vkoul@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-10-18, 11:51, Vinod Koul wrote:
> This adds prng-ee nodes for msm8996 and sdm845

Ping Andy, would appreciate if you can pick these up.

Thanks

> 
> changes in v6:
>  - Fix comments given by Stan
> 
> changes in v5:
>  - Add more description in patch logs
> 
> changes in v4:
>  - Fix node address on sdm845
> 
> changes in v3:
>  - Add Bjorn's reviewed-by
>  - Update patch titles to reflect that they add nodes
> 
> changes in v2:
>  - rebase on v4.19-rc1
> 
> Vinod Koul (2):
>   arm64: dts: msm8996: add prng-ee node
>   arm64: dts: sdm845: add prng-ee node
> 
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 7 +++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi  | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> -- 
> 2.14.4

-- 
~Vinod
