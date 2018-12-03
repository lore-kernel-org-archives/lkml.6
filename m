Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E09CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E966120672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UosMbsE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E966120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbeLCHvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:51:46 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:60222 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeLCHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:51:45 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB37p4O4009296;
        Mon, 3 Dec 2018 16:51:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB37p4O4009296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543823466;
        bh=Vb/3OPGyTEOlXKRrpP3pR6+EXfznXh75TNXsZGFgG5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UosMbsE9r86oY8zuhVPhKXTYvfuO+KGkDW/MfMF0ZL9Fg6V9k67jxJz4J4UHniaMg
         ZyDwApNHqd+KjJvC2okGlAIzRY9gfsrToRdiunxTuVd8xGQdvOMsoOHmP0bJbdIo7k
         7fZ1Mxn9+AogTfDLbtaZOoyD2hUbAzN+rEBcHsxsb93b7HHrS0CoQ7j4kXO2mTHrBG
         /YY0VqtAly3JGbW9jAuX/c38ef6mEQMdy3xHi3v18Vcl1/5XmZ100ewlpGCZrfee0V
         EtjmsQezg7LvUKzgOsHXV818M71ZKxIDMqI0hnBXCIESHca099DjRKjUj5KzNmABQ2
         KLhuUAOPzp0uw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] microblaze: move "... is ready" message to arch/microblaze/Makefile
Date:   Mon,  3 Dec 2018 16:50:53 +0900
Message-Id: <1543823457-32478-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for more fixes, move this to arch/microblaze/Makefile.
Otherwise, the same "... is ready" would be printed multiple times.

(Another solution would be, to remove these messages entirely unless
people persist with them.)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/microblaze/Makefile      | 2 ++
 arch/microblaze/boot/Makefile | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 97e1384..cfd7bfca 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -81,9 +81,11 @@ archclean:
 
 linux.bin linux.bin.gz linux.bin.ub: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
 simpleImage.%: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
 define archhelp
   echo '* linux.bin    - Create raw binary'
diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index e8684a2..c2579a7 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -9,15 +9,12 @@ OBJCOPYFLAGS := -R .note -R .comment -R .note.gnu.build-id -O binary
 
 $(obj)/linux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
-	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
 
 $(obj)/linux.bin.ub: $(obj)/linux.bin FORCE
 	$(call if_changed,uimage)
-	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
 
 $(obj)/linux.bin.gz: $(obj)/linux.bin FORCE
 	$(call if_changed,gzip)
-	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
 
 quiet_cmd_cp = CP      $< $@$2
 	cmd_cp = cat $< >$@$2 || (rm -f $@ && echo false)
@@ -35,6 +32,5 @@ $(obj)/simpleImage.%: vmlinux FORCE
 	$(call if_changed,objcopy)
 	$(call if_changed,uimage)
 	$(call if_changed,strip,.strip)
-	@echo 'Kernel: $(UIMAGE_OUT) is ready' ' (#'`cat .version`')'
 
 clean-files += simpleImage.*
-- 
2.7.4

