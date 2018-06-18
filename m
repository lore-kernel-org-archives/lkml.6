Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5F4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4027820874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4027820874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966661AbeFRI23 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:28:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966646AbeFRI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:28:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45F85CE0;
        Mon, 18 Jun 2018 08:28:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Landley <rob@landley.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 278/279] ARM: replace unnecessary perl with sed and the shell $(( )) operator
Date:   Mon, 18 Jun 2018 10:14:23 +0200
Message-Id: <20180618080620.170374076@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 6cea14f55474ec71f1098228e0ae5dd2a8f22c0a ]

You can build a kernel in a cross compiling environment that doesn't
have perl in the $PATH. Commit 429f7a062e3b broke that for 32 bit
ARM. Fix it.

As reported by Stephen Rothwell, it appears that the symbols can be
either part of the BSS section or absolute symbols depending on the
binutils version.  When they're an absolute symbol, the $(( ))
operator errors out and the build fails.  Fix this as well.

Fixes: 429f7a062e3b ("ARM: decompressor: fix BSS size calculation")
Reported-by: Rob Landley <rob@landley.net>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Rob Landley <rob@landley.net>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/compressed/Makefile |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -117,11 +117,9 @@ ccflags-y := -fpic -mno-single-pic-base
 asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
-KBSS_SZ = $(shell $(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
-		perl -e 'while (<>) { \
-			$$bss_start=hex($$1) if /^([[:xdigit:]]+) B __bss_start$$/; \
-			$$bss_end=hex($$1) if /^([[:xdigit:]]+) B __bss_stop$$/; \
-		}; printf "%d\n", $$bss_end - $$bss_start;')
+KBSS_SZ = $(shell echo $$(($$($(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
+		sed -n -e 's/^\([^ ]*\) [AB] __bss_start$$/-0x\1/p' \
+		       -e 's/^\([^ ]*\) [AB] __bss_stop$$/+0x\1/p') )) )
 LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)


