Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeFERET (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752004AbeFEREP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:04:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <mmarek@suse.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 32/37] Kbuild: change CC_OPTIMIZE_FOR_SIZE definition
Date: Tue,  5 Jun 2018 19:01:37 +0200
Message-Id: <20180605170110.766880991@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 877417e6ffb9578e8580abf76a71e15732473456 upstream.

CC_OPTIMIZE_FOR_SIZE disables the often useful -Wmaybe-unused warning,
because that causes a ridiculous amount of false positives when combined
with -Os.

This means a lot of warnings don't show up in testing by the developers
that should see them with an 'allmodconfig' kernel that has
CC_OPTIMIZE_FOR_SIZE enabled, but only later in randconfig builds
that don't.

This changes the Kconfig logic around CC_OPTIMIZE_FOR_SIZE to make
it a 'choice' statement defaulting to CC_OPTIMIZE_FOR_PERFORMANCE
that gets added for this purpose. The allmodconfig and allyesconfig
kernels now default to -O2 with the maybe-unused warning enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Michal Marek <mmarek@suse.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 init/Kconfig |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1308,6 +1308,17 @@ source "usr/Kconfig"
 
 endif
 
+choice
+	prompt "Compiler optimization level"
+	default CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
+
+config CC_OPTIMIZE_FOR_PERFORMANCE
+	bool "Optimize for performance"
+	help
+	  This is the default optimization level for the kernel, building
+	  with the "-O2" compiler flag for best performance and most
+	  helpful compile-time warnings.
+
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size"
 	help
@@ -1316,6 +1327,8 @@ config CC_OPTIMIZE_FOR_SIZE
 
 	  If unsure, say N.
 
+endchoice
+
 config SYSCTL
 	bool
 
