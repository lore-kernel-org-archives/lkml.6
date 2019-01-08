Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE0AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3102063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732740AbfAHTnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:43:24 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:50230 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732224AbfAHTnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:43:20 -0500
Received: from ip4d142c80.dynamic.kabel-deutschland.de ([77.20.44.128] helo=xps13.fritz.box); authenticated
        by wp227.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1ggxHQ-00070C-4q; Tue, 08 Jan 2019 20:43:16 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH v2 2/2] docs: Revamp tainted-kernels.rst to make it more comprehensible
Date:   Tue,  8 Jan 2019 20:40:07 +0100
Message-Id: <20190108194007.29439-3-linux@leemhuis.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108194007.29439-1-linux@leemhuis.info>
References: <20190108194007.29439-1-linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1546976598;f0a954fc;
X-HE-SMSGID: 1ggxHQ-00070C-4q
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on an update for reporting-bugs.rst I noticed there is no easy
comprehensible document showing how to check if or why the running kernel might
be tainted. That's why I started updating the document which in the end became
nearly a rewrite.

Main goal was to make decoding /proc/sys/kernel/tainted easier. That can be done
now using the script tools/debugging/kernel-chktaint, which got posted and
enhanced when I posted an earlier version of this patch (see this thread:
https://lore.kernel.org/lkml/20181217152043.9989-1-linux@leemhuis.info/) and
was added by an earlier patch.

While putting a section about decoding /proc/sys/kernel/tainted in place I ended
up writing an easier understandable intro and a hopefully better explanation for
the tainted flags in bugs, oops or panics messages. Only thing missing then was
a table that quickly describes the various bits and taint flags before going
into more detail, so I added one as well.

That table is partly based on a section from Documentation/sysctl/kernel.txt,
but a bit more compact. To avoid cofusion I added the shortened version to
kernel.txt, to have only one verbose and one short description of each taint.
The same short one is used in three different places now:
./tools/debugging/kernel-chktaint, Documentation/admin-guide/tainted-kernels.rst
and Documentation/sysctl/kernel.txt

Note that the table mentions the bit position, which as usual starts counting at
zero; thus to avoid an off-by-one within one document I had decrease the numbers
in the existing description by one to match.

During review of v1 (see above) a number of existing issues with the text were
raised, like outdated usages as well as incomplete or missing descriptions.
Address most of those as well, apart from those for bit 2 and 9, as that needs a
wider and more focused discussion with more stakeholders.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/tainted-kernels.rst | 159 +++++++++++++++---
 Documentation/sysctl/kernel.txt               |  50 +++---
 2 files changed, 154 insertions(+), 55 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 28a869c509a0..71e9184a9079 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -1,59 +1,164 @@
 Tainted kernels
 ---------------
 
-Some oops reports contain the string **'Tainted: '** after the program
-counter. This indicates that the kernel has been tainted by some
-mechanism.  The string is followed by a series of position-sensitive
-characters, each representing a particular tainted value.
-
- 1)  ``G`` if all modules loaded have a GPL or compatible license, ``P`` if
+The kernel will mark itself as 'tainted' when something occurs that might be
+relevant later when investigating problems. Don't worry too much about this,
+most of the time it's not a problem to run a tainted kernel; the information is
+mainly of interest once someone wants to investigate some problem, as its real
+cause might be the event that got the kernel tainted. That's why bug reports
+from tainted kernels will often be ignored by developers, hence try to reproduce
+problems with an untainted kernel.
+
+Note the kernel will remain tainted even after you undo what caused the taint
+(i.e. unload a proprietary kernel module), to indicate the kernel remains not
+trustworthy. That's also why the kernel will print the tainted state when it
+notices an internal problem (a 'kernel bug'), a recoverable error
+('kernel oops') or a non-recoverable error ('kernel panic') and writes debug
+information about this to the logs ``dmesg`` outputs. It's also possible to
+check the tainted state at runtime through a file in ``/proc/``.
+
+
+Tainted flag in bugs, oops or panics messages
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You find the tainted state near the top in a line starting with 'CPU:'; if or
+why the kernel was tainted is shown after the Process ID ('PID:') and a shortened
+name of the command ('Comm:') that triggered the event::
+
+	BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
+	Oops: 0002 [#1] SMP PTI
+	CPU: 0 PID: 4424 Comm: insmod Tainted: P        W  O      4.20.0-0.rc6.fc30 #1
+	Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
+	RIP: 0010:my_oops_init+0x13/0x1000 [kpanic]
+	[...]
+
+You'll find a 'Not tainted: ' there if the kernel was not tainted at the
+time of the event; if it was, then it will print 'Tainted: ' and characters
+either letters or blanks. In above example it looks like this::
+
+	Tainted: P        W  O
+
+The meaning of those characters is explained in the table below. In tis case
+the kernel got tainted earlier because a proprietary Module (``P``) was loaded,
+a warning occurred (``W``), and an externally-built module was loaded (``O``).
+To decode other letters use the table below.
+
+
+Decoding tainted state at runtime
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+At runtime, you can query the tainted state by reading
+``cat /proc/sys/kernel/tainted``. If that returns ``0``, the kernel is not
+tainted; any other number indicates the reasons why it is. The easiest way to
+decode that number is the script ``tools/debugging/kernel-chktaint``, which your
+distribution might ship as part of a package called ``linux-tools`` or
+``kernel-tools``; if it doesn't you can download the script from
+`git.kernel.org <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/tools/debugging/kernel-chktaint>`_
+and execute it with ``sh kernel-chktaint``, which would print something like
+this on the machine that had the statements in the logs that were quoted earlier::
+
+	Kernel is Tainted for following reasons:
+	 * Proprietary module was loaded (#0)
+	 * Kernel issued warning (#9)
+	 * Externally-built ('out-of-tree') module was loaded  (#12)
+	See Documentation/admin-guide/tainted-kernels.rst in the the Linux kernel or
+	 https://www.kernel.org/doc/html/latest/admin-guide/tainted-kernels.html for
+	 a more details explanation of the various taint flags.
+	Raw taint value as int/string: 4609/'P        W  O     '
+
+You can try to decode the number yourself. That's easy if there was only one
+reason that got your kernel tainted, as in this case you can find the number
+with the table below. If there were multiple reasons you need to decode the
+number, as it is a bitfield, where each bit indicates the absence or presence of
+a particular type of taint. It's best to leave that to the aforementioned
+script, but if you need something quick you can use this shell command to check
+which bits are set::
+
+	$ for i in $(seq 18); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
+
+Table for decoding tainted state
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+===  ===  ======  ========================================================
+Bit  Log  Number  Reason that got the kernel tainted
+===  ===  ======  ========================================================
+  0  G/P       1  proprietary module was loaded
+  1  _/F       2  module was force loaded
+  2  _/S       4  SMP kernel oops on an officially SMP incapable processor
+  3  _/R       8  module was force unloaded
+  4  _/M      16  processor reported a Machine Check Exception (MCE)
+  5  _/B      32  bad page referenced or some unexpected page flags
+  6  _/U      64  taint requested by userspace application
+  7  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
+  8  _/A     256  ACPI table overridden by user
+  9  _/W     512  kernel issued warning
+ 10  _/C    1024  staging driver was loaded
+ 11  _/I    2048  workaround for bug in platform firmware applied
+ 12  _/O    4096  externally-built ("out-of-tree") module was loaded
+ 13  _/E    8192  unsigned module was loaded
+ 14  _/L   16384  soft lockup occurred
+ 15  _/K   32768  kernel has been live patched
+ 16  _/X   65536  auxiliary taint, defined for and used by distros
+ 17  _/T  131072  kernel was built with the struct randomization plugin
+===  ===  ======  ========================================================
+
+Note: The character ``_`` is representing a blank in this table to make reading
+easier.
+
+More detailed explanation for tainting
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+ 0)  ``G`` if all modules loaded have a GPL or compatible license, ``P`` if
      any proprietary module has been loaded.  Modules without a
      MODULE_LICENSE or with a MODULE_LICENSE that is not recognised by
      insmod as GPL compatible are assumed to be proprietary.
 
- 2)  ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
+ 1)  ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
      modules were loaded normally.
 
- 3)  ``S`` if the oops occurred on an SMP kernel running on hardware that
+ 2)  ``S`` if the oops occurred on an SMP kernel running on hardware that
      hasn't been certified as safe to run multiprocessor.
      Currently this occurs only on various Athlons that are not
      SMP capable.
 
