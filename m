Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbeCZHtR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:49:17 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:32980 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeCZHtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:49:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w2Q7mqF3026208
X-Nifty-SrcIP: [209.85.217.172]
X-Google-Smtp-Source: AG47ELtb6kT5/A4H1tXz41BCN+N+bn7Ku7ChVZBgE4E5BZxg16pOAve+ETsz3SQHaXzBWh4v7RQmZzSLUdh55yofNHE=
MIME-Version: 1.0
In-Reply-To: <20180321014635.29113-1-labbott@redhat.com>
References: <20180321014635.29113-1-labbott@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 26 Mar 2018 16:48:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQTf_tVvks==_wGsEeNs6Bpdcfy9k39fpzneFvVZGAOiA@mail.gmail.com>
Message-ID: <CAK7LNAQTf_tVvks==_wGsEeNs6Bpdcfy9k39fpzneFvVZGAOiA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Salted build ids via linker sections
To: Laura Abbott <labbott@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-21 10:46 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> Hi,
>
> This is a proposal that's come out of several discussion for Fedora but
> may be of interest to other distributions.
>
> In Fedora, the debug information is packaged separately (foo-debuginfo) and
> can be installed separately. There's been a long standing issue where only one
> version of a debuginfo info package can be installed at a time. Mark Wielaard
> made an effort for Fedora 27 to allow parallel installation of debuginfo (see
> https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo for
> more details)

Is this a kernel-specific problem?

IIUC, the URL above is discussing packages in general.

Any executable from slightly different versions
could result in identical ELF.
If so, will you tweak link process of every package
that needs parallel installation?




> Part of the requirement to allow this to work is that build ids are
> unique between builds. The existing upstream rpm implementation ensures
> this by re-calculating the build-id using the version and release as a
> seed. This doesn't work 100% for the kernel because of the vDSO which is
> its own binary and doesn't get updated. After poking holes in a few of my
> ideas, there was a discussion with some people from the binutils team about
> adding --build-id-salt to let ld do the calculation debugedit is doing. There
> was a counter proposal made about adding some extra information via a .comment
> which will affect the build id calculation but just get stripped out.
>
> This is an implementation of the counter proposal. If an environment variable
> is set, that value gets added as a .comment section to the necessary binaries.
> This is RFC mostly to see if this approach is plausible enough to be merged or
> if it's worth trying to update binutils with the --build-id-salt option.
> I don't care about any names, I was pretty inconsistent. If people are
> roughly satisifed with this I'll probably just change all the names to
> build-salt or whatever gets bike shedded.
>
> Thanks,
> Laura
>
> Laura Abbott (3):
>   kbuild: Introduce build-salt generated header
>   kbuild: Link with generated build-salt header
>   x86/vdso: Add build salt to the vDSO
>
>  Makefile                              | 13 +++++++++++--
>  arch/x86/entry/vdso/vdso-layout.lds.S |  3 +++
>  scripts/.gitignore                    |  1 +
>  scripts/Makefile                      |  2 +-
>  scripts/build-id.lds.S                |  5 +++++
>  scripts/gencomment                    | 19 +++++++++++++++++++
>  scripts/link-vmlinux.sh               |  3 ++-
>  7 files changed, 42 insertions(+), 4 deletions(-)
>  create mode 100644 scripts/build-id.lds.S
>  create mode 100755 scripts/gencomment
>
> --
> 2.16.2
>



-- 
Best Regards
Masahiro Yamada
