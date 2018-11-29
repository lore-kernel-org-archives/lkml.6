Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E3FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B1E213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbQochE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B1E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeK3BT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbeK3BT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB7921019;
        Thu, 29 Nov 2018 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500837;
        bh=1QisvhshrmTAlJrem3YOr5iAdmSCgVpmLrJGgt/1080=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbQochE0Vc33FZYx9h/WZGZtemOaU+nWTRv9snVoR2re2kAjlM13+Lg9x4MZ8ayRE
         2IS5+Fd0XSHZXHNglLO1Oqio4aKKEMgoEQOnBkFw2SS0ZYj8Gx/jlldoRpN3Zv87Wa
         DPp/uIJ93fgEsR5wvGd642EOeQTppR9r2N+45NeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 19/83] arm64: remove no-op -p linker flag
Date:   Thu, 29 Nov 2018 15:11:37 +0100
Message-Id: <20181129140139.155036780@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

(commit 1a381d4a0a9a0f999a13faaba22bf6b3fc80dcb9 upstream)

Linking the ARM64 defconfig kernel with LLVM lld fails with the error:

  ld.lld: error: unknown argument: -p
  Makefile:1015: recipe for target 'vmlinux' failed

Without this flag, the ARM64 defconfig kernel successfully links with
lld and boots on Dragonboard 410c.

After digging through binutils source and changelogs, it turns out that
-p is only relevant to ancient binutils installations targeting 32-bit
ARM.  binutils accepts -p for AArch64 too, but it's always been
undocumented and silently ignored.  A comment in
ld/emultempl/aarch64elf.em explains that it's "Only here for backwards
compatibility".

Since this flag is a no-op on ARM64, we can safely drop it.

Acked-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 37c4fd6aeb7a..42065599d014 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -10,7 +10,7 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:=-p --no-undefined -X
+LDFLAGS_vmlinux	:=--no-undefined -X
 CPPFLAGS_vmlinux.lds = -DTEXT_OFFSET=$(TEXT_OFFSET)
 OBJCOPYFLAGS	:=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 GZFLAGS		:=-9
-- 
2.17.1



