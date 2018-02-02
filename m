Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeBBLsA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 06:48:00 -0500
Received: from terminus.zytor.com ([65.50.211.136]:46857 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeBBLrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 06:47:53 -0500
Date: Fri, 2 Feb 2018 03:46:41 -0800
From: tip-bot for David Woodhouse <tipbot@zytor.com>
Message-ID: <tip-66f793099a636862a71c59d4a6ba91387b155e0c@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, dwmw@amazon.co.uk, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1517484441-1420-2-git-send-email-dwmw@amazon.co.uk>
References: <1517484441-1420-2-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/retpoline: Avoid retpolines for built-in __init
 functions
Git-Commit-ID: 66f793099a636862a71c59d4a6ba91387b155e0c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  66f793099a636862a71c59d4a6ba91387b155e0c
Gitweb:     https://git.kernel.org/tip/66f793099a636862a71c59d4a6ba91387b155e0c
Author:     David Woodhouse <dwmw@amazon.co.uk>
AuthorDate: Thu, 1 Feb 2018 11:27:20 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 2 Feb 2018 12:28:27 +0100

x86/retpoline: Avoid retpolines for built-in __init functions

There's no point in building init code with retpolines, since it runs before
any potentially hostile userspace does. And before the retpoline is actually
ALTERNATIVEd into place, for much of it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: karahmed@amazon.de
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517484441-1420-2-git-send-email-dwmw@amazon.co.uk

---
 include/linux/init.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index ea1b311..506a981 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -5,6 +5,13 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
+/* Built-in __init functions needn't be compiled with retpoline */
+#if defined(RETPOLINE) && !defined(MODULE)
+#define __noretpoline __attribute__((indirect_branch("keep")))
+#else
+#define __noretpoline
+#endif
+
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
  * as `initialization' functions. The kernel can take this
@@ -40,7 +47,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold  __latent_entropy
+#define __init		__section(.init.text) __cold  __latent_entropy __noretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
