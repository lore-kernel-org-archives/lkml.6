Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518048789; cv=none;
        d=google.com; s=arc-20160816;
        b=tixqjUklz3vPnV8YRB8mByhMv9xH9oHXDG9vqCG1mmw71orG2OFtW85JzZvjbxsplj
         4BNW+Yf7pRaqKnKHls/sGalz1ZHTJpHOomdSDgVXPG6Ti3h80mc6dWEgQoc+0LGNDWGI
         CQPRRmsFwn3xhwSg5Tw6a1lDCZvC3Vf9C1UajyopYW5BBslAOJGaLkb0O0HFi9XV5wuS
         4chtDTVAGmkSdKcMVzbXzYSsU/m2cyju6/hpFXPjnw4xX03bIQfVWgpX8fL6jO/kAOmc
         2xp7bhnh8TNZ7e/x2AYm1/2QQit1OYC1nvsjAV2e361JGmSewlDyndYEen+7lucWPp1A
         7vog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=uKYPfMLg5qoP1hzpX+0VN7FAJmDPWhR77BqqBtO6uZ4=;
        b=cU+wAtDEpRfMdEADPcAJyo/1k32/FH8IOQjIhJhUtENPBro2wFg6C4NQqmAsX8XCp/
         d52y9vMyAMU4VlcB+8fBdcJScWYeRMSyEGdhv5uFPdUqaht2cApVh8N9yTeWI9fZIUjS
         wzDaY8ihlyRFXrJHodb1KWaEU8V0jqBAT7J2e0CJLKY83141lOH+pAvneVgeKSVzNMO1
         jxMswlR9u8VWEe1epVN9ClrWZp7ziJyutDic50e65/KaLYuzp7l/eyXpA38O+B2Bfz1L
         MmeOUa92DI5urcvwmSKfhHmW9pU6Dbay15IihHdDInd/k1ZDk+oVi5byAlVjlBeZ58cN
         fRIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XWEMJiHE;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XWEMJiHE;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225KnSWgnSKj6+YVUF2Fv28D1QGvMTmihg530hpTd2kqBSwMDLwzhP0GEaW+qKc1yuDzdiaxRCucaHtXrS4k994=
MIME-Version: 1.0
In-Reply-To: <1517877294-4826-13-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <1517877294-4826-13-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 01:13:09 +0100
Message-ID: <CAFkk2KQG6Na0ONRbmsmC01Bz7VjDAKs4TLTH9pK7hPe4c5StXQ@mail.gmail.com>
Subject: Re: [PATCH 12/14] kconfig: test: check visibility of tristate choice
 values in y choice
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778417647763?=
X-GMAIL-MSGID: =?utf-8?q?1591789527974479305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> If tristate choice values depend on symbols set to 'm', they should be
> hidden when the choice containing them is changed from 'm' to 'y'
> (i.e. exclusive choice).
>
> This issue was fixed by commit fa64e5f6a35e ("kconfig/symbol.c: handle
> choice_values that depend on 'm' symbols").
>
> Add a test case to avoid regression.
>
> For the input in this unit test, there is a room for argument if
> "# CONFIG_CHOICE1 is not set" should be written to the .config file.
>
> After commit fa64e5f6a35e, this line was written to the .config file.
>
> Then, it is not written after my fix "kconfig: do not write choice
> values when their dependency becomes n".
>
> In this test, "# CONFIG_CHOICE1 is not set" is don't care.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  .../kconfig/tests/choice_value_with_m_dep/Kconfig    | 20 ++++++++++++++++++++
>  .../tests/choice_value_with_m_dep/__init__.py        | 15 +++++++++++++++
>  scripts/kconfig/tests/choice_value_with_m_dep/config |  2 ++
>  .../tests/choice_value_with_m_dep/expected_config    |  3 +++
>  .../tests/choice_value_with_m_dep/expected_stdout    |  4 ++++
>  5 files changed, 44 insertions(+)
>  create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
>  create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
>  create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/config
>  create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/expected_config
>  create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout
>
> diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig b/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
> new file mode 100644
> index 0000000..dbc49e2
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
> @@ -0,0 +1,20 @@
> +config MODULES
> +       bool
> +       default y
> +       option modules
> +
> +config DEP
> +       tristate
> +       default m
> +
> +choice
> +       prompt "Tristate Choice"
> +
> +config CHOICE0
> +       tristate "Choice 0"
> +
> +config CHOICE1
> +       tristate "Choice 1"
> +       depends on DEP
> +
> +endchoice
> diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py b/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
> new file mode 100644
> index 0000000..ec71777
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
> @@ -0,0 +1,15 @@
> +"""
> +Hide tristate choice values with mod dependency in y choice
> +===========================================================
> +
> +If tristate choice values depend on symbols set to 'm', they should be
> +hidden when the choice containing them is changed from 'm' to 'y'
> +(i.e. exclusive choice).
> +
> +Related Linux commit: fa64e5f6a35efd5e77d639125d973077ca506074
> +"""
> +
> +def test(conf):
> +    assert conf.oldaskconfig('config', 'y') == 0
> +    assert conf.config_contains('expected_config')
> +    assert conf.stdout_contains('expected_stdout')
> diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/config b/scripts/kconfig/tests/choice_value_with_m_dep/config
> new file mode 100644
> index 0000000..3a126b7
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice_value_with_m_dep/config
> @@ -0,0 +1,2 @@
> +CONFIG_CHOICE0=m
> +CONFIG_CHOICE1=m
> diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/expected_config b/scripts/kconfig/tests/choice_value_with_m_dep/expected_config
> new file mode 100644
> index 0000000..4d07b44
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice_value_with_m_dep/expected_config
> @@ -0,0 +1,3 @@
> +CONFIG_MODULES=y
> +CONFIG_DEP=m
> +CONFIG_CHOICE0=y
> diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout b/scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout
> new file mode 100644
> index 0000000..5eac85d
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout
> @@ -0,0 +1,4 @@
> +Tristate Choice [M/y/?]
> +Tristate Choice
> +> 1. Choice 0 (CHOICE0)
> +choice[1]: 1
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
