Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D8FC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A7D205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4ARci1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A7D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJMA4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:56:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42441 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeJMA4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:56:45 -0400
Received: by mail-ot1-f65.google.com with SMTP id c23so11300821otl.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wLKvl0AMOy211XIbhuy21uB9bAp6ZKu9unCjjQ3yyUI=;
        b=C4ARci1kFfc3/rfjF0x1e0ufiYTtC2lKGgdX5beckbYcGRwWHKf+NvFKEdD3p2UMPG
         1JkK0owu8CqlVHfVd0YGAropoGapEostI4DFgJdtPwLTnOTrw2YR1Cws9DdsW2UVT3xD
         Lr81eTF9fOH6pY4fyXkswc5kcqwF0Vjk48UerMcuiVJ7I0a/wSbiIyCLoL7uEXdg+1Tr
         8kyJWtPg16iYLn0yEmjOjhx/XiA8Vp1JzVnUauOU/C1+B42q4u87FcrtVk2w10AvyI1w
         8SEYIR948FPYnuYHmfIQXeDMvmtsRFQOPL886SqTh3RY0gkRDDlJjiKAUDZsSL01hQNq
         HEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wLKvl0AMOy211XIbhuy21uB9bAp6ZKu9unCjjQ3yyUI=;
        b=eMueC8W7M48F4vA8TRgMxehX6eygJlCzTUJALcZzc/4zRmpkNtAG5fO70GtO0KXkn0
         h1qrW4V7FEORTg990/9WEHsAVvH+z4gVG1hVLIGJSS34XpoCR8ftNNqq6lfRIpxbC7cB
         uoB0ibXnVBckbi7eOHyrS/WFuzICDiNvG6bm6SE0jCstE4nGbjtVcOUeScoumwaBlOvN
         ks/gpNvrKSAtR+u8ot89baQ7qyXZoqU+e29IO12odtKrAs1WGZyOlX2zGVv5rAGynKf6
         PvSDTHLwx2QFawccHrrYyx1d1qSRzv2VtKFzQJT2ci+Sf0MCGVDXEQ4kw57eZ3MFcpte
         UYJw==
X-Gm-Message-State: ABuFfoiqLngscBBSk298M5uLaGP/6VySm2vop0hafSOzEHADXxCq6Ztu
        ZBL54E2EUr/cpEFvD+ll9HwDil1VlFxPLeNvbt9VeQ==
X-Google-Smtp-Source: ACcGV60PkhpBQ9N0KEOWQw25NDWusszaBDeeUba7G0l1oTS3N17uWcAsHUE/xmkdkP7VobGrZo4KJsFOoorspDpj9e4=
X-Received: by 2002:a9d:49ac:: with SMTP id g44mr4664190otf.198.1539364993786;
 Fri, 12 Oct 2018 10:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-2-rick.p.edgecombe@intel.com> <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
 <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
In-Reply-To: <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 19:22:46 +0200
Message-ID: <CAG48ez0XfGFAWDYa75COMPCsKqqGfBFOtcNuGD4_dubGf2YeAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
To:     rick.p.edgecombe@intel.com
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, jeyu@kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-s390 <linux-s390@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 7:04 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> On Fri, 2018-10-12 at 02:35 +0200, Jann Horn wrote:
> > On Fri, Oct 12, 2018 at 1:40 AM Rick Edgecombe
> > <rick.p.edgecombe@intel.com> wrote:
> > > This introduces a new rlimit, RLIMIT_MODSPACE, which limits the amoun=
t of
> > > module space a user can use. The intention is to be able to limit mod=
ule
> > > space
> > > allocations that may come from un-privlidged users inserting e/BPF fi=
lters.
> >
> > Note that in some configurations (iirc e.g. the default Ubuntu
> > config), normal users can use the subuid mechanism (the /etc/subuid
> > config file and the /usr/bin/newuidmap setuid helper) to gain access
> > to 65536 UIDs, which means that in such a configuration,
> > RLIMIT_MODSPACE*65537 is the actual limit for one user. (Same thing
> > applies to RLIMIT_MEMLOCK.)
> Ah, that is a problem. There is only room for about 130,000 filters on x8=
6 with
> KASLR, so it couldn't really be set small enough.
>
> I'll have to look into what this is. Thanks for pointing it out.
>
> > Also, it is probably possible to waste a few times as much virtual
> > memory as permitted by the limit by deliberately fragmenting virtual
> > memory?
> Good point. I guess if the first point can be addressed somehow, this one=
 could
