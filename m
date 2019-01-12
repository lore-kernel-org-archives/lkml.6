Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2893CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 23:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D610620836
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 23:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="b2x40S3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfALXZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 18:25:51 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:29859 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfALXZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 18:25:51 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x0CNPTG2030943
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 08:25:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x0CNPTG2030943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547335529;
        bh=0421Kp23+mQJUgC30L5JOfmL0OfavBvoQk0fduLsEA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b2x40S3E+sfmL8hwiJ6nx2DgEUsZ3sPntLKfNvAqw4isAKSPTXBKXMqil2P7JaiPK
         SPGRNqZNe2ZyzRMqRlTKtHmOwSSyJGODz9/G5NtEkRIMFO9sU1VF9oeMVqSwFEgzdz
         bPbT88Ubn6ygqVFapXZL34laHxKCf8NFIWF82RKTtEMvgBDR2FwqfPzYuxRgBxzYWn
         PsZzQaInS+Wsb/CHO3i35X0O1TW8i7pXnVzSRxKkaJjRgkluyjsMGiGNOQfL8xs7v5
         Rdqqq9t2NREpSp7Zr/xaspfTpz7Zd9Opg+ga07UCwVPumEsZ13cYfuPwHqpv2BZlE+
         aE6X5IyMp6g+Q==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id b18so4116680vke.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 15:25:29 -0800 (PST)
X-Gm-Message-State: AJcUukfyuJEAoMv0lWgQZwcQObTtClhCDJcyp0ldVQ39lTHGNi9ByO8I
        BXaTE0rF8GC2LLfusVrsgM4GYLbDmXcLicweUjE=
X-Google-Smtp-Source: ALg8bN69Er6P3F2xuxPZ9l66T5D1nSmqMEiwhssBkpSq+4v2WOwADLWEiaHAMNk24sUj0zX+EzcqcXJQm/ZZ0OZ6nfM=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr7646563vkd.74.1547335528323;
 Sat, 12 Jan 2019 15:25:28 -0800 (PST)
MIME-Version: 1.0
References: <b2d62e31-a64c-4561-a7ad-1625acad8a3d.longchun.lc@alibaba-inc.com>
In-Reply-To: <b2d62e31-a64c-4561-a7ad-1625acad8a3d.longchun.lc@alibaba-inc.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 13 Jan 2019 08:24:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQD6iD_BW9FgufYzw2Pd5LUAM8wPyRKvzAsA_feU0B=2w@mail.gmail.com>
Message-ID: <CAK7LNAQD6iD_BW9FgufYzw2Pd5LUAM8wPyRKvzAsA_feU0B=2w@mail.gmail.com>
Subject: Re: stack-protector: fix CC_HAS_STACKPROTECTOR_NONE depend on -fno-stack-protector
To:     =?UTF-8?B?6ZqG5pil?= <longchun.lc@alibaba-inc.com>
Cc:     =?UTF-8?B?5p2O6K+aKOWFgeivmik=?= <lc85446@alibaba-inc.com>,
        =?UTF-8?B?5p2O5Li5KOaWl+mToCk=?= <doukai.ld@alibaba-inc.com>,
        =?UTF-8?B?6K645p2l5YWJKOaclOmjnik=?= <laiguang.xlg@alibaba-inc.com>,
        =?UTF-8?B?6YKs5qGF5qGFKOaXoOW4hik=?= <tom.www@alibaba-inc.com>,
        =?UTF-8?B?5p2O6ICAKOi0peWkqSk=?= <yao.ly@alibaba-inc.com>,
        =?UTF-8?B?546L5L2z55CmKOWHjOWknCk=?= <jiaqi.wjq@alibaba-inc.com>,
        =?UTF-8?B?55Sz5pmoKOWtpOmfpyk=?= <shenchen@alibaba-inc.com>,
        keescook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        akpm <akpm@linux-foundation.org>, tglx <tglx@linutronix.de>,
        mingo <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 12:57 PM =E9=9A=86=E6=98=A5 <longchun.lc@alibaba-in=
c.com> wrote:
>
> commit=EF=BC=882a61f4747eeaa85ce26ca9fbd81421b15facd018=EF=BC=89rename CC=
_STACKPROTECTOR_NONE
> config. but unfortunately if the compiler support option -fno-stack-prote=
ctor,
> CC_HAS_STACKPROTECTOR_NONE will not be disabled.

You completely misunderstood that commit.


The meaning of CC_HAS_STACKPROTECTOR_NONE is
"the compiler recognizes -fno-stack-protector option"
instead of "disable the stack protector".




Now that STACKPROTECTOR is a boolean option,
CONFIG_STACKPROTECTOR=3Dn means "disable the stack protector".




> CC_HAS_STACKPROTECTOR_NONE and CC_STACKPROTECTOR_STRONG will be enabled a=
t once,
> as the following conditions:
>         1. gcc support -fno-stack-protector & -fstack-protector-strong
>         2. enabled CC_STACKPROTECTOR_STRONG & STACKPROTECTOR


CC_STACKPROTECTOR_STRONG does not exist any more.

STACKPROTECTOR_STRONG and STACKPROTECTOR exist.




>         3. disabled CC_HAS_STACKPROTECTOR_NONE

This represents the compiler capability.

Not a user-configurable option.



>
>
>


--=20
Best Regards
Masahiro Yamada
