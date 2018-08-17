Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA36C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6202621788
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6202621788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeHQSt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:49:59 -0400
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:39114 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727213AbeHQSt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:49:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C85E2181D341C;
        Fri, 17 Aug 2018 15:46:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pump47_6ef20ada02a5e
X-Filterd-Recvd-Size: 16570
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Aug 2018 15:46:02 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <rob.herring@linaro.org>,
        Jonas Oberg <jonas@fsfe.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH V2] license-rules.rst and LICENSES: Use only spdx version 3 with -only and -or-later
Date:   Fri, 17 Aug 2018 08:45:59 -0700
Message-Id: <9f90ed3678d32bdde88d63e877880dcb08a97e15.1534519501.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current linux-kernel source git tree has a mixture of the deprecated
spdx version 2 and the newer version 3 uses.

Update the process/license-rules.rst file to show only the version 3 style.
Use only the version 3 styles in LICENSES.

Add a script to update all old versions in the tree as well.
Update scripts/spdxcheck.py to ignore this new script file.

I suggest this be applied and the script be run and applied immediately
after an -rc1.

The script could also be used at any time after the initial use to update
any other now deprecated spdx license use added afterwards.

Signed-off-by: Joe Perches <joe@perches.com>
---

V2:

o Use the correct SPDX-URLs in LICENSES files
o Use the correct exceptions in exceptions/Linux-syscall-note
o Add comments to update_spdx_v2_licenses.sh script
o Update scripts/spdxcheck.py to ignore the added script

Now the output of scripts/spdxcheck.py is unchanged before and after
this patch is applied and the script is run.

After the update_spdx_v2_licenses.sh script is run but not applied:

$ git diff --name-only | wc -l
17783

 Documentation/process/license-rules.rst | 60 ++++++++++++++++-----------------
 LICENSES/exceptions/Linux-syscall-note  |  2 +-
 LICENSES/other/GPL-1.0                  |  6 ++--
 LICENSES/preferred/GPL-2.0              |  9 ++---
 LICENSES/preferred/LGPL-2.0             | 11 +++---
 LICENSES/preferred/LGPL-2.1             | 11 +++---
 scripts/spdxcheck.py                    |  4 ++-
 scripts/update_spdx_v2_licenses.sh      | 28 +++++++++++++++
 8 files changed, 79 insertions(+), 52 deletions(-)
 create mode 100755 scripts/update_spdx_v2_licenses.sh

diff --git a/Documentation/process/license-rules.rst b/Documentation/process/license-rules.rst
index 8ea26325fe3f..2b294611b6c1 100644
--- a/Documentation/process/license-rules.rst
+++ b/Documentation/process/license-rules.rst
@@ -16,12 +16,12 @@ The license described in the COPYING file applies to the kernel source
 as a whole, though individual source files can have a different license
 which is required to be compatible with the GPL-2.0::
 
-    GPL-1.0+  :  GNU General Public License v1.0 or later
-    GPL-2.0+  :  GNU General Public License v2.0 or later
-    LGPL-2.0  :  GNU Library General Public License v2 only
-    LGPL-2.0+ :  GNU Library General Public License v2 or later
-    LGPL-2.1  :  GNU Lesser General Public License v2.1 only
-    LGPL-2.1+ :  GNU Lesser General Public License v2.1 or later
+    GPL-1.0-or-later  :  GNU General Public License v1.0 or later
+    GPL-2.0-or-later  :  GNU General Public License v2.0 or later
+    LGPL-2.0-only     :  GNU Library General Public License v2 only
+    LGPL-2.0-or-later :  GNU Library General Public License v2 or later
+    LGPL-2.1-only     :  GNU Lesser General Public License v2.1 only
+    LGPL-2.1-or-later :  GNU Lesser General Public License v2.1 or later
 
 Aside from that, individual files can be provided under a dual license,
 e.g. one of the compatible GPL variants and alternatively under a
@@ -98,21 +98,21 @@ License identifier syntax
    "(", ")" .
 
    License identifiers for licenses like [L]GPL with the 'or later' option
-   are constructed by using a "+" for indicating the 'or later' option.::
+   are constructed by using the '-or-later' option.::
 
-      // SPDX-License-Identifier: GPL-2.0+
-      // SPDX-License-Identifier: LGPL-2.1+
+      // SPDX-License-Identifier: GPL-2.0-or-later
+      // SPDX-License-Identifier: LGPL-2.1-or-later
 
    WITH should be used when there is a modifier to a license needed.
    For example, the linux kernel UAPI files use the expression::
 
