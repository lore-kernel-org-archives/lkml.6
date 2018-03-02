Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164586AbeCBHJL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:09:11 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:35976 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932927AbeCBHJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:09:08 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w2278sA6014642
X-Nifty-SrcIP: [209.85.217.171]
X-Google-Smtp-Source: AG47ELv9wPPCqmSelc7KY2kmWFBG4WZLX8LDWVgZURu9tP65WY99faGDFIUhKCILQsdfIsHwpiwHFAKwEyT7g6k3psc=
MIME-Version: 1.0
In-Reply-To: <1519965121-12017-12-git-send-email-yamada.masahiro@socionext.com>
References: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com> <1519965121-12017-12-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 2 Mar 2018 16:08:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASShS-umtrDwhc7vg1mc-u01cO4qSsAxX1rxBQ_pjVZ3g@mail.gmail.com>
Message-ID: <CAK7LNASShS-umtrDwhc7vg1mc-u01cO4qSsAxX1rxBQ_pjVZ3g@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] kconfig: unittest: test if recursive inclusion
 is detected
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-02 13:32 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> If recursive inclusion is detected, it should fail with error messages.
> Test this.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>
> Changes in v2:
>   - coding style clean-up based on PEP8, PEP257
>
>  scripts/kconfig/tests/err_recursive_inc/Kconfig         |  1 +
>  scripts/kconfig/tests/err_recursive_inc/Kconfig.inc     |  1 +
>  scripts/kconfig/tests/err_recursive_inc/__init__.py     | 10 ++++++++++
>  scripts/kconfig/tests/err_recursive_inc/expected_stderr |  4 ++++
>  4 files changed, 16 insertions(+)
>  create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig
>  create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig.inc
>  create mode 100644 scripts/kconfig/tests/err_recursive_inc/__init__.py
>  create mode 100644 scripts/kconfig/tests/err_recursive_inc/expected_stderr
>
> diff --git a/scripts/kconfig/tests/err_recursive_inc/Kconfig b/scripts/kconfig/tests/err_recursive_inc/Kconfig
> new file mode 100644
> index 0000000..3ce7a3f
> --- /dev/null
> +++ b/scripts/kconfig/tests/err_recursive_inc/Kconfig
> @@ -0,0 +1 @@
> +source "Kconfig.inc"
> diff --git a/scripts/kconfig/tests/err_recursive_inc/Kconfig.inc b/scripts/kconfig/tests/err_recursive_inc/Kconfig.inc
> new file mode 100644
> index 0000000..1fab1c1
> --- /dev/null
> +++ b/scripts/kconfig/tests/err_recursive_inc/Kconfig.inc
> @@ -0,0 +1 @@
> +source "Kconfig"
> diff --git a/scripts/kconfig/tests/err_recursive_inc/__init__.py b/scripts/kconfig/tests/err_recursive_inc/__init__.py
> new file mode 100644
> index 0000000..0e4c839
> --- /dev/null
> +++ b/scripts/kconfig/tests/err_recursive_inc/__init__.py
> @@ -0,0 +1,10 @@
> +"""
> +Detect recursive inclusion error.
> +
> +If recursive inclusion is detected, it should fail with error messages.
> +"""
> +
> +
> +def test(conf):
> +    assert conf.oldaskconfig() != 0
> +    assert conf.stderr_contains('expected_stderr')
> diff --git a/scripts/kconfig/tests/err_recursive_inc/expected_stderr b/scripts/kconfig/tests/err_recursive_inc/expected_stderr
> new file mode 100644
> index 0000000..b256c91
> --- /dev/null
> +++ b/scripts/kconfig/tests/err_recursive_inc/expected_stderr
> @@ -0,0 +1,4 @@
> +Kconfig:1: recursive inclusion detected. Inclusion path:
> +  current file : 'Kconfig'
> +  included from: 'Kconfig.inc:1'
> +  included from: 'Kconfig:3'


Currently, the line number is wrong.

The following patch should be applied first
https://patchwork.kernel.org/patch/10253541/


Then, expected data should be changed

  included from: 'Kconfig:3'

->

  included from: 'Kconfig:1'



-- 
Best Regards
Masahiro Yamada
