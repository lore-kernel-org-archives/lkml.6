Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17252C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EA9208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xu1LPVbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EA9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJPRBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:01:43 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:57743 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeJPRBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:01:42 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w9G9BLLx029692;
        Tue, 16 Oct 2018 18:11:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w9G9BLLx029692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539681084;
        bh=oOu070Ru7d+JJagPqx7fCHtw6LbcaDKL54LM4cesph4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xu1LPVbJscQBy8rpYl0T7P+sapQdLxQs6liVk992m/r3XP3O3rAiF0aa/8ER7hh7O
         wYwsOxYSY8T/krf/Su1ZuFd4wRKrOMAHWxtPoxXfEos5vmJcL9IxtDM4/BFU85XpBv
         BGGkqRPasp4jQfzMJ7/0lsHkogLSSEZUY0w74EwZXFwj1vYbUC2O0Mdg6CTZ2qFRQd
         lAtZQ2rL19vMORhaggPfScKJXBW8Q89bNAsQ9LFMcak6ERw8gLKzZcc4Bvq6JdhL/o
         e0ZLgep1/pSQ8fHz9/rVU+npzFG3jBJd9S1XQtEAdqxteamYXKzdzY3vRX7xFVG2mk
         c/BSyJ5akimwQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Borislav Petkov <bp@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kbuild: check the presence of lzo and lz4 tools when necessary
Date:   Tue, 16 Oct 2018 18:10:53 +0900
Message-Id: <1539681053-24388-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_KERNEL_LZ4 is enabled without lz4 tool installed on the
system, the build fails at the very last stage (reported by
Borislav Petkov [1]).

  LZO     arch/x86/boot/compressed/vmlinux.bin.lzo
/bin/sh: 1: lzop: not found
arch/x86/boot/compressed/Makefile:141: recipe for target 'arch/x86/boot/compressed/vmlinux.bin.lzo' failed
make[2]: *** [arch/x86/boot/compressed/vmlinux.bin.lzo] Error 1
arch/x86/boot/Makefile:112: recipe for target 'arch/x86/boot/compressed/vmlinux' failed
make[1]: *** [arch/x86/boot/compressed/vmlinux] Error 2
arch/x86/Makefile:284: recipe for target 'bzImage' failed
make: *** [bzImage] Error 2

Check the tools in scripts/Makefile.toolcheck to fail the build
earlier with a more readable message.

[1] https://patchwork.kernel.org/patch/10635381/

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.toolcheck | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/Makefile.toolcheck b/scripts/Makefile.toolcheck
index bc26fc0..5e336e4 100644
--- a/scripts/Makefile.toolcheck
+++ b/scripts/Makefile.toolcheck
@@ -17,6 +17,14 @@ msg_stack_validation = "libelf is necessary for building the objtool." \
 		       "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
 toolcheck-$(CONFIG_STACK_VALIDATION) += stack_validation
 
+chk_lzo = command -v lzop
+msg_lzo = "lzo tool not found. Please install it."
+toolcheck-$(CONFIG_KERNEL_LZO) += lzo
+
+chk_lz4 = command -v lz4c
+msg_lz4 = "lz4 tool not found. Please install it."
+toolcheck-$(CONFIG_KERNEL_LZ4) += lz4
+
 PHONY += $(toolcheck-y)
 __toolcheck: $(toolcheck-y)
 
-- 
2.7.4

