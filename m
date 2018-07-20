Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9EEECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064E520854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064E520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbeGTRYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:24:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55652 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeGTRYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:24:20 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so15462860itl.5;
        Fri, 20 Jul 2018 09:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VcPxtB9T7Gbi3b30kFhXH0Cfx1cjRLHRunUolPWZuG4=;
        b=aSSs60NUCuHIgIDC3ufHAG9aIghYn/vzcd5Ll4D5xVPt2T8rod+C7zlwgy44uKgumq
         G8SSt/xAD3dtr4DTYl7S5056tCxSB2T74PVedmirBTGwEjMG5cYvXrs3CWE0A1OAvZAg
         tY+zAj0MuoUYgkXVBYg0Y1NsXygLzD6nwbu1WcJKogefT5cu2G6NU7WYqwCeTKNt4I5d
         5XcN3pQShkk70IJBHLO+qC5d35NswQbdmMou4B+fsMy2dF1ufPx+22EdWC26JQqiInXK
         dlLWXK5BfuOj2uZK1a8LG8pPJlieIvMVg8c7ZKy1GekKcT5qPhNtVphZjjEY8Kpis/1S
         d/fw==
X-Gm-Message-State: AOUpUlEbIlTl6bTQeSG7HZzogss4oDAJXKIWyr0CSH3NdzdWZNr+E7Lm
        INEZMa1IPtwm85gNwQQdYg==
X-Google-Smtp-Source: AAOMgpcGiphdjrCjj+bCoBR9caxyti+MqWocEiTy98WfflvlVn9sgGdL92/O/1j65pjolHaflLLMZw==
X-Received: by 2002:a24:9d92:: with SMTP id f140-v6mr2499911itd.130.1532104516694;
        Fri, 20 Jul 2018 09:35:16 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 16-v6sm1214306itk.15.2018.07.20.09.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 09:35:16 -0700 (PDT)
Date:   Fri, 20 Jul 2018 10:35:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        amelie.delaunay@st.com
Subject: Re: [PATCH 1/2] pinctrl: stm32: fix bank io port number
Message-ID: <20180720163515.GA16515@rob-hp-laptop>
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
 <1531745857-5561-2-git-send-email-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531745857-5561-2-git-send-email-alexandre.torgue@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 02:57:36PM +0200, Alexandre Torgue wrote:
> In case the exti line is not in line with the bank number (that is the case
> when there is an hole between two banks, for example GPIOK and then GPIOZ),
> use "st,bank-ioport" DT property to get the right exti line.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> index 9a06e1f..60c678a 100644
> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> @@ -55,6 +55,8 @@ Optional properties:
>     NOTE: If "gpio-ranges" is used for a gpio controller, all gpio-controller
>     have to use a "gpio-ranges" entry.
>     More details in Documentation/devicetree/bindings/gpio/gpio.txt.
> + - st,bank-ioport: should correspond to the EXTI IOport selection (EXTI line
> +   used to select GPIOs as interrupts).

ioport sounds like something else. Perhaps '-exti-line'?

>  
>  Example 1:
>  #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