> maybe be solved by just picking a lower limit.
>
> Any thoughts on if instead of all this there was just a system wide limit=
 on BPF
> JIT module space usage?

That does sound more robust to me. And at least on systems that don't
compile out the BPF interpreter, everything should be more or less
fine then...

> > > There is unfortunately no cross platform place to perform this accoun=
ting
> > > during allocation in the module space, so instead two helpers are cre=
ated to
> > > be
> > > inserted into the various arch=E2=80=99s that implement module_alloc.=
 These
> > > helpers perform the checks and help with tracking. The intention is t=
hat
> > > they
> > > an be added to the various arch=E2=80=99s as easily as possible.
> >
> > nit: s/an/can/
> >
> > [...]
> > > diff --git a/kernel/module.c b/kernel/module.c
> > > index 6746c85511fe..2ef9ed95bf60 100644
> > > --- a/kernel/module.c
> > > +++ b/kernel/module.c
> > > @@ -2110,9 +2110,139 @@ static void free_module_elf(struct module *mo=
d)
> > >  }
> > >  #endif /* CONFIG_LIVEPATCH */it
> > >
> > > +struct mod_alloc_user {
> > > +       struct rb_node node;
> > > +       unsigned long addr;
> > > +       unsigned long pages;
> > > +       kuid_t uid;
> > > +};
> > > +
> > > +static struct rb_root alloc_users =3D RB_ROOT;
> > > +static DEFINE_SPINLOCK(alloc_users_lock);
> >
> > Why all the rbtree stuff instead of stashing a pointer in struct
> > vmap_area, or something like that?
>
> Since the tracking was not for all vmalloc usage, the intention was to no=
t bloat
> the structure for other usages likes stacks. I thought usually there woul=
dn't be
> nearly as much module space allocations as there would be kernel stacks, =
but I
> didn't do any actual measurements on the tradeoffs.

I imagine that one extra pointer in there - pointing to your struct
mod_alloc_user - would probably not be terrible. 8 bytes more per
kernel stack shouldn't be so bad?

> > [...]
> > > +int check_inc_mod_rlimit(unsigned long size)
> > > +{
> > > +       struct user_struct *user =3D get_current_user();
> > > +       unsigned long modspace_pages =3D rlimit(RLIMIT_MODSPACE) >>
> > > PAGE_SHIFT;
> > > +       unsigned long cur_pages =3D atomic_long_read(&user->module_vm=
);
> > > +       unsigned long new_pages =3D get_mod_page_cnt(size);
> > > +
> > > +       if (rlimit(RLIMIT_MODSPACE) !=3D RLIM_INFINITY
> > > +                       && cur_pages + new_pages > modspace_pages) {
> > > +               free_uid(user);
> > > +               return 1;
> > > +       }
> > > +
> > > +       atomic_long_add(new_pages, &user->module_vm);
> > > +
> > > +       if (atomic_long_read(&user->module_vm) > modspace_pages) {
> > > +               atomic_long_sub(new_pages, &user->module_vm);
> > > +               free_uid(user);
> > > +               return 1;
> > > +       }
> > > +
> > > +       free_uid(user);
> >
> > If you drop the reference on the user_struct, an attacker with two
> > UIDs can charge module allocations to UID A, keep the associated
> > sockets alive as UID B, and then log out and back in again as UID A.
> > At that point, nobody is charged for the module space anymore. If you
> > look at the eBPF implementation, you'll see that
> > bpf_prog_charge_memlock() actually stores a refcounted pointer to the
> > user_struct.
> Ok, I'll take a look. Thanks Jann.
> > > +       return 0;
> > > +}
