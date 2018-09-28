Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F30C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB48221759
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7vY1ir0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB48221759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbeI1Nvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:51:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39679 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbeI1Nvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:51:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id q5-v6so287057qki.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//QovXEGoNpJ5MUEz1aVm0Tjd4FGI4rf4AhkOK+sGUY=;
        b=e7vY1ir0XQR5FzM8H4s6DzM20B+d4o3Z04K/dLSVOPAGcntftN93ST010y9fD3572U
         yOYvZFYpCRzfn7NNOfg5/ykNHh+u1E8J2VgAsZrEjZ8Tcc3jrJzWdu22n7dlucjJPKvm
         qseoL5Ubn1Vmy0PLqSH8fvSxSHVvI0oQsXBL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//QovXEGoNpJ5MUEz1aVm0Tjd4FGI4rf4AhkOK+sGUY=;
        b=f4lBTK/4fC9HxrbzRpPcXGm4WlVjyVECM4xTDt7xyndYbAVy/hLkakZQ91vBhIymFd
         1XzfFod/EQC6iXFeDxufBZyyBwDSkhHIm+RL6butfiVu5pGQAxw2SyiLsB4FyG/P9ou3
         GfYZkHoPh/jDYxTLgaEot8MyyySLEaNdHkoJc+jFzpaH/IxKyR43M8FugUtf+SaO1xKE
         KPELiJf7Rkpse+OqIFBgjO14yE5B+eURtO14dWX+FaYYY8xuedQZMorm9y9bkHG5RdzW
         OJhuEKBPrW2+jIT6OAsTjUNOUi+m8kx4d9gm7/8MuaRVbuchtxp3n4FRr6CSNKjKmNNI
         0kLA==
X-Gm-Message-State: ABuFfogOvV9+j3zaNxe2/oGT8z3tIKj+wcxWA79dQXExEFGeT6+xNqKn
        /f8gvNmP5eUBZ2IK+RnzpbYpasROKj1muD9nknQnkA==
X-Google-Smtp-Source: ACcGV62OIcxde/7+vPnnccd0X6gLPnl83guMAfLiOEKjMUWiIBbYHqsLAu5u/CMwftPZTwXJKEaORWeT6pHNfOC5+Lo=
X-Received: by 2002:a37:1b4b:: with SMTP id b72-v6mr10880176qkb.48.1538119766082;
 Fri, 28 Sep 2018 00:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
In-Reply-To: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Sep 2018 09:29:14 +0200
Message-ID: <CACRpkdYLgT3eRRx6VFa3hMEd11JF1CeANgo9hrgkTD-wn2F1zQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] power: supply: core: Introduce one property to
 present the battery internal resistance
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 9:27 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> The internal resistance of a battery is not a constant in its life cycle,
> this varies over the age of the battery or temperature and so on. But we
> just want use one constant battery internal resistance to estimate the
> battery capacity. Thus this patch introduces one property to present
> the battery factory internal resistance for battery information.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v2:
>  - Rename the property.
>  - Improve the commit message.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
