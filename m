Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD9BECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B9E2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="txyK6NuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B9E2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeKERLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:11:30 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:64633 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeKERLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:11:30 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wA57qbQr022156;
        Mon, 5 Nov 2018 16:52:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wA57qbQr022156
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541404357;
        bh=q9OLMNtOOyyslTccVJ2Ga2Cr0/sE1ldRFpj9Vwpm0+8=;
        h=From:To:Cc:Subject:Date:From;
        b=txyK6NuI+h2wKEJWQLemfY8dRQYf3JpqqYs0LjRLrVkSrqRSjsjgfLEnDUB4y6fzz
         gmAloTYzGZQ/6XrBr07KPCXTM4Ul3jFAHhALrWJXne3s6xC+R3PH+NLQDkFxnfmb1S
         KdQTycSnA1HRnE3+lsjMWIscE2i+BV0mD15B5y9pwnCfc2khNARg7QMXrumzDu1dYt
         7fjYcTzZrKYjYzRZSSZz9C4L+UEjlwWw1K5ssX2fb7Lk/7cD9kzyby1BfdcPRmEvdW
         567RFXNaQ7rJtSxx67WBTcOjwDQ09BE9kbAAN3IA7NLdFNaxYU+nEJAh8o/Iadqplw
         Pugy/3pxcVF6w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: deb-pkg: fix bindeb-pkg breakage when O= is used
Date:   Mon,  5 Nov 2018 16:52:34 +0900
Message-Id: <1541404354-30331-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ard Biesheuvel reports bindeb-pkg with O= option is broken in the
following way:

  ...
    LD [M]  sound/soc/rockchip/snd-soc-rk3399-gru-sound.ko
    LD [M]  sound/soc/rockchip/snd-soc-rockchip-pcm.ko
    LD [M]  sound/soc/rockchip/snd-soc-rockchip-rt5645.ko
    LD [M]  sound/soc/rockchip/snd-soc-rockchip-spdif.ko
    LD [M]  sound/soc/sh/rcar/snd-soc-rcar.ko
   fakeroot -u debian/rules binary
  make KERNELRELEASE=4.19.0-12677-g19beffaf7a99-dirty ARCH=arm64 KBUILD_SRC= intdeb-pkg
  /bin/bash /home/ard/linux/scripts/package/builddeb
  Makefile:600: include/config/auto.conf: No such file or directory
  ***
  *** Configuration file ".config" not found!
  ***
  *** Please run some configurator (e.g. "make oldconfig" or
  *** "make menuconfig" or "make xconfig").
  ***
  make[12]: *** [syncconfig] Error 1
  make[11]: *** [syncconfig] Error 2
  make[10]: *** [include/config/auto.conf] Error 2
  make[9]: *** [__sub-make] Error 2
  ...

Prior to commit 80463f1b7bf9 ("kbuild: add --include-dir flag only
for out-of-tree build"), both objtree and srctree were added to
--include-dir, and the wrong code '$MAKE image_name' was working
relying on that. Now, the potential issue that had previously been
hidden just showed up.

'$MAKE image_name' recurses to the generated $(objtree)/Makefile and
ends up with running in srctree, which is incorrect. It should be
invoked with '-f $srctree/Makefile' (or KBUILD_SRC=) to be executed
in objtree.

Fixes: 80463f1b7bf9 ("kbuild: add --include-dir flag only for out-of-tree build")
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/package/builddeb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 90c9a8a..0b31f4f 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -81,7 +81,7 @@ else
 	cp System.map "$tmpdir/boot/System.map-$version"
 	cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
 fi
-cp "$($MAKE -s image_name)" "$tmpdir/$installed_image_path"
+cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
 
 if grep -q "^CONFIG_OF=y" $KCONFIG_CONFIG ; then
 	# Only some architectures with OF support have this target
-- 
2.7.4

