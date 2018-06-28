Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A50C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284EB27A6F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lk10Dnmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284EB27A6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936266AbeF1Xj4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:39:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbeF1Xjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MUBDEJLassogivScKlUkGXz7Qfu2f08dm6CUJsvtxDU=; b=lk10DnmfMbgB4LWr5wwLXbQKd
        B7oYkIH8uQeSUKBZXTXNuWRKy8/pWkyTJu/mnKThEn6ZtYjpo/Wor270Wq4TqeSbkemsQV+pX6bp0
        IIZE3PwK6rut6MEf0P6DKVIMakoEkbwynqofcJAcKjLGQoustbzbR0+BXF5TCdUauasy4yB+jx2j1
        thvFIYiBGeGQCIcbtvPzXElOeulTOjyskfCJJ2n7nrhpDggfpSs8E26aX30p7NLxYMN5smIW+urAp
        JSjKfHns+ct8iJQtifcJKgvDdSy7B0r5o7+csdjnF+j827RuS8N/p2HRMkpVWodxEXxll72tuYmpZ
        PYK+xp34A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYgW1-0001sK-Lx; Thu, 28 Jun 2018 23:39:53 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     =?UTF-8?Q?Bj=c3=b8rn_Forsman?= <bjorn.forsman@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4] kconfig: check for pkg-config on make {menu,n,g,x}config
Message-ID: <c2541256-d3de-e0cf-077c-cdb590c3c152@infradead.org>
Date:   Thu, 28 Jun 2018 16:39:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Each of 'make {menu,n,g,x}config' uses (needs) pkg-config to make sure
that other required files are present and to determine build flags
settings, but none of these check that pkg-config itself is present.
Add a check for all 4 of these targets and update
Documentation/process/changes.rst to mention 'pkg-config'.

Fixes kernel bugzilla #77511:
https://bugzilla.kernel.org/show_bug.cgi?id=77511

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjørn Forsman <bjorn.forsman@gmail.com>
---
v4: apply Masahiro's suggestions

Strictly speaking, pkg-config is not required if someone is only
using 'make {menu,n}config' since there are fallbacks for those
two targets.

 Documentation/process/changes.rst  |    8 ++++++++
 scripts/kconfig/Makefile           |    1 +
 scripts/kconfig/check-pkgconfig.sh |    8 ++++++++
 3 files changed, 17 insertions(+)

--- linux-next-20180628.orig/scripts/kconfig/Makefile
+++ linux-next-20180628/scripts/kconfig/Makefile
@@ -215,6 +215,7 @@ $(obj)/zconf.tab.o: $(obj)/zconf.lex.c
 
 # check if necessary packages are available, and configure build flags
 define filechk_conf_cfg
+	$(CONFIG_SHELL) $(srctree)/scripts/kconfig/check-pkgconfig.sh; \
 	$(CONFIG_SHELL) $<
 endef
 
--- /dev/null
+++ linux-next-20180628/scripts/kconfig/check-pkgconfig.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Check for pkg-config presence
+
+if [ -z $(command -v pkg-config) ]; then
+	echo "'make *config' requires 'pkg-config'. Please install it." 1>&2
+	exit 1
+fi
--- linux-next-20180628.orig/Documentation/process/changes.rst
+++ linux-next-20180628/Documentation/process/changes.rst
@@ -81,6 +81,14 @@ The build system has, as of 4.13, switch
 rather than incremental linking (`ld -r`) for built-in.a intermediate steps.
 This requires binutils 2.20 or newer.
 
+pkg-config
+----------
+
+The build system, as of 4.18, requires pkg-config to check for installed
+kconfig tools and to determine flags settings for use in
+'make {menu,n,g,x}config'.  Previously pkg-config was being used but not
+verified or documented.
+
 Flex
 ----
 