-      // SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
-      // SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note
+      // SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
+      // SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note
 
    Other examples using WITH exceptions found in the kernel are::
 
-      // SPDX-License-Identifier: GPL-2.0 WITH mif-exception
-      // SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+      // SPDX-License-Identifier: GPL-2.0-only WITH mif-exception
+      // SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0
 
    Exceptions can only be used with particular License identifiers. The
    valid License identifiers are listed in the tags of the exception text
@@ -123,28 +123,28 @@ License identifier syntax
    to be selected.  For example, some dtsi files are available under dual
    licenses::
 
-      // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+      // SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 
    Examples from the kernel for license expressions in dual licensed files::
 
-      // SPDX-License-Identifier: GPL-2.0 OR MIT
-      // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
-      // SPDX-License-Identifier: GPL-2.0 OR Apache-2.0
-      // SPDX-License-Identifier: GPL-2.0 OR MPL-1.1
-      // SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT
-      // SPDX-License-Identifier: GPL-1.0+ OR BSD-3-Clause OR OpenSSL
+      // SPDX-License-Identifier: GPL-2.0-only OR MIT
+      // SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+      // SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0
+      // SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1
+      // SPDX-License-Identifier: (GPL-2.0-only WITH Linux-syscall-note) OR MIT
+      // SPDX-License-Identifier: GPL-1.0-or-later OR BSD-3-Clause OR OpenSSL
 
    AND should be used if the file has multiple licenses whose terms all
    apply to use the file. For example, if code is inherited from another
    project and permission has been given to put it in the kernel, but the
    original license terms need to remain in effect::
 
-      // SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) AND MIT
+      // SPDX-License-Identifier: (GPL-2.0-only WITH Linux-syscall-note) AND MIT
 
    Another other example where both sets of license terms need to be
    adhered to is::
 
-      // SPDX-License-Identifier: GPL-1.0+ AND LGPL-2.1+
+      // SPDX-License-Identifier: GPL-1.0-or-later AND LGPL-2.1-or-later
 
 License identifiers
 -------------------
@@ -168,7 +168,7 @@ kernel, can be broken down into:
 
    Examples::
 
-      LICENSES/preferred/GPL-2.0
+      LICENSES/preferred/GPL-2.0-only
 
    Contains the GPL version 2 license text and the required metatags::
 
@@ -204,17 +204,17 @@ kernel, can be broken down into:
 
    File format examples::
 
-      Valid-License-Identifier: GPL-2.0
-      Valid-License-Identifier: GPL-2.0+
-      SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
+      Valid-License-Identifier: GPL-2.0-only
+      Valid-License-Identifier: GPL-2.0-or-later
+      SPDX-URL: https://spdx.org/licenses/GPL-2.0-only.html
       Usage-Guide:
         To use this license in source code, put one of the following SPDX
 	tag/value pairs into a comment according to the placement
 	guidelines in the licensing rules documentation.
 	For 'GNU General Public License (GPL) version 2 only' use:
-	  SPDX-License-Identifier: GPL-2.0
+	  SPDX-License-Identifier: GPL-2.0-only
 	For 'GNU General Public License (GPL) version 2 or any later version' use:
-	  SPDX-License-Identifier: GPL-2.0+
+	  SPDX-License-Identifier: GPL-2.0-or-later
       License-Text:
         Full license text
 
@@ -338,7 +338,7 @@ kernel, can be broken down into:
 
       SPDX-Exception-Identifier: Linux-syscall-note
       SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
-      SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+
+      SPDX-Licenses: GPL-2.0-only, GPL-2.0-or-later, GPL-1.0-or-later, LGPL-2.0-only, LGPL-2.0-or-later, LGPL-2.1-only, LGPL-2.1-or-later
       Usage-Guidance:
         This exception is used together with one of the above SPDX-Licenses
 	to mark user-space API (uapi) header files so they can be included
@@ -353,7 +353,7 @@ kernel, can be broken down into:
 
       SPDX-Exception-Identifier: GCC-exception-2.0
       SPDX-URL: https://spdx.org/licenses/GCC-exception-2.0.html
-      SPDX-Licenses: GPL-2.0, GPL-2.0+
+      SPDX-Licenses: GPL-2.0-only, GPL-2.0-or-later
       Usage-Guidance:
         The "GCC Runtime Library exception 2.0" is used together with one
 	of the above SPDX-Licenses for code imported from the GCC runtime
