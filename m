Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx49CwDvPrtN7SuxJi3MXQAyUXYP1I8afGTeTLOTy8NKCJ3lhDvDW7PQAT8+SF7OCXt/Mn4Ny
ARC-Seal: i=1; a=rsa-sha256; t=1522204891; cv=none;
        d=google.com; s=arc-20160816;
        b=CCauI111/VlIf4wdjW1SQekO8ZU2WN9u4M1T66BiGWE2DjKXQTwZ/F9ElZFE04KExf
         WzCfEojfZ1RH0T46kGAV14Z4FdOoE1Mu5VQQdml0LmNxGrpLifOUwta55hZRXd1wBtBS
         2tDmXSEApSY+m1L0g6iWFlufsJBs3H5Ig9d0vmxEV+oeoAVWXMVKV0YMnEhvMkysxpT2
         NiW9pb2Jub7itLjjVISBC3D8YaRIz7MiHuSG3bW3NPs/hqrzkVkiVGdUZkBsmgk1tf7T
         B1yO0081ypoRLkh0LA2ZORYXSBLBZz2ut9gtc2oZhEWFfRzS56nzW4hVcmF/wGH7anv4
         KUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=0Dp1mlhyYDRpM7kJ+Ob7WMnEy9c71BC4++MPu7gB1m0=;
        b=CUz1/0ohLNwzWlsP/KxDQmw6UxB20RYPIyHYjp+82AdcOgzmddQHeCKRu0qS6CJvOn
         1vpF/5WEawpaRPTfO+WFsxvNlHjN2dmrbn6JxFIlk/HtlJhmbclLFql6z5YngPsJRigo
         x3Xn2NNStLHGIbBG+gu9FJoAQgqrN02WFkNx/NtAlyF+bvcocK1HeK+Pj7DQbYatw+4W
         sxlulT7HE492ZeXJOpNxla7kJhvxkcgokoDqXMxDrpXmBaZ/btpDtqyM/naGBQlmF43l
         PJyoZRJVNhfs89skEhZPPd5BtccSgpVFvRLY7lRkgmq7uoUByIEopaJ7mIN2O/Dtwx8O
         RM5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=DQQauHjj;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.75 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=DQQauHjj;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.75 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w2S2ex0Q003268
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] kbuild: move <linux/compiler_types.h> out of <linux/kconfig.h>
Date: Wed, 28 Mar 2018 11:40:48 +0900
Message-Id: <1522204848-11803-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596147516031704256?=
X-GMAIL-MSGID: =?utf-8?q?1596147516031704256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since commit 28128c61e08e ("kconfig.h: Include compiler types to avoid
missed struct attributes"), <linux/kconfig.h> pulls in kernel-space
headers to unrelated file.

Commit 0f9da844d877 ("MIPS: boot: Define __ASSEMBLY__ for its.S build")
suppressed the build error by defining __ASSEMBLY__, but ITS (i.e. DTS)
is not assembly, and should not include <linux/compiler_types.h> in the
first place.

Looking at arch/s390/tools/Makefile, host programs gen_facilities and
gen_opcode_table now pull in <linux/compiler_types.h> as well.

The motivation for that commit was to define necessary attributes
before any struct is defined.  Obviously, this happens only in C.

It is enough to include <linux/compiler_types.h> only when compiling
C files, and only when compiling kernel space.

Move the <linux/compiler_types.h> inclusion to c_flags.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I will also send a correct fix-up for MIPS Makefile later.



 include/linux/kconfig.h | 3 ---
 scripts/Makefile.lib    | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index dcde947..cc8fa10 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -70,7 +70,4 @@
  */
 #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
 
-/* Make sure we always have all types and struct attributes defined. */
-#include <linux/compiler_types.h>
-
 #endif /* __LINUX_KCONFIG_H */
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index c114ce5..07d0740 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -152,6 +152,7 @@ __cpp_flags     = $(call flags,_cpp_flags)
 endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
+		 -include $(srctree)/include/linux/compiler_types.h       \
 		 $(__c_flags) $(modkern_cflags)                           \
 		 $(basename_flags) $(modname_flags)
 
-- 
2.7.4
