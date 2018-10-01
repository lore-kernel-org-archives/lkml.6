Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98563C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AD82145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OljXZJnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AD82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeJBEgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:36:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52393 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJBEgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:36:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so268421wmw.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lSbAEg7edB3ftvs5ar7mtviM21y9zFXQ6/fKwokXkFA=;
        b=OljXZJnPFCfvmQMo+1JuJsOjRkNC8II91LHPZy41z02aiWPQKAsxwlx0MX2hkxEA5R
         svASjoPEoBfs76UkKvhCqflH3l6HVq5YY/OIiTEqBRqMlpHgYxTtBFCjF/nd9LMjWVCv
         4mHGPeeENw+soQLR6YKnZQvvGnOMecCSqISkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lSbAEg7edB3ftvs5ar7mtviM21y9zFXQ6/fKwokXkFA=;
        b=RjvFasWc1+G19Bq2KuVnZTUIbOW4KDdwvFxnE2hyAdT69gizM6Fwsz6oPkeeRiMj/+
         MI837WNjHwWT7MjOOcjRUCOhb4pboNJJe76A59S8MVCxQVOJC3Usp+ISUoLRSAtoYiPX
         Lb3QIQ9Gg4kPcHWZNhJjoVcbtOwnhGTYrbiu2L9Cadl5+8Hv6v8rWYoOcocs1ATh4oxX
         skJRii3l64ib8NU8m3X2Yck+zQ8q3GP4SnaQyMiwoLq/rzX8BCnEc7O3IKBQB/GhCg8V
         LUsQNKmt8jr41xK/apALVeeBJI17Ijfsh3mnBg2CvtwArRpokte7GjUXlCm1Am6wcR7F
         cMug==
X-Gm-Message-State: ABuFfogbRTfCRDlXf9U9fWe84G/J/Y8cJfk8JPQqHuygIo8pPv05ik4w
        TANYCAqIFF6kLph7a47OJkrT8/57qDcJF6/Dc+vsjQ==
X-Google-Smtp-Source: ACcGV62tAb79utju+7AncSKBwGk+/bLz2XPaOsnO2Hl+Z3vYrUbk/q6J40VTAm3g5Nn+kD4QyTWVznxG2rEWw9FXBBw=
X-Received: by 2002:a1c:1452:: with SMTP id 79-v6mr2420544wmu.31.1538430971204;
 Mon, 01 Oct 2018 14:56:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 14:56:10 -0700 (PDT)
In-Reply-To: <20181001204346.4655-1-linus.walleij@linaro.org>
References: <20181001204346.4655-1-linus.walleij@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 1 Oct 2018 14:56:10 -0700
Message-ID: <CALAqxLU-fWHQetRFeghbe+XT504YXHFXLVi6CbBsXisNSdQ-OA@mail.gmail.com>
Subject: Re: [PATCH] regulator: fixed: Default enable high on DT regulators
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 1:43 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> commit efdfeb079cc3
> ("regulator: fixed: Convert to use GPIO descriptor only")
> switched to use gpiod_get() to look up the regulator from the
> gpiolib core whether that is device tree or boardfile.
>
> This meant that we activate the code in
> a603a2b8d86e ("gpio: of: Add special quirk to parse regulator flags")
> which means the descriptors coming from the device tree already
> have the right inversion and open drain semantics set up from
> the gpiolib core.
>
> As the fixed regulator was inspected again we got the
> inverted inversion and things broke.
>
> Fix it by ignoring the config in the device tree for now: the
> later patches in the series will push all inversion handling
> over to the gpiolib core and set it up properly in the
> boardfiles for legacy devices, but I did not finish that
> for this kernel cycle.
>
> Fixes: commit efdfeb079cc3 ("regulator: fixed: Convert to use GPIO descriptor only")
> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reported-by: Fabio Estevam <festevam@gmail.com>
> Reported-by: John Stultz <john.stultz@linaro.org>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This seems to solve it!

Tested-by: John Stultz <john.stultz@linaro.org>
