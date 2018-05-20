Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeETXlH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 19:41:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49548 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbeETXlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 19:41:04 -0400
Subject: Re: [PATCH v2 5/5] kconfig: refactor ncurses package checks for
 building nconf
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc: "Luis R . Rodriguez" <mcgrof@suse.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
 <1526804213-8238-6-git-send-email-yamada.masahiro@socionext.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7819f81c-2de6-4202-1349-ae4ce01caa26@infradead.org>
Date: Sun, 20 May 2018 16:41:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526804213-8238-6-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20/2018 01:16 AM, Masahiro Yamada wrote:
> Building nconf requires ncurses, but its presence is not checked.
> Check and configure necessary packages by a shell script like the
> other GUI frontends.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 

> diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
> new file mode 100644
> index 0000000..8eb7948
> --- /dev/null
> +++ b/scripts/kconfig/nconf-cfg.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +PKG="ncursesw menuw panelw"
> +PKG2="ncurses menu panel"
> +
> +if pkg-config --exists $PKG; then
> +	echo libs=\"$(pkg-config --libs $PKG)\"
> +	exit 0
> +fi
> +
> +if pkg-config --exists $PKG2; then
> +	echo libs=\"$(pkg-config --libs $PKG2)\"
> +	exit 0
> +fi
> +

I guess this one needs clags, especially -I, like the mconf patch contains...


> +# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
> +# by pkg-config.
> +if [ -f /usr/include/ncursesw/ncurses.h ]; then
> +	echo libs=\"-lncursesw -lmenuw -lpanelw\"
> +	exit 0
> +fi
> +
> +if [ -f /usr/include/ncurses.h ]; then
> +	echo libs=\"-lncurses -lmenu -lpanel\"
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
