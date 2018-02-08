Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518048956; cv=none;
        d=google.com; s=arc-20160816;
        b=OL16DkrC4aKnzMno3W9CwklMUZ1rGN3Lr4Hf/ReByxEu1ZwrQ2sjv+DzZ3ttcTNmUf
         FrJ4sXBt/jbggDn1+fGBi+RFrsDOvKIWBmCAt3x/ygmMQsf0/UGAFjaC0auq6ZsX5S8E
         vrK7H7KidUtXFAHh4p7iFIEvUvPy63c/KmN3EphhSbOaCWI7NPduViCsfWzZgB1LddbC
         aR6+VWrjEaU7EUSJq+88rm5q1f6ccysmq2QtcaYmrPCPlF3wbENQMYD5QUbhWD4b283T
         KTtK6IUxUjoH5gyIk751pffUlZkIUX18R74Mq6zga7kh1fTwVIMkknlB1+at/PA9wNx2
         RDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=QZ2wVMRmESDzcZPrarpwq3qxmyK6frXC93u3u5CsR/I=;
        b=hqBrRDUTplCGU1kI3ToX3PvcDdastA9Drk2DySREvVaVEz4MN25RnZ1YkqsuzDKnbv
         JQ3j0GS7k4Ew0LvdElqD8bkSVdRYJiPlFRzs1gapEvUruUIhdrs3qfQ/324nin55nLTC
         xyHMXcUM/KIoMVRnz21Bfar0JrY2cpGqF4kZn1PICPVLjulcZ4NTDFdmyKY/dt5JvFI5
         t+Sr1cEHa4F7mxz+LW+UHnv0uMc9UqANJ07Bbh0SiFymYhxcEN+PBHgfzDZqasVabu6j
         R8KiXr62CWg0GggUI3ovEtE9WE+W5HjnfzUiHlKzMpW0cW76JwpgjbrEJGyX+KCpl9z5
         cmDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=I4aSErt1;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=I4aSErt1;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224/F7jlXhEDq2KLvp53s3T/TQTzviTw+DECgquLmXn9lzKHrL/vpEDm/JhY2iVE8dLlBVaFVy5ubdufQhzCEfI=
MIME-Version: 1.0
In-Reply-To: <1517877294-4826-14-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <1517877294-4826-14-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 01:15:56 +0100
Message-ID: <CAFkk2KQv3oXWVdvyH9EPhmCiOEX1Ab++wvcsd+=gP-8RvTua+g@mail.gmail.com>
Subject: Re: [PATCH 13/14] kconfig: test: check if recursive dependencies are detected
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778492159314?=
X-GMAIL-MSGID: =?utf-8?q?1591789703519972485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Recursive dependency should be detected and warned.  Test this.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/kconfig/tests/warn_recursive_dep/Kconfig   | 62 ++++++++++++++++++++++
>  .../kconfig/tests/warn_recursive_dep/__init__.py   | 10 ++++
>  .../tests/warn_recursive_dep/expected_stderr       | 33 ++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 scripts/kconfig/tests/warn_recursive_dep/Kconfig
>  create mode 100644 scripts/kconfig/tests/warn_recursive_dep/__init__.py
>  create mode 100644 scripts/kconfig/tests/warn_recursive_dep/expected_stderr
>
> diff --git a/scripts/kconfig/tests/warn_recursive_dep/Kconfig b/scripts/kconfig/tests/warn_recursive_dep/Kconfig
> new file mode 100644
> index 0000000..9ab2474
> --- /dev/null
> +++ b/scripts/kconfig/tests/warn_recursive_dep/Kconfig
> @@ -0,0 +1,62 @@
> +# depends on itself
> +
> +config A
> +       bool "A"
> +       depends on A
> +
> +# select itself
> +
> +config B
> +       bool
> +       select B
> +
> +# depends on each other
> +
> +config C1
> +       bool "C1

Missing end quote here. Noticed because the output contains
"Kconfig:16:warning: multi-line strings not supported". :)

> +       depends on C2
> +
> +config C2
> +       bool "C2"
> +       depends on C1
> +
> +# depends on and select
> +
> +config D1
> +       bool "D1"
> +       depends on D2
> +       select D2
> +
> +config D2
> +       bool
> +
> +# depends on and imply
> +# This is not recursive dependency
> +
> +config E1
> +       bool "E1"
> +       depends on E2
> +       imply E2
> +
> +config E2
> +       bool "E2"
> +
> +# property
> +
> +config F1
> +       bool "F1"
> +       default F2
> +
> +config F2
> +       bool "F2"
> +       depends on F1
> +
> +# menu
> +
> +menu "menu depending on its content"
> +       depends on G
> +
> +config G
> +       bool "G"
> +
> +endmenu
> diff --git a/scripts/kconfig/tests/warn_recursive_dep/__init__.py b/scripts/kconfig/tests/warn_recursive_dep/__init__.py
> new file mode 100644
> index 0000000..cdf2c13
> --- /dev/null
> +++ b/scripts/kconfig/tests/warn_recursive_dep/__init__.py
> @@ -0,0 +1,10 @@
> +"""
> +Warn recursive inclusion
> +========================
> +
> +Recursive dependency should be warned.
> +"""
> +
> +def test(conf):
> +    assert conf.oldaskconfig() == 0
> +    assert conf.stderr_contains('expected_stderr')
> diff --git a/scripts/kconfig/tests/warn_recursive_dep/expected_stderr b/scripts/kconfig/tests/warn_recursive_dep/expected_stderr
> new file mode 100644
> index 0000000..ea47cae
> --- /dev/null
> +++ b/scripts/kconfig/tests/warn_recursive_dep/expected_stderr
> @@ -0,0 +1,33 @@
> +Kconfig:16:warning: multi-line strings not supported
> +Kconfig:9:error: recursive dependency detected!
> +Kconfig:9:     symbol B is selected by B
> +For a resolution refer to Documentation/kbuild/kconfig-language.txt
> +subsection "Kconfig recursive dependency limitations"
> +
> +Kconfig:3:error: recursive dependency detected!
> +Kconfig:3:     symbol A depends on A
> +For a resolution refer to Documentation/kbuild/kconfig-language.txt
> +subsection "Kconfig recursive dependency limitations"
> +
> +Kconfig:15:error: recursive dependency detected!
> +Kconfig:15:    symbol C1 depends on C2
> +Kconfig:19:    symbol C2 depends on C1
> +For a resolution refer to Documentation/kbuild/kconfig-language.txt
> +subsection "Kconfig recursive dependency limitations"
> +
> +Kconfig:30:error: recursive dependency detected!
> +Kconfig:30:    symbol D2 is selected by D1
> +Kconfig:25:    symbol D1 depends on D2
> +For a resolution refer to Documentation/kbuild/kconfig-language.txt
> +subsection "Kconfig recursive dependency limitations"
> +
> +Kconfig:59:error: recursive dependency detected!
> +Kconfig:59:    symbol G depends on G
> +For a resolution refer to Documentation/kbuild/kconfig-language.txt
> +subsection "Kconfig recursive dependency limitations"
> +
> +Kconfig:50:error: recursive dependency detected!
> +Kconfig:50:    symbol F2 depends on F1
> +Kconfig:48:    symbol F1 default value contains F2
> +For a resolution refer to Documentation/kbuild/kconfig-language.txt
> +subsection "Kconfig recursive dependency limitations"
> --
> 2.7.4
>

Besides the missing end quote:

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
