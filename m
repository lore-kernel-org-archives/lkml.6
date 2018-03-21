Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbeCUBql (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:46:41 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41608 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeCUBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:46:40 -0400
X-Google-Smtp-Source: AG47ELs1ne6lvF/0yUJ+b7RbnG8333tmGkS63YlGMS8Ta/KUOim/knjPMx6P1XrujIlVDb5FBitXRQ==
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>
Subject: [RFC PATCH 0/3] Salted build ids via linker sections
Date: Tue, 20 Mar 2018 18:46:32 -0700
Message-Id: <20180321014635.29113-1-labbott@redhat.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a proposal that's come out of several discussion for Fedora but
may be of interest to other distributions.

In Fedora, the debug information is packaged separately (foo-debuginfo) and
can be installed separately. There's been a long standing issue where only one
version of a debuginfo info package can be installed at a time. Mark Wielaard
made an effort for Fedora 27 to allow parallel installation of debuginfo (see
https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo for
more details)

Part of the requirement to allow this to work is that build ids are
unique between builds. The existing upstream rpm implementation ensures
this by re-calculating the build-id using the version and release as a
seed. This doesn't work 100% for the kernel because of the vDSO which is
its own binary and doesn't get updated. After poking holes in a few of my
ideas, there was a discussion with some people from the binutils team about
adding --build-id-salt to let ld do the calculation debugedit is doing. There
was a counter proposal made about adding some extra information via a .comment
which will affect the build id calculation but just get stripped out.

This is an implementation of the counter proposal. If an environment variable
is set, that value gets added as a .comment section to the necessary binaries.
This is RFC mostly to see if this approach is plausible enough to be merged or
if it's worth trying to update binutils with the --build-id-salt option.
I don't care about any names, I was pretty inconsistent. If people are
roughly satisifed with this I'll probably just change all the names to
build-salt or whatever gets bike shedded.

Thanks,
Laura

Laura Abbott (3):
  kbuild: Introduce build-salt generated header
  kbuild: Link with generated build-salt header
  x86/vdso: Add build salt to the vDSO

 Makefile                              | 13 +++++++++++--
 arch/x86/entry/vdso/vdso-layout.lds.S |  3 +++
 scripts/.gitignore                    |  1 +
 scripts/Makefile                      |  2 +-
 scripts/build-id.lds.S                |  5 +++++
 scripts/gencomment                    | 19 +++++++++++++++++++
 scripts/link-vmlinux.sh               |  3 ++-
 7 files changed, 42 insertions(+), 4 deletions(-)
 create mode 100644 scripts/build-id.lds.S
 create mode 100755 scripts/gencomment

-- 
2.16.2
