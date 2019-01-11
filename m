Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB266C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCAE21848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217614;
	bh=3g1YrHdmxRqgIqe0so8HDrP8m/88VBxhENFa8T5tnvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZUTOwnSbxSkpELbwQm4dys8SCLBC++HMB28fc4qqy9yBxV0P0VigdLLSlfiezK3Ng
	 le2gAkLt4VUtBgr05zI6n/2679aLmcZNGXdFo0UTF3H/XgxhuuzCmbxNaWCPPtCzmI
	 JJM4dPP9LaRhESa3TdZ/BZAwPtkstVAuTixiiL4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391186AbfAKOkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403847AbfAKOkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51803206B6;
        Fri, 11 Jan 2019 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217610;
        bh=3g1YrHdmxRqgIqe0so8HDrP8m/88VBxhENFa8T5tnvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhLonGdq6aoSLIXS06ESnNLTwE1rjSOfdC+J5jK9r4UyqqWaMtoGjd5RXFKuzvUup
         AlvzVwirDZbKaeTiojxMo1b6j78/cBY1gQU/RDhc7+mZez5qHiMk0CkC3lGr0Rfpdz
         N/cRwP9AT0616g9KgA6u+5zk6gkzPmq4vP++eNtg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 125/148] arm64: drop linker script hack to hide __efistub_ symbols
Date:   Fri, 11 Jan 2019 15:15:03 +0100
Message-Id: <20190111131119.249039125@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit dd6846d774693bfa27d7db4dae5ea67dfe373fa1 upstream.

Commit 1212f7a16af4 ("scripts/kallsyms: filter arm64's __efistub_
symbols") updated the kallsyms code to filter out symbols with
the __efistub_ prefix explicitly, so we no longer require the
hack in our linker script to emit them as absolute symbols.

Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/image.h |   46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -76,16 +76,6 @@
 __efistub_stext_offset = stext - _text;
 
 /*
- * Prevent the symbol aliases below from being emitted into the kallsyms
- * table, by forcing them to be absolute symbols (which are conveniently
- * ignored by scripts/kallsyms) rather than section relative symbols.
- * The distinction is only relevant for partial linking, and only for symbols
- * that are defined within a section declaration (which is not the case for
- * the definitions below) so the resulting values will be identical.
- */
-#define KALLSYMS_HIDE(sym)	ABSOLUTE(sym)
-
-/*
  * The EFI stub has its own symbol namespace prefixed by __efistub_, to
  * isolate it from the kernel proper. The following symbols are legally
  * accessed by the stub, so provide some aliases to make them accessible.
@@ -94,28 +84,28 @@ __efistub_stext_offset = stext - _text;
  * linked at. The routines below are all implemented in assembler in a
  * position independent manner
  */
-__efistub_memcmp		= KALLSYMS_HIDE(__pi_memcmp);
-__efistub_memchr		= KALLSYMS_HIDE(__pi_memchr);
-__efistub_memcpy		= KALLSYMS_HIDE(__pi_memcpy);
-__efistub_memmove		= KALLSYMS_HIDE(__pi_memmove);
-__efistub_memset		= KALLSYMS_HIDE(__pi_memset);
-__efistub_strlen		= KALLSYMS_HIDE(__pi_strlen);
-__efistub_strnlen		= KALLSYMS_HIDE(__pi_strnlen);
-__efistub_strcmp		= KALLSYMS_HIDE(__pi_strcmp);
-__efistub_strncmp		= KALLSYMS_HIDE(__pi_strncmp);
-__efistub_strrchr		= KALLSYMS_HIDE(__pi_strrchr);
-__efistub___flush_dcache_area	= KALLSYMS_HIDE(__pi___flush_dcache_area);
+__efistub_memcmp		= __pi_memcmp;
+__efistub_memchr		= __pi_memchr;
+__efistub_memcpy		= __pi_memcpy;
+__efistub_memmove		= __pi_memmove;
+__efistub_memset		= __pi_memset;
+__efistub_strlen		= __pi_strlen;
+__efistub_strnlen		= __pi_strnlen;
+__efistub_strcmp		= __pi_strcmp;
+__efistub_strncmp		= __pi_strncmp;
+__efistub_strrchr		= __pi_strrchr;
+__efistub___flush_dcache_area	= __pi___flush_dcache_area;
 
 #ifdef CONFIG_KASAN
-__efistub___memcpy		= KALLSYMS_HIDE(__pi_memcpy);
-__efistub___memmove		= KALLSYMS_HIDE(__pi_memmove);
-__efistub___memset		= KALLSYMS_HIDE(__pi_memset);
+__efistub___memcpy		= __pi_memcpy;
+__efistub___memmove		= __pi_memmove;
+__efistub___memset		= __pi_memset;
 #endif
 
-__efistub__text			= KALLSYMS_HIDE(_text);
-__efistub__end			= KALLSYMS_HIDE(_end);
-__efistub__edata		= KALLSYMS_HIDE(_edata);
-__efistub_screen_info		= KALLSYMS_HIDE(screen_info);
+__efistub__text			= _text;
+__efistub__end			= _end;
+__efistub__edata		= _edata;
+__efistub_screen_info		= screen_info;
 
 #endif
 


