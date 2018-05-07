Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeEGG35 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:29:57 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:35094 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeEGG3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:29:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w476TUgp007443
X-Nifty-SrcIP: [209.85.213.43]
X-Google-Smtp-Source: AB8JxZqsdoWjVWRNq+bpIFWvRQyoq3xbdRIvp1I3BmAw/SHc16HMBQN5+kHf1r7e1NatI1PzS7Xd963GmKKvKwhAo2c=
MIME-Version: 1.0
In-Reply-To: <20180329180112.11055-1-labbott@redhat.com>
References: <20180329180112.11055-1-labbott@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 7 May 2018 15:28:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATTfjpkG0PLR5_anZOW5zfSZxKgFO6sHXuMf50OEtx0PQ@mail.gmail.com>
Message-ID: <CAK7LNATTfjpkG0PLR5_anZOW5zfSZxKgFO6sHXuMf50OEtx0PQ@mail.gmail.com>
Subject: Re: [RFCv2 PATCH 0/3] Salted build ids via linker sections
To: Laura Abbott <labbott@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-30 3:01 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> Hi,
>
> This is v2 of my proposal to allow unique build-ids in the kernel. from
> last time:
>
> ""
> In Fedora, the debug information is packaged separately (foo-debuginfo) and
> can be installed separately. There's been a long standing issue where only one
> version of a debuginfo info package can be installed at a time. Mark Wielaard
> made an effort for Fedora 27 to allow parallel installation of debuginfo (see
> https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo for
> more details)
>
> Part of the requirement to allow this to work is that build ids are
> unique between builds. The existing upstream rpm implementation ensures
> this by re-calculating the build-id using the version and release as a
> seed. This doesn't work 100% for the kernel because of the vDSO which is
> its own binary and doesn't get updated. After poking holes in a few of my
> ideas, there was a discussion with some people from the binutils team about
> adding --build-id-salt to let ld do the calculation debugedit is doing. There
> was a counter proposal made about adding some extra information via a .comment
> which will affect the build id calculation but just get stripped out.
> ""


I think you already know '--build-id=uuid' linker option.

Doesn't this solve your problem?

The disadvantage of this option is,
we will lose reproducible building because  --build-id=uuid
adds every time random salt.

The advantage is, the implementation is even simpler,
and easier to migrate to --build-id-salt once it is supported
in the future.


> This v2 cleans up the naming to be consistent and also switches to a
> config option vs. an environment variable. I've seen some sporadic
> failures about missing the generated header so I think I'm still missing
> a dependency somewhere.

Right.

There is no dependency between 'prepare' and 'scripts'
in the top Makefile.
Therefore, Kbuild can run them simultaneously,
which would cause a race in parallel building.








 I'm still mostly looking for feedback whether
> this would be acceptable for merging or if we should just persue a
> --build-id-salt in binutils.
>
> Thanks,
> Laura
>
>
> Laura Abbott (3):
>   kbuild: Introduce build-salt generated header
>   kbuild: Link with generated build-salt header
>   x86/vdso: Add build salt to the vDSO
>
>  Makefile                              | 13 +++++++++++--
>  arch/x86/entry/vdso/vdso-layout.lds.S |  3 +++
>  init/Kconfig                          |  8 ++++++++
>  scripts/.gitignore                    |  1 +
>  scripts/Makefile                      |  2 +-
>  scripts/build-salt.lds.S              |  5 +++++
>  scripts/gensalt                       | 21 +++++++++++++++++++++
>  scripts/link-vmlinux.sh               |  3 ++-
>  8 files changed, 52 insertions(+), 4 deletions(-)
>  create mode 100644 scripts/build-salt.lds.S
>  create mode 100755 scripts/gensalt
>
> --
> 2.16.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
