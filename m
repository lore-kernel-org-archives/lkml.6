Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZpPYTv2Uznewb17WBxlEjSY2Inchklgko3ex3cBH+3+fZ9byNw0aY6pKsnde3G5ZaVfI9mb
ARC-Seal: i=1; a=rsa-sha256; t=1527003376; cv=none;
        d=google.com; s=arc-20160816;
        b=Pqjv9FYEIOLuF7Pu3i1P4R2o1t/4H7Pucxvd81EHqHqz3l+dO6wQJ2nsHhQM93pPc2
         dVH8Gdz9BIE8i8Cc6hk211wJkcvSESCwExFvZfcxQjw0FK7A68F5FQWmDEKd7ZIs0Zu+
         rlCIhs6V7xP1Rg6vmBcUfsytnLWEb20Cc0di8mnRjDXnDRI4Ke0SyTWKAHlC/0p9RJzc
         QPChD1poHVrzYh+gvw12Pfn0cn2N1TP2GmBXO5rF4OSk6+XGX8daYALvEh88cIbbj9RQ
         IkpLk3eT6l4F7xaDwbtFnTutLVEPrQvzQsh3EyzAemVuVeFGYgRyxE8WV1SNR/OKo3Mt
         x/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=AHFvKtmNqMCwP29dicqcZuOcKFrEcS5jpp3a0kSoOBU=;
        b=PFDuMTf3N1TNmF/A/YefJFjjHStCmKJHb2qSO1BWkuRLxOAwRjkcL4mKyvs5DAsiTV
         KcODjP1R2U7NfydIJ84E5OvIHi0m+UplzecRpngJvkzDJCmiDShj4DKx8ms5rhe+cd52
         14ZmNOZPpz10dnGgNYI0eRZZbWckADVgBH2Kk2OLr+pa7l0dyqdWfDafsB66p13YtU6L
         xcMSNcVPZ2/gHIsKCSO9QSiFLgJfvSCt5Ldp1lpZ3N2UD6sLGJpkgs7zXkixK3Baf/nX
         9E+4GXEAV8GL9nr29uEjt2qvtRXmvwh/9XbSqrxLbXnCc1BIjcaHtwaY5dftkSUH2Ojq
         G0bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=1OXnQPSY;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=1OXnQPSY;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v3 4/4] kconfig: refactor ncurses package checks for
 building mconf and nconf
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
 linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arvind Prasanna <arvindprasanna@gmail.com>
References: <1526973741-664-1-git-send-email-yamada.masahiro@socionext.com>
 <1526973741-664-5-git-send-email-yamada.masahiro@socionext.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8729f343-a206-0975-475b-a26e54e7b932@infradead.org>
Date: Tue, 22 May 2018 08:36:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526973741-664-5-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601148063802796135?=
X-GMAIL-MSGID: =?utf-8?q?1601179092489229100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/22/2018 12:22 AM, Masahiro Yamada wrote:
> The mconf (or its infrastructure, lxdiaglog) depends on the ncurses.
> Move and rename check-lxdialog.sh to mconf-cfg.sh to make it work in
> the same way as for qconf and gconf.
> 
> This commit fixes some more weirdnesses.
> 
> The nconf also needs ncurses packages.  HOSTLOADLIBES_nconf is set
> to the libraries needed for nconf, but the cflags is not explicitly
> set.  Actually, nconf relies on the check-lxdialog.sh for the proper
> cflags:
> 
> HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags) \
>                     -DLOCALE
> 
> The code above passes the ncurses flags to all objects, even for conf,
> qconf, gconf.  Let's pass the ncurses flags only to mconf and nconf.
> 
> Currently, the presence of ncurses is not checked for nconf.  Let's
> show a prompt like the mconf case.
> 
> According to Randy's report, the shell scripts still need to carry
> the fallback code in case the pkg-config fails to find the ncurses
> packages.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> Changes in v3:
>   - Squash two patches into one to not lose bisectability
> 
> Changes in v2:
>   - Restore fallback detection for openSUSE etc.
> 
>  scripts/kconfig/Makefile                   | 58 ++++++++-----------
>  scripts/kconfig/lxdialog/check-lxdialog.sh | 93 ------------------------------
>  scripts/kconfig/lxdialog/dialog.h          |  2 +-
>  scripts/kconfig/mconf-cfg.sh               | 44 ++++++++++++++
>  scripts/kconfig/nconf-cfg.sh               | 43 ++++++++++++++
>  5 files changed, 112 insertions(+), 128 deletions(-)
>  delete mode 100755 scripts/kconfig/lxdialog/check-lxdialog.sh
>  create mode 100755 scripts/kconfig/mconf-cfg.sh
>  create mode 100644 scripts/kconfig/nconf-cfg.sh


-- 
~Randy
