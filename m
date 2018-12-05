Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF2EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AFF20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="21/4wliy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AFF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeLEDBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:01:55 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:21518 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEDBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:01:55 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wB530C3N030996;
        Wed, 5 Dec 2018 12:00:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wB530C3N030996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543978813;
        bh=48mcGvMT2ApW6AdVlLjmIDpHjCMBJ4B/FrgGQuUSOTs=;
        h=From:To:Cc:Subject:Date:From;
        b=21/4wliySXOepY8eSysx9ZkFJxA0Xba55URkSBrMcBD1+k4onr6h+I7N6slx6YtqS
         IB0+OCKc3w3jgSmD/kHWlpu6YcrFw2JhW4pGhgwDP629h/t0hrhq9iKbHoajBVBjDI
         qx3VPhHWr2v8tY+8WcGv4hlG9UwjBFRR3JlDHFdrM5SzVt2gcQ+c+1FbjpaGxbGpjX
         /XAt61ET49ZufaniRgzuaShZ03dzqIckuKy6VduVCum7NnjtDg0EzlSN2ORkNQIjoc
         LpX2r8ZKG5ZqXr7mhMPAONCzosD43CqMiwRMj7x1jOZxt3bl39QjTwAnt9aPVqcOTI
         GwDdG+KD3577Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Meelis Roos <mroos@linux.ee>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/build: fix compiler support check for CONFIG_RETPOLINE
Date:   Wed,  5 Dec 2018 12:00:02 +0900
Message-Id: <1543978802-24196-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is wrong to add CONFIG option diagnostic to the Makefile parse
stage.

Once you are hit by the error about non-retpoline compiler, the
compilation still breaks even after disabling CONFIG_RETPOLINE.

The easiest fix is to move this check to the "archprepare" like commit
829fe4aa9ac1 ("x86: Allow generating user-space headers without a
compiler") did.

Link: https://lkml.org/lkml/2018/12/4/206
Reported-by: Meelis Roos <mroos@linux.ee>
Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Makefile | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f5d7f41..ae0148b 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -219,12 +219,7 @@ KBUILD_CFLAGS += -Wno-sign-compare
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
-ifdef CONFIG_RETPOLINE
-ifeq ($(RETPOLINE_CFLAGS),)
-  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
-endif
-  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
-endif
+KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
 
 archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
@@ -307,6 +302,13 @@ ifndef CC_HAVE_ASM_GOTO
 	@echo Compiler lacks asm-goto support.
 	@exit 1
 endif
+ifdef CONFIG_RETPOLINE
+ifeq ($(RETPOLINE_CFLAGS),)
+	@echo "You are building kernel with non-retpoline compiler." >&2
+	@echo "Please update your compiler." >&2
+	@false
+endif
+endif
 
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
-- 
2.7.4

