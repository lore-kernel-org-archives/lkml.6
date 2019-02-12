Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B6FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3002921773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yqlGqFFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfBLDqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:46:25 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:53954 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBLDqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 22:46:24 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x1C3j8aH007458;
        Tue, 12 Feb 2019 12:45:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x1C3j8aH007458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549943109;
        bh=qBZd1c9KzcEe6uaLQVppkNCLI29LIZhWS8mr/U0FrbI=;
        h=From:To:Cc:Subject:Date:From;
        b=yqlGqFFcSlVvnI1KWllZ44LJtZUJtfaw+/CSlz8RvVrIRoQYga3eucc+oz829AF26
         f5Q18XuL4+m4TtbIPGM6fN9JraQ1j61JtI0uoGfPKbBSkgjDZ58FuJaDkfgb1SP/ag
         ctr+Oy+9mKsUueoz1bPBiKYzJ63UuH0ts76OEeJZJ0cra0EZKiScf+BZ6s17ORmJPz
         FaSpoxipfjImLYC94coZhKrvZlZjM6u6ZxdWnuOnDyKe8JDV/D1xHKZROSFgjDKD2Y
         md37GqkWzwIpxh5VYEzhOKCaV56bPEsqWebN6u3DkSrTLOWjTef1a5O5GwmR0YPgc7
         +E0F+pTYe+eNw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-efi@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Alistair Strachan <astrachan@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] efi/libstub: refactor cmd_stubcopy
Date:   Tue, 12 Feb 2019 12:44:55 +0900
Message-Id: <1549943095-10956-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It took me a while to understand what is going on in the nested
if-blocks.

Simplify it by removing unneeded code.

  - if_changed automatically adds 'set -e', so any failure in the
    series of commands makes it immediately fail as a whole.
    So, the outer if block is entirely redundant.

  - Since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special
    target"), GNU Make automatically deletes the target on any failure
    in its recipe. The explicit 'rm -f $@' is redundant.

  - surrounding commands with ( ) will spawn a subshell to execute them
    in it, but it is rarely useful to do so.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/firmware/efi/libstub/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d984509..7788e8a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -86,12 +86,13 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 # this time, use objcopy and leave all sections in place.
 #
 quiet_cmd_stubcopy = STUBCPY $@
-      cmd_stubcopy = if $(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<; \
-		     then if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); \
-		     then (echo >&2 "$@: absolute symbol references not allowed in the EFI stub"; \
-			   rm -f $@; /bin/false); 			  \
-		     else $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@; fi	  \
-		     else /bin/false; fi
+      cmd_stubcopy =							\
+	$(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<;		\
+	if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then		\
+		echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
+		/bin/false;						\
+	fi;								\
+	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
 
 #
 # ARM discards the .data section because it disallows r/w data in the
-- 
2.7.4

