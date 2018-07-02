Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAF8C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9F525116
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SnPzNyH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9F525116
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeGBUvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:51:51 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34987 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeGBUvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:51:48 -0400
Received: by mail-pg0-f67.google.com with SMTP id i7-v6so7647519pgp.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nc3ThZ/dLdj8M/tNkrs/elT1kRl3be9boQ6OKmSY3pg=;
        b=SnPzNyH8J7DGZXUFiFRDhXRI+sVpTePWu58vZyt2itChfPfjCeAAxJzoYH15r/KZ9Q
         Ad8Euda5vP+Dfok4ZPUVGC17lakTVADZUV+Cx/LSjuhour5S9WiSi4IPRCHQXsId/vxD
         qyPAzWQdx9N6hHYVjUe3TrTyoJvIFCMx1ry1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nc3ThZ/dLdj8M/tNkrs/elT1kRl3be9boQ6OKmSY3pg=;
        b=jHfMI3ZfNGibF9I9Ol0i6vHZB7uqakEMg1cswk/j5Cb4wefNj73ypoR01vWXrA4MjW
         F3slF/JA0iabj8Gti2y/kUK7ph8GQcy1tkKc1lTVCfDpFmXkiBbF16o7mE+LiiNgigKy
         YbL67PP3bJibNM2NKTotM7UmnqWiHlnGzCKvka9qLgsao5buZ8hI3Fiy5tlTwM4h5Y34
         Z2yOqmxy8YzNEeIq9/nXEKy+MIJ8cnuNis2rPnk0mmZhHZzGZNQHBGzu2kFKM8O1acNX
         Ekg8OLdgxlumSpkbYVD4O5v+gIdWszjjc6nGQBuVjri7WsGsBdS3uh+S/DaOB1QeySzA
         Sc5g==
X-Gm-Message-State: APt69E36tltxw00z6h7dEjYBxjW8iFFdfiqwAhR0gydkHR1DLmbO4Ez6
        O15Zyf+DLzxpPBApfd8JjFxDsg==
X-Google-Smtp-Source: ADUXVKJuYyPo1XBWAiSBqOFxSfOZUCac2vCw5Pkh4enPpBrVQL8uQ2CCiblW2oULTp7hDh+W6amDkA==
X-Received: by 2002:a63:980a:: with SMTP id q10-v6mr22653365pgd.50.1530564707903;
        Mon, 02 Jul 2018 13:51:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id f10-v6sm22140112pgr.30.2018.07.02.13.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 13:51:47 -0700 (PDT)
Date:   Mon, 2 Jul 2018 13:51:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Message-ID: <20180702205146.GA129942@google.com>
References: <20180702181005.18247-1-mka@chromium.org>
 <CAD=FV=VSnKWqeRj-Kr9tkzeuqxm86Ex6E0uT6Qka=EqjurizNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=VSnKWqeRj-Kr9tkzeuqxm86Ex6E0uT6Qka=EqjurizNg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 01:12:01PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 2, 2018 at 11:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > This adds the spmi-temp-alarm node to pm8998 based on the examples in the
> > bindings.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - none
> >
> >  arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > index 92bed1e7d4bb..2f4989e7ef68 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > @@ -11,6 +11,13 @@
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >
> > +               pm8998_temp: qcom,temp-alarm@2400 {
> 
> Remove "qcom," from the node name (AKA please change to
> "temp-alarm@2400").  Someone internal in Qualcomm seems to have
> started this trend so you see it on all downstream kernels, but
> upstream device tree isn't supposed to have it.

Ok, thanks

> > +                       compatible = "qcom,spmi-temp-alarm";
> > +                       reg = <0x2400 0x100>;
> 
> Why are there two numbers for the "reg"?  Should just be 0x2400.

From /Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt:

Required properties:
...
- reg:             Specifies the SPMI address and length of the controller's
                   registers.
