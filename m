Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97548C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A87D20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bqdWSyR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A87D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeLGLeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:34:37 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:45839 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeLGLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:34:35 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wB7BY6rg020070;
        Fri, 7 Dec 2018 20:34:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB7BY6rg020070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544182449;
        bh=iWKyb7H5Y6sa+fS3ZVKUj+AUMRvSCVfD4O07yhmAYiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqdWSyR4ct/WJ+ehuhU+WAJQkwtK44msPUli7SjFA8ROLf/az93c6UktZdCt0ZXMY
         0Nl+x+PLiyTuT8VMfKfcvDBfqp9+zAYiRDSlhDS6T9wMWlv+EFBFTkGKn1RANPLJRC
         9xg1Ov4LGkhWBzoXVyinLT9Kz9zsQ+WpJolntiRkpr2MXaL9zldQ5oX02lS/iXvEW+
         EMVdRIzrJIoMO+9iFeE4Jx2YVesCddmJsJmj5iVRPn2KEGTWJd6Tyb2LHM/d0HN0Ua
         O6jI2s610G3XOnWZancW8nJtwJjpogOZhV1YwWDsVxvdj4q2poEDeprJbiEntOY4RU
         8JHvwvR8fzIBA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] microblaze: fix race condition in building boot images
Date:   Fri,  7 Dec 2018 20:33:56 +0900
Message-Id: <1544182437-26660-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544182437-26660-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544182437-26660-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed a race condition in the parallel building of ARM in commit
3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
generate invalid images").

I see the same problem for MicroBlaze too.

"make -j<N> ARCH=microblaze all linux.bin.ub" results in a broken build
because two threads descend into arch/microblaze/boot simultaneously.

Add proper dependencies to avoid it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 arch/microblaze/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 180dffa..7b340a3 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -83,7 +83,9 @@ archheaders:
 	$(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
 
 PHONY += linux.bin linux.bin.gz linux.bin.ub
-linux.bin linux.bin.gz linux.bin.ub: vmlinux
+linux.bin.ub linux.bin.gz: linux.bin
+linux.bin: vmlinux
+linux.bin linux.bin.gz linux.bin.ub:
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
-- 
2.7.4

