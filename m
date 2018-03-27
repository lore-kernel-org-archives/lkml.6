Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELsHGBsqvX1Q0mzsjcQ9C2avNhVmUiWDEhym9KX/CvEnP/udqgItgSqHqA8dhrskMi9gADp5
ARC-Seal: i=1; a=rsa-sha256; t=1522128625; cv=none;
        d=google.com; s=arc-20160816;
        b=iWySTA34lAKy6ltsp+FKMKmKDowrtQldjRpFjDvdrtFN2Og4QPDT2P1YCVVKD0hghV
         uK8WBBOeJc7dhfFOXnW6oL/CgyjB6TSl6R0mSY4dICemOAxGlxf3zqKVBjvYvmnPZc/b
         ofzBMxhiavY7wMNmF5RN/0btyibDA0zgZrL6waM09KurLGyv2WwQLMvJIw+W2KOBcYaM
         gdmnRyLMTxWlG2kuue5srov5bxyHz23GHWyvthn3srBVYiHVLSmZeYQQNp4O4/FUNF1k
         g4wjfb3i9koKvuT+Hp7eXeDEZpWPDCVH5Icze1gL4NrCPqLvW5CH8OmocswVt2TBPsI+
         suIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=+KtcYTB0i2G/+6IMyIjcZZUASKlIoX6zrXACCTEjvdQ=;
        b=lOAD6pIYo1jOK2hrBt5Zm9zvIYAOPFleoPeAFHo05mL8+S/HK200QUPC6aajD4ZmK5
         bFedEDT5y3t0+buawVxldAxImbUNo+w/uxsvj+Z2SD1338UkokJVZ0Z6GO5g12LXkMZZ
         hTb885VuJffIDfjJSxpYavq13TiwjplDvMWmeNREQc+GFgIcb1EiYsCXIwDr2NkpYvfS
         VM2vcVT8G+cXx3uYSvwfeKi8121A/JIBJI8IGLmJgxfgV+fjLGMAo91IWRPjNw0tfwwm
         i1nMzXNccEpwYn5qPWyS42/Ewmcj/QxH7gH6SY9w3SxG/3R74wZ2Txrm6++YxQ4Fv/hq
         +LEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=qdNilvxk;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=qdNilvxk;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaM0011947
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/21] gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT
Date: Tue, 27 Mar 2018 14:29:29 +0900
Message-Id: <1522128575-5326-16-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545713412850?=
X-GMAIL-MSGID: =?utf-8?q?1596067545713412850?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

CONFIG_GCOV_FORMAT_AUTODETECT compiles either gcc_3_4.c or gcc_4_7.c
according to your GCC version.

We can achieve the equivalent behavior by setting reasonable dependency
with the knowledge of the compiler version.

If GCC older than 4.7 is used, GCOV_FORMAT_3_4 is the default, but users
are still allowed to select GCOV_FORMAT_4_7 in case the newer format is
back-ported.

On the other hand, If GCC 4.7 or newer is used, there is no reason to
use GCOV_FORMAT_3_4, so it should be hidden.

If you down-grade your compiler GCC 4.7 or older, oldconfig/syncconfig
will display a prompt for the choice because GCOV_FORMAT_3_4 becomes
visible as a new symbol.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Move the 'depends on' to the choice value.

 kernel/gcov/Kconfig  | 17 +++++------------
 kernel/gcov/Makefile |  2 --
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 1276aab..1e3823f 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -53,23 +53,16 @@ config GCOV_PROFILE_ALL
 choice
 	prompt "Specify GCOV format"
 	depends on GCOV_KERNEL
-	default GCOV_FORMAT_AUTODETECT
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
+	depends on CC_IS_GCC && GCC_VERSION < 40700
 	---help---
 	Select this option to use the format defined by GCC 3.4.
 
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