- 4)  ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
+ 3)  ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
      modules were unloaded normally.
 
- 5)  ``M`` if any processor has reported a Machine Check Exception,
+ 4)  ``M`` if any processor has reported a Machine Check Exception,
      ``' '`` if no Machine Check Exceptions have occurred.
 
- 6)  ``B`` if a page-release function has found a bad page reference or
-     some unexpected page flags.
+ 5)  ``B`` If a page-release function has found a bad page reference or some
+     unexpected page flags. This indicates a hardware problem or a kernel bug;
+     there should be other information in the log indicating why this tainting
+     occured.
 
- 7)  ``U`` if a user or user application specifically requested that the
+ 6)  ``U`` if a user or user application specifically requested that the
      Tainted flag be set, ``' '`` otherwise.
 
- 8)  ``D`` if the kernel has died recently, i.e. there was an OOPS or BUG.
+ 7)  ``D`` if the kernel has died recently, i.e. there was an OOPS or BUG.
 
- 9)  ``A`` if the ACPI table has been overridden.
+ 8)  ``A`` if an ACPI table has been overridden.
 
- 10) ``W`` if a warning has previously been issued by the kernel.
+ 9)  ``W`` if a warning has previously been issued by the kernel.
      (Though some warnings may set more specific taint flags.)
 
