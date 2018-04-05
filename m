Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeDEUbd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:31:33 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:47220 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbeDEUb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:31:27 -0400
Date: Thu, 5 Apr 2018 22:31:21 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [PATCH 0/8] use struct pt_regs based syscall calling for x86-64
Message-ID: <20180405203121.GA27104@light.dominikbrodowski.net>
References: <20180405095307.3730-1-linux@dominikbrodowski.net>
 <20180405151933.egmt7ressx2ikdnr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405151933.egmt7ressx2ikdnr@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 05:19:33PM +0200, Ingo Molnar wrote:
> Ok, this series looks mostly good to me, but AFAICS this breaks the UML build:
> 
>  make[2]: *** No rule to make target 'archheaders'.  Stop.
>  arch/um/Makefile:119: recipe for target 'archheaders' failed
>  make[1]: *** [archheaders] Error 2
>  make[1]: *** Waiting for unfinished jobs....

Ah, that's caused by patch 8/8 which I did and do not like all that much
anyway: UML re-uses syscall_64.tbl which now has x86-specific entries like
__sys_x86_pread64, but expects the generic syscall stub sys_pread64
referenced there. Fixup patch below; could be folded with patch 8/8. Or
patch 8/8 could simply be dropped from the series altogether...

Thanks,
	Dominik

--------------------------------------------------------------------------
>From f5049ea4e1e5e7751e72a22cbc1b3a9389959a04 Mon Sep 17 00:00:00 2001
From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Thu, 5 Apr 2018 22:16:23 +0200
Subject: [PATCH] syscalls/x86: fix UML syscall table

To differentiate the different calling regime used on x86, the syscall
functions received __sys_x86_ as prefix (instead of sys_). This breaks
the build of UML on 64-bit x86, as it re-uses the same syscall table.

To fix this, replace the __sys_x86_ prefix with sys_ during the generation
of <asm/syscalls_64.h>.

Fixes: syscalls/x86: rename struct pt_regs-based sys_*() to __sys_x86_*()
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index d71ef4bd3615..d6376b87ecb2 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -20,17 +20,47 @@ syscall_macro() {
     echo "__SYSCALL_${abi}($nr, $real_entry, $qualifier)"
 }
 
-emit() {
+emit64() {
     abi="$1"
     nr="$2"
     entry="$3"
     compat="$4"
 
-    if [ "$abi" = "64" -a -n "$compat" ]; then
+    if [ "$abi" = "I386" ]; then
+	echo "emit64() called for a 32-bit syscall" >&2
+	exit 1
+    fi
+
+    if [ -n "$compat" ]; then
 	echo "a compat entry for a 64-bit syscall makes no sense" >&2
 	exit 1
     fi
 
+    if [ -n "$entry" ]; then
+	# For CONFIG_UML, we need to strip the __sys_x86 prefix
+	if [ "${entry}" = "${entry#__compat_sys}" ]; then
+            umlentry="sys${entry#__sys_x86}"
+	fi
+
+	echo "#ifdef CONFIG_X86"
+	syscall_macro "$abi" "$nr" "$entry"
+	echo "#else /* CONFIG_UML */"
+	syscall_macro "$abi" "$nr" "$umlentry"
+	echo "#endif"
+    fi
+}
+
+emit32() {
+    abi="$1"
+    nr="$2"
+    entry="$3"
+    compat="$4"
+
+    if [ "$abi" = "64" ]; then
+	echo "emit32() called for a 64-bit syscall" >&2
+	exit 1
+    fi
+
     if [ -z "$compat" ]; then
 	if [ -n "$entry" ]; then
 	    syscall_macro "$abi" "$nr" "$entry"
@@ -53,14 +83,14 @@ grep '^[0-9]' "$in" | sort -n | (
 	    # COMMON is the same as 64, except that we don't expect X32
 	    # programs to use it.  Our expectation has nothing to do with
 	    # any generated code, so treat them the same.
-	    emit 64 "$nr" "$entry" "$compat"
+	    emit64 64 "$nr" "$entry" "$compat"
 	elif [ "$abi" = "X32" ]; then
 	    # X32 is equivalent to 64 on an X32-compatible kernel.
 	    echo "#ifdef CONFIG_X86_X32_ABI"
-	    emit 64 "$nr" "$entry" "$compat"
+	    emit64 64 "$nr" "$entry" "$compat"
 	    echo "#endif"
 	elif [ "$abi" = "I386" ]; then
-	    emit "$abi" "$nr" "$entry" "$compat"
+	    emit32 "$abi" "$nr" "$entry" "$compat"
 	else
 	    echo "Unknown abi $abi" >&2
 	    exit 1
