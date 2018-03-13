Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbeCMMxd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:53:33 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33391 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeCMMxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:53:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: fix undefined reference to 'printk'
Date: Tue, 13 Mar 2018 13:52:36 +0100
Message-Id: <20180313125309.3662792-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <CAKv+Gu-6s1tqBzAEgL63WxXrc9SuF2C9PtADqmEcUKWxP8eZUw@mail.gmail.com>
References: <CAKv+Gu-6s1tqBzAEgL63WxXrc9SuF2C9PtADqmEcUKWxP8eZUw@mail.gmail.com>
X-Provags-ID: V03:K0:20BptMwLZiFxFPC0ASmnMSPN35mCbHrTvO/+zyLhAE43Sf9K0Jd
 MsRbXhWtsYe7YmXb6bUyiEY6l1sUr9y6X+n3A9klSgQMMxGS+VPJwAnOKfQ8n8xVU/Q38TZ
 GbGg5yPPc+/Lo02re/3AqSNLy9sjGkZO0Z6BZLP1/my1EoidVNf52hSVNJtx51R6TKTqyEv
 AkKgcfiQ4E5CP6jFovXQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1tq1ARxm9NQ=:VT2DFcvOg1G29ioQ2IFx9+
 b+PNXtOFJQcSlqvYtzZ9MMKcDtC0G0cWnMHtf93ZZhJcZPzJVgp40aRp1LtLzTXMfZhmvFMQS
 6dn2Cu1FmK3ozHriC6suuaIw0DIpRK+VzendHBfkr/Za83NDD5cYzn6GTWOXdMlXW5jBKe2af
 14Z9EMuAuK42lKJwTLLKr4LeYGESwouqo7TLYEHgTf9Fg0NW3tEYY3SXnPxNIVBpgUGQfAnZD
 JSDwpKVyQWVFXegYbfNUGm+kOckm+y8JNr7pEZXM0lpkEAKIPBUFEw8g9QZhOM8pOsURII4M8
 ALrwwR/96GZfIMhO+s1R3R2+h0M7sAohnKMn5mOoryhOvEnYM0IdU5sa8EfRBJIfTs5oI5T2t
 i7LHhLl+c1dC80EJ51xXw82B2U6xTHSoiCrJ1K2ps5GXm19TwZhRJ5v3NGd0GEU9N70FfUPzu
 YM+mYro0RBdYENMMZuPnt2zXY+yv5nxjOkGlZo5JJI46//PoTYZHIJYkYqYzQqFExMcEYaZFh
 pGBX01EgTMxOs4X5LPA69cKRRuq7//EQOj0LR5YZoLw5ap+Beox7fwC69Z7K0XThOMd5BLE/w
 t54rRay/7fE+R1fSGdjJ5UwAeyKOe7ttgT1yheF+Q1zB8mUvqNQpY/Klf9wZYoWrLJQjjo8+J
 afUM2MuEQuXuH/7hQm3ymOa2fu+yw/9ZkJWXZPrhqRXy/akk7URoZEi+APhymG953fettt4GO
 UwMGME96dtYcdzUk/iN4uvTRXlqtfOLXaFJ2Bg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk symbol was intended as a generic address that is always
exported, however that turned out to be false with CONFIG_PRINTK=n:

ERROR: "printk" [arch/arm64/kernel/arm64-reloc-test.ko] undefined!

This changes the references to memstart_addr, which should be there
regardless of configuration.

Fixes: a257e02579e4 ("arm64/kernel: don't ban ADRP to work around Cortex-A53 erratum #843419")
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix changelog as pointed out by Ard

 arch/arm64/kernel/reloc_test_core.c | 2 +-
 arch/arm64/kernel/reloc_test_syms.S | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/reloc_test_core.c b/arch/arm64/kernel/reloc_test_core.c
index a70489c584c7..5915ce5759cc 100644
--- a/arch/arm64/kernel/reloc_test_core.c
+++ b/arch/arm64/kernel/reloc_test_core.c
@@ -45,7 +45,7 @@ static struct {
 	{ "R_AARCH64_MOVW_SABS_Gn",	signed_movw, UL(SYM64_ABS_VAL) },
 	{ "R_AARCH64_MOVW_UABS_Gn",	unsigned_movw, UL(SYM64_ABS_VAL) },
 	{ "R_AARCH64_ADR_PREL_PG_HI21",	relative_adrp, (u64)&sym64_rel },
-	{ "R_AARCH64_ADR_PREL_PG_HI21",	relative_adrp_far, (u64)&printk },
+	{ "R_AARCH64_ADR_PREL_PG_HI21",	relative_adrp_far, (u64)&memstart_addr },
 	{ "R_AARCH64_ADR_PREL_LO21",	relative_adr, (u64)&sym64_rel },
 	{ "R_AARCH64_PREL64",		relative_data64, (u64)&sym64_rel },
 	{ "R_AARCH64_PREL32",		relative_data32, (u64)&sym64_rel },
diff --git a/arch/arm64/kernel/reloc_test_syms.S b/arch/arm64/kernel/reloc_test_syms.S
index f333b4b7880d..2b8d9cb8b078 100644
--- a/arch/arm64/kernel/reloc_test_syms.S
+++ b/arch/arm64/kernel/reloc_test_syms.S
@@ -54,8 +54,8 @@ ENDPROC(relative_adrp)
 	.align	12
 	.space	0xffc
 ENTRY(relative_adrp_far)
-	adrp	x0, printk
-	add	x0, x0, #:lo12:printk
+	adrp	x0, memstart_addr
+	add	x0, x0, #:lo12:memstart_addr
 	ret
 ENDPROC(relative_adrp_far)
 
-- 
2.9.0
