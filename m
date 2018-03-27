Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELsT4M9y5MThPjCzVp6lqS9wiFQhr6op5l9o1ThnyOOittBUaAUU8bVFa1KUma+SBHDbNJhM
ARC-Seal: i=1; a=rsa-sha256; t=1522128618; cv=none;
        d=google.com; s=arc-20160816;
        b=G5HjdoJzhDN45/L8+n0ADK4mVqXVCoqtRwKCH1RKw4rMJ9xT6tSF4IggCCU6J1pkVd
         AnS2fgh+HrNeN0PXu0mgs24G8fLcdBB01It3ZfWfJU2D5sTRsTQvsO9SQTIw5up3Sgkh
         KrAn/3Mn/0ImE5aL5H8a+RXH6cUe/djRiZO6snTwrp9udG6aBMiBetef7PupLonyA9XS
         T1kOtl5NvIu7nRAbFXo43S0htOgcUl1e8qZFpUTCL99znUF19spZvUGkEIx31a0Kj6fr
         S5sb5AGPeIUKAcBkjZhahU0GgQVsZSUDgeWSiTkwm39bOYK6pf2ChD7q7Hpam6dMf8Pk
         ApjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=BEYy2YpsCxousWjhVu3n83TSZ8fZI9tGa32wUXYJQxE=;
        b=SuTCrab9Y/mcjgFFfQKtsWlB0zJOiJmaoI1LFSfOWjJGRnUqTsABt9ntJhhuFIQxst
         tZyZw4H3AxSw8/Yu+u8vcxNdRajJgRQ7asjyuQsskHQ5Adchax1Zl7ntZmhAzl/CYA8I
         YHdXYijjsUe1IM7NWEfPGCkLck16sxVTYtQH1pbboqzEqYm/5JC9ndLf5GzFXAN5mjNv
         yzxAROhhUepixZW6qvhSxB0F2n89ZQXHC2Za2BsXr8O9p034t+5fOAWStxCPs6GX0iIK
         IX2dGp2cWeSxyPKOy1mizdPpzQuMErK+mksA8qPf4NDsZs/zjiNHrv76UsPZKCwfaumI
         yzRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=oBpSn+rE;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=oBpSn+rE;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLk011947
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/21] kbuild: remove kbuild cache
Date: Tue, 27 Mar 2018 14:29:15 +0900
Message-Id: <1522128575-5326-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538031163827?=
X-GMAIL-MSGID: =?utf-8?q?1596067538031163827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kbuild cache was introduced to remember the result of shell
commands, some of which are expensive to compute, such as
$(call cc-option,...).

However, this turned out not so clever as I had first expected.
Actually, it is problematic.  For example, "$(CC) -print-file-name"
is cached.  If the compiler is updated, the stale search path causes
build error, which is difficult to figure out.  Another problem
scenario is cache files could be touched while install targets are
running under the root permission.  We can patch them if desired,
but the build infrastructure is getting uglier and uglier.

Now, we are going to move compiler flag tests to the configuration
phase.  If this is completed, the result of compiler tests will be
naturally cached in the .config file.  We will not have performance
issues of incremental building since this testing only happens at
Kconfig time.

To start this work with a cleaner code base, remove the kbuild
cache first.

Revert the following commits:
Commit 9a234a2e3843 ("kbuild: create directory for make cache only when necessary")
Commit e17c400ae194 ("kbuild: shrink .cache.mk when it exceeds 1000 lines")
Commit 4e56207130ed ("kbuild: Cache a few more calls to the compiler")
Commit 3298b690b21c ("kbuild: Add a cache for generated variables")

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 Makefile               |   5 +--
 scripts/Kbuild.include | 101 +++++++------------------------------------------
 2 files changed, 16 insertions(+), 90 deletions(-)

diff --git a/Makefile b/Makefile
index ff62b8e..c55cf95 100644
--- a/Makefile
+++ b/Makefile
@@ -656,7 +656,7 @@ KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
 
 # check for 'asm goto'
-ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
+ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
 	KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
 	KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
 endif
