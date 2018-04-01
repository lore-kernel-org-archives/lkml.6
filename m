Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeDAUlN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:41:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753951AbeDAUlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:41:10 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/45] C++: x86: Fix the x86 syscall table production for C++
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:41:09 +0100
Message-ID: <152261526940.30503.3933152630838784113.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the x86 syscall table production for C++ to not miss out any slots in
the syscall table as this would otherwise cause errors from the compiler.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/entry/syscalls/Makefile      |    8 +--
 arch/x86/entry/syscalls/syscallhdr.pl |   73 +++++++++++++++++++++++++
 arch/x86/entry/syscalls/syscalltbl.pl |   95 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/asm-offsets_32.c      |    1 
 arch/x86/kernel/asm-offsets_64.c      |    1 
 5 files changed, 174 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/entry/syscalls/syscallhdr.pl
 create mode 100644 arch/x86/entry/syscalls/syscalltbl.pl

diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index 6fb9b57ed5ba..18d87b98e3e3 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -9,16 +9,16 @@ _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)') \
 syscall32 := $(srctree)/$(src)/syscall_32.tbl
 syscall64 := $(srctree)/$(src)/syscall_64.tbl
 
-syshdr := $(srctree)/$(src)/syscallhdr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+syshdr := $(srctree)/$(src)/syscallhdr.pl
+systbl := $(srctree)/$(src)/syscalltbl.pl
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@' \
+      cmd_syshdr = perl '$(syshdr)' '$<' '$@' \
 		   '$(syshdr_abi_$(basetarget))' \
 		   '$(syshdr_pfx_$(basetarget))' \
 		   '$(syshdr_offset_$(basetarget))'
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' $< $@
+      cmd_systbl = perl '$(systbl)' $< $@
 
 quiet_cmd_hypercalls = HYPERCALLS $@
       cmd_hypercalls = $(CONFIG_SHELL) '$<' $@ $(filter-out $<,$^)
