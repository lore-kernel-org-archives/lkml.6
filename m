Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09D8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC0E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TR0IOkEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfAVX0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:26:41 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33348 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfAVX0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:26:40 -0500
Received: by mail-vs1-f66.google.com with SMTP id p74so219171vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWPLJYo4miRs+OWEcMGYhEawD49GCIFumgBBTjk3kCQ=;
        b=TR0IOkEwZmw/ayF3ZgmACrIIUwj/4wuOlyqtr6Z3sDSTznhrlNZ6toEudtfWgvI4p3
         Gqydo4JdovlqkUxFk2sfpV7/Mduu8bUXytApPRI9aYpmf/gTNY7DCtmt/liXm+v5/oiX
         3i/OetYBn4oVRoI3eceITNY7dDI1DDl1IFi+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWPLJYo4miRs+OWEcMGYhEawD49GCIFumgBBTjk3kCQ=;
        b=JCA6ToFZkpunDAy0+xcuVTwMZjwDOYWSaUzMEunUBtSw0ZXl1fGrRtUuzuYswXbR6n
         VQUnaF7iQH5xZdE4c1u6nuxYXzMLPL1s1lrMecSVH2KkNyEptR8CN6DNIOXwJsSb5BJF
         pMe3dhdkdfcqsKQzhusVntlVd6oinjA5znpvHqXOK+IY+vklc9Te5Wo4a6actMRsAZdV
         xmE4kGteAIxIijFylsgk+nxeKooXmYcR18L5aBXY0Lrx+q/tczAY4GFLJHtLl8rcYstA
         m4RfqVJk39CgZokP5OmZyO11JJLV+/dxi4y+NvN47p7hVuT0xdfNz0cBj2PaEAEpWiFM
         jMBQ==
X-Gm-Message-State: AJcUukf6pA4vQH45Q0Tu1Nqmk0W2CPAVXWVP0M5RzmQXuubbdQN+vcQM
        Fb8VpeNswOgBRjIC4BnN3l/luNgT2ug=
X-Google-Smtp-Source: ALg8bN7k5NLgaN79aHuQPGRqoTd1LRk/HuT75ZaEGboylwEzEI07/c1+WE8CtFFImWITtz1OUDPjRw==
X-Received: by 2002:a67:99c2:: with SMTP id b185mr14380350vse.84.1548199599310;
        Tue, 22 Jan 2019 15:26:39 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id x8sm3290720vsf.21.2019.01.22.15.26.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 15:26:38 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id e7so209992vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:26:38 -0800 (PST)
X-Received: by 2002:a67:f598:: with SMTP id i24mr14349951vso.87.1548199597867;
 Tue, 22 Jan 2019 15:26:37 -0800 (PST)
MIME-Version: 1.0
References: <20190122055112.30943-1-bjorn.andersson@linaro.org> <20190122055112.30943-3-bjorn.andersson@linaro.org>
In-Reply-To: <20190122055112.30943-3-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jan 2019 15:26:22 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X0x4hQ=8yQ6wDWE8ximf9A8hpgpRWTdPrFXDD4FVO8VQ@mail.gmail.com>
Message-ID: <CAD=FV=X0x4hQ=8yQ6wDWE8ximf9A8hpgpRWTdPrFXDD4FVO8VQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] arm64: dts: qcom: sdm845: Define rmtfs memory
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Ben Chan <benchan@google.com>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 21, 2019 at 9:51 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Define the rmtfs memory node, as described in version 10 of the memory
> map.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v2:
> - New patch
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdcac3704c13..64f57cc5c61a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -72,6 +72,15 @@
>                 #size-cells = <2>;
>                 ranges;
>
> +               rmtfs@85d00000 {
> +                       compatible = "qcom,rmtfs-mem";
> +                       reg = <0 0x85d00000 0 0x200000>;
> +                       no-map;
> +
> +                       qcom,client-id = <1>;
> +                       qcom,vmid = <15>;
> +               };

Ah, I saw this after I posted my comments to patch #1.  I guess this
is the same as this node we have in our cheza board file downstream
(need to get that posted upstream soon):

rmtfs@88f00000 {
  compatible = "qcom,rmtfs-mem";
  reg = <0x0 0x88f00000 0x0 0x800000>;
  no-map;

  qcom,client-id = <1>;
};

That brings up a few things:

1. You should add a node label here.  This allows us to act on the
node more easily from board files, like setting it to disabled or
changing it.

2. In https://crrev.com/c/1119572, the argument was made that the size
of this carveout is board-specific.  That makes it hard to put it in
sdm845.dts.


-Doug