- 11) ``C`` if a staging driver has been loaded.
+ 10) ``C`` if a staging driver has been loaded.
 
- 12) ``I`` if the kernel is working around a severe bug in the platform
+ 11) ``I`` if the kernel is working around a severe bug in the platform
      firmware (BIOS or similar).
 
- 13) ``O`` if an externally-built ("out-of-tree") module has been loaded.
+ 12) ``O`` if an externally-built ("out-of-tree") module has been loaded.
 
- 14) ``E`` if an unsigned module has been loaded in a kernel supporting
+ 13) ``E`` if an unsigned module has been loaded in a kernel supporting
      module signature.
 
- 15) ``L`` if a soft lockup has previously occurred on the system.
+ 14) ``L`` if a soft lockup has previously occurred on the system.
+
+ 15) ``K`` if the kernel has been live patched.
 
- 16) ``K`` if the kernel has been live patched.
+ 16) ``X`` Auxiliary taint, defined for and used by Linux distributors.
 
-The primary reason for the **'Tainted: '** string is to tell kernel
-debuggers if this is a clean kernel or if anything unusual has
-occurred.  Tainting is permanent: even if an offending module is
-unloaded, the tainted value remains to indicate that the kernel is not
-trustworthy.
+ 17) ``T`` Kernel was build with the randstruct plugin, which can intentionally
+     produce extremely unusual kernel structure layouts (even performance
+     pathological ones), which is important to know when debugging. Set at
+     build time.
diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 1b8775298cf7..b279b824b887 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -93,7 +93,7 @@ show up in /proc/sys/kernel:
 - stop-a                      [ SPARC only ]
 - sysrq                       ==> Documentation/admin-guide/sysrq.rst
 - sysctl_writes_strict
-- tainted
+- tainted                     ==> Documentation/admin-guide/tainted-kernels.rst
 - threads-max
 - unknown_nmi_panic
 - watchdog
@@ -1002,39 +1002,33 @@ compilation sees a 1% slowdown, other systems and workloads may vary.
 
   1: kernel stack erasing is enabled (default), it is performed before
      returning to the userspace at the end of syscalls.
-
 ==============================================================
 
-tainted:
+tainted
 
 Non-zero if the kernel has been tainted. Numeric values, which can be
 ORed together. The letters are seen in "Tainted" line of Oops reports.
 
-     1 (P):  A module with a non-GPL license has been loaded, this
-             includes modules with no license.
-             Set by modutils >= 2.4.9 and module-init-tools.
-     2 (F): A module was force loaded by insmod -f.
-            Set by modutils >= 2.4.9 and module-init-tools.
-     4 (S): Unsafe SMP processors: SMP with CPUs not designed for SMP.
-     8 (R): A module was forcibly unloaded from the system by rmmod -f.
-    16 (M): A hardware machine check error occurred on the system.
-    32 (B): A bad page was discovered on the system.
-    64 (U): The user has asked that the system be marked "tainted". This
-            could be because they are running software that directly modifies
-            the hardware, or for other reasons.
-   128 (D): The system has died.
-   256 (A): The ACPI DSDT has been overridden with one supplied by the user
-            instead of using the one provided by the hardware.
-   512 (W): A kernel warning has occurred.
-  1024 (C): A module from drivers/staging was loaded.
-  2048 (I): The system is working around a severe firmware bug.
-  4096 (O): An out-of-tree module has been loaded.
-  8192 (E): An unsigned module has been loaded in a kernel supporting module
-            signature.
- 16384 (L): A soft lockup has previously occurred on the system.
- 32768 (K): The kernel has been live patched.
- 65536 (X): Auxiliary taint, defined and used by for distros.
-131072 (T): The kernel was built with the struct randomization plugin.
+     1 (P): proprietary module was loaded
+     2 (F): module was force loaded
+     4 (S): SMP kernel oops on an officially SMP incapable processor
+     8 (R): module was force unloaded
+    16 (M): processor reported a Machine Check Exception (MCE)
+    32 (B): bad page referenced or some unexpected page flags
+    64 (U): taint requested by userspace application
+   128 (D): kernel died recently, i.e. there was an OOPS or BUG
+   256 (A): an ACPI table was overridden by user
+   512 (W): kernel issued warning
+  1024 (C): staging driver was loaded
+  2048 (I): workaround for bug in platform firmware applied
+  4096 (O): externally-built ("out-of-tree") module was loaded
+  8192 (E): unsigned module was loaded
+ 16384 (L): soft lockup occurred
+ 32768 (K): kernel has been live patched
+ 65536 (X): Auxiliary taint, defined and used by for distros
+131072 (T): The kernel was built with the struct randomization plugin
+
+See Documentation/admin-guide/tainted-kernels.rst for more information.
 
 ==============================================================
 
-- 
2.20.1

