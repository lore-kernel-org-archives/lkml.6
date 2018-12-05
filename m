Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8FFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A946C2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OVD8advv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A946C2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeLEHil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:38:41 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:26153 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeLEHil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:38:41 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id wB57caND020089;
        Wed, 5 Dec 2018 16:38:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com wB57caND020089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543995517;
        bh=eGCqsSq3nENOotaoVO1vK+Z80FTfkETIFwDDyIqiXrM=;
        h=From:To:Cc:Subject:Date:From;
        b=OVD8advvHOPfs1qKwmMzFjQ1g3JsMqb92H8PZNMj+LyGpnFh+7/Wb1Eg0VpTtNQ+n
         dmGnZvtiOK8tHX3FqhYhqrG3FRTFbqjZ6/js8cd5SFms2mi9N1aKMuciADxh4xEOcF
         jNAQ+8g73RgaTJ1+G92avRT73JWUw7zfB5zw32kUcCKlcvYoTu0MTCxtkmH/rZbCAD
         5S0serH5Ckz0vzdl2GUlOgdpssP73A/np617iU6XrHWoT53P2X7LuUyoP911DWdN3c
         oKa0V1iik/mmpQwXymqoq1vLRcxepH7qkmwzESSTJZXTr/ssxmiNnJ46whqOiTcv6V
         R2w4ff+SkRCJQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: exploit parallel building for CONFIG_HEADERS_CHECK
Date:   Wed,  5 Dec 2018 16:38:35 +0900
Message-Id: <1543995515-25178-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_HEADERS_CHECK is enabled, the headers_check is executed
as a serialized task in the vmlinux recipe.

Make it independent of vmlinux so that parallel building can process
the headers_check and other build targets simultaneously.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 3af0379..2808a7d 100644
--- a/Makefile
+++ b/Makefile
@@ -1035,9 +1035,6 @@ cmd_link-vmlinux =                                                 \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
-ifdef CONFIG_HEADERS_CHECK
-	$(Q)$(MAKE) -f $(srctree)/Makefile headers_check
-endif
 ifdef CONFIG_GDB_SCRIPTS
 	$(Q)ln -fsn $(abspath $(srctree)/scripts/gdb/vmlinux-gdb.py)
 endif
@@ -1208,6 +1205,10 @@ headers_check: headers_install
 	$(Q)$(MAKE) $(hdr-inst)=include/uapi dst=include HDRCHECK=1
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(SRCARCH)/include/uapi $(hdr-dst) HDRCHECK=1
 
+ifdef CONFIG_HEADERS_CHECK
+all: headers_check
+endif
+
 # ---------------------------------------------------------------------------
 # Kernel selftest
 
-- 
2.7.4