diff --git a/LICENSES/exceptions/Linux-syscall-note b/LICENSES/exceptions/Linux-syscall-note
index 9abdad71fafd..859df5079d72 100644
--- a/LICENSES/exceptions/Linux-syscall-note
+++ b/LICENSES/exceptions/Linux-syscall-note
@@ -1,6 +1,6 @@
 SPDX-Exception-Identifier: Linux-syscall-note
 SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
-SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+, GPL-2.0-only, GPL-2.0-or-later
+SPDX-Licenses: GPL-2.0-only, GPL-2.0-or-later, GPL-1.0-or-later, LGPL-2.0-only, LGPL-2.0-or-later, LGPL-2.1-only, LGPL-2.1-or-later, GPL-2.0-only, GPL-2.0-or-later
 Usage-Guide:
   This exception is used together with one of the above SPDX-Licenses
   to mark user space API (uapi) header files so they can be included
diff --git a/LICENSES/other/GPL-1.0 b/LICENSES/other/GPL-1.0
index 3a4fa969e4c2..c92d37cf1e55 100644
--- a/LICENSES/other/GPL-1.0
+++ b/LICENSES/other/GPL-1.0
@@ -1,5 +1,5 @@
-Valid-License-Identifier: GPL-1.0+
-SPDX-URL: https://spdx.org/licenses/GPL-1.0.html
+Valid-License-Identifier: GPL-1.0-or-later
+SPDX-URL: https://spdx.org/licenses/GPL-1.0-or-later.html
 Usage-Guide:
   The GNU General Public License (GPL) version 1 should not be used in new
   code. For existing kernel code the 'or any later version' option is
@@ -7,7 +7,7 @@ Usage-Guide:
   To use the license in source code, put the following SPDX tag/value pair
   into a comment according to the placement guidelines in the licensing
   rules documentation:
-    SPDX-License-Identifier: GPL-1.0+
+    SPDX-License-Identifier: GPL-1.0-or-later
 License-Text:
 
 	    GNU GENERAL PUBLIC LICENSE
diff --git a/LICENSES/preferred/GPL-2.0 b/LICENSES/preferred/GPL-2.0
index ff0812fd89cc..cf93fa34a000 100644
--- a/LICENSES/preferred/GPL-2.0
+++ b/LICENSES/preferred/GPL-2.0
@@ -1,19 +1,14 @@
-Valid-License-Identifier: GPL-2.0
 Valid-License-Identifier: GPL-2.0-only
-Valid-License-Identifier: GPL-2.0+
 Valid-License-Identifier: GPL-2.0-or-later
-SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
+SPDX-URL: https://spdx.org/licenses/GPL-2.0-only.html
+SPDX-URL: https://spdx.org/licenses/GPL-2.0-or-later.html
 Usage-Guide:
   To use this license in source code, put one of the following SPDX
   tag/value pairs into a comment according to the placement
   guidelines in the licensing rules documentation.
   For 'GNU General Public License (GPL) version 2 only' use:
-    SPDX-License-Identifier: GPL-2.0
-  or
     SPDX-License-Identifier: GPL-2.0-only
   For 'GNU General Public License (GPL) version 2 or any later version' use:
-    SPDX-License-Identifier: GPL-2.0+
-  or
     SPDX-License-Identifier: GPL-2.0-or-later
 License-Text:
 
diff --git a/LICENSES/preferred/LGPL-2.0 b/LICENSES/preferred/LGPL-2.0
index 957d798fe037..3d378dd44928 100644
--- a/LICENSES/preferred/LGPL-2.0
+++ b/LICENSES/preferred/LGPL-2.0
@@ -1,15 +1,16 @@
-Valid-License-Identifier: LGPL-2.0
-Valid-License-Identifier: LGPL-2.0+
-SPDX-URL: https://spdx.org/licenses/LGPL-2.0.html
+Valid-License-Identifier: LGPL-2.0-only
+Valid-License-Identifier: LGPL-2.0-or-later
+SPDX-URL: https://spdx.org/licenses/LGPL-2.0-only.html
+SPDX-URL: https://spdx.org/licenses/LGPL-2.0-or-later.html
 Usage-Guide:
   To use this license in source code, put one of the following SPDX
   tag/value pairs into a comment according to the placement
   guidelines in the licensing rules documentation.
   For 'GNU Library General Public License (LGPL) version 2.0 only' use:
