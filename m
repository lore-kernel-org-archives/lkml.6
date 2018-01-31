Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753984AbeAaQfw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:35:52 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34067 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeAaQfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:35:51 -0500
X-Google-Smtp-Source: AH8x225ZH5utYDTG6WzcXp0/fG/+qSJTsWQArQ4zRNQGVnmXPqcdayPELC6t0d1pFBiWQoVJQCal60u/n4kv+a7/2dE=
MIME-Version: 1.0
In-Reply-To: <20180131163312.7144-1-bp@alien8.de>
References: <20180131163312.7144-1-bp@alien8.de>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 31 Jan 2018 08:35:30 -0800
Message-ID: <CALCETrVsZWL7ZDnGMyoN8V4mmL5NO+SARQBV1U2OzrVscMsoig@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/vdso: Remove retpoline flags
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 8:33 AM, Borislav Petkov <bp@alien8.de> wrote:
> From: Borislav Petkov <bp@suse.de>
>
> So this does not fix an existing problem but a hypothetical one. The
> below fires on an old Frankenstein distro kernel and I'm sending it
> only because it is obviously The Right Thing(tm). And in case we change
> things in the vdso in the future and thus manage to generate an indirect
> call for whatever reason...
>
> So on those older vdsos, the compiler can generate indirect calls to the
> retpoline thunks, which manifests itself as:
>
>   /usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../x86_64-suse-linux/bin/ld: arch/x86/vdso/vclock_gettime.o: \
>           relocation R_X86_64_PC32 against undefined symbol `__x86_indirect_thunk_rax' can not be used when \
>           making a shared object; recompile with -fPIC
>   /usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../x86_64-suse-linux/bin/ld: final link failed: Bad value
>   collect2: error: ld returned 1 exit status
>   nm: 'arch/x86/vdso/vdso.so.dbg': No such file
>   objcopy: 'arch/x86/vdso/vdso.so.dbg': No such file
>   make[2]: *** [arch/x86/vdso/vdso.so] Error 1
>   make[1]: *** [arch/x86/vdso] Error 2
>   make[1]: *** Waiting for unfinished jobs....
>
> However, since the vdso is not part of the kernel, it cannot reference
> kernel symbols so we better not build with with retpoline CFLAGS either.
>
> Thus, export RETPOLINE_CFLAGS to the lower level Makefiles so that they
> can be filtered out in vdso's Makefile.

Hmm.  I'm okay with this, but I'd also be okay doing nothing and
figuring out WTF happened if an upstream kernel fails to build like
this.

--Andy
