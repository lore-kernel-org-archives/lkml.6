Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033367AbeCARTM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:19:12 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54090 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032995AbeCARTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:19:11 -0500
X-Google-Smtp-Source: AG47ELutWBPFvxI0+Y/HHfsyCnx5h0YfHSPUKUFxSqVe0nHvt+EJJEFNuHzl9VDbiAhWO+TSZjHz5g==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: will.deacon@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] scripts/kallsyms: filter arm64's __efistub_ symbols
Date: Thu,  1 Mar 2018 17:19:01 +0000
Message-Id: <20180301171901.1134-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, the EFI stub and the kernel proper are essentially the same
binary, although the EFI stub executes at a different virtual address
as the kernel. For this reason, the EFI stub is restricted in the
symbols it can link to, which is ensured by prefixing all EFI stub
symbols with __efistub_ (and emitting __efistub_ prefixed aliases for
routines that may be shared between the core kernel and the stub)

These symbols are leaking into kallsyms, polluting the namespace, so
let's filter them explicitly.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/kallsyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 9ee9bf7fd1a2..1dd24c5b9b47 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -221,6 +221,7 @@ static int symbol_valid(struct sym_entry *s)
 
 	static char *special_prefixes[] = {
 		"__crc_",		/* modversions */
+		"__efistub_",		/* arm64 EFI stub namespace */
 		NULL };
 
 	static char *special_suffixes[] = {
-- 
2.11.0
