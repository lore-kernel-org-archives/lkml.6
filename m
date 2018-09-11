Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAE4C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670412086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMDvC3Cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670412086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeIKSzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:55:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36951 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeIKSzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:55:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so26106869wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PsMb5ucJUMCbQyvRTYrPFrwR9kS1LmUFMXqUk8rk4tM=;
        b=WMDvC3CwvKt563CSgKZClj0YdKGfRSVFT2MWBKjcSyYWuecF2N4eRlrDizXKyzka7D
         RB7ex6lhqJMjhf6yZO5sbCEkijxcaiq1iU/Ry96H3zbV1VLuAQtViGZp7CuNL+uCV1Yl
         RLlJ1WEOVgOqQrhURUD7mU0dUGQF5yBPPFTTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PsMb5ucJUMCbQyvRTYrPFrwR9kS1LmUFMXqUk8rk4tM=;
        b=Ihz7S+1q/ePpVuLkGsUeKwjWVLxQGG4Is8K6ln/NnTBZqML323QcT2cJvgfDOQecNm
         RS6lqCQey32Cr7ojrjlgZphtwbJlj0KB+AtNqHbmHnuB26k2LGf7I63lH809CSumFaZ/
         OAz85YNX70SyDmNVUqxpkRP2pe8Kw64AJCk08w+HKNIEII7HRD1ycysuG55/MXfbhP0e
         98gqvwJSDfCuFnDP6qf0z8CvlGvZoXiCMuUtEU706AApertbYaR3xGU57TvsyJys5sWT
         nrE6oayUspTzyhHm+yUxXRZOI5pKTC9/Uzt627gTojbFFh7KVUD6TehdgsLyu/hvuPzs
         Y15Q==
X-Gm-Message-State: APzg51CU3p7p5zy+mvYrjbKiAcwWpgsC6ITud4IxJ0+7aEbt4q8h1rus
        hrWbAxK1SVALFy1RR9sSAFg5WA==
X-Google-Smtp-Source: ANB0VdaS5KmP44mPHcgjsxSmnQ8/K2RMqSUaPkkIh7q1WZfsqQgkpflQyxl9x9/vR/meKaPU5gjJEQ==
X-Received: by 2002:adf:9ae5:: with SMTP id a92-v6mr20341215wrc.125.1536674151655;
        Tue, 11 Sep 2018 06:55:51 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id t132-v6sm1780559wmf.24.2018.09.11.06.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 06:55:50 -0700 (PDT)
Date:   Tue, 11 Sep 2018 14:55:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 7/8] regulator: bd718XX use pickable ranges
Message-ID: <20180911135549.GS4185@dell>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <6fa8728de34a18623736d3b01537930eda2dd54e.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fa8728de34a18623736d3b01537930eda2dd54e.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018, Matti Vaittinen wrote:

> Few regulators in BD71837 and BD71847 can output voltages from
> different voltage ranges. Register interface is arranged so that
> used range is selected by toggling bits which are not next to actual
> voltage selection bits. Then the voltage inside selected range is
> determined by voltage selection bits (as usual). Support BD71837
> and BD71847 selectible range voltages using new pickable ranges
> helpers.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/regulator/bd71837-regulator.c | 155 +++++++++++++++++++++++++++-------
>  include/linux/mfd/rohm-bd718x7.h      |  38 +++++----
>  2 files changed, 147 insertions(+), 46 deletions(-)

[...]

> diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
> index d1730b97ba52..4cc617047d5f 100644
> --- a/include/linux/mfd/rohm-bd718x7.h
> +++ b/include/linux/mfd/rohm-bd718x7.h
> @@ -7,13 +7,13 @@
>  #include <linux/regmap.h>
>  
>  enum {
> -	BD718XX_TYPE_BD71837,
> +	BD718XX_TYPE_BD71837 = 0,
>  	BD718XX_TYPE_BD71847,
>  	BD718XX_TYPE_AMNT // Keep this as last item
>  };
>  
>  enum {
> -	BD718XX_BUCK1	=	0,
> +	BD718XX_BUCK1 = 0,
>  	BD718XX_BUCK2,
>  	BD718XX_BUCK3,
>  	BD718XX_BUCK4,
> @@ -31,31 +31,27 @@ enum {
>  	BD718XX_REGULATOR_MAX,
>  };

Even though I don't care enough to NACK the patch, the above are
unrelated changes and should normally be contained in a separate
patch.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
