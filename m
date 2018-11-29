Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737AE205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYzt0Yg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737AE205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbeK3BaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731509AbeK3BaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F41D205C9;
        Thu, 29 Nov 2018 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501470;
        bh=BOSO/LAnamxiN6boCORNJjhFnQ2Ifsic/WhGceDaCqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYzt0Yg8b9YPvYlBLRrBzf9D+Vw9YmABqMkaER0ZmOBmw+CNMTdZI0XjHBP95DKYe
         mYbmxbpEwBtBXBOiYrvGKVe6TxGwwRAmvXhPQMnqePmGZvlYogcMVceNdLn8YGpfc8
         tjuHfEFBL3DyUeMG/CB6Wz0/nDm3Z9pqZQLG6rL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.14 003/100] ARM: 8767/1: add support for building ARM kernel with clang
Date:   Thu, 29 Nov 2018 15:11:33 +0100
Message-Id: <20181129140059.153160367@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

(commit c1c386681bd73c4fc28eb5cc91cf8b7be9b409ba upstream)

Use cc-options call for compiler options which are not available
in clang. With this patch an ARMv7 multi platform kernel can be
successfully build using clang (tested with version 5.0.1).

Based-on-patches-by: Behan Webster <behanw@converseincode.com>

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/compressed/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -113,7 +113,7 @@ CFLAGS_fdt_ro.o := $(nossp_flags)
 CFLAGS_fdt_rw.o := $(nossp_flags)
 CFLAGS_fdt_wip.o := $(nossp_flags)
 
-ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
+ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.


