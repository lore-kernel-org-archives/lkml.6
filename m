Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8CFC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A392085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVvjCe/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A392085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeKFK1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:27:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39955 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeKFK1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:27:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so2316838pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 17:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=adLlZ16E015OBx2S4OK7jMb995AyuajGJK07XS0H89k=;
        b=BVvjCe/NoYXYzyfYQn6ZBE41d2GWBpciycWhyVA5RUlWn8HsTREcre1aNtuer/tMh0
         atxWyayHtcmj7gHZZFckQUfWd4MrjaW8n5/bRhEsgD+QscyhkhJM7i0qa1ZpPfyFCuHi
         CpXH1mE+TTnzR5Hz9jAnJk9/9TTTVZoFoZjW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=adLlZ16E015OBx2S4OK7jMb995AyuajGJK07XS0H89k=;
        b=OsGS6EKy6HpUKXy1vTKrtSwjNHb/e+8YMUevBmgq44IE+zTCQIcGot1XHmT3FgF6My
         mp0s6yclPZlqcXgKL9XT6VWiHAa0Jez1xFAYhy/rSkp6FwBs8wrktaXMamjvgfBUns4/
         smSSwXdbNWfTVrvmA6zViayzMHWyjPmh9cBI/F/TMmRb7wliKuZDfiQC2EKskkNztFz1
         9xKybO/WIm7fAobxuTmLD40rhdVCj+64f09GJvHkkqeqjQCD8aNpng6qLAO0GPXXUzjI
         caVusNUncBIlEVN6xwJvGeQP4uOpUWo6dAO5W8OWTmPTw/1+UObouk3ypNrZ5VG/1Ptk
         Qvdw==
X-Gm-Message-State: AGRZ1gINPrt0f0RBGyXCR+TF1zgayCjApGsLCKWn3hQeGt6DL4jYuUew
        sP00ErLuAwGRnF3vXfOejqaOxw==
X-Google-Smtp-Source: AJdET5ccWTljB5duzD0NfaV+amQTrrQtKRH+s4P8zY1PBZGnJbAEcCNiDN3In4EMOt+TfunaAmAiEg==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7-v6mr23590299plp.14.1541466269861;
        Mon, 05 Nov 2018 17:04:29 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g17-v6sm63674073pfe.37.2018.11.05.17.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 17:04:29 -0800 (PST)
Date:   Mon, 5 Nov 2018 17:04:26 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: clk: Introduce 'protected-clocks'
 property
Message-ID: <20181106010426.GX2523@minitux>
References: <20181105194011.43770-1-swboyd@chromium.org>
 <20181105194011.43770-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105194011.43770-2-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 11:40 PST 2018, Stephen Boyd wrote:

> Add a generic clk property for clks which are not intended to be used by
> the OS due to security restrictions put in place by firmware. For
> example, on some Qualcomm firmwares reading or writing certain clk
> registers causes the entire system to reboot, but on other firmwares
> reading and writing those same registers is required to make devices
> like QSPI work. Rather than adding one-off properties each time a new
> set of clks appears to be protected, let's add a generic clk property to
> describe any set of clks that shouldn't be touched by the OS. This way
> we never need to register the clks or use them in certain firmware
> configurations.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Cc: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../devicetree/bindings/clock/clock-bindings.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> index 2ec489eebe72..b646bbcf7f92 100644
> --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -168,3 +168,19 @@ a shared clock is forbidden.
>  
>  Configuration of common clocks, which affect multiple consumer devices can
>  be similarly specified in the clock provider node.
> +
> +==Protected clocks==
> +
> +Some platforms or firmwares may not fully expose all the clocks to the OS, such
> +as in situations where those clks are used by drivers running in ARM secure
> +execution levels. Such a configuration can be specified in device tree with the
> +protected-clocks property in the form of a clock specifier list. This property should
> +only be specified in the node that is providing the clocks being protected:
> +
> +   clock-controller@a000f000 {
> +        compatible = "vendor,clk95;
> +        reg = <0xa000f000 0x1000>
> +        #clocks-cells = <1>;
> +        ...
> +        protected-clocks = <UART3_CLK>, <SPI5_CLK>;
> +   };
> -- 
> Sent by a computer through tubes
> 
