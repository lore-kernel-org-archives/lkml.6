Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D2BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41FC2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JbXzRfWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41FC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbeKGIhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:37:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36277 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeKGIhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:37:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id w24-v6so6928491plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 15:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=40UOj51taoo5+eE3jbs207pG36OAZnwXp9OK1oXq8eg=;
        b=JbXzRfWi6rhlHLG6//RULtqUSZ7Qw9Dw4xF61l78Q1faU8CmCa4o9rB5KFn6H7R40r
         +yXyKL5QfWFLEK9HO1e2lqfDH3EssJ6s4NbCUnEZdtjIJotyobRBpSnK7HCidTsL7dj5
         VlmIamER5AjobPzqUEzjhhPK1yb9yUpYyx1RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=40UOj51taoo5+eE3jbs207pG36OAZnwXp9OK1oXq8eg=;
        b=OPESW9rTlwcs4Nctm7UO3wPP8sdPbpcZsywZTlIn62qbNJuhAdMpLHcKxafgKCxYnP
         zNjqIoyDAiyNa4vgvAkX4bVpZw0vtp3fye/bEQJZVylGX97qwMsTczUcsHCdQ9pz8+PN
         6XRflOc8lbEJzzfW9KlAejcTYqGoCQFAcJ64IySzDoCOPWQdpzWa0iSC3yB4j1mFJi7L
         5ngoyHd8wBWfnlr8Pe4D8vy5Re1mxaTL3lt3gTX8Ryb22ZWMlYdv6L/3vZzY+wjP1DGr
         amiAu/NKYmm518BsmC7XyAkt6Lv8HYc2r7awzropiKIB1jw6qFjaWx33ffifnxDcOUXQ
         FlOg==
X-Gm-Message-State: AGRZ1gJUqeofE2EVmS+pMCZ63TwS4WXKv4mHgWbo5YBnogDt8r7DGLXP
        rP2/B6nI4RIhHIg7cC91OqV8Aw==
X-Google-Smtp-Source: AJdET5cANA36bJug8UdZE6aIs4/VEW6P3+Ig46DjfpxGq8i6T1q85xdkQyjL1bGr6ZhJFpU9DNXRzQ==
X-Received: by 2002:a17:902:6bc1:: with SMTP id m1-v6mr28850104plt.34.1541545783221;
        Tue, 06 Nov 2018 15:09:43 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id z9-v6sm24500324pfg.174.2018.11.06.15.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 15:09:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181102214534.184593-1-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
References: <20181102214534.184593-1-mka@chromium.org>
Message-ID: <154154578082.88331.1035410665298962611@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: msm/dsi: Add ref clock for 10nm PHY
Date:   Tue, 06 Nov 2018 15:09:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-02 14:45:33)
> Allow the 10nm PHY driver to get the ref clock from the DT.
> =

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> =

> diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Docu=
mentation/devicetree/bindings/display/msm/dsi.txt
> index dfc743219bd88..d0d2046ceff69 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi.txt
> +++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
> @@ -105,6 +105,10 @@ Required properties:
>  - power-domains: Should be <&mmcc MDSS_GDSC>.
>  - clocks: Phandles to device clocks. See [1] for details on clock bindin=
gs.
>  - clock-names: the following clocks are required:
> +  For 10nm PHY:
> +  * "iface"
> +  * "ref"
> +  For other PHYs:
>    * "iface"

Any reason we can't go back and do this for other phys too? They're all
the same with regards to this reference clk input.

>    For 28nm HPM/LP, 28nm 8960 PHYs:
>  - vddio-supply: phandle to vdd-io regulator device node
