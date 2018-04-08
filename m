Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDHUWg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752697AbeDHUSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8732A2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201834.420716060@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 08/23] ktest: Use config-bisect.pl in ktest.pl
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0008-ktest-Use-config-bisect.pl-in-ktest.pl.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

Reduce code duplication and take advantage of bisection logic
improvements by calling config-bisect.pl.

The output of make oldconfig is now copied directly to the desired file,
rather than doing assign_configs+save_config, in order to preserve the
ordering so that diffing the configs at the end will provide useful
output.

Link: http://lkml.kernel.org/r/20170717001630.10518-8-swood@redhat.com

Signed-off-by: Scott Wood <swood@redhat.com>
[ Modified to use with new version of config-bisect.pl ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 264 +++++++------------------------------------
 1 file changed, 42 insertions(+), 222 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index f597f9b4e8d5..ad00ce699749 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -3092,76 +3092,6 @@ sub create_config {
     make_oldconfig;
 }
 
-# compare two config hashes, and return configs with different vals.
-# It returns B's config values, but you can use A to see what A was.
-sub diff_config_vals {
-    my ($pa, $pb) = @_;
-
-    # crappy Perl way to pass in hashes.
-    my %a = %{$pa};
-    my %b = %{$pb};
-
-    my %ret;
-
-    foreach my $item (keys %a) {
-	if (defined($b{$item}) && $b{$item} ne $a{$item}) {
-	    $ret{$item} = $b{$item};
-	}
-    }
-
-    return %ret;
-}
-
-# compare two config hashes and return the configs in B but not A
-sub diff_configs {
-    my ($pa, $pb) = @_;
-
-    my %ret;
-
-    # crappy Perl way to pass in hashes.
-    my %a = %{$pa};
-    my %b = %{$pb};
-
-    foreach my $item (keys %b) {
-	if (!defined($a{$item})) {
-	    $ret{$item} = $b{$item};
-	}
-    }
-
-    return %ret;
-}
-
-# return if two configs are equal or not
-# 0 is equal +1 b has something a does not
-# +1 if a and b have a different item.
-# -1 if a has something b does not
-sub compare_configs {
-    my ($pa, $pb) = @_;
-
-    my %ret;
-
-    # crappy Perl way to pass in hashes.
-    my %a = %{$pa};
-    my %b = %{$pb};
-
-    foreach my $item (keys %b) {
-	if (!defined($a{$item})) {
-	    return 1;
-	}
-	if ($a{$item} ne $b{$item}) {
-	    return 1;
-	}
-    }
-
-    foreach my $item (keys %a) {
-	if (!defined($b{$item})) {
-	    return -1;
-	}
-    }
-
-    return 0;
-}
-
 sub run_config_bisect_test {
     my ($type) = @_;
 
@@ -3174,166 +3104,49 @@ sub run_config_bisect_test {
     return $ret;
 }
 
-sub process_failed {
-    my ($config) = @_;
+sub config_bisect_end {
+    my ($good, $bad) = @_;
 
     doprint "\n\n***************************************\n";
-    doprint "Found bad config: $config\n";
+    doprint "No more config bisecting possible.\n";
+    doprint `diff -u $good $bad`;
     doprint "***************************************\n\n";
 }
 
-# used for config bisecting
-my $good_config;
-my $bad_config;
-
-sub process_new_config {
-    my ($tc, $nc, $gc, $bc) = @_;
-
-    my %tmp_config = %{$tc};
-    my %good_configs = %{$gc};
-    my %bad_configs = %{$bc};
-
-    my %new_configs;
-
-    my $runtest = 1;
-    my $ret;
-
-    create_config "tmp_configs", \%tmp_config;
-    assign_configs \%new_configs, $output_config;
-
-    $ret = compare_configs \%new_configs, \%bad_configs;
-    if (!$ret) {
-	doprint "New config equals bad config, try next test\n";
-	$runtest = 0;
-    }
-
-    if ($runtest) {
-	$ret = compare_configs \%new_configs, \%good_configs;
-	if (!$ret) {
-	    doprint "New config equals good config, try next test\n";
-	    $runtest = 0;
-	}
-    }
-
-    %{$nc} = %new_configs;
-
-    return $runtest;
-}
-
 sub run_config_bisect {
-    my ($pgood, $pbad) = @_;
-
-    my $type = $config_bisect_type;
-
-    my %good_configs = %{$pgood};
-    my %bad_configs = %{$pbad};
-
-    my %diff_configs = diff_config_vals \%good_configs, \%bad_configs;
-    my %b_configs = diff_configs \%good_configs, \%bad_configs;
-    my %g_configs = diff_configs \%bad_configs, \%good_configs;
-
-    my @diff_arr = keys %diff_configs;
-    my $len_diff = $#diff_arr + 1;
-
-    my @b_arr = keys %b_configs;
-    my $len_b = $#b_arr + 1;
-
-    my @g_arr = keys %g_configs;
-    my $len_g = $#g_arr + 1;
-
-    my $runtest = 1;
-    my %new_configs;
+    my ($good, $bad, $last_result) = @_;
+    my $cmd;
     my $ret;
 
-    # First, lets get it down to a single subset.
-    # Is the problem with a difference in values?
-    # Is the problem with a missing config?
-    # Is the problem with a config that breaks things?
-
-    # Enable all of one set and see if we get a new bad
-    # or good config.
-
-    # first set the good config to the bad values.
-
-    doprint "d=$len_diff g=$len_g b=$len_b\n";
-
-    # first lets enable things in bad config that are enabled in good config
-
-    if ($len_diff > 0) {
-	if ($len_b > 0 || $len_g > 0) {
-	    my %tmp_config = %bad_configs;
-
-	    doprint "Set tmp config to be bad config with good config values\n";
-	    foreach my $item (@diff_arr) {
-		$tmp_config{$item} = $good_configs{$item};
-	    }
-
-	    $runtest = process_new_config \%tmp_config, \%new_configs,
-			    \%good_configs, \%bad_configs;
-	}
-    }
-
-    if (!$runtest && $len_diff > 0) {
-
-	if ($len_diff == 1) {
-	    process_failed $diff_arr[0];
-	    return 1;
-	}
-	my %tmp_config = %bad_configs;
-
-	my $half = int($#diff_arr / 2);
-	my @tophalf = @diff_arr[0 .. $half];
-
-	doprint "Settings bisect with top half:\n";
-	doprint "Set tmp config to be bad config with some good config values\n";
-	foreach my $item (@tophalf) {
-	    $tmp_config{$item} = $good_configs{$item};
-	}
-
-	$runtest = process_new_config \%tmp_config, \%new_configs,
-			    \%good_configs, \%bad_configs;
-
-	if (!$runtest) {
-	    my %tmp_config = %bad_configs;
-
-	    doprint "Try bottom half\n";
-
-	    my @bottomhalf = @diff_arr[$half+1 .. $#diff_arr];
-
-	    foreach my $item (@bottomhalf) {
-		$tmp_config{$item} = $good_configs{$item};
-	    }
+    run_command "$builddir/tools/testing/ktest/config-bisect.pl -b $outputdir $good $bad $last_result";
 
-	    $runtest = process_new_config \%tmp_config, \%new_configs,
-			    \%good_configs, \%bad_configs;
-	}
+    # config-bisect returns:
+    #   0 if there is more to bisect
+    #   1 for finding a good config
+    #   2 if it can not find any more configs
+    #  -1 (255) on error
+    if ($run_command_status) {
+	return $run_command_status;
     }
 
-    if ($runtest) {
-	$ret = run_config_bisect_test $type;
-	if ($ret) {
-	    doprint "NEW GOOD CONFIG\n";
-	    %good_configs = %new_configs;
-	    run_command "mv $good_config ${good_config}.last";
-	    save_config \%good_configs, $good_config;
-	    %{$pgood} = %good_configs;
-	} else {
-	    doprint "NEW BAD CONFIG\n";
-	    %bad_configs = %new_configs;
-	    run_command "mv $bad_config ${bad_config}.last";
-	    save_config \%bad_configs, $bad_config;
-	    %{$pbad} = %bad_configs;
-	}
-	return 0;
+    $ret = run_config_bisect_test $config_bisect_type;
+    if ($ret) {
+        doprint "NEW GOOD CONFIG\n";
+	# Return 3 for good config
+	return 3;
+    } else {
+        doprint "NEW BAD CONFIG\n";
+	# Return 4 for bad config
+	return 4;
     }
-
-    fail "Hmm, need to do a mix match?\n";
-    return -1;
 }
 
 sub config_bisect {
     my ($i) = @_;
 
+    my $good_config;
+    my $bad_config;
+
     my $type = $config_bisect_type;
     my $ret;
 
@@ -3364,18 +3177,14 @@ sub config_bisect {
     doprint "Run good configs through make oldconfig\n";
     assign_configs \%tmp_configs, $good_config;
     create_config "$good_config", \%tmp_configs;
-    assign_configs \%good_configs, $output_config;
+    $good_config = "$tmpdir/good_config";
+    system("cp $output_config $good_config") == 0 or dodie "cp good config";
 
     doprint "Run bad configs through make oldconfig\n";
     assign_configs \%tmp_configs, $bad_config;
     create_config "$bad_config", \%tmp_configs;
-    assign_configs \%bad_configs, $output_config;
-
-    $good_config = "$tmpdir/good_config";
     $bad_config = "$tmpdir/bad_config";
-
-    save_config \%good_configs, $good_config;
-    save_config \%bad_configs, $bad_config;
+    system("cp $output_config $bad_config") == 0 or dodie "cp bad config";
 
     if (defined($config_bisect_check) && $config_bisect_check ne "0") {
 	if ($config_bisect_check ne "good") {
@@ -3398,10 +3207,21 @@ sub config_bisect {
 	}
     }
 
+    my $last_run = "";
+
     do {
-	$ret = run_config_bisect \%good_configs, \%bad_configs;
+	$ret = run_config_bisect $good_config, $bad_config, $last_run;
+	if ($ret == 3) {
+	    $last_run = "good";
+	} elsif ($ret == 4) {
+	    $last_run = "bad";
+	}
 	print_times;
-    } while (!$ret);
+    } while ($ret == 3 || $ret == 4);
+
+    if ($ret == 2) {
+        config_bisect_end "$good_config.tmp", "$bad_config.tmp";
+    }
 
     return $ret if ($ret < 0);
 
-- 
2.16.3
