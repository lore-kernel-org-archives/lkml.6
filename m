Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4F9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487352082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vsks0E3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487352082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbeLDLJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:09:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbeLDLJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:09:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37E2214E0;
        Tue,  4 Dec 2018 11:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921759;
        bh=T6XfOrwrjQ4num1BT5tVLSkgpdHfU1XVLnoo+kGxywI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vsks0E3RNAPyP/cAH1q9vcNnSTTOFODJg3L+5o5hwyHXST2xv94GQVMtcM5MeMkNJ
         cJ9PtNup1cPhci2tlnz0vKPb1bZGZOh3mr+mHHcxk9KPdk0oCXUbpGwPNEDgwj+Rzc
         MhfKXhlLuZTMzD4eG3NQ9VJgKLuzGG7mhrR7yFog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 49/50] efi/libstub: Make file I/O chunking x86-specific
Date:   Tue,  4 Dec 2018 11:50:44 +0100
Message-Id: <20181204103716.938039643@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

(commit b3879a4d3a31ef14265a52e8d941cf4b0f6627ae upstream)

The ARM decompressor is finicky when it comes to uninitialized variables
with local linkage, the reason being that it may relocate .text and .bss
independently when executing from ROM. This is only possible if all
references into .bss from .text are absolute, and this happens to be the
case for references emitted under -fpic to symbols with external linkage,
and so all .bss references must involve symbols with external linkage.

When building the ARM stub using clang, the initialized local variable
__chunk_size is optimized into a zero-initialized flag that indicates
whether chunking is in effect or not. This flag is therefore emitted into
.bss, which triggers the ARM decompressor's diagnostics, resulting in a
failed build.

Under UEFI, we never execute the decompressor from ROM, so the diagnostic
makes little sense here. But we can easily work around the issue by making
__chunk_size global instead.

However, given that the file I/O chunking that is controlled by the
__chunk_size variable is intended to work around known bugs on various
x86 implementations of UEFI, we can simply make the chunking an x86
specific feature. This is an improvement by itself, and also removes the
need to parse the efi= options in the stub entirely.

Tested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/1486380166-31868-8-git-send-email-ard.biesheuvel@linaro.org
[ Small readability edits. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -356,6 +356,14 @@ efi_status_t efi_parse_options(char *cmd
 	char *str;
 
 	/*
+	 * Currently, the only efi= option we look for is 'nochunk', which
+	 * is intended to work around known issues on certain x86 UEFI
+	 * versions. So ignore for now on other architectures.
+	 */
+	if (!IS_ENABLED(CONFIG_X86))
+		return EFI_SUCCESS;
+
+	/*
 	 * If no EFI parameters were specified on the cmdline we've got
 	 * nothing to do.
 	 */
@@ -528,7 +536,8 @@ efi_status_t handle_cmdline_files(efi_sy
 			size = files[j].size;
 			while (size) {
 				unsigned long chunksize;
-				if (size > __chunk_size)
+
+				if (IS_ENABLED(CONFIG_X86) && size > __chunk_size)
 					chunksize = __chunk_size;
 				else
 					chunksize = size;


