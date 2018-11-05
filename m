Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5312DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6B320866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="RAGpRr1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6B320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbeKFCzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:55:42 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34989 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387618AbeKFCzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:55:42 -0500
Received: by mail-yb1-f195.google.com with SMTP id z2-v6so4146478ybj.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mDXw+9xXlfqt5xe1WPGy1QP9SO/lSuBDNL10hBwuasQ=;
        b=RAGpRr1lcFvwJ/qfGsy4QFUl78/kJTfNIKS3PMhbu5C+efKARxD12kpVSQoAQhjAfH
         UaTo2XT90jJ3MUzETc29yrMDmfkARZylVk90d2c9mvwDzYGHkbm9gVx2wZGXBFGYV7J2
         S9w0ewF4PYOiGL1OVsyoO2JHCX1Qnx0Nnxh0v8vXvBOW4Z21/LSsX9Dc+5CUGCiEuTX6
         o8Yx88kjQ/cekpfTb/CkvYFq0roy3MG9Bhqkgn2kns3naTol94xLJkHxQhl/4oCzFgVo
         5zO9FkXWjUTpEstbkdoN/l5RVe5UviMDFoxUYTNapqNogNdMsFnLeYwhLW/O075PhBL5
         c1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mDXw+9xXlfqt5xe1WPGy1QP9SO/lSuBDNL10hBwuasQ=;
        b=O5qzljuoqq+Y/w1i9VWaaeYIKXTvVOhfRoEt9Ri889S0BkvXk7g4EWt+oxjc75KJVs
         hYQX74Ojdh8QIaxI0dqa9xaDvGpEtCxl2q3Y1p6WT1GdFJHN9nzq5en3jR0SjOuc1bW0
         IalOSgO6haw+H12CawgTEHF7f8ou14Y3wJrTz2ZgAmwtcLOd4sdkqL4hGHzrgLA/AGje
         Zi9GhJ5laVZa2Kf1r39WA9w1W3UaVwpnzHXzHHQe4pM+3PAXuDdSCKA+rXScOSw7dmDi
         A17jMOKG0A2Gu/qz6Q1BVivQRbt1vVcjbYcmW011MBsZjqh4b1V2VocTh6Ec1fs+PwuE
         5deQ==
X-Gm-Message-State: AGRZ1gLjuxlQtYJYQ281AYeV6XohDmOYoZo8WyvQds6hYV8T/WaWbSle
        LG9zbYyyNQEMeHhb9lVw49HCfA==
X-Google-Smtp-Source: AJdET5d5ltEjJaUhWSoyLbBR89AqWWMObXbEWi6MUHzP9qWC/w7RkUnIHD3huwhDegYDxmbF5542mQ==
X-Received: by 2002:a25:27ca:: with SMTP id n193-v6mr22273593ybn.494.1541439298137;
        Mon, 05 Nov 2018 09:34:58 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id a189-v6sm11103840ywf.49.2018.11.05.09.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 09:34:57 -0800 (PST)
Date:   Mon, 5 Nov 2018 12:34:56 -0500
From:   Sean Paul <sean@poorly.run>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: msm/dsi: Add ref clock for 10nm PHY
Message-ID: <20181105173456.GK154160@art_vandelay>
References: <20181102214534.184593-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102214534.184593-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 02:45:33PM -0700, Matthias Kaehlcke wrote:
> Allow the 10nm PHY driver to get the ref clock from the DT.
> 

Might be nice to state that there are no current users of the 10nm phy in your
commit message.

Sean

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
> index dfc743219bd88..d0d2046ceff69 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi.txt
> +++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
> @@ -105,6 +105,10 @@ Required properties:
>  - power-domains: Should be <&mmcc MDSS_GDSC>.
>  - clocks: Phandles to device clocks. See [1] for details on clock bindings.
>  - clock-names: the following clocks are required:
> +  For 10nm PHY:
> +  * "iface"
> +  * "ref"
> +  For other PHYs:
>    * "iface"
>    For 28nm HPM/LP, 28nm 8960 PHYs:
>  - vddio-supply: phandle to vdd-io regulator device node
> -- 
> 2.19.1.930.g4563a0d9d0-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
