Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDC2C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911D0214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zXjeLT/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911D0214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeLDLJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbeLDLJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:09:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EBB22146D;
        Tue,  4 Dec 2018 11:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921777;
        bh=vro/dTUwBgsCYyS1ObtLz1B3rqkIWM+d/WsoXhxO9wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zXjeLT/QoX9hsJsq6h2YT1Og8LuNndNX0ekruUYA/4FOdDgsGihD4QXBXwANcp2gy
         tagqha4SsCfUhyPQpL+U1xzleE8nqaDiPwHYMIGd2xK5vK/NulDtjFyMAPVD3HnLkV
         kGbXAFUw936WQnXrdT6Enc3IkjrrDfrWhpg1QRM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 45/50] ARM: 8767/1: add support for building ARM kernel with clang
Date:   Tue,  4 Dec 2018 11:50:40 +0100
Message-Id: <20181204103716.747617506@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -112,7 +112,7 @@ CFLAGS_fdt_ro.o := $(nossp_flags)
 CFLAGS_fdt_rw.o := $(nossp_flags)
 CFLAGS_fdt_wip.o := $(nossp_flags)
 
-ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
+ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.