@@ -811,7 +811,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-fdata-sections,)
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
-NOSTDINC_FLAGS += -nostdinc -isystem $(call shell-cached,$(CC) -print-file-name=include)
+NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
 
 # warn about C99 declaration after statement
@@ -1615,7 +1615,6 @@ clean: $(clean-dirs)
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
 		-o -name modules.builtin -o -name '.tmp_*.o.*' \
-		-o -name .cache.mk \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \) -type f -print | xargs rm -f
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index cce31ee..9f7eb10 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -8,8 +8,6 @@ squote  := '
 empty   :=
 space   := $(empty) $(empty)
 space_escape := _-_SPACE_-_
-right_paren := )
-left_paren := (
 
 ###
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
@@ -82,71 +80,6 @@ cc-cross-prefix =  \
 			echo $(c);                                    \
 		fi)))
 
-# Tools for caching Makefile variables that are "expensive" to compute.
-#
-# Here we want to help deal with variables that take a long time to compute
-# by making it easy to store these variables in a cache.
-#
-# The canonical example here is testing for compiler flags.  On a simple system
-# each call to the compiler takes 10 ms, but on a system with a compiler that's
-# called through various wrappers it can take upwards of 100 ms.  If we have
-# 100 calls to the compiler this can take 1 second (on a simple system) or 10
-# seconds (on a complicated system).
-#
-# The "cache" will be in Makefile syntax and can be directly included.
-# Any time we try to reference a variable that's not in the cache we'll
-# calculate it and store it in the cache for next time.
-
-# Include values from last time
-make-cache := $(if $(KBUILD_EXTMOD),$(KBUILD_EXTMOD)/,$(if $(obj),$(obj)/)).cache.mk
-$(make-cache): ;
--include $(make-cache)
-
-cached-data := $(filter __cached_%, $(.VARIABLES))
-
-# If cache exceeds 1000 lines, shrink it down to 500.
-ifneq ($(word 1000,$(cached-data)),)
-$(shell tail -n 500 $(make-cache) > $(make-cache).tmp; \
-	mv $(make-cache).tmp $(make-cache))
-endif
-
-create-cache-dir := $(if $(KBUILD_SRC),$(if $(cache-data),,1))
-
-# Usage: $(call __sanitize-opt,Hello=Hola$(comma)Goodbye Adios)
-#
-# Convert all '$', ')', '(', '\', '=', ' ', ',', ':' to '_'
-__sanitize-opt = $(subst $$,_,$(subst $(right_paren),_,$(subst $(left_paren),_,$(subst \,_,$(subst =,_,$(subst $(space),_,$(subst $(comma),_,$(subst :,_,$(1)))))))))
-
-# Usage:   $(call shell-cached,shell_command)
-# Example: $(call shell-cached,md5sum /usr/bin/gcc)
-#
-# If we've already seen a call to this exact shell command (even in a
-# previous invocation of make!) we'll return the value.  If not, we'll
-# compute it and store the result for future runs.
-#
-# This is a bit of voodoo, but basic explanation is that if the variable
-# was undefined then we'll evaluate the shell command and store the result
-# into the variable.  We'll then store that value in the cache and finally
-# output the value.
-#
-# NOTE: The $$(2) here isn't actually a parameter to __run-and-store.  We
-# happen to know that the caller will have their shell command in $(2) so the
-# result of "call"ing this will produce a reference to that $(2).  The reason
-# for this strangeness is to avoid an extra level of eval (and escaping) of
-# $(2).
-define __run-and-store
-ifeq ($(origin $(1)),undefined)
-  $$(eval $(1) := $$(shell $$(2)))
-ifeq ($(create-cache-dir),1)
-  $$(shell mkdir -p $(dir $(make-cache)))
-  $$(eval create-cache-dir :=)
-endif
-  $$(shell echo '$(1) := $$($(1))' >> $(make-cache))
-endif
-endef
-__shell-cached = $(eval $(call __run-and-store,$(1)))$($(1))
-shell-cached = $(call __shell-cached,__cached_$(call __sanitize-opt,$(1)),$(1))
-
 # output directory for tests below
 TMPOUT := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)
 
