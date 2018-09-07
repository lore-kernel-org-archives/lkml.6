Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2013C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3883220645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3883220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeIHCID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:08:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbeIHCIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:08:01 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 69F3AF07;
        Fri,  7 Sep 2018 21:25:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.18 132/145] kconfig: fix "Cant open ..." in parallel build
Date:   Fri,  7 Sep 2018 23:09:58 +0200
Message-Id: <20180907210913.541647310@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 98a4afbfafd226636cd6bb6a1208b3693daff2b1 upstream.

If you run "make menuconfig" or "make nconfig" with -j<N> option in a
fresh source tree, you will see several "Can't open ..." messages:

  $ make -j8 menuconfig
    HOSTCC  scripts/basic/fixdep
    YACC    scripts/kconfig/zconf.tab.c
    LEX     scripts/kconfig/zconf.lex.c
  /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  /bin/sh: 1: .:   HOSTCC  scripts/kconfig/lxdialog/checklist.o
  Can't open scripts/kconfig/.mconf-cfg
  /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
    HOSTCC  scripts/kconfig/lxdialog/inputbox.o
  /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
    UPD     scripts/kconfig/.mconf-cfg
  /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
    HOSTCC  scripts/kconfig/lxdialog/menubox.o
    HOSTCC  scripts/kconfig/lxdialog/textbox.o
    HOSTCC  scripts/kconfig/lxdialog/util.o
    HOSTCC  scripts/kconfig/lxdialog/yesno.o
    HOSTCC  scripts/kconfig/mconf.o
    HOSTCC  scripts/kconfig/zconf.tab.o
    HOSTLD  scripts/kconfig/mconf

Correct dependencies to fix this problem.

Fixes: 1c5af5cf9308 ("kconfig: refactor ncurses package checks for building mconf and nconf")
Cc: linux-stable <stable@vger.kernel.org> # v4.18
Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/kconfig/Makefile |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -173,7 +173,7 @@ HOSTLOADLIBES_nconf	= $(shell . $(obj)/.
 HOSTCFLAGS_nconf.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
 HOSTCFLAGS_nconf.gui.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
 
-$(obj)/nconf.o: $(obj)/.nconf-cfg
+$(obj)/nconf.o $(obj)/nconf.gui.o: $(obj)/.nconf-cfg
 
 # mconf: Used for the menuconfig target based on lxdialog
 hostprogs-y	+= mconf
@@ -184,7 +184,8 @@ HOSTLOADLIBES_mconf = $(shell . $(obj)/.
 $(foreach f, mconf.o $(lxdialog), \
   $(eval HOSTCFLAGS_$f = $$(shell . $(obj)/.mconf-cfg && echo $$$$cflags)))
 
-$(addprefix $(obj)/, mconf.o $(lxdialog)): $(obj)/.mconf-cfg
+$(obj)/mconf.o: $(obj)/.mconf-cfg
+$(addprefix $(obj)/lxdialog/, $(lxdialog)): $(obj)/.mconf-cfg
 
 # qconf: Used for the xconfig target based on Qt
 hostprogs-y	+= qconf


