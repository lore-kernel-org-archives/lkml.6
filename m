Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D58AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC92206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XfQaXUqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC92206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395452AbeKWA7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:59:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37335 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389042AbeKWA7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:59:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so8118016lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fdfbxp8ZYXz9BLwKPvPsi+OXUy6+lXMgduIhtbUdGlE=;
        b=XfQaXUqEi32qYQ+xF/zMsF4T3bDJO3Zz7JACxg0DNLeWEVjIieCpJpG7T2SCDq42W+
         8b4RFacDX/bXR3haIQ+J+RdcR0tNNsFLAni+301KV4PJS+nGVcCP2Yzb1VA+9+H1SVzs
         m5LDVtqRa7UrasyQ/fMVqcAXdzBbAGetuhVy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fdfbxp8ZYXz9BLwKPvPsi+OXUy6+lXMgduIhtbUdGlE=;
        b=faLWYxgrbiSGI21BRhyCpAlRMDkFbzsZuaiVdF07Rj6TkdvhaphXWbT8w8mmP4ssqy
         rMgZBrtlSffCHmVS8HqwxXI4KtcZT1QWzKQ8MMB+jCn/SmVGQxoWU1Bf3Hyajf0UiZgO
         LtwQL6cn/KMi4jDEDLvXFpIMSZdLCdDaThpWlwIqBFr3u/0ICiRBOGKPuVE9OHCN+rIz
         DtjP+l155KlRDefOlWFThBy4jUJwNiIEqj06knk7HOjFF0631U8jmRujMFSy0fVpqRjj
         mYnUwPqdInuTd2VEF+KTKgWxvbPsG5MLSit57Z8AzsKL+blFbvwimzh15KNbdNE6XgX4
         80eA==
X-Gm-Message-State: AA+aEWZH2g/f5zWz8wkeGa25miLipSsrTsIjqCZROH/YIeoKz/cCoajM
        CwvjmNzBYRT6FcHV8E35dXKMxVOgzVXlcs9701oeZA==
X-Google-Smtp-Source: AJdET5dUdiQidEqDpCl0U9cJgKYQp8GXw6P/Mv3SQQXKETSnhprGa0ernBSS7+AMKdTPAE1A2pbKs/oKUSTHtnMRp5M=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr7094975ljc.97.1542896397192;
 Thu, 22 Nov 2018 06:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20181121101316.32194-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20181121101316.32194-1-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Nov 2018 15:19:45 +0100
Message-ID: <CACRpkdb3HSQ_h1+9RvBUEDRDSCih7bv7kcf+=cc3-c0Hn6A0bg@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: wm8994: Don't use devres for enable GPIOs
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:13 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> The regulator core takes over managing the lifetime of the enable GPIO
> once the regulator is registered. As such we shouldn't register the
> enable GPIO using devm, or it will be freed twice.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing everything I break, I owe you big time Charles!

Now as Marek points out, I need to discern the pattern in this so
I can see if I broke something else the same way.

Yours,
Linus Walleij
