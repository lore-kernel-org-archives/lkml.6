Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeFDHBT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752828AbeFDHBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:01:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 23/52] kbuild: clang: remove crufty HOSTCFLAGS
Date: Mon,  4 Jun 2018 08:58:18 +0200
Message-Id: <20180604065607.502037987@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <nick.desaulniers@gmail.com>

commit df16aaac26e92e97ab7234d3f93c953466adc4b5 upstream.

When compiling with `make CC=clang HOSTCC=clang`, I was seeing warnings
that clang did not recognize -fno-delete-null-pointer-checks for HOSTCC
targets.  These were added in commit 61163efae020 ("kbuild: LLVMLinux:
Add Kbuild support for building kernel with Clang").

Clang does not support -fno-delete-null-pointer-checks, so adding it to
HOSTCFLAGS if HOSTCC is clang does not make sense.

It's not clear why the other warnings were disabled, and just for
HOSTCFLAGS, but I can remove them, add -Werror to HOSTCFLAGS and compile
with clang just fine.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |    5 -----
 1 file changed, 5 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -369,11 +369,6 @@ HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
 HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
 HOST_LOADLIBES := $(HOST_LFS_LIBS)
 
-ifeq ($(shell $(HOSTCC) -v 2>&1 | grep -c "clang version"), 1)
-HOSTCFLAGS  += -Wno-unused-value -Wno-unused-parameter \
-		-Wno-missing-field-initializers -fno-delete-null-pointer-checks
-endif
-
 # Make variables (CC, etc...)
 AS		= $(CROSS_COMPILE)as
 LD		= $(CROSS_COMPILE)ld
