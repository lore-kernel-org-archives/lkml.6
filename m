Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeCMJOA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:14:00 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:41660 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeCMJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:13:56 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2D9CIo2016505
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/11] kbuild: add PYTHON2 and PYTHON3 variables
Date: Tue, 13 Mar 2018 18:12:02 +0900
Message-Id: <1520932332-2449-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'PYTHON' allows users to specify a proper executable
name in case the default 'python' does not work.  However, this does
not address the case where both Python 2.x and 3.x scripts are used
in one source tree.

PEP 394 (https://www.python.org/dev/peps/pep-0394/) provides a
convention for Python scripts portability.  Here is a quotation:

  In order to tolerate differences across platforms, all new code
  that needs to invoke the Python interpreter should not specify
  'python', but rather should specify either 'python2' or 'python3'.
  This distinction should be made in shebangs, when invoking from a
  shell script, when invoking via the system() call, or when invoking
  in any other context.
  One exception to this is scripts that are deliberately written to
  be source compatible with both Python 2.x and 3.x. Such scripts may
  continue to use python on their shebang line without affecting their
  portability.

To meet this requirement, this commit adds new variables 'PYTHON2'
and 'PYTHON3'.

arch/ia64/scripts/unwcheck.py is the only script that has ever used
$(PYTHON).  Recent commit bd5edbe67794 ("ia64: convert unwcheck.py to
python3") converted it to be compatible with both Python 2.x and 3.x,
so this is the exceptional case where the use of 'python' is allowed.
So, I did not touch arch/ia64/Makefile.

tools/perf/Makefile.config sets PYTHON and PYTHON2 by itself, so it
is not affected by this commit.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - Keep PYTHON as-is because ia64 recently converted its script
    compatible with Python 3.x

Changes in v2:
  - Add backward compatibility for PYTHON

 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e02d092..7a5f85e 100644
--- a/Makefile
+++ b/Makefile
@@ -385,6 +385,8 @@ INSTALLKERNEL  := installkernel
 DEPMOD		= /sbin/depmod
 PERL		= perl
 PYTHON		= python
+PYTHON2		= python2
+PYTHON3		= python3
 CHECK		= sparse
 
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
@@ -430,7 +432,7 @@ GCC_PLUGINS_CFLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
-export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON UTS_MACHINE
+export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
 export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
-- 
2.7.4
