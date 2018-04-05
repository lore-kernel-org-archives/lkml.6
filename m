Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeDEFOy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 01:14:54 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:38003 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeDEFOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 01:14:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w355EQ9D023382
X-Nifty-SrcIP: [209.85.217.179]
X-Google-Smtp-Source: AIpwx4837JrLpIoutE5lR+4ZwDeOk3yWUxT7hrkzxTsMgCszwOFxQC0kQwPwEWhNaBtpJLMW61goxY5ZEw3YSEKfGq8=
MIME-Version: 1.0
In-Reply-To: <20180329004805.7278-2-labbott@redhat.com>
References: <20180329004805.7278-1-labbott@redhat.com> <20180329004805.7278-2-labbott@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 5 Apr 2018 14:13:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNbgwN1B9ER0b3QyUn6iC3YiwhgnsPpZ-geW8YJuFB4A@mail.gmail.com>
Message-ID: <CAK7LNAQNbgwN1B9ER0b3QyUn6iC3YiwhgnsPpZ-geW8YJuFB4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: Support HOSTLDFLAGS
To: Laura Abbott <labbott@redhat.com>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-29 9:48 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> In addition to HOSTCFLAGS, there's HOSTLDFLAGS. Ensure these get passed to
> calls to build host binaries.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  scripts/Makefile.host      | 6 +++---
>  tools/build/Makefile.build | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index e6dc6ae2d7c4..a3a0e2282a56 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -84,7 +84,7 @@ hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
>  # Create executable from a single .c file
>  # host-csingle -> Executable
>  quiet_cmd_host-csingle         = HOSTCC  $@
> -      cmd_host-csingle = $(HOSTCC) $(hostc_flags) -o $@ $< \
> +      cmd_host-csingle = $(HOSTCC) $(HOSTLDFLAGS) $(hostc_flags) -o $@ $< \
>                 $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
>  $(host-csingle): $(obj)/%: $(src)/%.c FORCE
>         $(call if_changed_dep,host-csingle)


This hunk is correct, but Robin posted this.
https://patchwork.kernel.org/patch/10243073/

Somehow it fell into a crack, and I missed to pick it up.
I will apply it lately.




> @@ -102,7 +102,7 @@ $(call multi_depend, $(host-cmulti), , -objs)
>  # Create .o file from a single .c file
>  # host-cobjs -> .o
>  quiet_cmd_host-cobjs   = HOSTCC  $@
> -      cmd_host-cobjs   = $(HOSTCC) $(hostc_flags) -c -o $@ $<
> +      cmd_host-cobjs   = $(HOSTCC) $(HOSTLDFLAGS) $(hostc_flags) -c -o $@ $<
>  $(host-cobjs): $(obj)/%.o: $(src)/%.c FORCE
>         $(call if_changed_dep,host-cobjs)
>

This does not involve the link stage.
You should not do this.


> @@ -126,7 +126,7 @@ $(host-cxxobjs): $(obj)/%.o: $(src)/%.cc FORCE
>  # Compile .c file, create position independent .o file
>  # host-cshobjs -> .o
>  quiet_cmd_host-cshobjs = HOSTCC  -fPIC $@
> -      cmd_host-cshobjs = $(HOSTCC) $(hostc_flags) -fPIC -c -o $@ $<
> +      cmd_host-cshobjs = $(HOSTCC) $(HOSTLDFLAGS) $(hostc_flags) -fPIC -c -o $@ $<
>  $(host-cshobjs): $(obj)/%.o: $(src)/%.c FORCE
>         $(call if_changed_dep,host-cshobjs)
>
> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index cd72016c3cfa..cab55f0d90e1 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
> @@ -64,7 +64,7 @@ quiet_cmd_cc_o_c = CC       $@
>        cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
>
>  quiet_cmd_host_cc_o_c = HOSTCC   $@
> -      cmd_host_cc_o_c = $(HOSTCC) $(host_c_flags) -c -o $@ $<
> +      cmd_host_cc_o_c = $(HOSTCC) $(HOSTLDFLAGS) $(host_c_flags) -c -o $@ $<
>
>  quiet_cmd_cxx_o_c = CXX      $@
>        cmd_cxx_o_c = $(CXX) $(cxx_flags) -c -o $@ $<



-- 
Best Regards
Masahiro Yamada
