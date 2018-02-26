Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519634607; cv=none;
        d=google.com; s=arc-20160816;
        b=w/cr89QbrHqL/BIHduilSsA6nU8P8tElurbirjuZ9H+vkq5NtmxWFgWR9WaTDpJfbJ
         qU/NXhN5olDBVOJ58vavMMDAJlmtf11+GT6E67z6wcxJiMIhfcs0V5Acndj65CgMW5KT
         UGjkvr0hR5Sl0wG0wa/qA8ttw8cFJYPeztnltCe1MTCrnzmjo4hqnzlspNJm/ylWOp+H
         4yIGQDEjzqu/LIBAOVJmviDaneehgDkyZGpbD7+FSPm6gJcVr3l3WS1jmRNb/eNDz+zy
         lF2pdmW8rCxpAnjAweqFypQAqaVYtXQJa2WTNv4DsLYrx9SMnfYOWQyjrAZSjOGvVgxT
         2e/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Uame72BhtGgfR++c35pA+njjT37xuO0fmNJBBaoMsrg=;
        b=I+GfihCAj+QwnDK6Ranmf4Sixs5pX7u2jx+BrKEURN6KmxyALNrCIad8Myxrga/INa
         sWpC9lZZqdNA4CGCkTwfnsDxYC3ZjFK3QlCvgTl4B1qnUX72dV59UEy37NYkDntme+lM
         xMmaxQApx2r5m76zJrBEUSfKv9dWGeCrmx3jRV1jA87vU2eXc9/rbGI4Qa4HNWXArrMS
         9OXtfP/k4KJ8yvTLD0JI5TfrwDvjwo1p8ka+nxw/ptLmHqwvPxnc6UwugMqVVn2RpH78
         7Ca9mUm0kmatpLUJSz2drNYHYAJVt4my3aEXqQf54ELKQSFOdCNzjnPnXjKRWHLi6krb
         XTug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ApWdnDEF;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ApWdnDEF;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELviRfihzu1CvaKTOdfnAhvfGCOFZEj3YVQrn66PeFcq3H6fHn8h1xab7+fuO0jFf8bsItV4qc0at5Ii0DV/v/M=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Feb 2018 09:43:26 +0100
X-Google-Sender-Auth: _lM21uWLqlENNyLbY-XtqwxgLAQ
Message-ID: <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com>
Subject: Re: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593294329790174573?=
X-GMAIL-MSGID: =?utf-8?q?1593452378635330509?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 24, 2018 at 3:50 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
> used with care - it forces a lower limit of another symbol, ignoring
> the dependency.
>
> MFD_SYSCON depends on HAS_IOMEM, but several drivers with COMPILE_TEST
> select it.
>
> This causes unmet dependencies for architecture without HAS_IOMEM.
>
>   $ make ARCH=score randconfig
>   scripts/kconfig/conf  --randconfig Kconfig
>   KCONFIG_SEED=0x27C47F43
>   warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && ...)
>   selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>
> Use 'depends on' to observe the dependency.
>
> This commit was created by the following command:
>
>   $ find drivers -name 'Kconfig*' | xargs sed -i -e \
>     's/select MFD_SYSCON$/depends on MFD_SYSCON/'
>
> Then, COMMON_CLK_NXP and S3C2410_WATCHDOG were fixed up manually.
>
> Also, make MFD_SYSCON 'default y' because some defconfig files may
> rely on someone select's MFD_SYSCON.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> If you have a better idea to fix 'unmet dependencies',
> please suggest.

Changing 'select MFD_SYSCON' to 'depends on' will definitely break lots
of defconfig configurations, I'd rather not do that.

Only score, tile and um have some configurations that select 'NO_IOMEM'.
Score is getting removed now, tile might get removed later (we could make
PCI mandatory in the meantime to avoid that configuration), and I think for
um, we already have a workaround for the NO_IOMEM dependencies
(I forget the details).

        Arnd
