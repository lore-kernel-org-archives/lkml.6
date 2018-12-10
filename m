Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DB4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B580120821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4JAAWS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B580120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeLJKHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:07:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40719 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeLJKHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:07:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so9791363wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NM3kHVQqUzDYGFECnYFQlEVh1nDZzAwDhS9Ur9x25V8=;
        b=D4JAAWS5iHodNIPOboxukpafl76vItSa0P6ABaYiy0gtNk4SqKoBrlBpTi1xr0l8dr
         CdU5GXuvdVlIR1IoVo1DoVqOIPzo0hw+d9MXd/5TZ8IU5hEjtkLNtGud4rofGmLItnZA
         ndf0h6ty1OcaOL2R6wzFR97zASneVqUFaZgD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NM3kHVQqUzDYGFECnYFQlEVh1nDZzAwDhS9Ur9x25V8=;
        b=J7t7X8EXizJGJlXbTz8vHEV2UPNOYbadNoek/QOKpWSRAKJfkbxOxjF33+NcZR1+jJ
         jXG+mDfdOH9UCtTdG3vArUKz6lGM7TeSaMxk4ZlYvZ5U2ARQN8bprPdgdCLqR96RgAtL
         rCO72XV5ZTNnDQ98D0xSbcF1T+wfMiBoBKYsYSqllrZkbGFUxdEZzAAeW9yBM7UzO9WX
         4KRpcQ6Ez7GKmXqSTkn8jtc4J4FnL0yj+0KgymeT1r87Bn5AeW2HFmX8d9+g+aX6iY3s
         iK66RWED5Je/RUozm0VyZrWLKFS1vyNkisaOvS6BJPMvRRq7bh8k+NYkaIVPDSy6USr5
         qDwg==
X-Gm-Message-State: AA+aEWa0C8n46L239DmCTxX4GhfEUzgsJW6HzjokkmOGg/qIrlxb5lYH
        4IYUz9+dq0cDC3UX4tJUfBuSmQ==
X-Google-Smtp-Source: AFSGD/XqLbFWgS6JEChHkstzJAj8jIlKIu3pJnGWZvCL/MuhZJrE1KDHCehTsEPHA5s9/o4OpOCY+w==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr10064713wrr.285.1544436452090;
        Mon, 10 Dec 2018 02:07:32 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id e142sm30375177wmf.46.2018.12.10.02.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 02:07:30 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:07:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dmitry.torokhov@gmail.com, matthias.bgg@gmail.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Subject: Re: [PATCH -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
Message-ID: <20181210100729.GX26661@dell>
References: <20181209063440.27820-1-yuehaibing@huawei.com>
 <20181210061557.GL26661@dell>
 <4f1a67e5-b735-f8bd-88b8-3a1ca590eba2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f1a67e5-b735-f8bd-88b8-3a1ca590eba2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018, YueHaibing wrote:

> On 2018/12/10 14:15, Lee Jones wrote:
> > On Sun, 09 Dec 2018, YueHaibing wrote:
> > 
> >> Remove duplicated include.
> >>
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>  drivers/input/keyboard/mtk-pmic-keys.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> >> index 02c67a1..5027ebb 100644
> >> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> >> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> >> @@ -19,7 +19,6 @@
> >>  #include <linux/input.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/platform_device.h>
> >> -#include <linux/kernel.h>
> >>  #include <linux/of.h>
> >>  #include <linux/of_device.h>
> >>  #include <linux/regmap.h>
> > 
> > You are removing the wrong one.
> 
> No, linux/kernel.h is a duplicated include indeed.

Actually both are not correct, but the first instance (at the top) is
even more incorrect.

> > Please convert this patch's main intent to alphabetise the header
> > files.  Then you can remove any obvious duplicates.
> 
> I can alphabetize it in v2 if need be.

Yes please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
