Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AA3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D91125572
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D91125572
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933869AbeGBJXL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:23:11 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:53836 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933829AbeGBJXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:23:08 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2018 05:23:08 EDT
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 4267CBFEB9;
        Mon,  2 Jul 2018 11:17:09 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id C6EE0C0780; Mon,  2 Jul 2018 11:17:08 +0200 (CEST)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 9C0C1BFFE3;
        Mon,  2 Jul 2018 11:17:01 +0200 (CEST)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Kocialkowski <contact@paulk.fr>, stable@vger.kernel.org
Subject: [PATCH] arm64: Use aarch64elf and aarch64elfb emulation mode variants
Date:   Mon,  2 Jul 2018 11:16:59 +0200
Message-Id: <20180702091659.17571-1-contact@paulk.fr>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aarch64linux and aarch64linuxb emulation modes are not supported by
bare-metal toolchains and Linux using them forbids building the kernel
with these toolchains.

Since there is apparently no reason to target these emulation modes, the
more generic elf modes are used instead, allowing to build on bare-metal
toolchains as well as the already-supported ones.

Fixes: 3d6a7b99e3fa ("arm64: ensure the kernel is compiled for LP64")

Cc: stable@vger.kernel.org
Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm64/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 87f7d2f9f17c..3e959ac43b40 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -67,14 +67,14 @@ KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
 LD		+= -EB
-LDFLAGS		+= -maarch64linuxb
+LDFLAGS		+= -maarch64elfb
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
 LD		+= -EL
-LDFLAGS		+= -maarch64linux
+LDFLAGS		+= -maarch64elf
 UTS_MACHINE	:= aarch64
 endif
 
-- 
2.17.1