-    SPDX-License-Identifier: LGPL-2.0
+    SPDX-License-Identifier: LGPL-2.0-only
   For 'GNU Library General Public License (LGPL) version 2.0 or any later
   version' use:
-    SPDX-License-Identifier: LGPL-2.0+
+    SPDX-License-Identifier: LGPL-2.0-or-later
 License-Text:
 
 GNU LIBRARY GENERAL PUBLIC LICENSE
diff --git a/LICENSES/preferred/LGPL-2.1 b/LICENSES/preferred/LGPL-2.1
index 27bb4342a3e8..5cfb7bc02a15 100644
--- a/LICENSES/preferred/LGPL-2.1
+++ b/LICENSES/preferred/LGPL-2.1
@@ -1,15 +1,16 @@
-Valid-License-Identifier: LGPL-2.1
-Valid-License-Identifier: LGPL-2.1+
-SPDX-URL: https://spdx.org/licenses/LGPL-2.1.html
+Valid-License-Identifier: LGPL-2.1-only
+Valid-License-Identifier: LGPL-2.1-or-later
+SPDX-URL: https://spdx.org/licenses/LGPL-2.1-only.html
+SPDX-URL: https://spdx.org/licenses/LGPL-2.1-or-later.html
 Usage-Guide:
   To use this license in source code, put one of the following SPDX
   tag/value pairs into a comment according to the placement
   guidelines in the licensing rules documentation.
   For 'GNU Lesser General Public License (LGPL) version 2.1 only' use:
-    SPDX-License-Identifier: LGPL-2.1
+    SPDX-License-Identifier: LGPL-2.1-only
   For 'GNU Lesser General Public License (LGPL) version 2.1 or any later
   version' use:
-    SPDX-License-Identifier: LGPL-2.1+
+    SPDX-License-Identifier: LGPL-2.1-or-later
 License-Text:
 
 GNU LESSER GENERAL PUBLIC LICENSE
diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 7deaef297f52..6f1b353d7e4a 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -1,5 +1,5 @@
 #!/usr/bin/env python
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 # Copyright Thomas Gleixner <tglx@linutronix.de>
 
 from argparse import ArgumentParser
@@ -201,6 +201,8 @@ def scan_git_tree(tree):
             continue
         if el.path == 'scripts/checkpatch.pl':
             continue
+        if el.path == 'scripts/update_spdx_v2_licenses.sh':
+            continue
         if not os.path.isfile(el.path):
             continue
         parser.parse_lines(open(el.path), args.maxlines, el.path)
diff --git a/scripts/update_spdx_v2_licenses.sh b/scripts/update_spdx_v2_licenses.sh
new file mode 100755
index 000000000000..afcec4cc92cc
--- /dev/null
+++ b/scripts/update_spdx_v2_licenses.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+# This script should update all files in a git tree that use deprecated
+# v2 SPDX license identifiers to use v3 styles with -only and -or-later.
+
+# The following styles are intended to be converted
+
+# GPL-1.0+	->	GPL-1.0-or-later
+# GPL-2.0	->	GPL-2.0-only
+# GPL-2.0+	->	GPL-2.0-or-later
+# LGPL-2.0	->	LGPL-2.0-only
+# LGPL-2.0+	->	LGPL-2.0-or-later
+# LGPL-2.1	->	LGPL-2.1-only
+# LGPL-2.1+	->	LGPL-2.1-or-later
+
+# GPL variants without \+ that should use -only
+
+spdx_find='(SPDX-License-Identifier:\s[\s\(]*.*\bL?GPL-[12].[01])(\s|\)|$)'
+spdx_replace='\1-only\2'
+git grep -P --name-only "$spdx_find" -- './*' ':(exclude)LICENSES/' | \
+    xargs -r perl -p -i -e "s/$spdx_find/$spdx_replace/"
+
+# GPL variants with \+ that should use -or-later
+
+spdx_find='(SPDX-License-Identifier:\s[\s\(]*.*\bL?GPL-[12].[01])\+(\s|\)|$)'
+spdx_replace='\1-or-later\2'
+git grep -P --name-only "$spdx_find" -- './*' ':(exclude)LICENSES/' | \
+    xargs -r perl -p -i -e "s/$spdx_find/$spdx_replace/"
-- 
2.15.0

