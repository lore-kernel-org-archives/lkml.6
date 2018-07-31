Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9079BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0F20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B0F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeGaW1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:27:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54726 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeGaW1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:27:45 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so6498287itb.4;
        Tue, 31 Jul 2018 13:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8VgM0/PMdpEhpazNqz/outk0nLCwO87pqDD5KmIhms4=;
        b=SXAXE9sLdg1cku1fW23lcFGBVhACJPK9Qwpj2ic/WlGG7t6glwj80rdeqmPMuX+VAc
         sDMJp5uknAKuc6FmysUFD4i4szdaKP0wK/ic7i9zNFZ3syPqg9TtnUj7vtG6s9innG4v
         jS+W3Qjy5KWmJ0VDY9JKZVyQnq9Vi0esy4F9FHcyuofwqwHqcxLwNHzZAoDrWZsRQ1eC
         b3hGjew+WeJjOf/aH21dTflEnFxkNeFgzwoSBJWwrzuEc8+i1oq9RLuk0C0Vrf+bfw5a
         N6OQeIYEWxfOdPJ/JkzyDXAzY+RdenGBxnM35t0+zRQ+MWF/7MZHU7COavVNusUaT5ut
         9lbw==
X-Gm-Message-State: AOUpUlE7fWnNtEwrwpKmYism9kNFAWrR/K7NQtPP9adRRTaiuT9w6lc2
        reSEvxAY90WBoFiZS6s4gQ==
X-Google-Smtp-Source: AAOMgpeeqZlQX75I9ANeRY+6nUtF4hkshW1XUS9yJZkIWOBeYlw4KW+6aOoElOrdz9WLToF6ahiKHQ==
X-Received: by 2002:a24:e38a:: with SMTP id d132-v6mr1180394ith.2.1533069937550;
        Tue, 31 Jul 2018 13:45:37 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id w193-v6sm2485772ita.11.2018.07.31.13.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:45:37 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:45:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 03/10] mfd: wcd9335: add wcd irq support
Message-ID: <20180731204536.GA7241@rob-hp-laptop>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727121806.18209-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 01:17:59PM +0100, Srinivas Kandagatla wrote:
> WCD9335 supports two lines of irqs INTR1 and INTR2.
> Multiple interrupts are muxed via these lines.
> INTR1 consists of all possible interrupt sources like:
> Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA
> INTR2 is a subset of first interrupt sources like MAD, VBAT, and SVA
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/mfd/Makefile                |   2 +-
>  drivers/mfd/wcd9335-core.c          |   9 ++
>  drivers/mfd/wcd9335-irq.c           | 172 ++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++

I'm confused why these are defined here. The binding for the wc9335 is 
not an interrupt-controller.

>  include/linux/mfd/wcd9335/wcd9335.h |   3 +
>  5 files changed, 228 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mfd/wcd9335-irq.c
>  create mode 100644 include/dt-bindings/mfd/wcd9335.h
