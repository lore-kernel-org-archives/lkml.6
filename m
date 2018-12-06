Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F16C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E850120868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CdfKz3Nz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E850120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeLFXjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:39:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33357 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeLFXjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:39:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so2022212ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEQ1EBvJcPezsGB7SQbsMaVj3lDWsOG6mXorcUThiog=;
        b=CdfKz3Nzz+etlWfKeETyw8Ttk2jcvphtF4xAvCFuNjoxlY7iV8fQFZ8wRpjzZFj8YN
         3Bxgn9PWU21BodabJUXnHJScRFAPJLm7QPOShhMoXeEy6499+FctaayoOeqyAKHe5g9P
         HAEHsgtLwO2pc5qK9cyWacf5WD9sq3fJ2Piec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEQ1EBvJcPezsGB7SQbsMaVj3lDWsOG6mXorcUThiog=;
        b=NuUu69YC/CApTkQtmetTLoQOI/o3UUSz+YyGu08GKlxZ13N3amO3kX5aD4BqLIUPSP
         +IaduxzSMb9QvUqSimkpCWWQPaRjFoNl3xuHoP5+pkIcDqijb2WPpvObmLele0d7T0mE
         4BLmN/B79a0S+KIswu2XsBff4rUwavLQyvxRO2kdIEK5tDzL0hyMULYE4X5HakurH6ZB
         FjKthDToX3AO/oibNrxRJPx8OkXTz9fj2pi2D+ORcudhe71xuer0zeClC7gDw1LrcgmD
         ooJ91Hx+STyQjdsWMgpzIiX5tvWvHDpG2W8sfzy7EIrGBwfvJNbOlB1+3DB/5hbVJsCu
         ST2A==
X-Gm-Message-State: AA+aEWYkUcvGaxiX9AyPc4nqWTEp5lg5YLwgF0IAVSbm9tbp0eoe3nIp
        XsH70KQLX8XDsB38k/peUKRaUqM54rc=
X-Google-Smtp-Source: AFSGD/W0RiwsNJgXpQ/yoInoB1fntOxhPntPnzGCTi5iHrL9W9EzE0dn1iOt7gj6VD/EC4eYmCI/fw==
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr19225186ljd.45.1544139577975;
        Thu, 06 Dec 2018 15:39:37 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j25-v6sm294891lji.77.2018.12.06.15.39.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 15:39:37 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id z13so1668550lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:39:37 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr19082715lfa.135.1544139576585;
 Thu, 06 Dec 2018 15:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20181206184522.118062-1-evgreen@chromium.org> <20181206184522.118062-2-evgreen@chromium.org>
 <CAD=FV=XWpLcevH72bchsKauqRpH3FSSKooQ7r6uoEgjN=4k_PQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XWpLcevH72bchsKauqRpH3FSSKooQ7r6uoEgjN=4k_PQ@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 6 Dec 2018 15:39:00 -0800
X-Gmail-Original-Message-ID: <CAE=gft7kmzB1p8uehzmzoSymdaT1vsGJhdy+jnNdP=BfNDbS6Q@mail.gmail.com>
Message-ID: <CAE=gft7kmzB1p8uehzmzoSymdaT1vsGJhdy+jnNdP=BfNDbS6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: sdhci-msm: Clarify register requirements
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 3:34 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
> On Thu, Dec 6, 2018 at 10:45 AM Evan Green <evgreen@chromium.org> wrote:
> >
> > In sdhci-msm-v5 and beyond, the MCI registers are removed, so there is only
> > one register region required.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> > Changes in v2: None
> >
> >  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> You probably should have skipped this patch from v2.  Ulf already
> landed it.  It can be found at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=next&id=68fe87ac8a9309bbdc960cbd774725e44ea98b58
>

Oh, oops. Ignore this 1/3 patch then, but the other two are valid.
-Evan
