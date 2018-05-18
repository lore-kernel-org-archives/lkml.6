Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZpkCloX4vKhmvE/LGmJjSm54VZ4fcTdBMsZN6Ui/OdAoBZqTUfJfopeRuv4GzbQSklbWV+w
ARC-Seal: i=1; a=rsa-sha256; t=1526619187; cv=none;
        d=google.com; s=arc-20160816;
        b=C80LsuMeHetNjcu3zVApxWKTsoxznvGfoPeUtmzbsQSD6MV51GVUzxAsypcz4a17gQ
         s7t6fMsj4um2KeuNvwEhR5SJ7NA9hpp7dJOyfSXr7B8Ok8gXYoyjVgzpZCEKjJufI5O1
         4zzfjjvzQvSZIM4Q3in9D+HztEOmXwJEO+vr3yr38MH76nIy8EUMtXyr7B56Qy6Z6APx
         XBU554k2Rn6fj2lmYlX58cfK0U1zusuiXlW8oTgmhQg5iz/fy3J8iMsFbbTNDjuQhu0P
         KwneZkKov7SJR9yaC4GJNDRHHTu3O6QQm+sxixw3wXCuWSzDJEzaU2YAeNBXsmITdscQ
         GivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=Ri0z0TLkurUq1SvOmVEvg55GZ3OIRe55Wm0sUE9oSTo=;
        b=jdbuqidUTxvwB4V15cwccdPIg2o+vERYe5cozLFY8FMV5wKsndEm9OkyUATL8hUcJh
         ZxkRRlgxyvgfV6ZEZzHg2kTwItK1nMTS2aKXItSRkQLm0HA3UY78/HXhis1CT16fIAOy
         3xp46MBwBcwkUOWKHWgyl2yQWitYpI//lzekMM8jBSX2L/N+6OiBkRaeXpVN4JtdGZqG
         LIq4oq07P9T+AAe/Ycx3mq+pD8yhflV+fZREuwNXdAKvL6xbMaUdzxcxltViCVR7HZmW
         2MG70rDOGAWNSMflhYjCwYrEgiJh2plQA2Spf39Pqj3aXbzgExQxbyb7zR3qFWLfvCZ2
         SabQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=lcnnjaTa;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=lcnnjaTa;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w4I4qbKD013482
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvind Prasanna <arvindprasanna@gmail.com>
Subject: [PATCH 0/5] kconfig: refactor package checks for GUI frontends
Date: Fri, 18 May 2018 13:52:21 +0900
Message-Id: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600776240582675977?=
X-GMAIL-MSGID: =?utf-8?q?1600776240582675977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kconfig supports 4 GUI frontends.
Each of them needs some support packages, but checks them differently:

  qconf, gconf: check packages in Makefile (pkg-config is required)
  mconf: lxdialog/check-lxdialog.sh
  nconf: needs ncurses, but its presence is not checked

This series refactor the package checks so that all of them work
in the same way.

The package check scripts have been moved to scripts/kconfig/*conf-cfg.sh

The motivation of this clean-up is Randy's following patch:
https://patchwork.kernel.org/patch/10277723/

I want to clean up existing code before adding more checks.



Masahiro Yamada (5):
  kbuild: do not display CHK for filechk
  kconfig: refactor Qt package checks for building qconf
  kconfig: refactor GTK+ package checks for building gconf
  kconfig: refactor ncurses package checks for building mconf
  kconfig: refactor ncurses package checks for building nconf

 scripts/Kbuild.include                     |   1 -
 scripts/kconfig/Makefile                   | 160 ++++++++++-------------------
 scripts/kconfig/gconf-cfg.sh               |  23 +++++
 scripts/kconfig/lxdialog/check-lxdialog.sh |  93 -----------------
 scripts/kconfig/lxdialog/dialog.h          |   2 +-
 scripts/kconfig/mconf-cfg.sh               |  24 +++++
 scripts/kconfig/nconf-cfg.sh               |  22 ++++
 scripts/kconfig/qconf-cfg.sh               |  25 +++++
 8 files changed, 148 insertions(+), 202 deletions(-)
 create mode 100755 scripts/kconfig/gconf-cfg.sh
 delete mode 100755 scripts/kconfig/lxdialog/check-lxdialog.sh
 create mode 100755 scripts/kconfig/mconf-cfg.sh
 create mode 100644 scripts/kconfig/nconf-cfg.sh
 create mode 100755 scripts/kconfig/qconf-cfg.sh

-- 
2.7.4
