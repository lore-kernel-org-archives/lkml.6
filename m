Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B16C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15562075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="coBYb5DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15562075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937558AbeFSJpu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:45:50 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:64680 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937535AbeFSJpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:45:46 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w5J9i6pw002346;
        Tue, 19 Jun 2018 18:44:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w5J9i6pw002346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529401448;
        bh=YqGuGS0XS1b867FvtzcfzHY5JWMqL5TunvKY9jcybc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=coBYb5DVM0jfM1dKnYjhiWWAouHbey6Fs0puHoWAuuL017jeNf9gdY+8mmJvjjxnx
         7IYqe3uykgSgJJVLZ0TQpGjZpO0Lue2TUB7ZQTJGId8rNls/8/5Gc2/d//Tgq0T832
         kiCFO2SjuYWTavMOB9n79YhQ88RrcHHDyKA0mSWMyqwDJOE8qT095PQaeKR+SiEDmt
         vmyp4SPaBGa/E01FBmACbnW65q7otYhw7M7FZB1dk3XfHZIGR6YudJGSHwZck07kPL
         rj6ChxtjYKG4xtQTIdoFhRE/wIxjQxZh9EPfLykhSmimIJzM/J8IjuANuPADh8gyxo
         dFBVN5Jn4De2w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "kexec: purgatory: add clean-up for purgatory directory"
Date:   Tue, 19 Jun 2018 18:43:41 +0900
Message-Id: <1529401422-28838-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529401422-28838-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529401422-28838-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b0108f9e93d0d39050eaa11358852f349bdccb71.

Commit b0108f9e93d0 ("kexec: purgatory: add clean-up for purgatory
directory") stated that the kexec-purgatory.c and purgatory.ro files
were not removed after make mrproper.

In fact, they are.  You can confirm it after reverting it.

  $ make mrproper
  $ touch arch/x86/purgatory/kexec-purgatory.c
  $ touch arch/x86/purgatory/purgatory.ro
  $ make mrproper
    CLEAN   arch/x86/purgatory
  $ ls arch/x86/purgatory/
  entry64.S  Makefile  purgatory.c  setup-x86_64.S  stack.S  string.c

This is obvious from the build system point of view.

arch/x86/Makefile adds 'arch/x86' to core-y.
Hence 'make clean' descends like this:

  arch/x86/Kbuild
    -> arch/x86/purgatory/Makefile

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f0a6ea2..246a979 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -327,7 +327,6 @@ archclean:
 	$(Q)rm -rf $(objtree)/arch/x86_64
 	$(Q)$(MAKE) $(clean)=$(boot)
 	$(Q)$(MAKE) $(clean)=arch/x86/tools
-	$(Q)$(MAKE) $(clean)=arch/x86/purgatory
 
 define archhelp
   echo  '* bzImage      - Compressed kernel image (arch/x86/boot/bzImage)'
-- 
2.7.4

