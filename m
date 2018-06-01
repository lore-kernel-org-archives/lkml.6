Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeFAB4z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:56:55 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:63102 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeFAB4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:56:53 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w511umtq029329
X-Nifty-SrcIP: [209.85.217.169]
X-Google-Smtp-Source: ADUXVKJyDu0cp0dnMk4WO84GnPEDNZum3z/vXCCLNbiqQG4WRkU9KDYbN9xm9j6x8/WlZJh+H9sQSq1gLVqw5aPLIO4=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKb9f7Or9z3eBzAUci2teE6ULVjkuqv00O_j3VuowwbJw@mail.gmail.com>
References: <20180531084037.2f8b4c1e@canb.auug.org.au> <CAK7LNAQjVCPwfJ-opUkW3+XTM0uk9PSo3XiyGwCAMKkK05WnxA@mail.gmail.com>
 <CAGXu5jK8OSJXT5eGK=J0msL9kc+fjOxFUyv=5NYbOH8savc5Xw@mail.gmail.com> <CAGXu5jKb9f7Or9z3eBzAUci2teE6ULVjkuqv00O_j3VuowwbJw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 1 Jun 2018 10:56:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASYTVNque5kgq7FnyOSjX4byBsWhfB-0Jy9Fp0ZmpuqYA@mail.gmail.com>
Message-ID: <CAK7LNASYTVNque5kgq7FnyOSjX4byBsWhfB-0Jy9Fp0ZmpuqYA@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the kbuild tree
To: Kees Cook <keescook@chromium.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w511xWkf027671

2018-05-31 12:53 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Wed, May 30, 2018 at 6:26 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, May 30, 2018 at 6:12 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> Hi.
>>> (+CC Kees)
>>>
>>> 2018-05-31 7:40 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
>>>> Hi Masahiro,
>>>>
>>>> After merging the kbuild tree, today's linux-next build (x86_64
>>>> allmodconfig) produced these warnings:
>>>>
>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_workarounds_nphy_rev7':
>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16563:1: warning: the frame size of 3136 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>>>  }
>>>>  ^
>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_workarounds_nphy_rev3':
>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16905:1: warning: the frame size of 2872 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>>>  }
>>>>  ^
>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_cal_txiqlo_nphy':
>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:26033:1: warning: the frame size of 2432 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>>>  }
>>>>  ^
>>>>
>>>> I have no idea what caused these warnings to appear ... nothing in those
>>>> functions looks too bad.
>>>
>>>
>>> This has been triggered by the following commit:
>>>
>>>
>>> commit 0e461945f3504e09b8ecf947b6398adce1287a28
>>> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Date:   Mon May 28 18:22:07 2018 +0900
>>>
>>>     gcc-plugins: allow to enable GCC_PLUGINS for COMPILE_TEST
>>>
>>>
>>>
>>> CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL was previously disabled
>>> for COMPILE_TEST, which is now enabled.
>>
>> Weird -- I do build tests with plugins enabled pretty regularly. I
>> hadn't seen this before. I'll see if I can figure out what the
>> combination is...
>
> Weirdly, I only see this after merging kbuild/for-next into
> next-20180530. (I don't get the warning if I just force the plugins
> on.)


I see this warning on Linus' tree as well
if the plugins are enabled.


Just remove "depends on !COMPILE_TEST", and try allmodconfig.






masahiro@grover:~/ref/linux$ git show --pretty=short
commit 0512e0134582ef85dee77d51aae77dcd1edec495
Merge: dd52cb8 829bc787
Author: Linus Torvalds <torvalds@linux-foundation.org>

    Merge tag 'xfs-4.17-fixes-3' of
git://git.kernel.org/pub/scm/fs/xfs/xfs-linux

masahiro@grover:~/ref/linux$ git diff
diff --git a/arch/Kconfig b/arch/Kconfig
index 75dd23a..7d44cfe 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -410,7 +410,6 @@ config HAVE_GCC_PLUGINS
 menuconfig GCC_PLUGINS
        bool "GCC plugins"
        depends on HAVE_GCC_PLUGINS
-       depends on !COMPILE_TEST
        help
          GCC plugins are loadable modules that provide extra features to the
          compiler. They are useful for runtime instrumentation and
