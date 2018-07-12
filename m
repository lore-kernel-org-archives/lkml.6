Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06C9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCD121476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DxDnMz9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCD121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeGLKVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:21:05 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:64331 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeGLKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:21:05 -0400
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com [209.85.217.177]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w6CABw6Z031926;
        Thu, 12 Jul 2018 19:11:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w6CABw6Z031926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531390319;
        bh=k/ssaWK2LvvKS+vEBz9k1+ITXg9tIowGqSGWU+aOESE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=DxDnMz9l0PGm12/u7WkL+Hs2xyTWOBt+R4h42X6pdfRuEtuXXnbjDmMkrCYtsWd3h
         300fI0uGaKf1TqL7m5n6RH2pj1Upy7pbssv7vJ4Q2/rqV8FXX7qugWRh6u1Ue7FIZg
         WywFtvhkABDfXInhXkqkdTMPkSnb49jT6vZtrXPbr8KA/SQ5TNe/otcgl1/23QRU0C
         TU+yA8XK4eG4WP0MIBt/eXjrZCjc6W09bIlyvQAKQOJxpm7uQIDEuYdXFXkyIs4o03
         PoK5N66EBHfVXIVGT1gmwDujuX3rio6VZHyB8n5xNbFo0bN/f0h2JmZbB+uJJd9PXA
         waV9Opsis48xw==
X-Nifty-SrcIP: [209.85.217.177]
Received: by mail-ua0-f177.google.com with SMTP id k8-v6so2668902uaq.12;
        Thu, 12 Jul 2018 03:11:59 -0700 (PDT)
X-Gm-Message-State: AOUpUlH+zJZd80Z2i+txwIYnJA3tZpLuuawHwow9ONGZ7FM1JTgq+NRe
        JAHpMTpAfmcLpOUJSZ38qjvHZ/lXvD3gbVoAEYk=
X-Google-Smtp-Source: AAOMgpd5sd2i0V4TBRfRBP0uNDbfxwtBMpoTfjr6XxmZUXPsJQEj9pAZqrjI/TGj5+zDHGKdG89dSLsKu6cT1IbDTv4=
X-Received: by 2002:ab0:e3:: with SMTP id 90-v6mr874227uaj.52.1531390318288;
 Thu, 12 Jul 2018 03:11:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 03:11:17
 -0700 (PDT)
In-Reply-To: <20180710004602.21599-8-labbott@redhat.com>
References: <20180710004602.21599-1-labbott@redhat.com> <20180710004602.21599-8-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 12 Jul 2018 19:11:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNATjYXn8z-FbVLO-ZPGQUQSiX0YD_hCOPhcWSdoc2T5JhA@mail.gmail.com>
Message-ID: <CAK7LNATjYXn8z-FbVLO-ZPGQUQSiX0YD_hCOPhcWSdoc2T5JhA@mail.gmail.com>
Subject: Re: [PATCHv2 7/7] Kbuild: Use HOST*FLAGS options from the command line
To:     Laura Abbott <labbott@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Jarry <robin.jarry@6wind.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-10 9:46 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> Now that we have the rename in place, reuse the HOST*FLAGS options as
> something that can be set from the command line and included with the
> rest of the flags.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Use the correct name for HOSTLDLIBS, update documentation.
> ---
>  Documentation/kbuild/kbuild.txt | 16 ++++++++++++++++
>  Makefile                        |  9 +++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
>




> +HOSTLDFLAGS
> +--------------------------------------------------
> +Additional flags to be passed to $(HOSTLD) when building host programs.



Strictly speaking, $(CC) or $(CXX) is used
when linking host programs.


See this.
https://github.com/torvalds/linux/blob/v4.17/scripts/Makefile.host#L95
https://github.com/torvalds/linux/blob/v4.17/scripts/Makefile.host#L112


In fact, there is no definition of 'HOSTLD' in the top Makefile.


I will reword it to:


HOSTLDFLAGS
--------------------------------------------------
Additional flags to be passed when linking host programs.




I will also move this hunk up
after LDFLAGS_MODULE.





-- 
Best Regards
Masahiro Yamada