diff --git a/arch/x86/entry/syscalls/syscallhdr.pl b/arch/x86/entry/syscalls/syscallhdr.pl
new file mode 100644
index 000000000000..2e16a1c9c48a
--- /dev/null
+++ b/arch/x86/entry/syscalls/syscallhdr.pl
@@ -0,0 +1,73 @@
+#!/usr/bin/perl -w
+# SPDX-License-Identifier: GPL-2.0
+use strict;
+
+my ($in, $out, $abi_list, $prefix, $offset) = @ARGV;
+
+$offset = ""
+    if ($#ARGV < 4);
+
+#
+# Parse the table file
+#
+my %syscalls = ();
+my $highest_nr = 0;
+open TBL, "<$in" || die $in;
+while (my $line = <TBL>) {
+    if ($line =~ m/^[0-9A-Fa-fXx]+[[:space:]]/) {
+	my @bits = split(" ", $line);
+	my $nr = int($bits[0]);
+	$syscalls{$nr} = {
+	    nr		=> $nr,
+	    abi		=> $bits[1],
+	    name	=> $bits[2],
+	    sys		=> $bits[3],
+	    sys32	=> $bits[4],
+	};
+	$highest_nr = $nr
+	    if ($nr > $highest_nr);
+    }
+}
+close TBL || die $in;
+
+#
+# Determine which ABIs we are interested in
+#
+my %my_abis = ();
+foreach (split(",", $abi_list)) {
+    $my_abis{$_} = 1;
+}
+
+#
+# Generate the output
+#
+my $fileguard = $out;
+$fileguard =~ s!.*/!!;
+$fileguard = "_ASM_X86_" . $fileguard;
+$fileguard =~ y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/;
+$fileguard =~ s/[^A-Z0-9_]/_/g;
+$fileguard =~ s/__/_/g;
+
+open OUT, ">$out" || die $out;
+print OUT "#ifndef ${fileguard}\n";
+print OUT "#define ${fileguard} 1\n";
+print OUT "\n";
+
+for (my $i = 0; $i <= $highest_nr; $i++) {
+    next unless exists($syscalls{$i});
+
+    my $c = $syscalls{$i};
+    next unless exists($my_abis{$c->{abi}});
+
+    if ($offset eq "") {
+	print OUT "#define __NR_" . $prefix . $c->{name} . " " . $c->{nr} . "\n";
+    } else {
+	print OUT "#define __NR_" . $prefix . $c->{name} . " (" . $offset . "+" . $c->{nr} . ")\n";
+    }
+}
+
+print OUT "\n";
+print OUT "#endif /* ${fileguard} */\n";
+close OUT || die $out;
+
+exit 0;
diff --git a/arch/x86/entry/syscalls/syscalltbl.pl b/arch/x86/entry/syscalls/syscalltbl.pl
new file mode 100644
index 000000000000..71664f3aa78d
--- /dev/null
+++ b/arch/x86/entry/syscalls/syscalltbl.pl
@@ -0,0 +1,95 @@
+#!/usr/bin/perl -w
+# SPDX-License-Identifier: GPL-2.0
+use strict;
+
+my ($in, $out) = @ARGV;
+
+#
+# Parse the table file
+#
+my %syscalls = ();
+my $highest_nr = 0;
+open TBL, "<$in" || die $in;
+while (my $line = <TBL>) {
+    if ($line =~ m/^[0-9A-Fa-fXx]+[[:space:]]/) {
+	my @bits = split(" ", $line);
+	push @bits, "" if ($#bits == 2);
+	push @bits, "" if ($#bits == 3);
+	my $nr = int($bits[0]);
+	$syscalls{$nr} = {
+	    nr		=> $nr,
+	    abi		=> $bits[1],
+	    name	=> $bits[2],
+	    entry	=> $bits[3],
+	    compat	=> $bits[4],
+	};
+	$highest_nr = $nr
+	    if ($nr > $highest_nr);
+    }
+}
+close TBL || die $in;
+
+#
+# Generate the output
+#
+sub syscall_macro($$$) {
+    my ($abi, $nr, $entry) = @_;
+
+    # Entry can be either just a function name or "function/qualifier"
+    my @pieces = split("/", $entry);
+    my ($func, $qualifier) = @pieces;
+    $qualifier = "" unless ($#pieces == 1);
+
+    return "__SYSCALL_" . $abi . "(" . $nr . ", " . $func . ", " . $qualifier . ")";
+}
+
+sub emit($$$$) {
+    my ($abi, $nr, $entry, $compat) = @_;
+
+    die "a compat entry for a 64-bit syscall makes no sense"
+	if ($abi eq "64" && $compat);
+
+    if ($compat eq "") {
+	if ($entry) {
+	    print OUT syscall_macro($abi, $nr, $entry), "\n"
+	} else {
+	    print OUT "__NO_SYSCALL_(" . $nr . ")\n";
+	}
+    } else {
+	print OUT "#ifdef CONFIG_X86_32\n";
+	print OUT syscall_macro($abi, $nr, $entry), "\n"
+	    if ($entry);
+	print OUT "#else\n";
+	print OUT syscall_macro($abi, $nr, $compat), "\n";
+	print OUT "#endif\n";
+    }
+}
+
+open OUT, ">$out" || die $out;
+for (my $i = 0; $i <= $highest_nr; $i++) {
+    if (!exists($syscalls{$i})) {
+	print OUT "__NO_SYSCALL_(" . $i . ")\n";
+	next;
+    }
+
+    my $c = $syscalls{$i};
+    my $abi = uc($c->{abi});
+    if ($abi eq "COMMON" || $abi eq "64") {
+	# COMMON is the same as 64, except that we don't expect X32
+	# programs to use it.  Our expectation has nothing to do with
+	# any generated code, so treat them the same.
+	emit(64, $c->{nr}, $c->{entry}, $c->{compat});
+    } elsif ($abi eq "X32") {
+	# X32 is equivalent to 64 on an X32-compatible kernel.
+	print OUT "#ifdef CONFIG_X86_X32_ABI\n";
+	emit(64, $c->{nr}, $c->{entry}, $c->{compat});
+	print OUT "#endif\n";
+    } elsif ($abi eq "I386") {
+	emit($abi, $c->{nr}, $c->{entry}, $c->{compat});
+    } else {
+	die "Unknown abi $abi";
+    }
+}
+close OUT || die $out;
+
+exit 0;
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index f91ba53e06c8..d83af227d373 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -6,6 +6,7 @@
 #include <asm/ucontext.h>
 
 #define __SYSCALL_I386(nr, sym, qual) [nr] = 1,
+#define __NO_SYSCALL(nr, sym, qual) [nr] = 0,
 static char syscalls[] = {
 #include <asm/syscalls_32.h>
 };
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index bf51e51d808d..8f507236fec5 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -5,6 +5,7 @@
 
 #include <asm/ia32.h>
 
+#define __NO_SYSCALL_(nr) [nr] = 0,
 #define __SYSCALL_64(nr, sym, qual) [nr] = 1,
 static char syscalls_64[] = {
 #include <asm/syscalls_64.h>
