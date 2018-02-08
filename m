Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224cMAHyG8LpA4X7G+o1R6QR/cV69LFxJ7es5vl+qpQ/caMEfiJUBcQfM2QQEhN45tGX9UZ8
ARC-Seal: i=1; a=rsa-sha256; t=1518106812; cv=none;
        d=google.com; s=arc-20160816;
        b=d7j8lMCH05vs2435iNhI6p0Nrcdq0orMDK2twwqDQJegZfiSexAr9UpFIRAs2wwMSP
         +ph8D6LXkCqezKnN3lLLyPLJjRyAuHfYHIF2M97fZUf85zd6QYct2Fm8v3jYP8JJ9+RW
         Ud7441lI1MBhM/6CeIkqqbKALdj178bcOmqW1IoUkTvKJzA0mz3S6iXd7w0B5SZyT+SZ
         zb2f0Rusmvm6rk4FHsG960er64LETW7ZqmAAgVJVyoUBz6eyqafO3dAvacYt1QyTBHbP
         Ai+fO07BFFvEoXRDJf4o9iGEXOROhwKzZXj4xudM4/ZSrUw7KbDYNCqGP5hk0rUlWu2F
         954g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=YzitirJ/Q8VjI4HXMIX0Plvx4w1aL52mZmd+kxZQD80=;
        b=ClSRu6P7AtZm4uU4wDcAfaNtEJPpJIlSHdk1JS4+dq0hD2lPR1yZZwHnp47GMkuTTT
         xPE+hhtBnu1FdTYiuZCwbk6HSqgjwU5ihoebxJnClPoEmM67342m5mtF9hoDPcYObNP7
         sfSwpjr1FvJ1wJTdfXfCnEnOWx3kEbtTg9FOpGimyVfttHADgL8+wr+AEOZVY+JZIyaa
         w3pYyGD84CMg6ggBsgrFpx9//7uY9tlI6JIDogXiUAE5ABlFfpL+yREyRqW35jS3J44R
         JFKn0PdXUrFF4+ljE/BxExVk8lYjtcy4H0ZcMQ+4H3zTErWfUQoIrP/IYnSoufTngKA0
         jafg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=GE/4Nbyw;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=GE/4Nbyw;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w18GJP1C021191
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/7] Kconfig: add new special property shell= to test compiler options in Kconfig
Date: Fri,  9 Feb 2018 01:19:05 +0900
Message-Id: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368430758875?=
X-GMAIL-MSGID: =?utf-8?q?1591850368430758875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This was prompted by the email from Linus today's morning.

I implmented this in a rush today, so there are still many TODOs,
but I put it here to start discussion.

I think it is working, but as you notice, it is tedious to repeat something
like follows:

config CC_HAS_STACKPROTECTOR
        bool
        option shell="$CC -Werror -fstack-protector -c -x c /dev/null"

One possiblity is to put this ugly code into script like follows,

config CC_STACKPROTECTOR
          bool
          option shell="$srctree/scripts/cc-option.sh $CC -fstack-protector"

... but this is longer.

I was thinking of something like follows:

config CC_STACKPROTECTOR
          bool
          option shell="$(CC_OPTION -fstack-protector)"

Need time to brush up details.

Comments are appreciated.



Masahiro Yamada (7):
  kbuild: remove kbuild cache
  kconfig: add xrealloc() helper
  kconfig: remove const qualifier from sym_expand_string_value()
  kconfig: support new special property shell=
  kconfig: invoke silentoldconfig when compiler is updated
  kconfig: add basic environments to evaluate C flags in Kconfig
  Test stackprotector options in Kconfig to kill CC_STACKPROTECTOR_AUTO

 Makefile                    |  65 +++++++---------------------
 arch/Kconfig                |  54 +++++++++++++----------
 init/Kconfig                |  17 ++++++++
 scripts/Kbuild.include      | 101 ++++++--------------------------------------
 scripts/kconfig/confdata.c  |   2 +-
 scripts/kconfig/expr.h      |   1 +
 scripts/kconfig/kconf_id.c  |   1 +
 scripts/kconfig/lkc.h       |   2 +
 scripts/kconfig/lkc_proto.h |   2 +-
 scripts/kconfig/menu.c      |   3 ++
 scripts/kconfig/nconf.gui.c |   2 +-
 scripts/kconfig/symbol.c    |  78 +++++++++++++++++++++++++++++++++-
 scripts/kconfig/util.c      |  15 +++++--
 scripts/kconfig/zconf.l     |   2 +-
 14 files changed, 176 insertions(+), 169 deletions(-)

-- 
2.7.4
