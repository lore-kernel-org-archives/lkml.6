Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80876C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8C82089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACEwAEXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8C82089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeIZNm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:42:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35006 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeIZNm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:42:57 -0400
Received: by mail-io1-f67.google.com with SMTP id w11-v6so22543121iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+p5WaPW7GbAsg1iXJQPbTuM98mJORGn3sbInfZuMNs=;
        b=ACEwAEXSTd0QUuwNeBYN1nmI85YrF0W/RJ1TkgjJ9zmFdqAMkZ5Pq7DFE+mX1miaYQ
         NN3wZggtPxO5trxbKz/GZJ6TkpsrUAdbHvOoC2rN+yE2rVHmEgImKWKCXtMv1E8hP1R0
         y2MtQdgjGgSLukXezgxRIqU5LEg/L9AJs/6H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+p5WaPW7GbAsg1iXJQPbTuM98mJORGn3sbInfZuMNs=;
        b=s6xm5NSHll9uWW85N7uByH3X0vB/lZ0NtCdDf2eUqEAYJAV/VWq0+edhl900eReykN
         x3joeBQGRXn+Fp672fh49DIzxv8OSTukjPfyNj/fgX9I159Hilkzd6lW2z5C5vTSnY8/
         h04ybLYzmA0mHovH9eLvGyUIMrCY8kUTtvFqKY0PHgdZXL932YD3lbM0OO//8AP14nus
         tvZSjyY1E8YtzOTBhVCws03l3hUlE79kzEEQ1pjRfscdBcHx1dOIghWXS449FnXKKh43
         8IDgCMT2nqrdFFQujEwYmrM3kuflas9QS/up0+tBMvfFgDVCu2RllP/l+SqkgN8tYfAh
         Kqpw==
X-Gm-Message-State: ABuFfojgipSfjQ20X3TA5hYf+LoAXeFhhc6YaKb+EDOPrAnd5PBAdvLn
        kW2r1l90hU8dzOtIoX2iRTRIIBlRj/5RxY4qaeVYtw==
X-Google-Smtp-Source: ACcGV61R7d2/QTfd/vY65R11pgqQImxrpVpVOmzjGLSqFXvDFY8kIbmtkaGwTORQq9cuHW6l7xkMY0eNkZhmk41zCz4=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr3662100ioa.277.1537947084143;
 Wed, 26 Sep 2018 00:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180924221748.21584-1-bjorn.andersson@linaro.org> <20180924221748.21584-3-bjorn.andersson@linaro.org>
In-Reply-To: <20180924221748.21584-3-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:31:12 +0200
Message-ID: <CACRpkdamu83JidqT89iLOfqsuW_UxAUVxU=Faq_QownNb-R10Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pinctrl: qcom: Support dispersed tiles
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:15 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> On some new platforms the tiles have been placed too far apart to be
> covered in a single ioremap. Turn "regs" into an array of base addresses
> and make the pingroup carry the information about which tile the pin
> resides in.
>
> For existing platforms we map the first entry regs and the existing
> pingroups will all use tile 0, meaning that there's no functional
> change.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied.

Yours,
Linus Walleij
