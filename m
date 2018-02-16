Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2250gvomXg+yT06yn8T7sPLquCz3YkDTc4M2lSfoY6hM5GOiL0UNBwTo56jsRjiAl5ZoZERz
ARC-Seal: i=1; a=rsa-sha256; t=1518806395; cv=none;
        d=google.com; s=arc-20160816;
        b=aQdzqNQAH4crpF0F7hXtWMxHbEd/lKbn5yxkvZXX1yzbU57EP/LZAhT8WvDRyq4I3H
         rqJyvtbJEcBl2gLU8DuPdIUafMbz9Ai9UAr9l4lqEe1RTQCoQYLTo8RRqLT7mFGLgG9s
         nWrAQxQt/qKOAdmdzNml1SSZ621No2PPwg0ByQhQXTWD2gWgIycC/gNt7ULTpCh3jbn8
         MI9HKSXKr1M2y0IFU3c+1jPqzIROen4MQAL+3jfDItOXR6zvhG0mwA95wW+lYjUdTnje
         bwR62GLxO34+br6yJoFHmalXe3KV7bK8Zw6WVg3r6H1AaIbjOvETyU0wMen3Ij41bfGt
         BGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=5E3V+lniGkXthizHMXYirjjRQ8c47R+TtsbPm2hC14Y=;
        b=SsM5WHVpG/Srxzz5+SaCG0JG90pv0lioCppDA5rnCEQ1+M1KuZ2f1G7eX0quzUy+ch
         1z6QWJK/ckpYHe0hW+IJsEudkJkrNUrYM8Wv1+Gptazw3iA3u6JXB0JWIU8Zh4HpmfCo
         PbE2J8skVNrGNwTL9O7hp4fSHtYs63b/NbO5uqxUcQE2OX24QMnK8j/f3UH2cbEfI9AP
         ss+J7mFP/q4wHSE1+KL+57NJwQ+xkMcDcgxIK3Gu1DRqMEJ7DGmBOtbtCGvYMvYcNRxS
         vOqT8zBuDbELdG7z9s1SXksV1s9innL1lbwhnPwB+oibska+I3wHc7cligQjQLGLc1f+
         6FgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=oJRN23ux;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=oJRN23ux;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTL013418
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/23] gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT
Date: Sat, 17 Feb 2018 03:38:46 +0900
Message-Id: <1518806331-7101-19-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935598072219?=
X-GMAIL-MSGID: =?utf-8?q?1592583935598072219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

CONFIG_GCOV_FORMAT_AUTODETECT compiles either gcc_3_4.c or gcc_4_7.c
according to your GCC version.

We can achieve the equivalent behavior by setting reasonable default
in the 'choice' with the knowledge of the compiler version.

Users are still allowed to change it if they need to do so.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 kernel/gcov/Kconfig  | 18 ++++++------------
 kernel/gcov/Makefile |  2 --
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 1276aab..c56bee7 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -53,20 +53,14 @@ config GCOV_PROFILE_ALL
 choice
 	prompt "Specify GCOV format"
 	depends on GCOV_KERNEL
-	default GCOV_FORMAT_AUTODETECT
+	default GCOV_FORMAT_3_4 if CC_IS_GCC && GCC_VERSION < 40700
+	default GCOV_FORMAT_4_7
 	---help---
-	The gcov format is usually determined by the GCC version, but there are
+	The gcov format is usually determined by the GCC version, and the
+	default is chosen according to your GCC version. However, there are
 	exceptions where format changes are integrated in lower-version GCCs.
-	In such a case use this option to adjust the format used in the kernel
-	accordingly.
-
-	If unsure, choose "Autodetect".
-
-config GCOV_FORMAT_AUTODETECT
-	bool "Autodetect"
-	---help---
-	Select this option to use the format that corresponds to your GCC
-	version.
+	In such a case, change this option to adjust the format used in the
+	kernel accordingly.
 
 config GCOV_FORMAT_3_4
 	bool "GCC 3.4 format"
diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index c6c50e5..ff06d64 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -4,5 +4,3 @@ ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 obj-y := base.o fs.o
 obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_3_4.o
 obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_4_7.o
-obj-$(CONFIG_GCOV_FORMAT_AUTODETECT) += $(call cc-ifversion, -lt, 0407, \
-							gcc_3_4.o, gcc_4_7.o)
-- 
2.7.4
