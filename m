Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C372C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5445120818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="CeFX6rSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfBUWTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:19:37 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:59044 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfBUWTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W0GX3B+wxTVUSEQ6NXFzgsKD/pn4qjWyHXfmo8sTUiU=; b=CeFX6rSxlK+KVOpGHvCI/NtYyI
        xiCtHAjaOGY1iX6lZWrPP/x8uXwEhPM8UZTayO12jeoZhXzIbHc+MY1Ajqwdr1TBHCsvtQRwBzfWx
        raVDYL6frbdrpNdtGzoGHcY4dIm7wdhdD5WJdte+LBv8bqBOpHsEfloxopw0W2u8hfBDfmbqlKpJe
        BPg4nCDnc9wLWCSjw+E6Agv12X1I4bhmSIAw28dMooqEBRaQSxHVxCBnMGM9sr5DIy2vcQLQzrt47
        coJ5uxisrEb6Xj9qrH1LBtTH0VxB2uizwkRNlejPDwmI3jDlIZfuWLBHEATKTaY5o7GgAvguAKOpY
        990zNryw==;
Received: from [37.204.119.143] (port=58724 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1gwwNj-0004BO-9N; Fri, 22 Feb 2019 00:59:51 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Fri, 22 Feb 2019 00:58:58 +0300
Message-Id: <20190221215901.23970-2-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221215901.23970-1-ar@cs.msu.ru>
References: <20190221215901.23970-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH] scripts/kconfig/Makefile: use KCONFIG_CONFIG if set
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a kernel source tree:

% make mrproper
% make KCONFIG_CONFIG=.myconfig kvmconfig'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/preprocess.o
  LEX     scripts/kconfig/zconf.lex.c
  YACC    scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/zconf.lex.o
  YACC    scripts/kconfig/zconf.tab.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
The base file '.config' does not exist.  Exit.
make[1]: *** [scripts/kconfig/Makefile:96: kvm_guest.config] Error 1
make: *** [Makefile:538: kvmconfig] Error 2

Essentially `make kvmconfig' (and probably other similar targets)
did ignore KCONFIG_CONFIG set to a different filename.

If KCONFIG_CONFIG is set, use it; otherwise behave as if it was set
to `.config'.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 scripts/kconfig/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 181973509a05..1c7ac07def4d 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -93,7 +93,7 @@ configfiles=$(wildcard $(srctree)/kernel/configs/$@ $(srctree)/arch/$(SRCARCH)/c
 
 %.config: $(obj)/conf
 	$(if $(call configfiles),, $(error No configuration exists for this target on this architecture))
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m .config $(configfiles)
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m $(KCONFIG_CONFIG) $(configfiles)
 	+$(Q)yes "" | $(MAKE) -f $(srctree)/Makefile oldconfig
 
 PHONY += kvmconfig
-- 
2.20.1

