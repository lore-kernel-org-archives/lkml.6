Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZr7duOgVEhbB+nWC529VmKA6aQXCPOkWFkpZ7dgCdmCo1G+K7IIzlq8utNQjq+X0e407RM3
ARC-Seal: i=1; a=rsa-sha256; t=1526804251; cv=none;
        d=google.com; s=arc-20160816;
        b=aoM6txJjxg0KEQQtdxrnGC27wj1kPE8kJZNXdT5b7QegtkHTqD3ZNG5ac1XWwz3Spw
         0sM9f4swpavF07dE6rIOqA/60l2zT+fuPxRdWHqX8+qnN2T9Jc0TGKYr/pyWGFHUv9wG
         wPwqllsQ4t5MD9MwISbHZQC5yCAWzmwwxSWW7NWLEwUCvGWPZeAz7N3aejgtU/unbprj
         Q8jy4nabZDaKGC5M6QMV4Zb09lxLbTwko+ElyI1kh1unwhNztZWBQDRbN3d18C1dsUiA
         KW/VDYM0Rb2/7MyXchhUe8DCwn1JptCgxoImcmggBeeRi/bRmQFwWepPFclJGGQQC0x0
         5hMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=NQmz1UIlM/ANVMh96TY4fJp4CbW8yR/w0cO3yiXR1kE=;
        b=tpfEzH6rWSohmMw33Qb1w9n8tKSLmYPTtQppi9ArxPjeCd1ap9TfZ/zVh22Shy1K86
         c6KXoeAVkqz2MZK8TIBEPAWmqQV1qirldR5mdaa7kGzs7WsKATnBed1aDYvqRe0Wc01A
         mdwbbP7AmmTzmxQYCJYh7wOUWFVfLpkP2/U5oDs2aQosNB2u/qFKsb5wBzZfMO8lEDUl
         BHH191DsGFL9cNQX2unCFA2/5r8dq8+oHKa5YNSASLyfJHqSVqQzd/p66R0kqen31gWQ
         FgHcWH15ggPNZd+iz/BhRap4IDNAf8+BVG4QNqXE9R9c1IfyQMsN9xJNHnR/e5odWv5k
         S25Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=I8YScQUn;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=I8YScQUn;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w4K8H4h0004008
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvind Prasanna <arvindprasanna@gmail.com>
Subject: [PATCH v2 0/5] kconfig: refactor package checks for GUI frontends
Date: Sun, 20 May 2018 17:16:48 +0900
Message-Id: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600970294495348952?=
X-GMAIL-MSGID: =?utf-8?q?1600970294495348952?=
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
 scripts/kconfig/mconf-cfg.sh               |  38 +++++++
 scripts/kconfig/nconf-cfg.sh               |  34 ++++++
 scripts/kconfig/qconf-cfg.sh               |  25 +++++
 8 files changed, 174 insertions(+), 202 deletions(-)
 create mode 100755 scripts/kconfig/gconf-cfg.sh
 delete mode 100755 scripts/kconfig/lxdialog/check-lxdialog.sh
 create mode 100755 scripts/kconfig/mconf-cfg.sh
 create mode 100644 scripts/kconfig/nconf-cfg.sh
 create mode 100755 scripts/kconfig/qconf-cfg.sh

-- 
2.7.4
