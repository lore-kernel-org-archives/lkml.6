Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 910AAC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B39208C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1cpQxlg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B39208C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbeFMGHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:07:46 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:18988 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754416AbeFMGHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:07:44 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w5D67Pp3009146;
        Wed, 13 Jun 2018 15:07:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w5D67Pp3009146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528870047;
        bh=rqLuD5PfJripy9VhqOkUrh6uJgtqzkfQwR7z9zeA/cU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1cpQxlg4PWBQ/JdtIkRQq+9SVSMZstFmDX+F6LcbNstefOcWIl4z5XhgSVvWAgjo0
         xbl5gql01nvYRNSkD/U5vlVegIbjsbKsXFVXxqBC/iSI1bs5wdZ5wzs2JsUlxrAIRf
         ZuiU56KmMZscu7astmLMmccN8AlGmHsH49D851EVdZj6RItmAReEJlksh6jWVlnf8R
         lXXQmWbNhGXoCFN711pRYMGjs9waaSJrPdlUi35mAtrLA1f5UJBpmwd2SsQXKR6m6L
         Bpy0fGkf6PMDqcKJuB7h4svBvIDx0Y5kJJ0ijL9wx0bbBYNLZOJ/0I4yCZby6UUm4L
         SCaB0O5D/TXJw==
X-Nifty-SrcIP: [209.85.213.49]
Received: by mail-vk0-f49.google.com with SMTP id r83-v6so823929vkf.6;
        Tue, 12 Jun 2018 23:07:26 -0700 (PDT)
X-Gm-Message-State: APt69E1gBCybFMks0Y2zJR21+c5v+ItmFwzvtUOLBEAKCO71ad+KxGze
        6jP5Drku/fY05ye6h/6NabE62g02lY8Rv7abvJs=
X-Google-Smtp-Source: ADUXVKKKPV+2U+CCxaPUxUEINLWw6Zoo7ZFBijHe5fcC2oI3FhUsEl7LBCnwe44c3ZAYmWO6mPPPoe4zOaTuUKKJy3A=
X-Received: by 2002:a1f:ba4a:: with SMTP id k71-v6mr2175648vkf.11.1528870045244;
 Tue, 12 Jun 2018 23:07:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 23:06:44
 -0700 (PDT)
In-Reply-To: <20180612003224.3658-3-labbott@redhat.com>
References: <20180612003224.3658-1-labbott@redhat.com> <20180612003224.3658-3-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Jun 2018 15:06:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASB3Jdj3TwWJGmSEsrXWfJX8xcm1ZN2gKwY7P8hReog-w@mail.gmail.com>
Message-ID: <CAK7LNASB3Jdj3TwWJGmSEsrXWfJX8xcm1ZN2gKwY7P8hReog-w@mail.gmail.com>
Subject: Re: [PATCHv4 2/3] kbuild: Introduce build-salt linker section and
 config option
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


2018-06-12 9:32 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> The build id generated from --build-id can be generated in several different
> ways, with the default being the sha1 on the output of the linked file. For
> distributions, it can be useful to make sure this ID is unique, even if the
> actual file contents don't change. The easiest way to do this is to insert
> a section with some data.
>
> Introduce a macro to insert a linker section which will be filled
> with a hex value. This will ensure the build id can be changed just via
> a config option. Users who don't care about this can leave the
> default value and strip the section.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 6 ++++++
>  init/Kconfig                      | 9 +++++++++
>  scripts/module-common.lds.S       | 4 ++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e373e2e10f6a..4af7e683aad2 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -830,6 +830,12 @@
>  #define PERCPU_DECRYPTED_SECTION
>  #endif
>
> +#define        BUILD_SALT                                                      \
> +       . = ALIGN(32);                                                  \
> +       .salt : AT(ADDR(.salt) - LOAD_OFFSET) {                         \
> +         LONG(0xffaa5500);                                             \
> +         . = ALIGN(32);                                                \
> +       } = CONFIG_BUILD_ID_SALT                                        \


What is 0xffaa5500 ?

Is it another salt in addition to CONFIG_BUILD_ID_SALT ?

Or, does it have a special meaning?



>  /*
>   * Default discarded sections.
> diff --git a/init/Kconfig b/init/Kconfig
> index d2b8b2ea097e..eb92ccfe4ecb 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1967,3 +1967,12 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>  # <asm/syscall_wrapper.h>.
>  config ARCH_HAS_SYSCALL_WRAPPER
>         def_bool n
> +
> +config BUILD_ID_SALT
> +       hex "Build ID Salt"
> +       default 0x12345678
> +       help
> +          The build ID is used to link binaries and their debug info. Setting
> +          this option will use the value in the calculation of the build id.
> +          This is mostly useful for distributions which want to ensure the
> +          build is unique between builds. It's safe to leave the default.


If you run "make menuconfig",
you will notice this looks so strange;
"Build ID Salt" is displayed in the top level menu.






> diff --git a/scripts/module-common.lds.S b/scripts/module-common.lds.S
> index d61b9e8678e8..3c8410270ac1 100644
> --- a/scripts/module-common.lds.S
> +++ b/scripts/module-common.lds.S
> @@ -3,6 +3,9 @@
>   * Archs are free to supply their own linker scripts.  ld will
>   * combine them automatically.
>   */
> +
> +#include <asm-generic/vmlinux.lds.h>
> +

You are pulling many macros in <asm-generic/vmlinux.lds.h>
into modules, VDSO, etc.


