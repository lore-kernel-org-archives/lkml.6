Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9ECC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 02:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9A821019
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 02:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEl/FxYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbeL3CHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 21:07:05 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:34562 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeL3CHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 21:07:05 -0500
Received: by mail-pf1-f176.google.com with SMTP id h3so11997642pfg.1;
        Sat, 29 Dec 2018 18:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJKFFczQ+bZuXrD/WI8ziv70382O9ZE78dw0/23jYWE=;
        b=qEl/FxYrBNDgvagUI04v5D6U7L88OB3rhWN1XMG0qOKoq8GssxnCuIvSwkeUFvq2mV
         GPc0Ux2peqeo0YhK3pwgIvvC1baM4jHlAVR5A5nL4WtlONEBmf5x/ZFe/aANeSRCJJ2p
         IHJ7u75Qntai/I45SMoH8A1q3GlSrr2SZnkdapjwJoVRJtwuCynDXBertrRDkqYDeoW/
         z4VBiCmE84qzO3+A5dGcj/t6qvh+VV+4AfNATZFvJiSNc5WAUKoNdigKs0Wjd/4WMGY1
         7YAQoqbge/44fewtLrF6cmSQhuIZ+oxtCRJ56sdMwRboKuFr8GKwJLcoU/XgDLvAYdRz
         n9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJKFFczQ+bZuXrD/WI8ziv70382O9ZE78dw0/23jYWE=;
        b=VS7kv7jEA5C3iaMQuQurCfnPN+3nwABJ0JTecxzkyAlcaDNeOPVfkKAnQe4bclNJWu
         TJNTUhEGXeM+PkBmU+1xUh6VpF3wQIWFZ85j2JFU+qznibbi5idWUqvZHsBHQjuzrAQr
         NuUbetXFGyc+RvH8Up5cutKb1TvvgAvcX1d44hTNElLVLU8tkn7SGmvdziIwRNghtSo+
         Bemt3gkQLxqCw5C8UCoRd6bmFK2TpFiY7vMOFsa7d3nYVT55QMw4vUN0vo7uMyNLExBG
         X0nAWgIkZ9kK1xYt2DhoRG7dIR/N6RFIsjsskyBksWuQNrNFgRlJ5sG7idLMua1IfKZt
         PeZg==
X-Gm-Message-State: AJcUukdlBs1StRHu4BXaN0lPgl6pwF20uIcahC0FywEjxcIiP7ysa9yA
        pJD5ezm2t0fgzZgA+iNCqi71WxdAo3vXKrPYKNw=
X-Google-Smtp-Source: ALg8bN572pXaP4kAFg9sTD39tv/wNInLPSI7dXAaQD08zVdsHGub1phB4Z5YSgZOaLIfREgajwIhjk7Y3tZ0InZCcvE=
X-Received: by 2002:a63:5026:: with SMTP id e38mr3306350pgb.123.1546135624220;
 Sat, 29 Dec 2018 18:07:04 -0800 (PST)
MIME-Version: 1.0
References: <000000000000da8f65057e1ce530@google.com> <20181229173658.GA13856@yaina.de>
In-Reply-To: <20181229173658.GA13856@yaina.de>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 29 Dec 2018 18:06:52 -0800
Message-ID: <CAM_iQpUoBiWTM77JD0LPXpU2Fykw4b+c4FNx4iSLjA5rOzgHjQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in ax25_fillin_cb
To:     Joerg Reuter <jreuter@yaina.de>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>, linux-hams@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Joerg

On Sat, Dec 29, 2018 at 2:06 PM Joerg Reuter <jreuter@yaina.de> wrote:
> Unfortunately, I'm on a low bandwidth connection right now. I'd be
> grateful if someone could create a patch. This is likely not a high
> impact issue (unpriviliged users can't set up or tear down interfaces),
> still it may cause hard to find memory corruptions.

I already sent a patch:
http://patchwork.ozlabs.org/patch/1019386/

Sorry for forgetting to Cc more people.

Thanks.
