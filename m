Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D174C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5DB20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="M658JAGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfAKJw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:52:28 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:40670 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfAKJw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:52:27 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x0B9q8sf019557;
        Fri, 11 Jan 2019 18:52:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0B9q8sf019557
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547200328;
        bh=hmjRxVLse3KfB65gtEHQhiYrire4aNjXDv2r+uSNxeM=;
        h=From:To:Cc:Subject:Date:From;
        b=M658JAGb6bGNWqWs0/9dCqILZx0D6Ym/RPDBzEjnuJoA5Q2EWSLwN9Yq1Am7EZjtj
         RYPQRc3wqk8I0GdFRvbs7GFrn01WdqDiv42FM2yYE26yxacBWRkkQORJ1HkGQrbgQw
         V74DXKYHIGVnhV07wGGUFetpfLb1lABcO021HPqLUm/l7di7L8VDNlaguh7Uakc2ck
         JzjxpSeg1pJaN81jjiriNKHbphLsQUVnjoNteMTxhYDOIdAW8FhOcHR4A81v0CYGab
         DzN0RMVVuDe9u6nYU8oZkTOPU7Klys7HYUpPVMhRsbaVAAzHo84C4aZ6PeypbZpPlo
         AfM35uxYZya/g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] firmware_loader: move firmware/ to drivers/base/firmware_loader/builtin/
Date:   Fri, 11 Jan 2019 18:52:00 +0900
Message-Id: <1547200321-17120-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the 'firmware' directory only contains a single Makefile
to embed extra firmware into the kernel.

Move it to the more relevant place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                                                      | 2 +-
 drivers/base/firmware_loader/Makefile                         | 2 ++
 {firmware => drivers/base/firmware_loader/builtin}/.gitignore | 0
 {firmware => drivers/base/firmware_loader/builtin}/Makefile   | 0
 4 files changed, 3 insertions(+), 1 deletion(-)
 rename {firmware => drivers/base/firmware_loader/builtin}/.gitignore (100%)
 rename {firmware => drivers/base/firmware_loader/builtin}/Makefile (100%)

diff --git a/Makefile b/Makefile
index 8c55b64..1625c99 100644
--- a/Makefile
+++ b/Makefile
@@ -583,7 +583,7 @@ export KBUILD_MODULES KBUILD_BUILTIN
 ifeq ($(KBUILD_EXTMOD),)
 # Objects we will link into vmlinux / subdirs we need to visit
 init-y		:= init/
-drivers-y	:= drivers/ sound/ firmware/
+drivers-y	:= drivers/ sound/
 net-y		:= net/
 libs-y		:= lib/
 core-y		:= usr/
diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmware_loader/Makefile
index 5c7f422..0b2dfa6 100644
--- a/drivers/base/firmware_loader/Makefile
+++ b/drivers/base/firmware_loader/Makefile
@@ -5,3 +5,5 @@ obj-$(CONFIG_FW_LOADER_USER_HELPER) += fallback_table.o
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 firmware_class-objs := main.o
 firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) += fallback.o
+
+obj-y += builtin/
diff --git a/firmware/.gitignore b/drivers/base/firmware_loader/builtin/.gitignore
similarity index 100%
rename from firmware/.gitignore
rename to drivers/base/firmware_loader/builtin/.gitignore
diff --git a/firmware/Makefile b/drivers/base/firmware_loader/builtin/Makefile
similarity index 100%
rename from firmware/Makefile
rename to drivers/base/firmware_loader/builtin/Makefile
-- 
2.7.4

