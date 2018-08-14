Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29145C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C974D2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C974D2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbeHNLaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:30:13 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43497 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeHNLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:30:12 -0400
Received: by mail-qt0-f193.google.com with SMTP id f18-v6so20277267qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 01:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rj3Iu5SdcNG26avVHSw7vWSAp/q5O4XT2I5YgCEK5oQ=;
        b=SPTsIZUTBNUjn08yXcPVbaCVqi8EBT1GhTmKpbrNqM4XFn4CnAaOe2Q2PNmZWrv2ex
         78S2nFKaTT59SyODixgYfpraDqImRua58qO3VkBJvxu8kKsxUNlgLjXectJuMTMDw4XY
         aFrkQmiwJ8yfzYfNVs0HAwjQL9PDCSq1Ajx1xF1VV/G3K6avzPCtK3htv8W3gjV/mvy8
         w6Yn/w+YqQQaNBGC4RQjlijKipEJJ7UUGGFSfpTaCToRXt0U75zUzaQeT5R5Bu/zrBj8
         EtNiFauQyG37YEJ/tR/Qf2BRYFSK4W5ldYqqOhmMtxhemT6Oq3ccIA2RR/YqsDrZFL+J
         fQPg==
X-Gm-Message-State: AOUpUlE/WvqjXH4nHmA96C48fG9jyAHNwzVHkHpFY9muOEp0BmTQy4d7
        TFxdDoIiT4SkCgtE0AkEog0KaOLm7zsTyt5Gmjo=
X-Google-Smtp-Source: AA+uWPx/LYXEaYyr2Lh7Tp8btfvYUtHYyZjB6drsbu/4Bpo7vJrHSNJE/VmfUZ6qvEr4IcsgmDjOe0C3TKFkJBmHg5c=
X-Received: by 2002:ac8:30e3:: with SMTP id w32-v6mr20656334qta.280.1534236241939;
 Tue, 14 Aug 2018 01:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180813220950.194841-1-arnd@arndb.de> <CAK7LNASVE-vZhGyAsWg8YmPb8P-sucwPVOUt5qsfVwZQuHg9gw@mail.gmail.com>
 <1534233405.3547.4.camel@sipsolutions.net>
In-Reply-To: <1534233405.3547.4.camel@sipsolutions.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Aug 2018 10:43:45 +0200
Message-ID: <CAK8P3a2+ZLN_HmNJiNs4YFsvkqewnwq-a2d0uNe+RS61RAMYOQ@mail.gmail.com>
Subject: Re: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 9:57 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> On Tue, 2018-08-14 at 08:57 +0900, Masahiro Yamada wrote:
> > 2018-08-14 7:09 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:

> > > drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1025:21: note: in expansion of macro 'FIELD_GET'
> > >     le16_encode_bits(FIELD_GET(IWL_RX_HE_PHY_SIBG_SYM_OR_USER_NUM_MASK,
> >
> >
> > How about fixing the root cause
> > in drivers/net/wireless/intel/iwlwifi/fw/api/rx.h ?
> >
> >
> > #define IWL_RX_HE_PHY_SIBG_SYM_OR_USER_NUM_MASK   0x1e00000000ULL
> >
> >
> > enum iwl_rx_he_phy looks really strange.
>
> Why? I don't think this is a problem, the enum is used here to get
> constants so that we can also have documentation for them. That's a
> common and accepted technique.

I think using #define is more common overall, but I also prefer using enum
for this in my own code.

   Arnd
