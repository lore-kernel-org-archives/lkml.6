Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC3AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D417214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NFFdkR70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D417214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388873AbeKVH1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:27:06 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44582 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbeKVH1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:27:06 -0500
Received: by mail-vs1-f65.google.com with SMTP id g68so4078782vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MAG6q11GJTCo0sHyNxIZ3Ay7kIn973OOOVT+DbzJeU=;
        b=NFFdkR70VCoBdkXODFt6EOUIqL7M3ap2a9rZdMH3WUwFK86ifnGl3jZRpL82jxL9ef
         SMTuN1dSOcg6hs2QAx5XTyQLCVZEdwE4opSkALHqlxhEXH0Pm7/ZfmEiHjwhUTrCl6O4
         s1OXwauXv0aHVWOGqAxO+f2kJGgC1kK6t78Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MAG6q11GJTCo0sHyNxIZ3Ay7kIn973OOOVT+DbzJeU=;
        b=tJ2puoQpsb9MvKOp8GKgMOsmkR/uUwJgpdeJX7QZUXRc5F4/y0+YlWxxISMSzxj9+K
         /Ef1cayA8qX+GnQP5IHUSXlAvcoJeZCIjADW8W5OMaxBNZdx87tmeHGlWPSF/tYDx2OU
         9KhkXjgv6DEtBFDv/5+JwQFOFYztOIruUmBDayi1uKTwUqwKZVRw7GATc3N6xOWVCu12
         UuBgK+dCWs6wZyd/nh4xzj6n7kJKSZDCZzwZzJ2zvwtPWON7w1GUqv2LAJOK77EkmaMR
         yhiowJhdXNaRTlMj91C9jiM8aG/+0Wypzc5pVVFyzm6GOKCZhh9yjvseEI4deYfPqbCh
         soXg==
X-Gm-Message-State: AA+aEWbfxGAJ0Zz6u2Ym2i5X2h4gBvJZQKXcvYLpSMqP74aD8fAgjVMS
        yzuVO1kH8biMNccSvl9mDfI7emle+Gc=
X-Google-Smtp-Source: AJdET5dQ5v4GLSfiLBeRh+PBQCirUqwcqDSZuHjf+BSCjDYRG/8nfEnJXA9hScMzp/Jlxa1+k9tkBg==
X-Received: by 2002:a67:43c7:: with SMTP id q190mr3129982vsa.237.1542833469346;
        Wed, 21 Nov 2018 12:51:09 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id f186sm7167133vkc.7.2018.11.21.12.51.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 12:51:08 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id r14so4073580vsc.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:51:08 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr933593vsj.144.1542833468047;
 Wed, 21 Nov 2018 12:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20181122072528.11372826@canb.auug.org.au> <CAD=FV=WErS73ZLVmnP1o1WYX1VfrhwhCa6yhRC4gS9B=3vPYGg@mail.gmail.com>
In-Reply-To: <CAD=FV=WErS73ZLVmnP1o1WYX1VfrhwhCa6yhRC4gS9B=3vPYGg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 21 Nov 2018 12:50:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X4JjQYnuqR_tKcu8t5mAGFnLt1x+u_F9XB+G=7iPXhWA@mail.gmail.com>
Message-ID: <CAD=FV=X4JjQYnuqR_tKcu8t5mAGFnLt1x+u_F9XB+G=7iPXhWA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the regulator tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 21, 2018 at 12:39 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
> On Wed, Nov 21, 2018 at 12:25 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Commit
> >
> >   fe115f7fd44b ("regulator: core: Only count load for enabled consumers")
> >
> > is missing a Signed-off-by from its author.
>
> Argh.  When I squashed two commits together I must have clobbered the
> Signed-off-by.  :(  Is there a suggested way that I can fix this?

Oh.  Actually it looks like my dumb commit message is to blame.  :(  I
used two dashes ("--") to separate parts of my patch description.
"git am" seems to think this means it's after the cut.  Thus my
"Signed-off-by" got cut off...

-Doug
