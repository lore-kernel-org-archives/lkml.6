Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeDDWi5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 18:38:57 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53044 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeDDWiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 18:38:55 -0400
Date: Wed, 4 Apr 2018 23:38:44 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jinbum Park <jinb.park7@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: decompressor: mark error() as __noreturn
Message-ID: <20180404223843.GL16141@n2100.armlinux.org.uk>
References: <20180404123117.3575773-1-arnd@arndb.de>
 <CAGXu5jK1abgzQCJ+9ysTZHvxPo4vG6dfwPFs_CuXdP=0_Qib_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jK1abgzQCJ+9ysTZHvxPo4vG6dfwPFs_CuXdP=0_Qib_g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 03:34:06PM -0700, Kees Cook wrote:
> On Wed, Apr 4, 2018 at 5:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > gcc complains about fortify_panic() possibly returning:
> >
> > arch/arm/boot/compressed/misc.c: In function 'fortify_panic':
> > arch/arm/boot/compressed/misc.c:167:1: error: 'noreturn' function does return [-Werror]
> >
> > This annotates the error() function as __noreturn, which lets gcc
> > see in all configurations that it fortify_panic() cannot return either.
> >
> > Fixes: ee333554fed5 ("ARM: 8749/1: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Kees Cook <keescook@chromium.org>

I'd actually prefer a more robust solution to this - error() is used
in different files, each with their own separate prototype, which is
error-prone.  The same goes for a few other variables.  The following
is IMHO a more complete (and thus larger) patch:

 arch/arm/boot/compressed/decompress.c |  5 +----
 arch/arm/boot/compressed/misc.c       |  2 +-
 arch/arm/boot/compressed/misc.h       | 10 ++++++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index a2ac3fe7dbf8..c16c1829a5e4 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -6,10 +6,7 @@
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/linkage.h>
 #include <asm/string.h>
-
-extern unsigned long free_mem_ptr;
-extern unsigned long free_mem_end_ptr;
-extern void error(char *);
+#include "misc.h"
 
 #define STATIC static
 #define STATIC_RW_DATA	/* non-static please */
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index a3ded2a64b32..e94c84dded6c 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -22,9 +22,9 @@ unsigned int __machine_arch_type;
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>
 #include <linux/linkage.h>
+#include "misc.h"
 
 static void putstr(const char *ptr);
-extern void error(char *x);
 
 #include CONFIG_UNCOMPRESS_INCLUDE
 
diff --git a/arch/arm/boot/compressed/misc.h b/arch/arm/boot/compressed/misc.h
new file mode 100644
index 000000000000..c958dccd1d97
--- /dev/null
+++ b/arch/arm/boot/compressed/misc.h
@@ -0,0 +1,10 @@
+#ifndef MISC_H
+#define MISC_H
+
+#include <linux/compiler.h>
+
+void error(char *x) __noreturn;
+extern unsigned long free_mem_ptr;
+extern unsigned long free_mem_end_ptr;
+
+#endif


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