@@ -154,36 +87,30 @@ TMPOUT := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)
 # Usage: option = $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwise)
 # Exit code chooses option. "$$TMP" serves as a temporary file and is
 # automatically cleaned up.
-__try-run = set -e;			\
+try-run = $(shell set -e;		\
 	TMP="$(TMPOUT).$$$$.tmp";	\
 	TMPO="$(TMPOUT).$$$$.o";	\
 	if ($(1)) >/dev/null 2>&1;	\
 	then echo "$(2)";		\
 	else echo "$(3)";		\
 	fi;				\
-	rm -f "$$TMP" "$$TMPO"
-
-try-run = $(shell $(__try-run))
-
-# try-run-cached
-# This works like try-run, but the result is cached.
-try-run-cached = $(call shell-cached,$(__try-run))
+	rm -f "$$TMP" "$$TMPO")
 
 # as-option
 # Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
-as-option = $(call try-run-cached,\
+as-option = $(call try-run,\
 	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
 # Usage: cflags-y += $(call as-instr,instr,option1,option2)
 
-as-instr = $(call try-run-cached,\
+as-instr = $(call try-run,\
 	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
 
 # __cc-option
 # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
-__cc-option = $(call try-run-cached,\
+__cc-option = $(call try-run,\
 	$(1) -Werror $(2) $(3) -c -x c /dev/null -o "$$TMP",$(3),$(4))
 
 # Do not attempt to build with gcc plugins during cc-option tests.
@@ -203,23 +130,23 @@ hostcc-option = $(call __cc-option, $(HOSTCC),\
 
 # cc-option-yn
 # Usage: flag := $(call cc-option-yn,-march=winchip-c6)
-cc-option-yn = $(call try-run-cached,\
+cc-option-yn = $(call try-run,\
 	$(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",y,n)
 
 # cc-disable-warning
 # Usage: cflags-y += $(call cc-disable-warning,unused-but-set-variable)
-cc-disable-warning = $(call try-run-cached,\
+cc-disable-warning = $(call try-run,\
 	$(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 
 # cc-name
 # Expands to either gcc or clang
-cc-name = $(call shell-cached,$(CC) -v 2>&1 | grep -q "clang version" && echo clang || echo gcc)
+cc-name = $(shell $(CC) -v 2>&1 | grep -q "clang version" && echo clang || echo gcc)
 
 # cc-version
-cc-version = $(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
+cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
 
 # cc-fullversion
-cc-fullversion = $(call shell-cached,$(CONFIG_SHELL) \
+cc-fullversion = $(shell $(CONFIG_SHELL) \
 	$(srctree)/scripts/gcc-version.sh -p $(CC))
 
 # cc-ifversion
@@ -232,21 +159,21 @@ cc-if-fullversion = $(shell [ $(cc-fullversion) $(1) $(2) ] && echo $(3) || echo
 
 # cc-ldoption
 # Usage: ldflags += $(call cc-ldoption, -Wl$(comma)--hash-style=both)
-cc-ldoption = $(call try-run-cached,\
+cc-ldoption = $(call try-run,\
 	$(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
 
 # ld-option
 # Usage: LDFLAGS += $(call ld-option, -X)
-ld-option = $(call try-run-cached, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
+ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
 # Important: no spaces around options
-ar-option = $(call try-run-cached, $(AR) rc$(1) "$$TMP",$(1),$(2))
+ar-option = $(call try-run, $(AR) rc$(1) "$$TMP",$(1),$(2))
 
 # ld-version
 # Note this is mainly for HJ Lu's 3 number binutil versions
-ld-version = $(call shell-cached,$(LD) --version | $(srctree)/scripts/ld-version.sh)
+ld-version = $(shell $(LD) --version | $(srctree)/scripts/ld-version.sh)
 
 # ld-ifversion
 # Usage:  $(call ld-ifversion, -ge, 22252, y)
-- 
2.7.4
