Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02669C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD58208CC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vwV8x+BI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD58208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeHTU0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:26:02 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:58370 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHTU0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:26:02 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w7KH8lMi020657;
        Tue, 21 Aug 2018 02:08:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w7KH8lMi020657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534784928;
        bh=W+ulMFy2DYDNDGT0WCl0WP5mY2rpiCkYnN0RMOcb80Q=;
        h=From:To:Cc:Subject:Date:From;
        b=vwV8x+BI6RIrLqIpWj05DWNp4XeSv0xZPdeaEW83PAI9mHInMLx/TkJpdfxJ7aLyO
         FCZ9SAQeJmPH1j45ypV6wzB3fGlSRA2RjNTrUfjlIoy3ArzgG1mpc5dcBB7BC9ZCL1
         JOcCsy2mApd5tXyp9o5U6dJCKfz/d+geFEzI4HxcRdCjbQad7ikQh362LePoG05GmZ
         KY7AyHn/5HLhsaPIBklUyJXHq3StJ2vuB6cHLAzFmAyr1gmY8vGGqta923Yz3Mrx8p
         3bqE+Go9Pbx33h3U8ajCeEMfthGpxhwdNYqnxIAkOgCxRDWYGqa5+c9QV5q2/+yDR/
         v26tYMdH5eJkw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: fix KBUILD_DEFCONFIG for ARCH=sparc32
Date:   Tue, 21 Aug 2018 02:08:28 +0900
Message-Id: <1534784908-11692-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 5ba800962a80 ("kbuild: update ARCH alias info for sparc")
addressed, SPARC accepts ARCH=sparc32 as an alias.

However, arch/sparc/Makefile wrongly sets KBUILD_DEFCONFIG, then
sparc64_defconfig is chosen as the base configuration for ARCH=sparc32.

  $ make ARCH=sparc32 defconfig
  *** Default configuration is based on 'sparc64_defconfig'
  #
  # configuration written to .config
  #

Fix the logic to choose sparc64_defconfig only when ARCH=sparc64.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sparc/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 966a13d..e32ef20 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -9,10 +9,10 @@
 # Copyright (C) 1998 Jakub Jelinek (jj@ultra.linux.cz)
 
 # We are not yet configured - so test on arch
-ifeq ($(ARCH),sparc)
-        KBUILD_DEFCONFIG := sparc32_defconfig
-else
+ifeq ($(ARCH),sparc64)
         KBUILD_DEFCONFIG := sparc64_defconfig
+else
+        KBUILD_DEFCONFIG := sparc32_defconfig
 endif
 
 ifeq ($(CONFIG_SPARC32),y)
-- 
2.7.4

