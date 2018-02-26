Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeBZSmb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:42:31 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40062 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeBZSm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:42:29 -0500
X-Google-Smtp-Source: AG47ELt1cjUbTRKCNbiCmCPb61yWNn0n0egMSG5dO1zE8JEngtNTkbFPGKnbmfNZWFYU6ZEv92NWww==
From: Robin Jarry <robin.jarry@6wind.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] kbuild: fix host progs build with libs in non standard locations
Date: Mon, 26 Feb 2018 19:41:45 +0100
Message-Id: <cover.1519668832.git.robin.jarry@6wind.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1519393674.git.robin.jarry@6wind.com>
References: <cover.1519393674.git.robin.jarry@6wind.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset allows to build host programs that depend on external libs
installed in non standard locations (i.e. not in /usr/include, /usr/lib,
etc.).  For now, the only way is to force HOSTCC to include both the
path to the host compiler and the build flags.

I have encountered this issue when building linux into the buildroot
framework. host-* versions of libs may be compiled and installed in a
host staging dir removing the need to install them on the build system.

I'm not really satisfied with the new HOST_{C,LD}FLAGS variables.  They
are too similar to HOST{C,LD}FLAGS and I find them confusing.  However,
HOST_EXTRA*FLAGS are already reserved for local use in makefiles (see
Documentation/kbuild/makefiles.txt).  And I didn't want to have even
longer USER_HOST_*FLAGS.  If someone has a better proposition, I'll
happily make a v3.

Comments are welcome.

Changes since v1:
 - Fix typos.
 - Do not use HOST_EXTRA*FLAGS. Add new user specifiable variables.
 - Pass HOSTLDFLAGS to build single .c programs.
 - Build objtool with host flags.

Robin Jarry (3):
  kbuild: introduce HOST_{C,LD}FLAGS
  kbuild: use HOSTLDFLAGS for single .c executables
  objtool: use global host flags for compilation

 Documentation/admin-guide/README.rst | 16 ++++++++++++++++
 Makefile                             |  9 +++++----
 scripts/Makefile.host                |  2 +-
 tools/objtool/Makefile               |  4 ++--
 4 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.11.0
