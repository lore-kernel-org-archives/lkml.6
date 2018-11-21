Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6CFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5138A2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="T2IQLKSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5138A2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbeKVBOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:14:38 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:50096 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeKVBOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:14:38 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wALEdo8f005462;
        Wed, 21 Nov 2018 23:39:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wALEdo8f005462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542811191;
        bh=tCyFuF/iqBLRB+fluc2UJkzvgjC4a9PbNxlhBnKQ+zA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T2IQLKSGTOqJU3zStu+chQF2VCfK3wBecsMPD0IwpLUczrMv4JC+XvzMpgP3PVLbK
         jqKtzaNJbOYsuhO+KRxFt5sWj5zcHTfJmKHmBMsl8F6yPe6tDISkh0W9OrVpKfw0dX
         pIz7kzvdj5c91x9avguGkAT7Z+LGQW0DGisSgXufXp6dhPpMYwBjt9JQD90OSahm9o
         h/QZfrYrr1+l67vW7uNP25aGeRKYeA4CfHEvLZF9qNmbFH/qzxHf0PPq0Fu8LgA6hv
         wjL0lI3WnKPaCuoN2wPG+JCI5PJnd539kvz0EdjJYjK90vsQrbPV6o/ozVQAco4vyd
         5b4u1J1urfmzg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id b74so3361506vsd.9;
        Wed, 21 Nov 2018 06:39:51 -0800 (PST)
X-Gm-Message-State: AGRZ1gLELYkNaVHB44Zw+gneX16KdJ4xAo+La990smGFgSOoERrpVmoH
        AN0ZtleK/hrwKLcSRnZ+7YoJ0iAg0nZISaSqKGk=
X-Google-Smtp-Source: AJdET5e8K8jpnsWzsGXxdLPlfTX9bzidbaTdYSZuG06D5zcsJnq+CvUJzDLbEoVPPYTyUZzycl/pl2QbjJj+y43Vtac=
X-Received: by 2002:a67:a858:: with SMTP id r85mr2811866vse.215.1542811189763;
 Wed, 21 Nov 2018 06:39:49 -0800 (PST)
MIME-Version: 1.0
References: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 21 Nov 2018 23:39:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReYwYAgGfxsHX2uRxXrYizM9C0rmq7V_ck-V+dc+oN4A@mail.gmail.com>
Message-ID: <CAK7LNAReYwYAgGfxsHX2uRxXrYizM9C0rmq7V_ck-V+dc+oN4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] kbuild: clean-up modversion, TRIM_UNUSED_KSYMS,
 if_changed_rule, etc.
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Dike <jdike@addtoit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:11 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> As a Kbuild maintainer, I always struggle to keep the core makefiles
> clean because people tend to squeeze more and more clutter code into
> the kbuild core in order to do what they want to do.
>
> The biggest step forward in this series is to re-implement
> the build trick of CONFIG_TRIM_UNUSED_KSYMS in a cleaner way.
> scripts/Kbuild.include now looks nice again.
> Also, in my rough estimation, building with CONFIG_TRIM_UNUSED_KSYMS
> became 40-50 % faster.
>
> Besides those, nice cleanups are here and there.
>
> Masahiro Yamada (9):
>   kbuild: let fixdep directly write to .*.cmd files
>   kbuild: remove redundant 'set -e' from filechk_* defines
>   kbuild: remove redundant 'set -e' from sub_cmd_record_mcount
>   kbuild: refactor modversions build rules
>   kbuild: simplify dependency generation for CONFIG_TRIM_UNUSED_KSYMS
>   kbuild: change if_changed_rule for multi-line recipe
>   kbuild: remove trailing semicolon from cmd_* passed to if_changed_rule
>   kbuild: refactor if_changed and if_changed_dep
>   kbuild: remove redundant 'set -e' from cmd_* defines

Series, applied to linux-kbuild.





>  Makefile                     |  13 +++---
>  arch/um/Makefile             |   2 +-
>  include/asm-generic/export.h |  13 +++---
>  include/linux/export.h       |  18 ++++----
>  scripts/Kbuild.include       |  49 +++-----------------
>  scripts/Makefile.build       | 105 ++++++++++++++++++-------------------------
>  scripts/Makefile.lib         |   2 +-
>  scripts/basic/fixdep.c       |  31 ++-----------
>  scripts/gen_ksymdeps.sh      |  25 +++++++++++
>  scripts/package/Makefile     |   1 -
>  10 files changed, 106 insertions(+), 153 deletions(-)
>  create mode 100755 scripts/gen_ksymdeps.sh
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
