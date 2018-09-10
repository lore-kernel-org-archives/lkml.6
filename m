Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC9A20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kG+NH7TA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC9A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeIJUvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:51:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55378 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbeIJUvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:51:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so22090632wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y2LXMPdZLj7TdwH8b5QlFT+lVGgdxENRTpHElbd7pfM=;
        b=kG+NH7TAjJ4PNPX+LF8q1bTT+IV3c9CSf8hUIo/zTNjYYEOwXinieWEyMkFmEZyvMN
         uoIsDQx/dv095mZD6X/um6yG7DY8vsBESg9HdwAJjKzFc325ZyRArVNsfNzF3hev3XOs
         aEypsEa7i0u96PlUJOGc12KOwiHFLND5hcq1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y2LXMPdZLj7TdwH8b5QlFT+lVGgdxENRTpHElbd7pfM=;
        b=ZG7ENkkI4re2dF5zgOY7H211tFOCs9AMBpkPbOtLmMGB+3p15gm0GT1IlsrnW0ieed
         UjCeW5wjlB4W+j02FudaUznx3j9TUwZ4+R6FjEBx1RXkUhQjoNU4tmkwLGKjO8Rl88/b
         qzz6pMq8m9JkO8VLTTJyOXmS+FbOlZ67WksmE9WNisPS5NPpKLmqCt3ompsTxXvnxllb
         Ij7yEosP4szF2UEgqAeFCldIZ2kd/IcSRmxMrEpjHrhWzvC925wyqdhC0PTmHX0w1Iq2
         QHyPu20Hf/U1KqW+J86AvsCGexzZddnR/dqOlOPpUmJWv4e1rBxhC+tzcQVK/7Wb8Z+5
         FIOA==
X-Gm-Message-State: APzg51A1q3f6XxYY5x51cHJr42NnCrJVF9zilOUWzd+mnpiAg2+76/++
        sZuXC98kYn+axa5cZLHum2Um/Q==
X-Google-Smtp-Source: ANB0VdaOwz3OubwdtfnNlz8GZQfP0JsTKNh6uAmDtQIOLM6pzUkoQ7nAYtdt5L4jkOI9itFj2YFPCw==
X-Received: by 2002:a1c:cf8a:: with SMTP id f132-v6mr1312426wmg.0.1536595006820;
        Mon, 10 Sep 2018 08:56:46 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id s205-v6sm18313787wmf.42.2018.09.10.08.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:56:45 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:56:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] regulator: da9063: fix DT probing with constraints
Message-ID: <20180910155644.GN28860@dell>
References: <20180831123402.9494-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180831123402.9494-1-p.zabel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018, Philipp Zabel wrote:

> Commit 1c892e38ce59 ("regulator: da9063: Handle less LDOs on DA9063L")
> reordered the da9063_regulator_info[] array, but not the DA9063_ID_*
> regulator ids and not the da9063_matches[] array, because ids are used
> as indices in the array initializer. This mismatch between regulator id
> and da9063_regulator_info[] array index causes the driver probe to fail
> because constraints from DT are not applied to the correct regulator:
> 
>   da9063 0-0058: Device detected (chip-ID: 0x61, var-ID: 0x50)
>   DA9063_BMEM: Bringing 900000uV into 3300000-3300000uV
>   DA9063_LDO9: Bringing 3300000uV into 2500000-2500000uV
>   DA9063_LDO1: Bringing 900000uV into 3300000-3300000uV
>   DA9063_LDO1: failed to apply 3300000-3300000uV constraint(-22)
> 
> This patch reorders the DA9063_ID_* as apparently intended, and with
> them the entries in the da90630_matches[] array.
> 
> Fixes: 1c892e38ce59 ("regulator: da9063: Handle less LDOs on DA9063L")
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/mfd/da9063/pdata.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

This is an MFD patch.

I'll make the necessary changes and apply it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
