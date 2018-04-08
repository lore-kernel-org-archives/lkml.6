Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeDHUUz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbeDHUSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8952183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201835.945799033@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>
Subject: [for-next][PATCH 16/23] Ktest: Use dodie for critical falures
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0016-Ktest-Use-dodie-for-critical-falures.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Tianyang Chen <tianyang.chen@oracle.com>

Users should get emails when the script dies because of a critical failure.
Critical failures are defined as any errors that could abnormally terminate
the script.

In order to add email support, this patch converts all die() to dodie() except:
 * when '-v' is used as an option to get the version of the script.
 * in Sig-Int handeler because it's not a fatal error to cancel the script.
 * errors happen during parsing config

Link: http://lkml.kernel.org/r/1522094884-22718-4-git-send-email-tianyang.chen@oracle.com

Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 54 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 1646af526089..30a4c053f98b 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1506,7 +1506,7 @@ sub exec_console {
     close($pts);
 
     exec $console or
-	die "Can't open console $console";
+	dodie "Can't open console $console";
 }
 
 sub open_console {
@@ -1657,7 +1657,7 @@ sub save_logs {
 
 	if (!-d $dir) {
 	    mkpath($dir) or
-		die "can't create $dir";
+		dodie "can't create $dir";
 	}
 
 	my %files = (
@@ -1670,7 +1670,7 @@ sub save_logs {
 	while (my ($name, $source) = each(%files)) {
 		if (-f "$source") {
 			cp "$source", "$dir/$name" or
-				die "failed to copy $source";
+				dodie "failed to copy $source";
 		}
 	}
 
@@ -1852,7 +1852,7 @@ sub get_grub2_index {
     $ssh_grub =~ s,\$SSH_COMMAND,cat $grub_file,g;
 
     open(IN, "$ssh_grub |")
-	or die "unable to get $grub_file";
+	or dodie "unable to get $grub_file";
 
     my $found = 0;
 
@@ -1867,7 +1867,7 @@ sub get_grub2_index {
     }
     close(IN);
 
-    die "Could not find '$grub_menu' in $grub_file on $machine"
+    dodie "Could not find '$grub_menu' in $grub_file on $machine"
 	if (!$found);
     doprint "$grub_number\n";
     $last_grub_menu = $grub_menu;
@@ -1895,7 +1895,7 @@ sub get_grub_index {
     $ssh_grub =~ s,\$SSH_COMMAND,cat /boot/grub/menu.lst,g;
 
     open(IN, "$ssh_grub |")
-	or die "unable to get menu.lst";
+	or dodie "unable to get menu.lst";
 
     my $found = 0;
 
@@ -1910,7 +1910,7 @@ sub get_grub_index {
     }
     close(IN);
 
-    die "Could not find '$grub_menu' in /boot/grub/menu on $machine"
+    dodie "Could not find '$grub_menu' in /boot/grub/menu on $machine"
 	if (!$found);
     doprint "$grub_number\n";
     $last_grub_menu = $grub_menu;
@@ -2023,7 +2023,7 @@ sub monitor {
     my $full_line = "";
 
     open(DMESG, "> $dmesg") or
-	die "unable to write to $dmesg";
+	dodie "unable to write to $dmesg";
 
     reboot_to;
 
@@ -2902,7 +2902,7 @@ sub run_bisect {
 sub update_bisect_replay {
     my $tmp_log = "$tmpdir/ktest_bisect_log";
     run_command "git bisect log > $tmp_log" or
-	die "can't create bisect log";
+	dodie "can't create bisect log";
     return $tmp_log;
 }
 
@@ -2911,9 +2911,9 @@ sub bisect {
 
     my $result;
 
-    die "BISECT_GOOD[$i] not defined\n"	if (!defined($bisect_good));
-    die "BISECT_BAD[$i] not defined\n"	if (!defined($bisect_bad));
-    die "BISECT_TYPE[$i] not defined\n"	if (!defined($bisect_type));
+    dodie "BISECT_GOOD[$i] not defined\n"	if (!defined($bisect_good));
+    dodie "BISECT_BAD[$i] not defined\n"	if (!defined($bisect_bad));
+    dodie "BISECT_TYPE[$i] not defined\n"	if (!defined($bisect_type));
 
     my $good = $bisect_good;
     my $bad = $bisect_bad;
@@ -2976,7 +2976,7 @@ sub bisect {
 	if ($check ne "good") {
 	    doprint "TESTING BISECT BAD [$bad]\n";
 	    run_command "git checkout $bad" or
-		die "Failed to checkout $bad";
+		dodie "Failed to checkout $bad";
 
 	    $result = run_bisect $type;
 
@@ -2988,7 +2988,7 @@ sub bisect {
 	if ($check ne "bad") {
 	    doprint "TESTING BISECT GOOD [$good]\n";
 	    run_command "git checkout $good" or
-		die "Failed to checkout $good";
+		dodie "Failed to checkout $good";
 
 	    $result = run_bisect $type;
 
@@ -2999,7 +2999,7 @@ sub bisect {
 
 	# checkout where we started
 	run_command "git checkout $head" or
-	    die "Failed to checkout $head";
+	    dodie "Failed to checkout $head";
     }
 
     run_command "git bisect start$start_files" or
@@ -3316,9 +3316,9 @@ sub patchcheck_reboot {
 sub patchcheck {
     my ($i) = @_;
 
-    die "PATCHCHECK_START[$i] not defined\n"
+    dodie "PATCHCHECK_START[$i] not defined\n"
 	if (!defined($patchcheck_start));
-    die "PATCHCHECK_TYPE[$i] not defined\n"
+    dodie "PATCHCHECK_TYPE[$i] not defined\n"
 	if (!defined($patchcheck_type));
 
     my $start = $patchcheck_start;
@@ -3332,7 +3332,7 @@ sub patchcheck {
     if (defined($patchcheck_end)) {
 	$end = $patchcheck_end;
     } elsif ($cherry) {
-	die "PATCHCHECK_END must be defined with PATCHCHECK_CHERRY\n";
+	dodie "PATCHCHECK_END must be defined with PATCHCHECK_CHERRY\n";
     }
 
     # Get the true sha1's since we can use things like HEAD~3
@@ -3396,7 +3396,7 @@ sub patchcheck {
 	doprint "\nProcessing commit \"$item\"\n\n";
 
 	run_command "git checkout $sha1" or
-	    die "Failed to checkout $sha1";
+	    dodie "Failed to checkout $sha1";
 
 	# only clean on the first and last patch
 	if ($item eq $list[0] ||
@@ -3487,7 +3487,7 @@ sub read_kconfig {
     }
 
     open(KIN, "$kconfig")
-	or die "Can't open $kconfig";
+	or dodie "Can't open $kconfig";
     while (<KIN>) {
 	chomp;
 
@@ -3648,7 +3648,7 @@ sub get_depends {
 
 	    $dep =~ s/^[^$valid]*[$valid]+//;
 	} else {
-	    die "this should never happen";
+	    dodie "this should never happen";
 	}
     }
 
@@ -3909,7 +3909,7 @@ sub make_min_config {
 	    # update new ignore configs
 	    if (defined($ignore_config)) {
 		open (OUT, ">$temp_config")
-		    or die "Can't write to $temp_config";
+		    or dodie "Can't write to $temp_config";
 		foreach my $config (keys %save_configs) {
 		    print OUT "$save_configs{$config}\n";
 		}
@@ -3937,7 +3937,7 @@ sub make_min_config {
 
 	    # Save off all the current mandatory configs
 	    open (OUT, ">$temp_config")
-		or die "Can't write to $temp_config";
+		or dodie "Can't write to $temp_config";
 	    foreach my $config (keys %keep_configs) {
 		print OUT "$keep_configs{$config}\n";
 	    }
@@ -4177,11 +4177,11 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
     $outputdir = set_test_option("OUTPUT_DIR", $i);
     $builddir = set_test_option("BUILD_DIR", $i);
 
-    chdir $builddir || die "can't change directory to $builddir";
+    chdir $builddir || dodie "can't change directory to $builddir";
 
     if (!-d $outputdir) {
 	mkpath($outputdir) or
-	    die "can't create $outputdir";
+	    dodie "can't create $outputdir";
     }
 
     $make = "$makecmd O=$outputdir";
@@ -4218,7 +4218,7 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     if (!-d $tmpdir) {
 	mkpath($tmpdir) or
-	    die "can't create $tmpdir";
+	    dodie "can't create $tmpdir";
     }
 
     $ENV{"SSH_USER"} = $ssh_user;
@@ -4291,7 +4291,7 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     if (defined($checkout)) {
 	run_command "git checkout $checkout" or
-	    die "failed to checkout $checkout";
+	    dodie "failed to checkout $checkout";
     }
 
     $no_reboot = 0;
-- 
2.16.3
