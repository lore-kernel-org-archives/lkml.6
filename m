Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeBZSmp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:42:45 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39056 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeBZSmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:42:42 -0500
X-Google-Smtp-Source: AH8x227po5CszI+sIVWEMJU/4ZBjLsfofExs+O0C0Vsn4LOtNyb910GGtZhLE6+de4JDlkupAs3zIQ==
From: Robin Jarry <robin.jarry@6wind.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 1/3] kbuild: introduce HOST_{C,LD}FLAGS
Date: Mon, 26 Feb 2018 19:41:46 +0100
Message-Id: <864ea8d9df0428826f85bbf3b7fc0af4e3669c5f.1519668832.git.robin.jarry@6wind.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1519668832.git.robin.jarry@6wind.com>
References: <cover.1519393674.git.robin.jarry@6wind.com> <cover.1519668832.git.robin.jarry@6wind.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add user-specifiable compiler/linker flags for host programs. Append
these to already existing HOST{C,CXX,LD}FLAGS.

Update documentation accordingly.

Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/README.rst | 16 ++++++++++++++++
 Makefile                             |  7 ++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index af5a437198d0..22ba3140e85f 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -271,6 +271,22 @@ Compiling the kernel
    To have the build system also tell the reason for the rebuild of each
    target, use ``V=2``.  The default is ``V=0``.
 
+ - Host libs in non standard locations:
+
+   Some host programs are linked with external libraries, such as openssl
+   or libelf.  If these libs are installed in non standard locations on
+   your build system, you may specify it via the ``HOST_CFLAGS`` and
+   ``HOST_LDFLAGS`` parameters on the ``make`` command line.
+
+   For example, if you have installed host libs in ``/foo/staging``, you
+   may use the following command::
+
+     make HOST_CFLAGS="-I/foo/staging/include" \
+          HOST_LDFLAGS="-L/foo/staging/lib -Wl,-rpath=/foo/staging/lib"
+
+   Please note: If the ``HOST_CFLAGS`` or ``HOST_LDFLAGS`` options are
+   used, then they must be used for all invocations of make.
+
  - Keep a backup kernel handy in case something goes wrong.  This is
    especially true for the development releases, since each new release
    contains new code which has not been debugged.  Make sure you keep a
diff --git a/Makefile b/Makefile
index 659a7780aeb3..f7c543cebfc6 100644
--- a/Makefile
+++ b/Makefile
@@ -362,9 +362,10 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS)
 HOSTCC       = gcc
 HOSTCXX      = g++
 HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
-		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
-HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
-HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
+		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS) \
+		$(HOST_CFLAGS)
+HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS) $(HOST_CFLAGS)
+HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOST_LDFLAGS)
 HOST_LOADLIBES := $(HOST_LFS_LIBS)
 
 # Make variables (CC, etc...)
-- 
2.11.0
