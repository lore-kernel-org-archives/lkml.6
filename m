Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427014AbeCBLPG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:15:06 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42827 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423672AbeCBLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:14:40 -0500
X-Google-Smtp-Source: AG47ELvlY/GaL+w0ZZgQW7B2JR2SphfjnYHPdnpoMd6jdLZAp+zADq1vxv4CA8Hp6o/7PhbZkqoL1RdiFtwsx6LD7Qk=
MIME-Version: 1.0
In-Reply-To: <1519965121-12017-10-git-send-email-yamada.masahiro@socionext.com>
References: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com> <1519965121-12017-10-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Fri, 2 Mar 2018 12:14:39 +0100
Message-ID: <CAFkk2KQTjnTLkBx_8jXLejxVJLHV6gijN0_MCYDwbsL+KNkp=w@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] kconfig: unittest: test randconfig for choice in choice
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 5:31 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Commit 3b9a19e08960 ("kconfig: loop as long as we changed some symbols
> in randconfig") fixed randconfig where a choice contains a sub-choice.
> Prior to that commit, the sub-choice values were not set.
>
> This is complicated usage, but it is still used in the real world;
> drivers/usb/gadget/legacy/Kconfig is source'd in a choice context,
> then creates a sub-choice in it.

That file is the only one that does all that weird choice stuff btw.

It's an optional choice with the choice symbols source'd from a
separate file, containing non-symbol items and symbols that end up in
implicit submenus and aren't considered choice symbols.

It's as if it was written to make use of as much obscure Kconfig stuff
as possible. :P

>
> For the test case in this commit, there are 3 possible results.
>
> Case 1:
>   CONFIG_A=y
>   # CONFIG_B is not set
>
> Case 2:
>   # CONFIG_A is not set
>   CONFIG_B=y
>   CONFIG_C=y
>   # CONFIG_D is not set
>
> Case 3:
>   # CONFIG_A is not set
>   CONFIG_B=y
>   # CONFIG_C is not set
>   CONFIG_D=y
>   CONFIG_E=y
>
> So, this test iterates several times, and checks if the result is
> either of the three.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Newly added
>
>  scripts/kconfig/tests/rand_nested_choice/Kconfig   | 33 ++++++++++++++++++++++
>  .../kconfig/tests/rand_nested_choice/__init__.py   | 16 +++++++++++
>  .../tests/rand_nested_choice/expected_stdout0      |  2 ++
>  .../tests/rand_nested_choice/expected_stdout1      |  4 +++
>  .../tests/rand_nested_choice/expected_stdout2      |  5 ++++
>  5 files changed, 60 insertions(+)
>  create mode 100644 scripts/kconfig/tests/rand_nested_choice/Kconfig
>  create mode 100644 scripts/kconfig/tests/rand_nested_choice/__init__.py
>  create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout0
>  create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout1
>  create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout2
>
> diff --git a/scripts/kconfig/tests/rand_nested_choice/Kconfig b/scripts/kconfig/tests/rand_nested_choice/Kconfig
> new file mode 100644
> index 0000000..c591d51
> --- /dev/null
> +++ b/scripts/kconfig/tests/rand_nested_choice/Kconfig
> @@ -0,0 +1,33 @@
> +choice
> +       prompt "choice"
> +
> +config A
> +       bool "A"
> +
> +config B
> +       bool "B"
> +
> +if B
> +choice
> +       prompt "sub choice"
> +
> +config C
> +       bool "C"
> +
> +config D
> +       bool "D"
> +
> +if D
> +choice
> +       prompt "subsub choice"
> +
> +config E
> +       bool "E"
> +
> +endchoice
> +endif # D
> +
> +endchoice
> +endif # B
> +
> +endchoice
> diff --git a/scripts/kconfig/tests/rand_nested_choice/__init__.py b/scripts/kconfig/tests/rand_nested_choice/__init__.py
> new file mode 100644
> index 0000000..9ceadf6
> --- /dev/null
> +++ b/scripts/kconfig/tests/rand_nested_choice/__init__.py
> @@ -0,0 +1,16 @@
> +"""
> +Set random values resursively in netsted choices.

Two small typos: recursively, nested

> +
> +Kconfig can create a choice-in-choice structure by using 'if' statement.
> +randconfig should correctly set randome choice values.

Typo: random

> +
> +Related Linux commit: 3b9a19e08960e5cdad5253998637653e592a3c29
> +"""
> +
> +
> +def test(conf):
> +    for i in range(20):
> +        assert conf.randconfig() == 0
> +        assert (conf.config_contains('expected_stdout0') or
> +                conf.config_contains('expected_stdout1') or
> +                conf.config_contains('expected_stdout2'))
> diff --git a/scripts/kconfig/tests/rand_nested_choice/expected_stdout0 b/scripts/kconfig/tests/rand_nested_choice/expected_stdout0
> new file mode 100644
> index 0000000..05450f3
> --- /dev/null
> +++ b/scripts/kconfig/tests/rand_nested_choice/expected_stdout0
> @@ -0,0 +1,2 @@
> +CONFIG_A=y
> +# CONFIG_B is not set
> diff --git a/scripts/kconfig/tests/rand_nested_choice/expected_stdout1 b/scripts/kconfig/tests/rand_nested_choice/expected_stdout1
> new file mode 100644
> index 0000000..37ab295
> --- /dev/null
> +++ b/scripts/kconfig/tests/rand_nested_choice/expected_stdout1
> @@ -0,0 +1,4 @@
> +# CONFIG_A is not set
> +CONFIG_B=y
> +CONFIG_C=y
> +# CONFIG_D is not set
> diff --git a/scripts/kconfig/tests/rand_nested_choice/expected_stdout2 b/scripts/kconfig/tests/rand_nested_choice/expected_stdout2
> new file mode 100644
> index 0000000..849ff47
> --- /dev/null
> +++ b/scripts/kconfig/tests/rand_nested_choice/expected_stdout2
> @@ -0,0 +1,5 @@
> +# CONFIG_A is not set
> +CONFIG_B=y
> +# CONFIG_C is not set
> +CONFIG_D=y
> +CONFIG_E=y
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>

Cheers,
Ulf
