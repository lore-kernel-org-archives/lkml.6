Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA80C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9490420892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lgrb6D6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9490420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeLGLeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:34:22 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:45509 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeLGLeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:34:21 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wB7BY6rc020070;
        Fri, 7 Dec 2018 20:34:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB7BY6rc020070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544182447;
        bh=b+/CYXfoOhRLJl50d2gy+TZDzV3UYeKW/v4ouoz7OoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgrb6D6CSf7xC97CxtfCzHEpo4yQbPFJ59WYm47+0gL58RzjcVRd89gsCFMTEsYJR
         /jt7Yj+qL0m5JGg2zv7ZAbilpc3AJFiHatagUhqrC/QsGX2HoPCrRMpEgFBNsUDLeS
         o4TbcZgbCd3zwVg7FeyzO0O2MRpTkF1GNpEK/ySNycTDjjMit4SQY5YjIb5oaiJd/d
         VrVm9eEEP8kD4jzGYhNGZ/3cY7rsucN5/VNLs0L3gkgG7Ml7nL+/i0TAkuebQ1LiKS
         hj2gygxD0mw0vsi7l9K9Dm0Sl1s5hFpaxNHfFVg/jeWy2VL/ZL78v2SmBgaEbz1b6u
         yv/68Vm/TjqBQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] microblaze: adjust the help to the real behavior
Date:   Fri,  7 Dec 2018 20:33:52 +0900
Message-Id: <1544182437-26660-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544182437-26660-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544182437-26660-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make ARCH=microblaze help" mentions simpleImage.<dt>.unstrip,
but it is not a real Make target. It does not work because Makefile
assumes "system.unstrip" is the name of DT.

$ make ARCH=microblaze CROSS_COMPILE=microblaze-linux- simpleImage.system.unstrip
  [ snip ]
make[1]: *** No rule to make target 'arch/microblaze/boot/dts/system.unstrip.dtb', needed by 'arch/microblaze/boot/dts/system.dtb'.  Stop.
make: *** [Makefile;1060: arch/microblaze/boot/dts] Error 2
make: *** Waiting for unfinished jobs....

simpleImage.<dt> works like a phony target that generates multiple
images. Reflect the real behavior. I removed the DT directory path
information because it is already explained a few lines below.

While I am here, I deleted the redundant *_defconfig explanation.

The top-level Makefile caters to list available defconfig files:

  mmu_defconfig            - Build for mmu
  nommu_defconfig          - Build for nommu

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Show all the four images in help
  - Delete redundant *_defconfig explanation

 arch/microblaze/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index ddb251a..f6b7ea6 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -92,11 +92,11 @@ define archhelp
   echo '* linux.bin    - Create raw binary'
   echo '  linux.bin.gz - Create compressed raw binary'
   echo '  linux.bin.ub - Create U-Boot wrapped raw binary'
-  echo '  simpleImage.<dt> - ELF image with $(arch)/boot/dts/<dt>.dts linked in'
-  echo '                   - stripped elf with fdt blob'
-  echo '  simpleImage.<dt>.unstrip - full ELF image with fdt blob'
-  echo '  *_defconfig      - Select default config from arch/microblaze/configs'
-  echo ''
+  echo '  simpleImage.<dt> - Create the following images with <dt>.dtb linked in'
+  echo '                    simpleImage.<dt>        : raw image'
+  echo '                    simpleImage.<dt>.ub     : raw image with U-Boot header'
+  echo '                    simpleImage.<dt>.unstrip: ELF (identical to vmlinux)'
+  echo '                    simpleImage.<dt>.strip  : stripped ELF'
   echo '  Targets with <dt> embed a device tree blob inside the image'
   echo '  These targets support board with firmware that does not'
   echo '  support passing a device tree directly. Replace <dt> with the'
-- 
2.7.4

