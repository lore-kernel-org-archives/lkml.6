Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeCZURm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:17:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52148 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeCZURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:17:41 -0400
From: Tim Tianyang Chen <tianyang.chen@oracle.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
Subject: [PATCH v3 3/4] Ktest: use dodie for critical falures
Date: Mon, 26 Mar 2018 13:08:03 -0700
Message-Id: <1522094884-22718-4-git-send-email-tianyang.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
References: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803260203
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users should get emails when the script dies because of a critical failure. Critical
failures are defined as any errors that could abnormally terminate the script.

In order to add email support, this patch converts all die() to dodie() except:
 * when '-v' is used as an option to get the version of the script.
 * in Sig-Int handeler because it's not a fatal error to cancel the script.
 * errors happen during parsing config

Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>

---
    Changes since v2:
        revert a change for opening and appending the config file
    Changes since v1:
        revert changes for errors happen during config parsing
---
 ktest.pl | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/ktest.pl b/ktest.pl
index 8be12ee27d34..03514a06844c 100755
--- a/ktest.pl
+++ b/ktest.pl
@@ -1502,7 +1502,7 @@ sub exec_console {
     close($pts);
 
     exec $console or
-	die "Can't open console $console";
+	dodie "Can't open console $console";
 }
 
 sub open_console {
@@ -1650,7 +1650,7 @@ sub save_logs {
 
 	if (!-d $dir) {
 	    mkpath($dir) or
-		die "can't create $dir";
+		dodie "can't create $dir";
 	}
 
 	my %files = (
@@ -1663,7 +1663,7 @@ sub save_logs {
 	while (my ($name, $source) = each(%files)) {
 		if (-f "$source") {
 			cp "$source", "$dir/$name" or
-				die "failed to copy $source";
+				dodie "failed to copy $source";
 		}
 	}
 
@@ -1837,7 +1837,7 @@ sub get_grub2_index {
     $ssh_grub =~ s,\$SSH_COMMAND,cat $grub_file,g;
 
     open(IN, "$ssh_grub |")
-	or die "unable to get $grub_file";
+	or dodie "unable to get $grub_file";
 
     my $found = 0;
 
@@ -1852,7 +1852,7 @@ sub get_grub2_index {
     }
     close(IN);
 
-    die "Could not find '$grub_menu' in $grub_file on $machine"
+    dodie "Could not find '$grub_menu' in $grub_file on $machine"
 	if (!$found);
     doprint "$grub_number\n";
     $last_grub_menu = $grub_menu;
@@ -1880,7 +1880,7 @@ sub get_grub_index {
     $ssh_grub =~ s,\$SSH_COMMAND,cat /boot/grub/menu.lst,g;
 
     open(IN, "$ssh_grub |")
-	or die "unable to get menu.lst";
+	or dodie "unable to get menu.lst";
 
     my $found = 0;
 
@@ -1895,7 +1895,7 @@ sub get_grub_index {
     }
     close(IN);
 
-    die "Could not find '$grub_menu' in /boot/grub/menu on $machine"
+    dodie "Could not find '$grub_menu' in /boot/grub/menu on $machine"
 	if (!$found);
     doprint "$grub_number\n";
     $last_grub_menu = $grub_menu;
@@ -2008,7 +2008,7 @@ sub monitor {
     my $full_line = "";
 
     open(DMESG, "> $dmesg") or
-	die "unable to write to $dmesg";
+	dodie "unable to write to $dmesg";
 
     reboot_to;
 
@@ -2887,7 +2887,7 @@ sub run_bisect {
 sub update_bisect_replay {
     my $tmp_log = "$tmpdir/ktest_bisect_log";
     run_command "git bisect log > $tmp_log" or
-	die "can't create bisect log";
+	dodie "can't create bisect log";
     return $tmp_log;
 }
 
@@ -2896,9 +2896,9 @@ sub bisect {
 
     my $result;
 
-    die "BISECT_GOOD[$i] not defined\n"	if (!defined($bisect_good));
-    die "BISECT_BAD[$i] not defined\n"	if (!defined($bisect_bad));
-    die "BISECT_TYPE[$i] not defined\n"	if (!defined($bisect_type));
+    dodie "BISECT_GOOD[$i] not defined\n"	if (!defined($bisect_good));
+    dodie "BISECT_BAD[$i] not defined\n"	if (!defined($bisect_bad));
+    dodie "BISECT_TYPE[$i] not defined\n"	if (!defined($bisect_type));
 
     my $good = $bisect_good;
     my $bad = $bisect_bad;
@@ -2961,7 +2961,7 @@ sub bisect {
 	if ($check ne "good") {
 	    doprint "TESTING BISECT BAD [$bad]\n";
 	    run_command "git checkout $bad" or
-		die "Failed to checkout $bad";
+		dodie "Failed to checkout $bad";
 
 	    $result = run_bisect $type;
 
@@ -2973,7 +2973,7 @@ sub bisect {
 	if ($check ne "bad") {
 	    doprint "TESTING BISECT GOOD [$good]\n";
 	    run_command "git checkout $good" or
-		die "Failed to checkout $good";
+		dodie "Failed to checkout $good";
 
 	    $result = run_bisect $type;
 
@@ -2984,7 +2984,7 @@ sub bisect {
 
 	# checkout where we started
 	run_command "git checkout $head" or
-	    die "Failed to checkout $head";
+	    dodie "Failed to checkout $head";
     }
 
     run_command "git bisect start$start_files" or
@@ -3441,9 +3441,9 @@ sub patchcheck_reboot {
 sub patchcheck {
     my ($i) = @_;
 
-    die "PATCHCHECK_START[$i] not defined\n"
+    dodie "PATCHCHECK_START[$i] not defined\n"
 	if (!defined($patchcheck_start));
-    die "PATCHCHECK_TYPE[$i] not defined\n"
+    dodie "PATCHCHECK_TYPE[$i] not defined\n"
 	if (!defined($patchcheck_type));
 
     my $start = $patchcheck_start;
@@ -3457,7 +3457,7 @@ sub patchcheck {
     if (defined($patchcheck_end)) {
 	$end = $patchcheck_end;
     } elsif ($cherry) {
-	die "PATCHCHECK_END must be defined with PATCHCHECK_CHERRY\n";
+	dodie "PATCHCHECK_END must be defined with PATCHCHECK_CHERRY\n";
     }
 
     # Get the true sha1's since we can use things like HEAD~3
@@ -3521,7 +3521,7 @@ sub patchcheck {
 	doprint "\nProcessing commit \"$item\"\n\n";
 
 	run_command "git checkout $sha1" or
-	    die "Failed to checkout $sha1";
+	    dodie "Failed to checkout $sha1";
 
 	# only clean on the first and last patch
 	if ($item eq $list[0] ||
@@ -3612,7 +3612,7 @@ sub read_kconfig {
     }
 
     open(KIN, "$kconfig")
-	or die "Can't open $kconfig";
+	or dodie "Can't open $kconfig";
     while (<KIN>) {
 	chomp;
 
@@ -3773,7 +3773,7 @@ sub get_depends {
 
 	    $dep =~ s/^[^$valid]*[$valid]+//;
 	} else {
-	    die "this should never happen";
+	    dodie "this should never happen";
 	}
     }
 
@@ -4034,7 +4034,7 @@ sub make_min_config {
 	    # update new ignore configs
 	    if (defined($ignore_config)) {
 		open (OUT, ">$temp_config")
-		    or die "Can't write to $temp_config";
+		    or dodie "Can't write to $temp_config";
 		foreach my $config (keys %save_configs) {
 		    print OUT "$save_configs{$config}\n";
 		}
@@ -4062,7 +4062,7 @@ sub make_min_config {
 
 	    # Save off all the current mandatory configs
 	    open (OUT, ">$temp_config")
-		or die "Can't write to $temp_config";
+		or dodie "Can't write to $temp_config";
 	    foreach my $config (keys %keep_configs) {
 		print OUT "$keep_configs{$config}\n";
 	    }
@@ -4302,11 +4302,11 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
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
@@ -4343,7 +4343,7 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     if (!-d $tmpdir) {
 	mkpath($tmpdir) or
-	    die "can't create $tmpdir";
+	    dodie "can't create $tmpdir";
     }
 
     $ENV{"SSH_USER"} = $ssh_user;
@@ -4416,7 +4416,7 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     if (defined($checkout)) {
 	run_command "git checkout $checkout" or
-	    die "failed to checkout $checkout";
+	    dodie "failed to checkout $checkout";
     }
 
     $no_reboot = 0;
-- 
2.15.1
