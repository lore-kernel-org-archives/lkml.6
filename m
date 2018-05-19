Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZol/QYiCIkoRe/RgNhuZ7JIY1Ff9fv0V5/X38ReWzx7LTPrXc88q5jvAtpnIb+LAEFzBguF
ARC-Seal: i=1; a=rsa-sha256; t=1526752980; cv=none;
        d=google.com; s=arc-20160816;
        b=agap2OEb7Nf3hB4JvMyMTC0bEnd/YvwHZyDp2Dh2wRSs0XzC9VgytiApET372UIQKx
         Y3dYg3N0D82LeJMpAMXRf9IShtpGy998rG/Cxb51wO298AWzDHpC1huvyiN0HIZ4qQUh
         EMBoohA9emOrHDrpe3zhIg0eaFIX/7vdbtRu0v1C7r06eY7ZIU9qSf0mhDvlFjW+JXXJ
         oXIK47RFPldxLYQ0/iuIk73KSERMSxY3PGEf7qGrh+xQwuGyVCr6Q5oElxTBZapUzqtg
         AKn/NN5Un+cDTbxE02JZ2bV5q2r1+CfSOi+aw80SGWZmW6iWiJ/2R/zY9a3HQbS6vtpH
         LW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=L5OZi0q7Gc7Pq6JgvZaOOUwCrJvfBqYXbCqbQ1KFf+g=;
        b=sFOfOJMOUrwGhn5mFeO9bUzIUzxt/tOKeC462PXFIVElZYilKVWS0iAv9bYUR5nZLG
         APakhuX/J8zp3ve7SFv9Q/CNvfCvHZ0Bg/R7BDr1o5DN86GeYLqUmRux80xTUZD0H5he
         F4r5wMt/v6ZImWo2WezDhuX+UaWI1PRVrJP4j8jNBTaTtAh6Jxce7Tag/NwAFX8ky9I/
         wbv8yqwli4pRXxModEldiQYb/GldDM2wbAryV+G8aZTCJzUIIJyQ77Pi1zQXbXeeNzJO
         khevEvMZcXUYuGfq9EYs+1JCMulLxCC3T1mBwXIJ1Te3P6kQfC4grE8/yUxvwYJn2nJL
         +LCw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=AM93xKnS;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=AM93xKnS;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 4/5] kconfig: refactor ncurses package checks for building
 mconf
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
 linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arvind Prasanna <arvindprasanna@gmail.com>
References: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
 <1526619146-1895-5-git-send-email-yamada.masahiro@socionext.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1e943db9-1340-2a23-be43-2bde85e3535b@infradead.org>
Date: Sat, 19 May 2018 11:02:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526619146-1895-5-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600776240586808874?=
X-GMAIL-MSGID: =?utf-8?q?1600916533121568287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/17/18 21:52, Masahiro Yamada wrote:
> The mconf (or its infrastructure, lxdiaglog) depends on ncurses.
> check-lxdialog.sh has additional checks in case pkg-config is not
> available.  However, qconf and gconf already rely on pkg-config to
> check necessary packages.  For simplification, drop the fallback
> code from check-lxdialog.sh and move/rename to mconf-cfg.sh to
> make it work in the same way as the other GUI frontends.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Hi,

I began by testing "make menuconfig" first and immediately got this:

*
* Unable to find the ncurses.
* Install ncurses (ncurses-devel or libncurses-dev
* depending on your distribution)
*

I do have ncurses-devel installed.  However, it seems that
pkg-config on openSUSE is not very reliable.  zypper (package management
tool) says:

$ zypper info ncurses-devel
Loading repository data...
Reading installed packages...

Information for package ncurses-devel:
--------------------------------------
Repository     : openSUSE-Leap-42.3-Update                            
Name           : ncurses-devel                                        
Version        : 5.9-62.1                                             
Arch           : x86_64                                               
Vendor         : openSUSE                                             
Installed Size : 25.0 MiB                                             
Installed      : Yes                                                  
Status         : up-to-date                                           
Source package : ncurses-5.9-62.1.src                                 
Summary        : Include Files and Libraries mandatory for Development
Description    :                                                      
    This package contains all necessary include files and libraries needed
    to develop applications that require these.
<END>

but there doesn't seem to be a way to get cflags and libs (name).


> diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
> new file mode 100755
> index 0000000..7d5a4b2
> --- /dev/null
> +++ b/scripts/kconfig/mconf-cfg.sh
> @@ -0,0 +1,24 @@
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
> +echo >&2 "*"
> +echo >&2 "* Unable to find the ncurses."

                              the ncurses package."

> +echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
> +echo >&2 "* depending on your distribution)"

                                 distribution)."

> +echo >&2 "*"
> +exit 1
> 

(more on the other patches later.)

thanks.
-- 
~Randy
