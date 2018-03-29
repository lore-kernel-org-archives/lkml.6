Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeC2SBT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:01:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45698 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeC2SBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:01:18 -0400
X-Google-Smtp-Source: AIpwx48QPRoELctMbFrpSQ9uQM3U5EZ9LhsTiM7EZtgd49GredsPNLD7ep0/kFNhKFcqBSz5/oQINA==
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org
Subject: [RFCv2 PATCH 0/3] Salted build ids via linker sections
Date: Thu, 29 Mar 2018 11:01:09 -0700
Message-Id: <20180329180112.11055-1-labbott@redhat.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2 of my proposal to allow unique build-ids in the kernel. from
last time:

""
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
""

This v2 cleans up the naming to be consistent and also switches to a
config option vs. an environment variable. I've seen some sporadic
failures about missing the generated header so I think I'm still missing
a dependency somewhere. I'm still mostly looking for feedback whether
this would be acceptable for merging or if we should just persue a
--build-id-salt in binutils.

Thanks,
Laura


Laura Abbott (3):
  kbuild: Introduce build-salt generated header
  kbuild: Link with generated build-salt header
  x86/vdso: Add build salt to the vDSO

 Makefile                              | 13 +++++++++++--
 arch/x86/entry/vdso/vdso-layout.lds.S |  3 +++
 init/Kconfig                          |  8 ++++++++
 scripts/.gitignore                    |  1 +
 scripts/Makefile                      |  2 +-
 scripts/build-salt.lds.S              |  5 +++++
 scripts/gensalt                       | 21 +++++++++++++++++++++
 scripts/link-vmlinux.sh               |  3 ++-
 8 files changed, 52 insertions(+), 4 deletions(-)
 create mode 100644 scripts/build-salt.lds.S
 create mode 100755 scripts/gensalt

-- 
2.16.2
