Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF852C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6936B20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="D1aZ88oQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6936B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbeLCHvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:51:48 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:60226 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:51:45 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB37p4O3009296;
        Mon, 3 Dec 2018 16:51:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB37p4O3009296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543823466;
        bh=X+Ozr6bkbkkxWvX5eFcOqnRQyZl1A0qa0bpJxN9vF1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1aZ88oQU7buOx7u7Z7XmXYq07dthDQsllFU/J2lWxPfDVpDDj+LeUx8m0uNXap0d
         8uPs6M35aPTOAH4D564THzMJNCXpBr8wx3pF9N3zIAuYxifegzaFdC4YPWT2prDInM
         n8pa3AW5yPiaTszt6kmgmkNb3ELxSeoICXWjzf3JQMWeVile8NhDVBWGOMQhrYzBx4
         n7Z7gDLiWHB2o1mP5PD8uHdUiOUz45cfLOewNYTyVeHeitvQ5nt4PW9GZ2HjidQwLB
         pekTXRm9JSjQZB0VKzwhLybFvIRliI+7hKXArdy0/Gll7RjnWjxEdq5Uz4lryxlDhO
         m8hhBfA2lEAng==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] microblaze: adjust the help to the real behavior
Date:   Mon,  3 Dec 2018 16:50:52 +0900
Message-Id: <1543823457-32478-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make ARCH=microblaze help" mentions simpleImage.<dt>.unstrip,
but it never works because Makefile assumes "system.unstrip" is
the name of DT.

$ make ARCH=microblaze CROSS_COMPILE=microblaze-linux- simpleImage.system.unstrip
  [ snip ]
make[1]: *** No rule to make target 'arch/microblaze/boot/dts/system.unstrip.dtb', needed by 'arch/microblaze/boot/dts/system.dtb'.  Stop.
make: *** [Makefile;1060: arch/microblaze/boot/dts] Error 2
make: *** Waiting for unfinished jobs....

Rip off the never-working target.

In my understanding, simpleImage.<dt> works like a phony target that
generates multiple images. Reflect the behavior to the help message.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/microblaze/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 0823d29..97e1384 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -89,9 +89,7 @@ define archhelp
   echo '* linux.bin    - Create raw binary'
   echo '  linux.bin.gz - Create compressed raw binary'
   echo '  linux.bin.ub - Create U-Boot wrapped raw binary'
-  echo '  simpleImage.<dt> - ELF image with $(arch)/boot/dts/<dt>.dts linked in'
-  echo '                   - stripped elf with fdt blob'
-  echo '  simpleImage.<dt>.unstrip - full ELF image with fdt blob'
+  echo '  simpleImage.<dt> - Create images with $(arch)/boot/dts/<dt>.dts linked in'
   echo '  *_defconfig      - Select default config from arch/microblaze/configs'
   echo ''
   echo '  Targets with <dt> embed a device tree blob inside the image'
-- 
2.7.4

