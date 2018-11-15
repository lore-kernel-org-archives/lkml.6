Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3084AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF73221582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF73221582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbeKPAvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:51:11 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43498 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbeKPAvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:51:10 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so32053348qkr.10;
        Thu, 15 Nov 2018 06:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0UK7+dWyiE8ihgkn/imXPi7Cm4RWnnrPO7xZCITF9E=;
        b=fxOKxNm1IEDWukKstlRI4DjFtayOS7r6WAlXdiU8h18kXHclJwvHtkV9ns9PdMqUIj
         AoTjXd1stqiDXQFjItQYajdecUeLX3YJcN+jFr/o6qWDQvf6QlsSkSRhwd0xD+/z3e16
         1+jl5YaZi9V9q+Ag+Nt0iH0bZENb83TDfvk1e/j6qlyMHrP7L1hHUUYaLG8N9098V4xt
         FoC0xjBaLGVanO/9BorKw58SEW5rNzYRFYBQskyZ2r1W5Hty4dAtbaborsKZElK3JH+K
         UswxAEX5kan85NYX0inI6PGHHx7NvBIKL+s+SMJHWMsqezS52PDFma99EXH5rYwIlL96
         auBA==
X-Gm-Message-State: AGRZ1gJCOJR3B+WTg2VS/hAVcdsx4VU0G/4IIJNlEyqLLVrX1AHH143P
        q81XGwT8vu7TaoLVyHcdjfxEgorM59tVOwkR9Ls=
X-Google-Smtp-Source: AJdET5dU1N4V7DqVgPPY4ndASEO8YT8D2qOqHUa8oO+yuGc08mbfWR/cdd50VsulSD7G5UMGYBLgGphuen9Drh840Qw=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr6238645qta.152.1542292983500;
 Thu, 15 Nov 2018 06:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-8-elder@linaro.org>
 <CAK8P3a2FsgR=SYAWsgFURVni1ReiCugKs1iUAfQzZhPkbW8aOA@mail.gmail.com> <e9114caf-0c92-7cac-33cd-6bea548b0375@linaro.org>
In-Reply-To: <e9114caf-0c92-7cac-33cd-6bea548b0375@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Nov 2018 06:42:45 -0800
Message-ID: <CAK8P3a1RKVYRhM7OtUK3BhPj=jip2-j_8ziW_6Z5rnhFCTOOUw@mail.gmail.com>
Subject: Re: [RFC PATCH 07/12] soc: qcom: ipa: IPA register abstraction
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 6:48 PM Alex Elder <elder@linaro.org> wrote:
>
> On 11/7/18 9:00 AM, Arnd Bergmann wrote:
> > On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
> >> diff --git a/drivers/net/ipa/ipa_reg.c b/drivers/net/ipa/ipa_reg.c
> >> new file mode 100644
> >> index 000000000000..5e0aa6163235
> >> --- /dev/null
> >> +++ b/drivers/net/ipa/ipa_reg.c
> >> @@ -0,0 +1,972 @@

> It may be that this parse/construct mechanism isn't justified
> at this point.  I thought the way it presented a generic
> interface was useful, but with just one (initial) hardware
> target we don't (yet) realize its potential benefit.  It could
> be added back later, as support for new versions is added.
>
> As of now I don't plan to change this, but if you or someone
> else feels it would be better without it I can do that.

Fair enough. I do think that it would be better to avoid this, but
it's much less important than the other issues I mentioned,
so please put this on the bottom of your priorities list, we
can talk about it again when we get closer to merging the driver.

     Arnd
