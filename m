Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3268C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9A9214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIqV3FNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9A9214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389157AbeKVFrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:47:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389139AbeKVFrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:47:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00D1821527;
        Wed, 21 Nov 2018 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827518;
        bh=Oj1VqjABVcOhitaAkge67jBKhaKLlKqEsTyw6gvcoT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIqV3FNlIWBlzerk0/3+ZdSrv+Q9lh704R5e1O7lvPMxZSyrdmgetvHx9BRpgEUq9
         mHqibPFWh4/c3B725OJFUjh6hCSO/RKJo3Zfsl+nXbnXrvs2beUTMsok3fAdXYCLKA
         Zgza0zY0S/cuf6TodT9zyY2MC1nLwFit4ownJxkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Vrabel <david.vrabel@citrix.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 34/59] Kbuild: use -fshort-wchar globally
Date:   Wed, 21 Nov 2018 20:06:49 +0100
Message-Id: <20181121183509.586441101@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 8c97023cf0518f172b8cb7a9fffc28b89401abbf upstream.

Commit 971a69db7dc0 ("Xen: don't warn about 2-byte wchar_t in efi")
added the --no-wchar-size-warning to the Makefile to avoid this
harmless warning:

arm-linux-gnueabi-ld: warning: drivers/xen/efi.o uses 2-byte wchar_t yet the output is to use 4-byte wchar_t; use of wchar_t values across objects may fail

Changing kbuild to use thin archives instead of recursive linking
unfortunately brings the same warning back during the final link.

The kernel does not use wchar_t string literals at this point, and
xen does not use wchar_t at all (only efi_char16_t), so the flag
has no effect, but as pointed out by Jan Beulich, adding a wchar_t
string literal would be bad here.

Since wchar_t is always defined as u16, independent of the toolchain
default, always passing -fshort-wchar is correct and lets us
remove the Xen specific hack along with fixing the warning.

Link: https://patchwork.kernel.org/patch/9275217/
Fixes: 971a69db7dc0 ("Xen: don't warn about 2-byte wchar_t in efi")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile             |    2 +-
 drivers/xen/Makefile |    3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -394,7 +394,7 @@ LINUXINCLUDE	+= $(filter-out $(LINUXINCL
 
 KBUILD_AFLAGS   := -D__ASSEMBLY__
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-		   -fno-strict-aliasing -fno-common \
+		   -fno-strict-aliasing -fno-common -fshort-wchar \
 		   -Werror-implicit-function-declaration \
 		   -Wno-format-security \
 		   -std=gnu89
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -7,9 +7,6 @@ obj-y	+= xenbus/
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_features.o			:= $(nostackp)
 
-CFLAGS_efi.o				+= -fshort-wchar
-LDFLAGS					+= $(call ld-option, --no-wchar-size-warning)
-
 dom0-$(CONFIG_ARM64) += arm-device.o
 dom0-$(CONFIG_PCI) += pci.o
 dom0-$(CONFIG_USB_SUPPORT) += dbgp.o


