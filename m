Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeFELiG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:38:06 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeFELiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:38:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: mark native_set_p4d() as __always_inline
Date: Tue,  5 Jun 2018 13:35:15 +0200
Message-Id: <20180605113715.1133726-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:3jiT0AcdXGPwkDX3jDsLr/EUaq2di6XVid1sscnP79ubIgD1TEz
 hfShsJahlNLz9J5KXRedWG5xmyBo7qgtNAvWtVxqC7mOn15sdGwY7OILoHeUBjjMnIwE1V7
 bgKndQmJIzbMkX5V2wKhDIo7Wl8SfFVlzzAOwBmDBR4TW9MaTWvp5KwkfnsBUaCiGv0FPEi
 FoTWZ1yzZyj/HdK7llY/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lw3GqVoN2cE=:OjvoOqHmW0xtAO7w/xQMCj
 qQrkKpGLFPX3r9pOQ4zCw8FsjOb/DrbXrp7qix5qo7XD9hv7FO8wCAxdfZykUTq1gcUE0maEj
 mB1i87UvM/l5HpoWO9hukfSYECWl3/jcX2ltJ8YS/2qzCtL0GGXbIcoJCyl4GszokuFR/Zu6P
 o8d9BkP45UOlOc+jsPWlOzjLPechYK4eqJIkDtouDb3k0ZyFr2ksVdk64scj0E+RAfZ1lQx2d
 15nI54qe73Iq4XeKH+w614oucWB9xLtIWErRi0jHIu+8Akufm1k62toR33n6kcCrqVY+ZQIt1
 E0vOPL7nDFO4Ytz6sAAVtFazN8XCcrGGxk0GwqsITWp6IcZXvqzny2X4Jmnj0oZ5NjKC8XWe8
 TJD/PKEQu7QfGIUoHmfTTbme9QJne0UF/6JlxWIBGPLqxvQABfscMDWcQUXUt1L+4rrTf6oYi
 pLsmWrlEqXE2rJtJR66LS0r3GsP7mleqZnXncRriKQ/LKJjJj49sHwEazUm73IkMnvu7xYH86
 VysoOYqiDPaFJB0oFnQgagkl0gk9inF9NdEJa4KTe0ej9XAdhWhsQVHRFW06xS1+hpBrhJNNR
 RMhs5k2ivfZrrw36d+PwJuKiKh7IOch6pzKX7QZqnLy2LIiKgEzU12oZzYGYGnVRAupvmEt+m
 XVP0K6dLJRt3QMOnfIvkGnhnXcP7tAIq9kf6LV32gKeLv1N/NirjALLHcLbA2BdxF7do=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OPTIMIZE_INLINING is enabled, the function native_set_p4d()
may not be fully inlined into the caller, resulting in a false-positive
warning about an access to the __pgtable_l5_enabled variable from a
non-__init function, despite the original caller being an __init function:

WARNING: vmlinux.o(.text.unlikely+0x1429): Section mismatch in reference from the function native_set_p4d() to the variable .init.data:__pgtable_l5_enabled
WARNING: vmlinux.o(.text.unlikely+0x1429): Section mismatch in reference from the function native_p4d_clear() to the variable .init.data:__pgtable_l5_enabled
The function native_set_p4d() references
the variable __initdata __pgtable_l5_enabled.
This is often because native_set_p4d lacks a __initdata
annotation or the annotation of __pgtable_l5_enabled is wrong.

Marking the native_set_p4d function and its caller native_p4d_clear()
avoids this problem.

I did not bisect the original cause, but I assume this is related to
the recent rework that turned pgtable_l5_enabled() into an inline
function, which in turn caused the compiler to make different inlining
decisions.

Fixes: ad3fe525b950 ("x86/mm: Unify pgtable_l5_enabled usage in early boot code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/pgtable_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 3c5385f9a88f..0fdcd21dadbd 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -216,7 +216,7 @@ static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
 }
 #endif
 
-static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
+static __always_inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
 
@@ -230,7 +230,7 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 	*p4dp = native_make_p4d(native_pgd_val(pgd));
 }
 
-static inline void native_p4d_clear(p4d_t *p4d)
+static __always_inline void native_p4d_clear(p4d_t *p4d)
 {
 	native_set_p4d(p4d, native_make_p4d(0));
 }
-- 
2.9.0
