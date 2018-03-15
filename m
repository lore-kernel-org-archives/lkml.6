Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeCOKFn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:05:43 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:44150 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeCOKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:05:40 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w2FA5J8C031822
X-Nifty-SrcIP: [209.85.217.182]
X-Google-Smtp-Source: AG47ELttvPwAr82SlKW36oqNJXotzFW1fuMjejTUOGlUjKxAq0p8VBT05imuF0FCWdcpeDeFEaf2VEZujfUzO9KZCCw=
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1803141437030.28583@knanqh.ubzr>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
 <1521045861-22418-7-git-send-email-yamada.masahiro@socionext.com> <nycvar.YSQ.7.76.1803141437030.28583@knanqh.ubzr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 15 Mar 2018 19:04:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNATS2CyFVXoN5CrqeVcNBYA09aCmyz3Bm5BZo4VJEvxONQ@mail.gmail.com>
Message-ID: <CAK7LNATS2CyFVXoN5CrqeVcNBYA09aCmyz3Bm5BZo4VJEvxONQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] kbuild: move include/config/ksym/* to include/ksym/*
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-15 3:47 GMT+09:00 Nicolas Pitre <nicolas.pitre@linaro.org>:
> On Thu, 15 Mar 2018, Masahiro Yamada wrote:
>
>> The idea of using fixdep was inspired by Kconfig, but autoksyms
>> is unrelated to Kconfig.  So, I want to get those touched files
>> out of include/config/.  The directory include/ksym/ is removed
>> by "make clean".  We do not need to keep it for external module
>> building.
>
> It could be argued that include/config/ is not strictly containing
> configuration data either and is slightly misleading.

But, slightly related to configuration, IMHO.
At least they carry timestamps that are updated
when kernel configuration is changed.

The difference between include/config/ and include/ksym/ is that
files under include/config/ are necessary for building
external modules (so should be cleaned away by mrproper)
whereas include/ksym/ is unnecessary for external modules
since vmlinux and in-kernel modules do not depend on
external modules.


I wonder if trimming symbols makes sense for external modules.

EXPORT_SYMBOL(_GPL) in external modules are always trimmed
since vmlinux and in-kernel modules never rely on them.

If an external module exports symbols,
it expects they will be used by other external modules.

So, the patch like follows make sense?




kbuild: do not trim symbols in external modules

diff --git a/Makefile b/Makefile
index 0a7bab6..bdf565e 100644
--- a/Makefile
+++ b/Makefile
@@ -998,6 +998,7 @@ autoksyms_recursive: $(vmlinux-deps)
 # (this can be evaluated only once include/config/auto.conf has been included)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
   KBUILD_MODULES := 1
+  export KBUILD_TRIM_UNUSED_KSYMS := 1
 endif

 autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 045971e..3249d5f 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -345,7 +345,7 @@ if_changed_dep = $(if $(strip $(any-prereq)
$(arg-check) ),                  \
        @set -e;                                                             \
        $(cmd_and_fixdep), @:)

-ifndef CONFIG_TRIM_UNUSED_KSYMS
+ifndef KBUILD_TRIM_UNUSED_KSYMS

 cmd_and_fixdep =                                                             \
        $(echo-cmd) $(cmd_$(1));                                             \




> What about moving include/config/ and include/ksym/ under
> include/depfiles/ ? In fact that could even be
> include/generated/depfiles/config/ and include/generated/depfiles/ksym/
> to trim down the top include directory.
>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  .gitignore                  | 1 +
>>  Makefile                    | 2 +-
>>  scripts/Kbuild.include      | 2 +-
>>  scripts/adjust_autoksyms.sh | 2 +-
>>  scripts/basic/fixdep.c      | 8 ++++----
>>  5 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 1be78fd..85bcc26 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -87,6 +87,7 @@ modules.builtin
>>  #
>>  include/config
>>  include/generated
>> +include/ksym
>>  arch/*/include/generated
>>
>>  # stgit generated dirs
>> diff --git a/Makefile b/Makefile
>> index e60b16f..1dab647 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1327,7 +1327,7 @@ endif # CONFIG_MODULES
>>  # make distclean Remove editor backup files, patch leftover files and the like
>>
>>  # Directories & files removed with 'make clean'
>> -CLEAN_DIRS  += $(MODVERDIR)
>> +CLEAN_DIRS  += $(MODVERDIR) include/ksym
>>
>>  # Directories & files removed with 'make mrproper'
>>  MRPROPER_DIRS  += include/config usr/include include/generated          \
>> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
>> index 065324a..045971e 100644
>> --- a/scripts/Kbuild.include
>> +++ b/scripts/Kbuild.include
>> @@ -368,7 +368,7 @@ ksym_dep_filter =                                                            \
>>           $(CPP) $(call flags_nodeps,a_flags) -D__KSYM_DEPS__ $< ;;        \
>>         boot*|build*|cpp_its_S|*cpp_lds_S|dtc|host*|vdso*) : ;;            \
>>         *) echo "Don't know how to preprocess $(1)" >&2; false ;;          \
>> -     esac | tr ";" "\n" | sed -rn 's/^.*=== __KSYM_(.*) ===.*$$/KSYM_\1/p'
>> +     esac | tr ";" "\n" | sed -rn 's/^.*=== __KSYM_(.*) ===.*$$/\1/p'
>>
>>  cmd_and_fixdep =                                                             \
>>       $(echo-cmd) $(cmd_$(1));                                             \
>> diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
>> index a52210b..7bb3618 100755
>> --- a/scripts/adjust_autoksyms.sh
>> +++ b/scripts/adjust_autoksyms.sh
>> @@ -81,7 +81,7 @@ sort "$cur_ksyms_file" "$new_ksyms_file" | uniq -u |
>>  sed -n 's/^#define __KSYM_\(.*\) 1/\1/p' | tr "A-Z_" "a-z/" |
>>  while read sympath; do
>>       if [ -z "$sympath" ]; then continue; fi
>> -     depfile="include/config/ksym/${sympath}.h"
>> +     depfile="include/ksym/${sympath}.h"
>>       mkdir -p "$(dirname "$depfile")"
>>       touch "$depfile"
>>       echo $((count += 1))
>> diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
>> index 449b68c..f387538 100644
>> --- a/scripts/basic/fixdep.c
>> +++ b/scripts/basic/fixdep.c
>> @@ -113,11 +113,11 @@ static void usage(void)
>>  /*
>>   * Print out a dependency path from a symbol name
>>   */
>> -static void print_config(const char *m, int slen)
>> +static void print_dep(const char *m, int slen, const char *dir)
>>  {
>>       int c, i;
>>
>> -     printf("    $(wildcard include/config/");
>> +     printf("    $(wildcard %s/", dir);
>>       for (i = 0; i < slen; i++) {
>>               c = m[i];
>>               if (c == '_')
>> @@ -140,7 +140,7 @@ static void do_extra_deps(void)
>>                       fprintf(stderr, "fixdep: bad data on stdin\n");
>>                       exit(1);
>>               }
>> -             print_config(buf, len - 1);
>> +             print_dep(buf, len - 1, "include/ksym");
>>       }
>>  }
>>
>> @@ -208,7 +208,7 @@ static void use_config(const char *m, int slen)
>>           return;
>>
>>       define_config(m, slen, hash);
>> -     print_config(m, slen);
>> +     print_dep(m, slen, "include/config");
>>  }
>>
>>  /* test if s ends in sub */
>> --
>> 2.7.4
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
