Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F01C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EDD20870
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FoUkvDbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfA1E7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 23:59:39 -0500
Received: from condef-05.nifty.com ([202.248.20.70]:35582 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1E7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 23:59:39 -0500
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-05.nifty.com with ESMTP id x0S441aC016680;
        Mon, 28 Jan 2019 13:04:01 +0900
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x0S43cGx007730;
        Mon, 28 Jan 2019 13:03:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x0S43cGx007730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548648219;
        bh=BOEIqh/RN2ZMkaNGC6ujx5fPfMNlEO00uL1qVwDyiUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FoUkvDbUsiRe3XlO2oi2bDV4dsWXDmsDtaDSnFUbu1plaBSUePEV3Kb5HqHWIcT4j
         3Vj4eP9dYv0bhYMoY5pYQ8IOtVKu/H+Okl0rGhfySFRsjkM3Asp+1Mhev/Bc/us/pG
         d/C+63hQg58i20Ea987nV6IU1e414WGjzik6tW6NrluRa8kLw7xTtE/iJdYER/YTOz
         nyyPEhZNe1mRNC08eAp84nSZDxMzMvlhelbO1TZjTLTMCljxxDc5Yi1xHGGVjHdvAs
         jJwPnD2TIWYS/4aB4/lJjnOr/AerXENJHLot75PREyC+YuBS52gaj5xoLQ8TDZ9yBU
         jFJ/4ghiyIsZg==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id j23so3363407vke.13;
        Sun, 27 Jan 2019 20:03:39 -0800 (PST)
X-Gm-Message-State: AJcUukch9DevK7GjVUr8JZGf1BepMvqF0CYt16kW/eRuN4cdJVvQEK4I
        L8TU6RigjCWn8vJmgX84xow1WC97AEqyZfygZJs=
X-Google-Smtp-Source: ALg8bN76aDDU7lEkTw1Z8JOWsmbU1AYKMN2xwFQllec4h+Ts0opkIiGAPh70ACQcD/PmA+QEU7sF/rAkdrYd5jwn8Tw=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr8058006vkd.74.1548648218173;
 Sun, 27 Jan 2019 20:03:38 -0800 (PST)
MIME-Version: 1.0
References: <1547765160-15502-1-git-send-email-eugene.loh@oracle.com>
 <CAKv+Gu8BeYsq-_7KiANOjSN2fp25BP=71uLqKnkkYYJdhD2Bfw@mail.gmail.com> <CAKv+Gu_6_K0ZrRLMST6bYxqgSfhDJACoiArQg+K3pFaYjJxQsA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_6_K0ZrRLMST6bYxqgSfhDJACoiArQg+K3pFaYjJxQsA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 28 Jan 2019 13:03:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQps9akw1z-t+zr3ZybmBX3buM1PoAVYHxmDn=U+nNhNQ@mail.gmail.com>
Message-ID: <CAK7LNAQps9akw1z-t+zr3ZybmBX3buM1PoAVYHxmDn=U+nNhNQ@mail.gmail.com>
Subject: Re: [PATCH] Kbuild: Handle too long symbols in kallsyms.c
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, eugene.loh@oracle.com
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:30 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> (+ masahiro)
>
> On Fri, 25 Jan 2019 at 14:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 17 Jan 2019 at 23:46, <eugene.loh@oracle.com> wrote:
> > >
> > > From: Eugene Loh <eugene.loh@oracle.com>
> > >
> > > When checking for symbols with excessively long names,
> > > account for null terminating character.
> > >
> > > Fixes: f3462aa952cf ("Kbuild: Handle longer symbols in kallsyms.c")
> > > Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
> >
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > > ---
> > >  scripts/kallsyms.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > > index 77cebad..f75e7


Applied to linux-kbuid/fixes.
Thanks!



-- 
Best Regards
Masahiro Yamada
