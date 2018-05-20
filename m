Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZpu3N4292iMlTWI/TDkGrouhJqtuNDErnlLkjNFAGDViOBW0RlLVLr9bEQ+qyKqWMIsHKMA
ARC-Seal: i=1; a=rsa-sha256; t=1526859431; cv=none;
        d=google.com; s=arc-20160816;
        b=WZmID0glyGEb/mgEG4Jm6fb2uhcPodvyeoHx/kSyCT30ZWPTmfiESyLq4cubO3Ubme
         YgAZsheCvRD/sWRnyzob/mUQxsBz++rTBG1+vtMmr7qljQDrSNmAsRk8gxqMjWMpZ1Px
         z1aCdipjvixTZaNxFbsNGErs49vXZ4CiygtvQ9yrKgZLAFyqRQtceO/BtzKO0TQ5s5D3
         CNV6UEV3b+aOR6z+YKGg6kEkA+niHrEM/EotGu8OAuu8KZMe8YQamNoyu6UkMzI0PGbY
         lGU8Y87wC68oHF/7vyK52iRYuaPIZCeQQj+bJWr9MwB7UBBO5uUBZdjfKgh2v7XAkOkE
         0XBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=AP650gtIkplDHSSTKv9OmCA0SccfJx3MwQMn5EK71B8=;
        b=je//40BEjRpLTGt7wv8mv/Uh3mrQLjBULOf7W3GG1ly62Bo43fGduJ6DmUPICXnRUi
         sinyzg6LL1DVd1AuVcFO2kDgKcaMAugVtPl0UN5sy2x2++Sj3tOQMO//XZIWPGxaFPrJ
         6hbJY54kKgruMeCQoGz9BPbD12BxxIKj8Bkx9DN1mKFvX8HCNbBHeYGkIEkFY0wsIUPz
         GdpU68Q+qXniBhCCwqMfm5TYd6hj6T6kkRccC0Kl/0g09SzYQDVtxdrjz0sYg/hnGPY0
         bI09NjDgnOpFDgQkczdQn+6b0mIHnM5kq1tkNPJzoPWCIyCYaCS4+WQyoZjtMPC+7YAa
         EbBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=JVN/vf8t;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=JVN/vf8t;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v2 4/5] kconfig: refactor ncurses package checks for
 building mconf
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kbuild@vger.kernel.org
Cc: "Luis R . Rodriguez" <mcgrof@suse.com>,
 Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arvind Prasanna <arvindprasanna@gmail.com>
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
 <1526804213-8238-5-git-send-email-yamada.masahiro@socionext.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <51f8c32f-f9ba-dc20-dd04-a2848ff7f8f1@infradead.org>
Date: Sun, 20 May 2018 16:36:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526804213-8238-5-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600970303979180771?=
X-GMAIL-MSGID: =?utf-8?q?1601028153214892454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/20/2018 01:16 AM, Masahiro Yamada wrote:
> The mconf (or its infrastructure, lxdiaglog) depends on ncurses.
> Move and rename check-lxdialog.sh to mconf-cfg.sh to make it work in
> the same way as for qconf and gconf.
> 
> According to Randy's report, we still need to carry the fallback code
> in case the pkg-config fails to find ncurses.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


> diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
> new file mode 100755
> index 0000000..f5fe183
> --- /dev/null
> +++ b/scripts/kconfig/mconf-cfg.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +PKG="ncursesw"
> +PKG2="ncurses"
> +
> +if pkg-config --exists $PKG; then
> +	echo cflags=\"-DNCURSES_WIDECHAR=1 $(pkg-config --cflags $PKG)\"
> +	echo libs=\"$(pkg-config --libs $PKG)\"
> +	exit 0
> +fi
> +
> +if pkg-config --exists $PKG2; then
> +	echo cflags=\"$(pkg-config --cflags $PKG2)\"
> +	echo libs=\"$(pkg-config --libs $PKG2)\"
> +	exit 0
> +fi
> +
> +# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
> +# by pkg-config.
> +if [ -f /usr/include/ncursesw/ncurses.h ]; then
> +	echo cflags=\"-DNCURSES_WIDECHAR=1 -I/usr/include/ncursesw\"
> +	echo libs=\"-lncursesw\"
> +	exit 0
> +fi
> +
> +if [ -f /usr/include/ncurses.h ]; then
> +	echo cflags=\"\"
> +	echo libs=\"-lncurses\"
> +	exit 0
> +fi
> +
> +echo >&2 "*"
> +echo >&2 "* Unable to find the ncurses."

                              the ncurses package."

> +echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
> +echo >&2 "* depending on your distribution)"

                                 distribution)."

> +echo >&2 "*"
> +exit 1
> 


-- 
~Randy