You also need to touch
arch/*/kernel/vmlinux.lds.S
of all architectures.

This is not so nice.




>  SECTIONS {
>         /DISCARD/ : {
>                 *(.discard)
> @@ -23,4 +26,5 @@ SECTIONS {
>         .init_array             0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
>
>         __jump_table            0 : ALIGN(8) { KEEP(*(__jump_table)) }
> +       BUILD_SALT
>  }
> --
> 2.18.0.rc1



I was playing with a different approach.

Instead of touching linker scripts around,
how about putting the salt into an elfnote?


The compiler puts the build ID
into the '.note.gnu.build-id' section.

So, I guess it is sensible to put
the salt into '.note.*' section as well.


I attached my trial below:


 - I moved 'config BUILD_SALT' to a better location
   so that it will be displayed in the "General setup" menu.

 - I added 'range 0 0xffffffff' to avoid warnings.

 - I renamed the config symbol to CONFIG_BUILD_SALT
   and change the default to 0x0.
   Of course, this is just bike-shed things, though..

 - It looks like 'owner=Linux, type_id=0'
   is already used in VDSO.
   https://github.com/torvalds/linux/blob/v4.17/arch/arm64/kernel/vdso/note.S#L26

   I chose 0x100 for the type id, but it could be a different value


diff --git a/arch/x86/entry/vdso/vdso-note.S b/arch/x86/entry/vdso/vdso-note.S
index 79a071e..7942317 100644
--- a/arch/x86/entry/vdso/vdso-note.S
+++ b/arch/x86/entry/vdso/vdso-note.S
@@ -3,6 +3,7 @@
  * Here we can supply some information useful to userland.
  */

+#include <linux/build-salt.h>
 #include <linux/uts.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
@@ -10,3 +11,5 @@
 ELFNOTE_START(Linux, 0, "a")
        .long LINUX_VERSION_CODE
 ELFNOTE_END
+
+BUILD_SALT
diff --git a/arch/x86/entry/vdso/vdso32/note.S
b/arch/x86/entry/vdso/vdso32/note.S
index 9fd51f2..e78047d 100644
--- a/arch/x86/entry/vdso/vdso32/note.S
+++ b/arch/x86/entry/vdso/vdso32/note.S
@@ -4,6 +4,7 @@
  * Here we can supply some information useful to userland.
  */

+#include <linux/build-salt.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>

@@ -14,6 +15,8 @@ ELFNOTE_START(Linux, 0, "a")
        .long LINUX_VERSION_CODE
 ELFNOTE_END

+BUILD_SALT
+
 #ifdef CONFIG_XEN
 /*
  * Add a special note telling glibc's dynamic linker a fake hardware
diff --git a/include/linux/build-salt.h b/include/linux/build-salt.h
new file mode 100644
index 0000000..66e87c9
--- /dev/null
+++ b/include/linux/build-salt.h
@@ -0,0 +1,20 @@
+#ifndef __BUILD_SALT_H
+#define __BUILD_SALT_H
+
+#include <linux/elfnote.h>
+
+#define LINUX_ELFNOTE_BUILD_SALT       0x100
+
+#ifdef __ASSEMBLER__
+
+#define BUILD_SALT \
+       ELFNOTE(Linux, LINUX_ELFNOTE_BUILD_SALT, .long CONFIG_BUILD_SALT)
+
+#else
+
+#define BUILD_SALT \
+       ELFNOTE32("Linux", LINUX_ELFNOTE_BUILD_SALT, CONFIG_BUILD_SALT)
+
+#endif
+
+#endif /* __BUILD_SALT_H */
diff --git a/init/Kconfig b/init/Kconfig
index d2b8b2e..54b5828 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -92,6 +92,16 @@ config LOCALVERSION_AUTO

          which is done within the script "scripts/setlocalversion".)

+config BUILD_SALT
+       hex "Build ID Salt"
+       default 0x0
+       range 0 0xffffffff
+       help
+          The build ID is used to link binaries and their debug info. Setting
+          this option will use the value in the calculation of the build id.
+          This is mostly useful for distributions which want to ensure the
+          build is unique between builds. It's safe to leave the default.
+
 config HAVE_KERNEL_GZIP
        bool

diff --git a/init/version.c b/init/version.c
index bfb4e3f..ef4012e 100644
--- a/init/version.c
+++ b/init/version.c
@@ -7,6 +7,7 @@
  */

 #include <generated/compile.h>
+#include <linux/build-salt.h>
 #include <linux/export.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
@@ -49,3 +50,5 @@ const char linux_proc_banner[] =
        "%s version %s"
        " (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
        " (" LINUX_COMPILER ") %s\n";
+
+BUILD_SALT;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1663fb1..dc6d714 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2125,10 +2125,13 @@ static int check_modname_len(struct module *mod)
  **/
 static void add_header(struct buffer *b, struct module *mod)
 {
+       buf_printf(b, "#include <linux/build-salt.h>\n");
        buf_printf(b, "#include <linux/module.h>\n");
        buf_printf(b, "#include <linux/vermagic.h>\n");
        buf_printf(b, "#include <linux/compiler.h>\n");
        buf_printf(b, "\n");
+       buf_printf(b, "BUILD_SALT;\n");
+       buf_printf(b, "\n");
        buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
        buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
        buf_printf(b, "\n");




-- 
Best Regards
Masahiro Yamada