static analysis.
masahiro@grover:~/ref/linux$ make allmodconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --allmodconfig Kconfig
#
# configuration written to .config
#
masahiro@grover:~/ref/linux$ make
drivers/net/wireless/broadcom/brcm80211/brcmsmac/
scripts/kconfig/conf  --syncconfig Kconfig
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
  HYPERCALLS arch/x86/include/generated/asm/xen-hypercalls.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  scripts/basic/bin2c
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  CHK     include/config/kernel.release
  UPD     include/config/kernel.release
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/asm/dma-contiguous.h
  WRAP    arch/x86/include/generated/asm/early_ioremap.h
  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
  WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
  CHK     include/generated/uapi/linux/version.h
  UPD     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
  CC      arch/x86/purgatory/purgatory.o
  AS      arch/x86/purgatory/stack.o
  AS      arch/x86/purgatory/setup-x86_64.o
  CC      arch/x86/purgatory/sha256.o
  AS      arch/x86/purgatory/entry64.o
  CC      arch/x86/purgatory/string.o
  LD      arch/x86/purgatory/purgatory.ro
  BIN2C   arch/x86/purgatory/kexec-purgatory.c
  HOSTCXX -fPIC scripts/gcc-plugins/latent_entropy_plugin.o
  HOSTLLD -shared scripts/gcc-plugins/latent_entropy_plugin.so
  HOSTCXX -fPIC scripts/gcc-plugins/structleak_plugin.o
  HOSTLLD -shared scripts/gcc-plugins/structleak_plugin.so
  GENSEED scripts/gcc-plugins/randomize_layout_seed.h
  HOSTCXX -fPIC scripts/gcc-plugins/randomize_layout_plugin.o
  HOSTLLD -shared scripts/gcc-plugins/randomize_layout_plugin.so
  CC      kernel/bounds.s
  CHK     include/generated/bounds.h
  UPD     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  UPD     include/generated/timeconst.h
  CC      arch/x86/kernel/asm-offsets.s
  CHK     include/generated/asm-offsets.h
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  HOSTCC   /home/masahiro/ref/linux/tools/objtool/fixdep.o
  HOSTLD   /home/masahiro/ref/linux/tools/objtool/fixdep-in.o
  LINK     /home/masahiro/ref/linux/tools/objtool/fixdep
  CC       /home/masahiro/ref/linux/tools/objtool/exec-cmd.o
  CC       /home/masahiro/ref/linux/tools/objtool/help.o
  CC       /home/masahiro/ref/linux/tools/objtool/pager.o
  CC       /home/masahiro/ref/linux/tools/objtool/parse-options.o
  CC       /home/masahiro/ref/linux/tools/objtool/run-command.o
  CC       /home/masahiro/ref/linux/tools/objtool/sigchain.o
  CC       /home/masahiro/ref/linux/tools/objtool/subcmd-config.o
  LD       /home/masahiro/ref/linux/tools/objtool/libsubcmd-in.o
  AR       /home/masahiro/ref/linux/tools/objtool/libsubcmd.a
  CC       /home/masahiro/ref/linux/tools/objtool/arch/x86/decode.o
  LD       /home/masahiro/ref/linux/tools/objtool/arch/x86/objtool-in.o
  CC       /home/masahiro/ref/linux/tools/objtool/builtin-check.o
  CC       /home/masahiro/ref/linux/tools/objtool/builtin-orc.o
  CC       /home/masahiro/ref/linux/tools/objtool/check.o
  CC       /home/masahiro/ref/linux/tools/objtool/orc_gen.o
  CC       /home/masahiro/ref/linux/tools/objtool/orc_dump.o
  CC       /home/masahiro/ref/linux/tools/objtool/elf.o
  CC       /home/masahiro/ref/linux/tools/objtool/special.o
  CC       /home/masahiro/ref/linux/tools/objtool/objtool.o
  CC       /home/masahiro/ref/linux/tools/objtool/libstring.o
  CC       /home/masahiro/ref/linux/tools/objtool/str_error_r.o
  LD       /home/masahiro/ref/linux/tools/objtool/objtool-in.o
  LINK     /home/masahiro/ref/linux/tools/objtool/objtool
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.h
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  YACC    scripts/dtc/dtc-parser.tab.c
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTLD  scripts/dtc/dtc
  HOSTCC  scripts/genksyms/genksyms.o
  YACC    scripts/genksyms/parse.tab.c
  HOSTCC  scripts/genksyms/parse.tab.o
  LEX     scripts/genksyms/lex.lex.c
  YACC    scripts/genksyms/parse.tab.h
  HOSTCC  scripts/genksyms/lex.lex.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  CHK     scripts/mod/devicetable-offsets.h
  UPD     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/selinux/genheaders/genheaders
  HOSTCC  scripts/selinux/mdp/mdp
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/recordmcount
  HOSTCC  scripts/sortextable
  HOSTCC  scripts/asn1_compiler
  HOSTCC  scripts/sign-file
  HOSTCC  scripts/extract-cert
  HOSTCC  scripts/insert-sys-cert
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/ucode_loader.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.o
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In
function ‘wlc_phy_workarounds_nphy_rev7’:
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16563:1:
warning: the frame size of 3128 bytes is larger than 2048 bytes
[-Wframe-larger-than=]
 }
 ^
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In
function ‘wlc_phy_workarounds_nphy_rev3’:
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16905:1:
warning: the frame size of 2800 bytes is larger than 2048 bytes
[-Wframe-larger-than=]
 }
 ^
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In
function ‘wlc_phy_cal_txiqlo_nphy’:
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:26033:1:
warning: the frame size of 2488 bytes is larger than 2048 bytes
[-Wframe-larger-than=]
 }
 ^
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_n.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_events.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.o
  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.o
  LD [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcmsmac.o




> Regardless, I can confirm that CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> trips it. I'll investigate more tomorrow...
>
> -Kees
>
> --
> Kees Cook
> Pixel Security



-- 
Best Regards
Masahiro Yamada
