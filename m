Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44044C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE7321471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XkVJGenv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE7321471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeISBp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:45:27 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52193 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbeISBp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:45:26 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so5168677itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4r4NCh/k9/32GkM8bJ1oyltTMxk3MO2vyuWJGTZfZE=;
        b=XkVJGenvwT9PCWIpKfQ4DIcbHR3UXAAxmks45SN+T3xVFEGQtkuS90AiXbiE/BppIk
         cd48Vp/ZgnejA3O1k9nY24bC/RXTOmVTSVZOFqjnkZiDrKOETPxKISIACku57JGtMBJi
         tygGvWaxIpYau+Ndizu0b6eX+aufE+xv1ugrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4r4NCh/k9/32GkM8bJ1oyltTMxk3MO2vyuWJGTZfZE=;
        b=eca+LfQ067WP90as28gMtFH42G8/IEjulpvPzgfxqPPpIQjase+NWOWfdQ9BsuyECs
         o56S7qSDuX/qr6wyenzFAWK5iPqdslDwscg0cr76i3kFcMLofjNqH17g8ydDLcVbgg34
         aJj7BOqwzx5/1Phbh7liOQNEAaleGptjcCfaENtooMePUUQTh9KS1HwnofWTAa7AxDde
         716vxy++KzbG8CPyenp0TPPQhBbCT4X9A8yw+wbq3EZXmlSDMX5+KiiMyRu+SybtTQJU
         BAtzi/pdmmfj1LDNnO13hIdAMLJw0Q+SnTljIJzUvcMlteEQfOiSZgBSnHO4qHFwcKcq
         UBDQ==
X-Gm-Message-State: APzg51Dwo4YTSvpQWjYGEXW6Jfui6dGL+2ipA0YB1W3WdWTVPyisFV3K
        JKEZwktpF3Q/pdvwmfSzsNzILp7iq/Y=
X-Google-Smtp-Source: ANB0VdZZsiCEf/mBN47QQ4UawuYyAllgrtwD9o6AX2DYDcWme6ksFeIHwJhnuUQMaGU8+q/bxR/KYw==
X-Received: by 2002:a02:602a:: with SMTP id i42-v6mr29335445jac.95.1537301475086;
        Tue, 18 Sep 2018 13:11:15 -0700 (PDT)
Received: from mail-it0-f42.google.com (mail-it0-f42.google.com. [209.85.214.42])
        by smtp.gmail.com with ESMTPSA id d12-v6sm4726457itf.25.2018.09.18.13.11.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 13:11:14 -0700 (PDT)
Received: by mail-it0-f42.google.com with SMTP id d10-v6so5122131itj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:11:13 -0700 (PDT)
X-Received: by 2002:a02:9f82:: with SMTP id a2-v6mr28788070jam.15.1537301473352;
 Tue, 18 Sep 2018 13:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org> <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
In-Reply-To: <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Sep 2018 13:11:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=URrgXgSOmh-_FXGxH7oZmmKBoPSz3EYx6K9Wr6i38gcQ@mail.gmail.com>
Message-ID: <CAD=FV=URrgXgSOmh-_FXGxH7oZmmKBoPSz3EYx6K9Wr6i38gcQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/4] dt-bindings: soc: qcom: Remove SPI controller
 maximum frequency binding
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 18, 2018 at 11:08 AM Dilip Kota <dkota@codeaurora.org> wrote:
>
> SPI controller driver should maintain the maximum frequency
> of the controller instead of relying on device tree bindings.
> Because maximum frequency is specific property of SPI
> controller.
>
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
