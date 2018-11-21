Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE11AC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D1C214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp0W0HBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D1C214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeKVFpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbeKVFpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:45:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE73214DB;
        Wed, 21 Nov 2018 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827386;
        bh=8KjP9kOuFuqv0oYS6QI0mOOnIgLfjYqkU9Haov8rEHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gp0W0HBUpq+lGNOo7v89M6Q3IW4n+jF3M199j/O42jjGfe2OlnUsP8n1n9mnXeP+8
         sVWzuzRH1OpaYmtPV1+9OH/oj/CgpoPPAHLWqx/BWwzGx93WXv3Rdsadvc7kzqfJ7w
         5Ej/xhuvtzZNvG/Cru2sNg/n51MMcYJUnrkvoZgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Behan Webster <behanw@converseincode.com>,
        =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>,
        Mark Charlebois <charlebm@gmail.com>,
        Greg Hackmann <ghackmann@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 10/59] kbuild: Add better clang cross build support
Date:   Wed, 21 Nov 2018 20:06:25 +0100
Message-Id: <20181121183508.664285134@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Behan Webster <behanw@converseincode.com>

commit 785f11aa595bc3d4e74096cbd598ada54ecc0d81 upstream.

Add cross target to CC if using clang. Also add custom gcc toolchain
path for fallback gcc tools.

Clang will fallback to using things like ld, as, and libgcc if
(respectively) one of the llvm linkers isn't available, the integrated
assembler is turned off, or an appropriately cross-compiled version of
compiler-rt isn't available. To this end, you can specify the path to
this fallback gcc toolchain with GCC_TOOLCHAIN.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Jan-Simon Möller <dl9pf@gmx.de>
Reviewed-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -704,6 +704,15 @@ endif
 KBUILD_CFLAGS += $(stackp-flag)
 
 ifeq ($(cc-name),clang)
+ifneq ($(CROSS_COMPILE),)
+CLANG_TARGET	:= -target $(notdir $(CROSS_COMPILE:%-=%))
+GCC_TOOLCHAIN	:= $(realpath $(dir $(shell which $(LD)))/..)
+endif
+ifneq ($(GCC_TOOLCHAIN),)
+CLANG_GCC_TC	:= -gcc-toolchain $(GCC_TOOLCHAIN)
+endif
+KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
+KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
 KBUILD_CPPFLAGS += $(call cc-option,-Wno-unknown-warning-option,)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)


