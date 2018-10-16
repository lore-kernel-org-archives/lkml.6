Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B148220869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJmy4ifs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B148220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJPPAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:00:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43870 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeJPPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:00:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id 12-v6so13464999qkj.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MC/TFJxT4wqRcTHQ3op6F7JPPs4E8aXvaRRl5X9BMQ=;
        b=EJmy4ifstZJCusc14jPOh3BMhlPvJZJ1hYP9IdQNTOijjjzpCFxFg6JKFiiRcRrGMd
         +MojfCRoQv1FAHsCGZgDvL5WVHlwbrYAD8+/I4hTCvJXhdJmtyibv393N6mFpu+sI6nF
         OwGFWpuUvEqTj6ifGQstTATUVxJOYEDBMAjVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MC/TFJxT4wqRcTHQ3op6F7JPPs4E8aXvaRRl5X9BMQ=;
        b=Ai556KRFa47OsFrwhmX7PsQ3mv8LzGMqZTaO3kIvmtfs0t38VmS7fFheIj9Yf/jbC+
         sKo4Lt5DVYYOuCsrPqiOI4ImLQ6UnioLwspJ+6AFoiRVmHmmVwQaGjL/6NcYcYb14Eb/
         1BHeStPgAkqVHEkrgYWp9soFAs1/7FUW+XdSU/7WyLGqDg9yhGJl2l8QtfaP2dggH+Jb
         BbGyEMiZY/oKzyrBDKSdy5BrzdNxW4OvIbts/p7cvBA+ptEN3euxuD/hZWWCuTt1T8bJ
         tk9+wj0/R2Qg+WF7+cfE6RqHLelv1faLqFu5YqpYy73SyrnQSGhpwovjl4wS5sKuw104
         WPYg==
X-Gm-Message-State: ABuFfoj9ReFbp4NjlyzQFlr84aoFgo4Jstwb22NP/fDD5LoRZiQ7Auml
        sYLHznnkE5bL15rkkKZrp4cG/IoxNWo7HsxrlviAHg==
X-Google-Smtp-Source: ACcGV62r9W2h7/7BlKy6grEcF6hu4Uk6fU0NmEuDmMQZFNJtGV5xpiOQkbtbew/CtkpNHl+wMx6G46ERaMvBEAwT3z4=
X-Received: by 2002:a37:5185:: with SMTP id f127-v6mr19362564qkb.44.1539673869537;
 Tue, 16 Oct 2018 00:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181012125412.21324-1-linus.walleij@linaro.org>
 <20181012142612.GJ7677@w540> <20181012164424.GE2340@sirena.org.uk> <2849502.hPNvL6TNkA@avalon>
In-Reply-To: <2849502.hPNvL6TNkA@avalon>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Oct 2018 09:10:56 +0200
Message-ID: <CACRpkdZGE3RGWarj6_kZN7e6AT+1C9FMrs=bGUFJLD00F9gOEQ@mail.gmail.com>
Subject: Re: [PATCH v2] regulator/gpio: Allow nonexclusive GPIO access
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mark Brown <broonie@kernel.org>, jacopo <jacopo@jmondi.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 1:08 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> I've seen other boards where two components sharing a reset signal have an
> active low reset for one, and an active high reset for the other one. Only one
> of the two can be out of reset at a time. That's probably considered as
> "clever" by the hardware engineers, but is awful to support for us.

Haha what a feat. If/when we run into that we simply invent a new
flag like GPIOD_ACTIVE_AMBIGUOUS.

> The core issue in my opinion is that we need code to handle this, and since
> the removal of board files there is no place anymore for such code. Board
> drivers exist in drivers/staging/board/, but that's hardly a solution moving
> forward (the TODO file explicitly states that removal of that code is the end
> goal).

Yeah I kind of already concluded that I need to pull the multiple user
reference counting out of the regulator core and take it over to the
GPIO subsystem so I'm going to attempt that for the next kernel
cycle. It's a neat feature anyways.

Yours,
Linus Walleij
