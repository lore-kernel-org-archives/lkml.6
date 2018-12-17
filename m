Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB30C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8853920578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbeLQPUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:20:46 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:46916 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbeLQPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:20:46 -0500
Received: from ip4d142c80.dynamic.kabel-deutschland.de ([77.20.44.128] helo=truhe.fritz.box); authenticated
        by wp227.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gYuhH-0007y3-Gg; Mon, 17 Dec 2018 16:20:43 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] docs: Revamp tainted-kernels.rst to make it more comprehensible
Date:   Mon, 17 Dec 2018 16:20:43 +0100
Message-Id: <20181217152043.9989-2-linux@leemhuis.info>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181217152043.9989-1-linux@leemhuis.info>
References: <20181217152043.9989-1-linux@leemhuis.info>
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1545060045;69a046e8;
X-HE-SMSGID: 1gYuhH-0007y3-Gg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a section about /proc/sys/kernel/tainted and a command that decodes it to
Documentation/admin-guide/tainted-kernels.rst. While at it introduce a table
that shows the various bits as well as the letters used in oops and panic
messages. Make the document more user focused and easier to understand, too.

Backstory: While working updating reporting-bugs.rst I noticed there is no easy
comprehensible document showing how to check if or why the running kernel might
be tainted. That's why I wrote a section with a small python command to decodes
/proc/sys/kernel/tainted. I suspect there is a more elegant and shorter command
to archive the same, which still works on common machines out of the box;
please let me know if you know such a command.

While putting that section in place I ended up writing an easier understandable
intro and a hopefully better explanation for the tainted flags in bugs, oops or
panics messages. Only thing missing then was a table that quickly describes the
various bits and the taint flags before going into more detail, so I added that
as well.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/tainted-kernels.rst | 105 ++++++++++++++++--
 1 file changed, 96 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 28a869c509a0..aabd307a178a 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -1,10 +1,102 @@
 Tainted kernels
 ---------------
 
-Some oops reports contain the string **'Tainted: '** after the program
-counter. This indicates that the kernel has been tainted by some
-mechanism.  The string is followed by a series of position-sensitive
-characters, each representing a particular tainted value.
+The kernel will mark itself as 'tainted' when something occurs that
+might be relevant later when investigating problems. Don't worry
+yourself too much about this, most of the time it's not a problem to run
+a tainted kernel; the information is mainly of interest once someone
+wants to investigate some problem, as its real cause might be the event
+that got the kernel tainted. That's why the kernel will remain tainted
+even after you undo what caused the taint (i.e. unload a proprietary
+kernel module), to indicate the kernel remains not trustworthy. That's
+also why the kernel will print the tainted state when it noticed
+ainternal problem (a 'kernel bug'), a recoverable error ('kernel oops')
+or a nonrecoverable error ('kernel panic') and writes debug information
+about this to the logs ``dmesg`` outputs. It's also possible to check
+the tainted state at runtime through a file in ``/proc/``.
+
+
+Tainted flag in bugs, oops or panics messages
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You find the tainted state near the top after the list of loaded
+modules.  The state is part of the line that begins with mentioning CPU
+('CPU:'), Process ID ('PID:'), and a shorted name of the executed
+command ('Comm:') that triggered the event. When followed by **'Not
+tainted: '** the kernel was not tainted at the time of the event; if it
+was, then it will print **'Tainted: '** and characters either letters or
+blanks. The meaning of those characters is explained in below table. The
+output for example might state '``Tainted: P   WO``' when the kernel got
+tainted earlier because a proprietary Module (``P``) was loaded, a
+warning occurred (``W``), and an externally-built module was loaded
+(``O``). To decode other letters use below table.
+
+
+Decoding tainted state at runtime
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+At runtime, you can query the tainted state by reading
+``/proc/sys/kernel/tainted``. If that returns ``0``, the kernel is not
+tainted; any other number indicates the reasons why it is. You might
+find that number in below table if there was only one reason that got
+the kernel tainted. If there were multiple reasons you need to decode
+the number, as it is a bitfield, where each bit indicates the absence or
+presence of a particular type of taint. You can use the following python
+command to decode::
+
+	$ python3 -c 'from pprint import pprint; from itertools import zip_longest; pprint(list(zip_longest(range(1,17), reversed(bin(int(open("/proc/sys/kernel/tainted").read()))[2:]),fillvalue="0")))'
+	[(1, '1'),
+	 (2, '0'),
+	 (3, '0'),
+	 (4, '0'),
+	 (5, '0'),
+	 (6, '0'),
+	 (7, '0'),
+	 (8, '0'),
+	 (9, '0'),
+	 (10, '1'),
+	 (11, '0'),
+	 (12, '0'),
+	 (13, '1'),
+	 (14, '0'),
+	 (15, '0'),
+	 (16, '0')]
+
+In this case ``/proc/sys/kernel/tainted`` contained ``4609``, as the
+kernel got tainted because a proprietary Module (Bit 1) got loaded, a
+warning occurred (Bit 10), and an externally-built module got loaded
+(Bit 13). To decode other bits use below table.
+
+
+Table for decoding tainted state
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+===  ===  ======  ========================================================
+Bit  Log     Int  Reason that got the kernel tainted
+===  ===  ======  ========================================================
+ 1)  G/P       0  proprietary module got loaded
+ 2)  _/F       2  module was force loaded
+ 3)  _/S       4  SMP kernel oops on a officially SMP incapable processor
+ 4)  _/R       8  module was force unloaded
+ 5)  _/M      16  processor reported a Machine Check Exception (MCE)
+ 6)  _/B      32  bad page referenced or some unexpected page flags
+ 7)  _/U      64  taint requested by userspace application
+ 8)  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
+ 9)  _/A     256  ACPI table overridden by user
+10)  _/W     512  kernel issued warning
+11)  _/C    1024  staging driver got loaded
+12)  _/I    2048  workaround for bug in platform firmware in use
+13)  _/O    4096  externally-built ("out-of-tree") module got loaded
+14)  _/E    8192  unsigned module was loaded
+15)  _/L   16384  soft lockup occurred
+16)  _/K   32768  Kernel live patched
+===  ===  ======  ========================================================
+
+Note: To make reading easier ``_`` is representing a blank in this
+table.
+
+More detailed explanation for tainting
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
  1)  ``G`` if all modules loaded have a GPL or compatible license, ``P`` if
      any proprietary module has been loaded.  Modules without a
@@ -52,8 +144,3 @@ characters, each representing a particular tainted value.
 
  16) ``K`` if the kernel has been live patched.
 
-The primary reason for the **'Tainted: '** string is to tell kernel
-debuggers if this is a clean kernel or if anything unusual has
-occurred.  Tainting is permanent: even if an offending module is
-unloaded, the tainted value remains to indicate that the kernel is not
-trustworthy.
-- 
2.18.1

