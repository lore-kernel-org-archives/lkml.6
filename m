Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeDKNSI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752906AbeDKNSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:18:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8E52178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 11 Apr 2018 09:18:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "John 'Warthog9' Hawley" <warthog9@kernel.org>
Subject: [GIT PULL] ktest: Updates for 4.17
Message-ID: <20180411091803.49da7d82@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

These commits have either been sitting in my INBOX or have been
in my local tree for some time. I need to push them upstream:

 - Separate out config-bisect.pl from ktest.pl.
   This allows users to do config bisects without full ktest setup.

 - Email on status change.
   Allow the user to be emailed on test start, finish, failure, etc.

 - Other small fixes and enhancements


Please pull the latest ktest-v4.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v4.17

Tag SHA1: 34296dfde52ec4aed68a951d79a25ba1f94f5f71
Head SHA1: 6cd110a91f52197e3392809cd43466bfe2c524d0


Satoru Takeuchi (1):
      ktest: Take submenu into account for grub2 menus

Scott Wood (4):
      ktest: Clarify config file usage
      ktest: Set buildonly=1 for CONFIG_BISECT_TYPE=build
      ktest: Set do_not_reboot=y for CONFIG_BISECT_TYPE=build
      ktest: Use config-bisect.pl in ktest.pl

Steven Rostedt (Red Hat) (1):
      ktest: Add standalone config-bisect.pl program

Steven Rostedt (VMware) (14):
      ktest: Wait for console process to exit
      ktest: Add CONNECT_TIMEOUT to change the connection timeout time
      ktest: Comment about other names than just ktest.conf
      ktest.pl: Allow for the config-bisect.pl output to display to console
      ktest.pl: Use diffconfig if available for failed config bisects
      ktest.pl: Have ktest.pl pass -r to config-bisect.pl to reset bisect
      ktest.pl: Make finding config-bisect.pl dynamic
      ktest.pl: Detect if a config-bisect was interrupted
      ktest.pl: No need to print no mailer is specified when mailto is not
      ktest.pl: Add MAIL_PATH option to define where to find the mailer
      ktest.pl: Kill test if mailer is not supported
      ktest.pl: Allow dodie be recursive
      ktest.pl: Use run_command to execute sending mail
      ktest.pl: Add MAIL_COMMAND option to define how to send email

Tim Tianyang Chen (4):
      Ktest: Add email support
      Ktest: Add SigInt handling
      Ktest: Use dodie for critical falures
      Ktest: add email options to sample.config

----
 tools/testing/ktest/config-bisect.pl | 770 +++++++++++++++++++++++++++++++++++
 tools/testing/ktest/ktest.pl         | 533 ++++++++++++------------
 tools/testing/ktest/sample.conf      |  60 +++
 3 files changed, 1091 insertions(+), 272 deletions(-)
 create mode 100755 tools/testing/ktest/config-bisect.pl
---------------------------
diff --git a/tools/testing/ktest/config-bisect.pl b/tools/testing/ktest/config-bisect.pl
new file mode 100755
index 000000000000..b28feea7c363
--- /dev/null
+++ b/tools/testing/ktest/config-bisect.pl
@@ -0,0 +1,770 @@
+#!/usr/bin/perl -w
+#
+# Copyright 2015 - Steven Rostedt, Red Hat Inc.
+# Copyright 2017 - Steven Rostedt, VMware, Inc.
+#
+# Licensed under the terms of the GNU GPL License version 2
+#
+
+# usage:
+#  config-bisect.pl [options] good-config bad-config [good|bad]
+#
+
+# Compares a good config to a bad config, then takes half of the diffs
+# and produces a config that is somewhere between the good config and
+# the bad config. That is, the resulting config will start with the
+# good config and will try to make half of the differences of between
+# the good and bad configs match the bad config. It tries because of
+# dependencies between the two configs it may not be able to change
+# exactly half of the configs that are different between the two config
+# files.
+
+# Here's a normal way to use it:
+#
+#  $ cd /path/to/linux/kernel
+#  $ config-bisect.pl /path/to/good/config /path/to/bad/config
+
+# This will now pull in good config (blowing away .config in that directory
+# so do not make that be one of the good or bad configs), and then
+# build the config with "make oldconfig" to make sure it matches the
+# current kernel. It will then store the configs in that result for
+# the good config. It does the same for the bad config as well.
+# The algorithm will run, merging half of the differences between
+# the two configs and building them with "make oldconfig" to make sure
+# the result changes (dependencies may reset changes the tool had made).
+# It then copies the result of its good config to /path/to/good/config.tmp
+# and the bad config to /path/to/bad/config.tmp (just appends ".tmp" to the
+# files passed in). And the ".config" that you should test will be in
+# directory
+
+# After the first run, determine if the result is good or bad then
+# run the same command appending the result
+
+# For good results:
+#  $ config-bisect.pl /path/to/good/config /path/to/bad/config good
+
+# For bad results:
+#  $ config-bisect.pl /path/to/good/config /path/to/bad/config bad
+
+# Do not change the good-config or bad-config, config-bisect.pl will
+# copy the good-config to a temp file with the same name as good-config
+# but with a ".tmp" after it. It will do the same with the bad-config.
+
+# If "good" or "bad" is not stated at the end, it will copy the good and
+# bad configs to the .tmp versions. If a .tmp version already exists, it will
+# warn before writing over them (-r will not warn, and just write over them).
+# If the last config is labeled "good", then it will copy it to the good .tmp
+# version. If the last config is labeled "bad", it will copy it to the bad
+# .tmp version. It will continue this until it can not merge the two any more
+# without the result being equal to either the good or bad .tmp configs.
+
+my $start = 0;
+my $val = "";
+
+my $pwd = `pwd`;
+chomp $pwd;
+my $tree = $pwd;
+my $build;
+
+my $output_config;
+my $reset_bisect;
+
+sub usage {
+    print << "EOF"
+
+usage: config-bisect.pl [-l linux-tree][-b build-dir] good-config bad-config [good|bad]
+  -l [optional] define location of linux-tree (default is current directory)
+  -b [optional] define location to build (O=build-dir) (default is linux-tree)
+  good-config the config that is considered good
+  bad-config the config that does not work
+  "good" add this if the last run produced a good config
+  "bad" add this if the last run produced a bad config
+  If "good" or "bad" is not specified, then it is the start of a new bisect
+
+  Note, each run will create copy of good and bad configs with ".tmp" appended.
+
+EOF
+;
+
+    exit(-1);
+}
+
+sub doprint {
+    print @_;
+}
+
+sub dodie {
+    doprint "CRITICAL FAILURE... ", @_, "\n";
+
+    die @_, "\n";
+}
+
+sub expand_path {
+    my ($file) = @_;
+
+    if ($file =~ m,^/,) {
+	return $file;
+    }
+    return "$pwd/$file";
+}
+
+sub read_prompt {
+    my ($cancel, $prompt) = @_;
+
+    my $ans;
+
+    for (;;) {
+	if ($cancel) {
+	    print "$prompt [y/n/C] ";
+	} else {
+	    print "$prompt [y/N] ";
+	}
+	$ans = <STDIN>;
+	chomp $ans;
+	if ($ans =~ /^\s*$/) {
+	    if ($cancel) {
+		$ans = "c";
+	    } else {
+		$ans = "n";
+	    }
+	}
+	last if ($ans =~ /^y$/i || $ans =~ /^n$/i);
+	if ($cancel) {
+	    last if ($ans =~ /^c$/i);
+	    print "Please answer either 'y', 'n' or 'c'.\n";
+	} else {
+	    print "Please answer either 'y' or 'n'.\n";
+	}
+    }
+    if ($ans =~ /^c/i) {
+	exit;
+    }
+    if ($ans !~ /^y$/i) {
+	return 0;
+    }
+    return 1;
+}
+
+sub read_yn {
+    my ($prompt) = @_;
+
+    return read_prompt 0, $prompt;
+}
+
+sub read_ync {
+    my ($prompt) = @_;
+
+    return read_prompt 1, $prompt;
+}
+
+sub run_command {
+    my ($command, $redirect) = @_;
+    my $start_time;
+    my $end_time;
+    my $dord = 0;
+    my $pid;
+
+    $start_time = time;
+
+    doprint("$command ... ");
+
+    $pid = open(CMD, "$command 2>&1 |") or
+	dodie "unable to exec $command";
+
+    if (defined($redirect)) {
+	open (RD, ">$redirect") or
+	    dodie "failed to write to redirect $redirect";
+	$dord = 1;
+    }
+
+    while (<CMD>) {
+	print RD  if ($dord);
+    }
+
+    waitpid($pid, 0);
+    my $failed = $?;
+
+    close(CMD);
+    close(RD)  if ($dord);
+
+    $end_time = time;
+    my $delta = $end_time - $start_time;
+
+    if ($delta == 1) {
+	doprint "[1 second] ";
+    } else {
+	doprint "[$delta seconds] ";
+    }
+
+    if ($failed) {
+	doprint "FAILED!\n";
+    } else {
+	doprint "SUCCESS\n";
+    }
+
+    return !$failed;
+}
+
+###### CONFIG BISECT ######
+
+# config_ignore holds the configs that were set (or unset) for
+# a good config and we will ignore these configs for the rest
+# of a config bisect. These configs stay as they were.
+my %config_ignore;
+
+# config_set holds what all configs were set as.
+my %config_set;
+
+# config_off holds the set of configs that the bad config had disabled.
+# We need to record them and set them in the .config when running
+# olddefconfig, because olddefconfig keeps the defaults.
+my %config_off;
+
+# config_off_tmp holds a set of configs to turn off for now
+my @config_off_tmp;
+
+# config_list is the set of configs that are being tested
+my %config_list;
+my %null_config;
+
+my %dependency;
+
+my $make;
+
+sub make_oldconfig {
+
+    if (!run_command "$make olddefconfig") {
+	# Perhaps olddefconfig doesn't exist in this version of the kernel
+	# try oldnoconfig
+	doprint "olddefconfig failed, trying make oldnoconfig\n";
+	if (!run_command "$make oldnoconfig") {
+	    doprint "oldnoconfig failed, trying yes '' | make oldconfig\n";
+	    # try a yes '' | oldconfig
+	    run_command "yes '' | $make oldconfig" or
+		dodie "failed make config oldconfig";
+	}
+    }
+}
+
+sub assign_configs {
+    my ($hash, $config) = @_;
+
+    doprint "Reading configs from $config\n";
+
+    open (IN, $config)
+	or dodie "Failed to read $config";
+
+    while (<IN>) {
+	chomp;
+	if (/^((CONFIG\S*)=.*)/) {
+	    ${$hash}{$2} = $1;
+	} elsif (/^(# (CONFIG\S*) is not set)/) {
+	    ${$hash}{$2} = $1;
+	}
+    }
+
+    close(IN);
+}
+
+sub process_config_ignore {
+    my ($config) = @_;
+
+    assign_configs \%config_ignore, $config;
+}
+
+sub get_dependencies {
+    my ($config) = @_;
+
+    my $arr = $dependency{$config};
+    if (!defined($arr)) {
+	return ();
+    }
+
+    my @deps = @{$arr};
+
+    foreach my $dep (@{$arr}) {
+	print "ADD DEP $dep\n";
+	@deps = (@deps, get_dependencies $dep);
+    }
+
+    return @deps;
+}
+
+sub save_config {
+    my ($pc, $file) = @_;
+
+    my %configs = %{$pc};
+
+    doprint "Saving configs into $file\n";
+
+    open(OUT, ">$file") or dodie "Can not write to $file";
+
+    foreach my $config (keys %configs) {
+	print OUT "$configs{$config}\n";
+    }
+    close(OUT);
+}
+
+sub create_config {
+    my ($name, $pc) = @_;
+
+    doprint "Creating old config from $name configs\n";
+
+    save_config $pc, $output_config;
+
+    make_oldconfig;
+}
+
+# compare two config hashes, and return configs with different vals.
+# It returns B's config values, but you can use A to see what A was.
+sub diff_config_vals {
+    my ($pa, $pb) = @_;
+
+    # crappy Perl way to pass in hashes.
+    my %a = %{$pa};
+    my %b = %{$pb};
+
+    my %ret;
+
+    foreach my $item (keys %a) {
+	if (defined($b{$item}) && $b{$item} ne $a{$item}) {
+	    $ret{$item} = $b{$item};
+	}
+    }
+
+    return %ret;
+}
+
+# compare two config hashes and return the configs in B but not A
+sub diff_configs {
+    my ($pa, $pb) = @_;
+
+    my %ret;
+
+    # crappy Perl way to pass in hashes.
+    my %a = %{$pa};
+    my %b = %{$pb};
+
+    foreach my $item (keys %b) {
+	if (!defined($a{$item})) {
+	    $ret{$item} = $b{$item};
+	}
+    }
+
+    return %ret;
+}
+
+# return if two configs are equal or not
+# 0 is equal +1 b has something a does not
+# +1 if a and b have a different item.
+# -1 if a has something b does not
+sub compare_configs {
+    my ($pa, $pb) = @_;
+
+    my %ret;
+
+    # crappy Perl way to pass in hashes.
+    my %a = %{$pa};
+    my %b = %{$pb};
+
+    foreach my $item (keys %b) {
+	if (!defined($a{$item})) {
+	    return 1;
+	}
+	if ($a{$item} ne $b{$item}) {
+	    return 1;
+	}
+    }
+
+    foreach my $item (keys %a) {
+	if (!defined($b{$item})) {
+	    return -1;
+	}
+    }
+
+    return 0;
+}
+
+sub process_failed {
+    my ($config) = @_;
+
+    doprint "\n\n***************************************\n";
+    doprint "Found bad config: $config\n";
+    doprint "***************************************\n\n";
+}
+
+sub process_new_config {
+    my ($tc, $nc, $gc, $bc) = @_;
+
+    my %tmp_config = %{$tc};
+    my %good_configs = %{$gc};
+    my %bad_configs = %{$bc};
+
+    my %new_configs;
+
+    my $runtest = 1;
+    my $ret;
+
+    create_config "tmp_configs", \%tmp_config;
+    assign_configs \%new_configs, $output_config;
+
+    $ret = compare_configs \%new_configs, \%bad_configs;
+    if (!$ret) {
+	doprint "New config equals bad config, try next test\n";
+	$runtest = 0;
+    }
+
+    if ($runtest) {
+	$ret = compare_configs \%new_configs, \%good_configs;
+	if (!$ret) {
+	    doprint "New config equals good config, try next test\n";
+	    $runtest = 0;
+	}
+    }
+
+    %{$nc} = %new_configs;
+
+    return $runtest;
+}
+
+sub convert_config {
+    my ($config) = @_;
+
+    if ($config =~ /^# (.*) is not set/) {
+	$config = "$1=n";
+    }
+
+    $config =~ s/^CONFIG_//;
+    return $config;
+}
+
+sub print_config {
+    my ($sym, $config) = @_;
+
+    $config = convert_config $config;
+    doprint "$sym$config\n";
+}
+
+sub print_config_compare {
+    my ($good_config, $bad_config) = @_;
+
+    $good_config = convert_config $good_config;
+    $bad_config = convert_config $bad_config;
+
+    my $good_value = $good_config;
+    my $bad_value = $bad_config;
+    $good_value =~ s/(.*)=//;
+    my $config = $1;
+
+    $bad_value =~ s/.*=//;
+
+    doprint " $config $good_value -> $bad_value\n";
+}
+
+# Pass in:
+# $phalf: half of the configs names you want to add
+# $oconfigs: The orginial configs to start with
+# $sconfigs: The source to update $oconfigs with (from $phalf)
+# $which: The name of which half that is updating (top / bottom)
+# $type: The name of the source type (good / bad)
+sub make_half {
+    my ($phalf, $oconfigs, $sconfigs, $which, $type) = @_;
+
+    my @half = @{$phalf};
+    my %orig_configs = %{$oconfigs};
+    my %source_configs = %{$sconfigs};
+
+    my %tmp_config = %orig_configs;
+
+    doprint "Settings bisect with $which half of $type configs:\n";
+    foreach my $item (@half) {
+	doprint "Updating $item to $source_configs{$item}\n";
+	$tmp_config{$item} = $source_configs{$item};
+    }
+
+    return %tmp_config;
+}
+
+sub run_config_bisect {
+    my ($pgood, $pbad) = @_;
+
+    my %good_configs = %{$pgood};
+    my %bad_configs = %{$pbad};
+
+    my %diff_configs = diff_config_vals \%good_configs, \%bad_configs;
+    my %b_configs = diff_configs \%good_configs, \%bad_configs;
+    my %g_configs = diff_configs \%bad_configs, \%good_configs;
+
+    # diff_arr is what is in both good and bad but are different (y->n)
+    my @diff_arr = keys %diff_configs;
+    my $len_diff = $#diff_arr + 1;
+
+    # b_arr is what is in bad but not in good (has depends)
+    my @b_arr = keys %b_configs;
+    my $len_b = $#b_arr + 1;
+
+    # g_arr is what is in good but not in bad
+    my @g_arr = keys %g_configs;
+    my $len_g = $#g_arr + 1;
+
+    my $runtest = 0;
+    my %new_configs;
+    my $ret;
+
+    # Look at the configs that are different between good and bad.
+    # This does not include those that depend on other configs
+    #  (configs depending on other configs that are not set would
+    #   not show up even as a "# CONFIG_FOO is not set"
+
+
+    doprint "# of configs to check:             $len_diff\n";
+    doprint "# of configs showing only in good: $len_g\n";
+    doprint "# of configs showing only in bad:  $len_b\n";
+
+    if ($len_diff > 0) {
+	# Now test for different values
+
+	doprint "Configs left to check:\n";
+	doprint "  Good Config\t\t\tBad Config\n";
+	doprint "  -----------\t\t\t----------\n";
+	foreach my $item (@diff_arr) {
+	    doprint "  $good_configs{$item}\t$bad_configs{$item}\n";
+	}
+
+	my $half = int($#diff_arr / 2);
+	my @tophalf = @diff_arr[0 .. $half];
+
+	doprint "Set tmp config to be good config with some bad config values\n";
+
+	my %tmp_config = make_half \@tophalf, \%good_configs,
+	    \%bad_configs, "top", "bad";
+
+	$runtest = process_new_config \%tmp_config, \%new_configs,
+			    \%good_configs, \%bad_configs;
+
+	if (!$runtest) {
+	    doprint "Set tmp config to be bad config with some good config values\n";
+
+	    my %tmp_config = make_half \@tophalf, \%bad_configs,
+		\%good_configs, "top", "good";
+
+	    $runtest = process_new_config \%tmp_config, \%new_configs,
+		\%good_configs, \%bad_configs;
+	}
+    }
+
+    if (!$runtest && $len_diff > 0) {
+	# do the same thing, but this time with bottom half
+
+	my $half = int($#diff_arr / 2);
+	my @bottomhalf = @diff_arr[$half+1 .. $#diff_arr];
+
+	doprint "Set tmp config to be good config with some bad config values\n";
+
+	my %tmp_config = make_half \@bottomhalf, \%good_configs,
+	    \%bad_configs, "bottom", "bad";
+
+	$runtest = process_new_config \%tmp_config, \%new_configs,
+			    \%good_configs, \%bad_configs;
+
+	if (!$runtest) {
+	    doprint "Set tmp config to be bad config with some good config values\n";
+
+	    my %tmp_config = make_half \@bottomhalf, \%bad_configs,
+		\%good_configs, "bottom", "good";
+
+	    $runtest = process_new_config \%tmp_config, \%new_configs,
+		\%good_configs, \%bad_configs;
+	}
+    }
+
+    if ($runtest) {
+	make_oldconfig;
+	doprint "READY TO TEST .config IN $build\n";
+	return 0;
+    }
+
+    doprint "\n%%%%%%%% FAILED TO FIND SINGLE BAD CONFIG %%%%%%%%\n";
+    doprint "Hmm, can't make any more changes without making good == bad?\n";
+    doprint "Difference between good (+) and bad (-)\n";
+
+    foreach my $item (keys %bad_configs) {
+	if (!defined($good_configs{$item})) {
+	    print_config "-", $bad_configs{$item};
+	}
+    }
+
+    foreach my $item (keys %good_configs) {
+	next if (!defined($bad_configs{$item}));
+	if ($good_configs{$item} ne $bad_configs{$item}) {
+	    print_config_compare $good_configs{$item}, $bad_configs{$item};
+	}
+    }
+
+    foreach my $item (keys %good_configs) {
+	if (!defined($bad_configs{$item})) {
+	    print_config "+", $good_configs{$item};
+	}
+    }
+    return -1;
+}
+
+sub config_bisect {
+    my ($good_config, $bad_config) = @_;
+    my $ret;
+
+    my %good_configs;
+    my %bad_configs;
+    my %tmp_configs;
+
+    doprint "Run good configs through make oldconfig\n";
+    assign_configs \%tmp_configs, $good_config;
+    create_config "$good_config", \%tmp_configs;
+    assign_configs \%good_configs, $output_config;
+
+    doprint "Run bad configs through make oldconfig\n";
+    assign_configs \%tmp_configs, $bad_config;
+    create_config "$bad_config", \%tmp_configs;
+    assign_configs \%bad_configs, $output_config;
+
+    save_config \%good_configs, $good_config;
+    save_config \%bad_configs, $bad_config;
+
+    return run_config_bisect \%good_configs, \%bad_configs;
+}
+
+while ($#ARGV >= 0) {
+    if ($ARGV[0] !~ m/^-/) {
+	last;
+    }
+    my $opt = shift @ARGV;
+
+    if ($opt eq "-b") {
+	$val = shift @ARGV;
+	if (!defined($val)) {
+	    die "-b requires value\n";
+	}
+	$build = $val;
+    }
+
+    elsif ($opt eq "-l") {
+	$val = shift @ARGV;
+	if (!defined($val)) {
+	    die "-l requires value\n";
+	}
+	$tree = $val;
+    }
+
+    elsif ($opt eq "-r") {
+	$reset_bisect = 1;
+    }
+
+    elsif ($opt eq "-h") {
+	usage;
+    }
+
+    else {
+	die "Unknow option $opt\n";
+    }
+}
+
+$build = $tree if (!defined($build));
+
+$tree = expand_path $tree;
+$build = expand_path $build;
+
+if ( ! -d $tree ) {
+    die "$tree not a directory\n";
+}
+
+if ( ! -d $build ) {
+    die "$build not a directory\n";
+}
+
+usage if $#ARGV < 1;
+
+if ($#ARGV == 1) {
+    $start = 1;
+} elsif ($#ARGV == 2) {
+    $val = $ARGV[2];
+    if ($val ne "good" && $val ne "bad") {
+	die "Unknown command '$val', bust be either \"good\" or \"bad\"\n";
+    }
+} else {
+    usage;
+}
+
+my $good_start = expand_path $ARGV[0];
+my $bad_start = expand_path $ARGV[1];
+
+my $good = "$good_start.tmp";
+my $bad = "$bad_start.tmp";
+
+$make = "make";
+
+if ($build ne $tree) {
+    $make = "make O=$build"
+}
+
+$output_config = "$build/.config";
+
+if ($start) {
+    if ( ! -f $good_start ) {
+	die "$good_start not found\n";
+    }
+    if ( ! -f $bad_start ) {
+	die "$bad_start not found\n";
+    }
+    if ( -f $good || -f $bad ) {
+	my $p = "";
+
+	if ( -f $good ) {
+	    $p = "$good exists\n";
+	}
+
+	if ( -f $bad ) {
+	    $p = "$p$bad exists\n";
+	}
+
+	if (!defined($reset_bisect)) {
+	    if (!read_yn "${p}Overwrite and start new bisect anyway?") {
+		exit (-1);
+	    }
+	}
+    }
+    run_command "cp $good_start $good" or die "failed to copy to $good\n";
+    run_command "cp $bad_start $bad" or die "faield to copy to $bad\n";
+} else {
+    if ( ! -f $good ) {
+	die "Can not find file $good\n";
+    }
+    if ( ! -f $bad ) {
+	die "Can not find file $bad\n";
+    }
+    if ($val eq "good") {
+	run_command "cp $output_config $good" or die "failed to copy $config to $good\n";
+    } elsif ($val eq "bad") {
+	run_command "cp $output_config $bad" or die "failed to copy $config to $bad\n";
+    }
+}
+
+chdir $tree || die "can't change directory to $tree";
+
+my $ret = config_bisect $good, $bad;
+
+if (!$ret) {
+    exit(0);
+}
+
+if ($ret > 0) {
+    doprint "Cleaning temp files\n";
+    run_command "rm $good";
+    run_command "rm $bad";
+    exit(1);
+} else {
+    doprint "See good and bad configs for details:\n";
+    doprint "good: $good\n";
+    doprint "bad:  $bad\n";
+    doprint "%%%%%%%% FAILED TO FIND SINGLE BAD CONFIG %%%%%%%%\n";
+}
+exit(2);
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 0c8b61f8398e..777388cc8221 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -10,6 +10,7 @@ use Fcntl qw(F_GETFL F_SETFL O_NONBLOCK);
 use File::Path qw(mkpath);
 use File::Copy qw(cp);
 use FileHandle;
+use FindBin;
 
 my $VERSION = "0.2";
 
@@ -22,6 +23,11 @@ my %evals;
 
 #default opts
 my %default = (
+    "MAILER"			=> "sendmail",  # default mailer
+    "EMAIL_ON_ERROR"		=> 1,
+    "EMAIL_WHEN_FINISHED"	=> 1,
+    "EMAIL_WHEN_CANCELED"	=> 0,
+    "EMAIL_WHEN_STARTED"	=> 0,
     "NUM_TESTS"			=> 1,
     "TEST_TYPE"			=> "build",
     "BUILD_TYPE"		=> "randconfig",
@@ -59,6 +65,7 @@ my %default = (
     "GRUB_REBOOT"		=> "grub2-reboot",
     "SYSLINUX"			=> "extlinux",
     "SYSLINUX_PATH"		=> "/boot/extlinux",
+    "CONNECT_TIMEOUT"		=> 25,
 
 # required, and we will ask users if they don't have them but we keep the default
 # value something that is common.
@@ -163,6 +170,8 @@ my $store_failures;
 my $store_successes;
 my $test_name;
 my $timeout;
+my $connect_timeout;
+my $config_bisect_exec;
 my $booted_timeout;
 my $detect_triplefault;
 my $console;
@@ -204,6 +213,20 @@ my $install_time;
 my $reboot_time;
 my $test_time;
 
+my $pwd;
+my $dirname = $FindBin::Bin;
+
+my $mailto;
+my $mailer;
+my $mail_path;
+my $mail_command;
+my $email_on_error;
+my $email_when_finished;
+my $email_when_started;
+my $email_when_canceled;
+
+my $script_start_time = localtime();
+
 # set when a test is something other that just building or install
 # which would require more options.
 my $buildonly = 1;
@@ -229,6 +252,14 @@ my $no_reboot = 1;
 my $reboot_success = 0;
 
 my %option_map = (
+    "MAILTO"			=> \$mailto,
+    "MAILER"			=> \$mailer,
+    "MAIL_PATH"			=> \$mail_path,
+    "MAIL_COMMAND"		=> \$mail_command,
+    "EMAIL_ON_ERROR"		=> \$email_on_error,
+    "EMAIL_WHEN_FINISHED"	=> \$email_when_finished,
+    "EMAIL_WHEN_STARTED"	=> \$email_when_started,
+    "EMAIL_WHEN_CANCELED"	=> \$email_when_canceled,
     "MACHINE"			=> \$machine,
     "SSH_USER"			=> \$ssh_user,
     "TMP_DIR"			=> \$tmpdir,
@@ -296,6 +327,8 @@ my %option_map = (
     "STORE_SUCCESSES"		=> \$store_successes,
     "TEST_NAME"			=> \$test_name,
     "TIMEOUT"			=> \$timeout,
+    "CONNECT_TIMEOUT"		=> \$connect_timeout,
+    "CONFIG_BISECT_EXEC"	=> \$config_bisect_exec,
     "BOOTED_TIMEOUT"		=> \$booted_timeout,
     "CONSOLE"			=> \$console,
     "CLOSE_CONSOLE_SIGNAL"	=> \$close_console_signal,
@@ -337,6 +370,7 @@ my %used_options;
 
 # default variables that can be used
 chomp ($variable{"PWD"} = `pwd`);
+$pwd = $variable{"PWD"};
 
 $config_help{"MACHINE"} = << "EOF"
  The machine hostname that you will test.
@@ -718,21 +752,13 @@ sub set_value {
 
     my $prvalue = process_variables($rvalue);
 
-    if ($buildonly && $lvalue =~ /^TEST_TYPE(\[.*\])?$/ && $prvalue ne "build") {
+    if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
+	$prvalue !~ /^(config_|)bisect$/ &&
+	$prvalue !~ /^build$/ &&
+	$buildonly) {
+
 	# Note if a test is something other than build, then we
 	# will need other mandatory options.
-	if ($prvalue ne "install") {
-	    # for bisect, we need to check BISECT_TYPE
-	    if ($prvalue ne "bisect") {
-		$buildonly = 0;
-	    }
-	} else {
-	    # install still limits some mandatory options.
-	    $buildonly = 2;
-	}
-    }
-
-    if ($buildonly && $lvalue =~ /^BISECT_TYPE(\[.*\])?$/ && $prvalue ne "build") {
 	if ($prvalue ne "install") {
 	    $buildonly = 0;
 	} else {
@@ -1140,7 +1166,8 @@ sub __read_config {
 sub get_test_case {
 	print "What test case would you like to run?\n";
 	print " (build, install or boot)\n";
-	print " Other tests are available but require editing the config file\n";
+	print " Other tests are available but require editing ktest.conf\n";
+	print " (see tools/testing/ktest/sample.conf)\n";
 	my $ans = <STDIN>;
 	chomp $ans;
 	$default{"TEST_TYPE"} = $ans;
@@ -1328,8 +1355,8 @@ sub reboot {
     my ($time) = @_;
     my $powercycle = 0;
 
-    # test if the machine can be connected to within 5 seconds
-    my $stat = run_ssh("echo check machine status", 5);
+    # test if the machine can be connected to within a few seconds
+    my $stat = run_ssh("echo check machine status", $connect_timeout);
     if (!$stat) {
 	doprint("power cycle\n");
 	$powercycle = 1;
@@ -1404,10 +1431,18 @@ sub do_not_reboot {
 
     return $test_type eq "build" || $no_reboot ||
 	($test_type eq "patchcheck" && $opt{"PATCHCHECK_TYPE[$i]"} eq "build") ||
-	($test_type eq "bisect" && $opt{"BISECT_TYPE[$i]"} eq "build");
+	($test_type eq "bisect" && $opt{"BISECT_TYPE[$i]"} eq "build") ||
+	($test_type eq "config_bisect" && $opt{"CONFIG_BISECT_TYPE[$i]"} eq "build");
 }
 
+my $in_die = 0;
+
 sub dodie {
+
+    # avoid recusion
+    return if ($in_die);
+    $in_die = 1;
+
     doprint "CRITICAL FAILURE... ", @_, "\n";
 
     my $i = $iteration;
@@ -1426,6 +1461,11 @@ sub dodie {
 	print " See $opt{LOG_FILE} for more info.\n";
     }
 
+    if ($email_on_error) {
+        send_email("KTEST: critical failure for your [$test_type] test",
+                "Your test started at $script_start_time has failed with:\n@_\n");
+    }
+
     if ($monitor_cnt) {
 	    # restore terminal settings
 	    system("stty $stty_orig");
@@ -1477,7 +1517,7 @@ sub exec_console {
     close($pts);
 
     exec $console or
-	die "Can't open console $console";
+	dodie "Can't open console $console";
 }
 
 sub open_console {
@@ -1515,6 +1555,9 @@ sub close_console {
     doprint "kill child process $pid\n";
     kill $close_console_signal, $pid;
 
+    doprint "wait for child process $pid to exit\n";
+    waitpid($pid, 0);
+
     print "closing!\n";
     close($fp);
 
@@ -1625,7 +1668,7 @@ sub save_logs {
 
 	if (!-d $dir) {
 	    mkpath($dir) or
-		die "can't create $dir";
+		dodie "can't create $dir";
 	}
 
 	my %files = (
@@ -1638,7 +1681,7 @@ sub save_logs {
 	while (my ($name, $source) = each(%files)) {
 		if (-f "$source") {
 			cp "$source", "$dir/$name" or
-				die "failed to copy $source";
+				dodie "failed to copy $source";
 		}
 	}
 
@@ -1692,6 +1735,7 @@ sub run_command {
     my $end_time;
     my $dolog = 0;
     my $dord = 0;
+    my $dostdout = 0;
     my $pid;
 
     $command =~ s/\$SSH_USER/$ssh_user/g;
@@ -1710,9 +1754,15 @@ sub run_command {
     }
 
     if (defined($redirect)) {
-	open (RD, ">$redirect") or
-	    dodie "failed to write to redirect $redirect";
-	$dord = 1;
+	if ($redirect eq 1) {
+	    $dostdout = 1;
+	    # Have the output of the command on its own line
+	    doprint "\n";
+	} else {
+	    open (RD, ">$redirect") or
+		dodie "failed to write to redirect $redirect";
+	    $dord = 1;
+	}
     }
 
     my $hit_timeout = 0;
@@ -1734,6 +1784,7 @@ sub run_command {
 	}
 	print LOG $line if ($dolog);
 	print RD $line if ($dord);
+	print $line if ($dostdout);
     }
 
     waitpid($pid, 0);
@@ -1812,7 +1863,7 @@ sub get_grub2_index {
     $ssh_grub =~ s,\$SSH_COMMAND,cat $grub_file,g;
 
     open(IN, "$ssh_grub |")
-	or die "unable to get $grub_file";
+	or dodie "unable to get $grub_file";
 
     my $found = 0;
 
@@ -1821,13 +1872,13 @@ sub get_grub2_index {
 	    $grub_number++;
 	    $found = 1;
 	    last;
-	} elsif (/^menuentry\s/) {
+	} elsif (/^menuentry\s|^submenu\s/) {
 	    $grub_number++;
 	}
     }
     close(IN);
 
-    die "Could not find '$grub_menu' in $grub_file on $machine"
+    dodie "Could not find '$grub_menu' in $grub_file on $machine"
 	if (!$found);
     doprint "$grub_number\n";
     $last_grub_menu = $grub_menu;
@@ -1855,7 +1906,7 @@ sub get_grub_index {
     $ssh_grub =~ s,\$SSH_COMMAND,cat /boot/grub/menu.lst,g;
 
     open(IN, "$ssh_grub |")
-	or die "unable to get menu.lst";
+	or dodie "unable to get menu.lst";
 
     my $found = 0;
 
@@ -1870,7 +1921,7 @@ sub get_grub_index {
     }
     close(IN);
 
-    die "Could not find '$grub_menu' in /boot/grub/menu on $machine"
+    dodie "Could not find '$grub_menu' in /boot/grub/menu on $machine"
 	if (!$found);
     doprint "$grub_number\n";
     $last_grub_menu = $grub_menu;
@@ -1983,7 +2034,7 @@ sub monitor {
     my $full_line = "";
 
     open(DMESG, "> $dmesg") or
-	die "unable to write to $dmesg";
+	dodie "unable to write to $dmesg";
 
     reboot_to;
 
@@ -2862,7 +2913,7 @@ sub run_bisect {
 sub update_bisect_replay {
     my $tmp_log = "$tmpdir/ktest_bisect_log";
     run_command "git bisect log > $tmp_log" or
-	die "can't create bisect log";
+	dodie "can't create bisect log";
     return $tmp_log;
 }
 
@@ -2871,9 +2922,9 @@ sub bisect {
 
     my $result;
 
-    die "BISECT_GOOD[$i] not defined\n"	if (!defined($bisect_good));
-    die "BISECT_BAD[$i] not defined\n"	if (!defined($bisect_bad));
-    die "BISECT_TYPE[$i] not defined\n"	if (!defined($bisect_type));
+    dodie "BISECT_GOOD[$i] not defined\n"	if (!defined($bisect_good));
+    dodie "BISECT_BAD[$i] not defined\n"	if (!defined($bisect_bad));
+    dodie "BISECT_TYPE[$i] not defined\n"	if (!defined($bisect_type));
 
     my $good = $bisect_good;
     my $bad = $bisect_bad;
@@ -2936,7 +2987,7 @@ sub bisect {
 	if ($check ne "good") {
 	    doprint "TESTING BISECT BAD [$bad]\n";
 	    run_command "git checkout $bad" or
-		die "Failed to checkout $bad";
+		dodie "Failed to checkout $bad";
 
 	    $result = run_bisect $type;
 
@@ -2948,7 +2999,7 @@ sub bisect {
 	if ($check ne "bad") {
 	    doprint "TESTING BISECT GOOD [$good]\n";
 	    run_command "git checkout $good" or
-		die "Failed to checkout $good";
+		dodie "Failed to checkout $good";
 
 	    $result = run_bisect $type;
 
@@ -2959,7 +3010,7 @@ sub bisect {
 
 	# checkout where we started
 	run_command "git checkout $head" or
-	    die "Failed to checkout $head";
+	    dodie "Failed to checkout $head";
     }
 
     run_command "git bisect start$start_files" or
@@ -3092,76 +3143,6 @@ sub create_config {
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
 
@@ -3174,166 +3155,57 @@ sub run_config_bisect_test {
     return $ret;
 }
 
-sub process_failed {
-    my ($config) = @_;
+sub config_bisect_end {
+    my ($good, $bad) = @_;
+    my $diffexec = "diff -u";
 
+    if (-f "$builddir/scripts/diffconfig") {
+	$diffexec = "$builddir/scripts/diffconfig";
+    }
     doprint "\n\n***************************************\n";
-    doprint "Found bad config: $config\n";
+    doprint "No more config bisecting possible.\n";
+    run_command "$diffexec $good $bad", 1;
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
+    my $reset = "";
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
+    if (!length($last_result)) {
+	$reset = "-r";
     }
+    run_command "$config_bisect_exec $reset -b $outputdir $good $bad $last_result", 1;
 
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
-
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
 
@@ -3353,6 +3225,24 @@ sub config_bisect {
 	$good_config = $output_config;
     }
 
+    if (!defined($config_bisect_exec)) {
+	# First check the location that ktest.pl ran
+	my @locations = ( "$pwd/config-bisect.pl",
+			  "$dirname/config-bisect.pl",
+			  "$builddir/tools/testing/ktest/config-bisect.pl",
+			  undef );
+	foreach my $loc (@locations) {
+	    doprint "loc = $loc\n";
+	    $config_bisect_exec = $loc;
+	    last if (defined($config_bisect_exec && -x $config_bisect_exec));
+	}
+	if (!defined($config_bisect_exec)) {
+	    fail "Could not find an executable config-bisect.pl\n",
+		"  Set CONFIG_BISECT_EXEC to point to config-bisect.pl";
+	    return 1;
+	}
+    }
+
     # we don't want min configs to cause issues here.
     doprint "Disabling 'MIN_CONFIG' for this test\n";
     undef $minconfig;
@@ -3361,21 +3251,31 @@ sub config_bisect {
     my %bad_configs;
     my %tmp_configs;
 
+    if (-f "$tmpdir/good_config.tmp" || -f "$tmpdir/bad_config.tmp") {
+	if (read_yn "Interrupted config-bisect. Continue (n - will start new)?") {
+	    if (-f "$tmpdir/good_config.tmp") {
+		$good_config = "$tmpdir/good_config.tmp";
+	    } else {
+		$good_config = "$tmpdir/good_config";
+	    }
+	    if (-f "$tmpdir/bad_config.tmp") {
+		$bad_config = "$tmpdir/bad_config.tmp";
+	    } else {
+		$bad_config = "$tmpdir/bad_config";
+	    }
+	}
+    }
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
@@ -3398,10 +3298,21 @@ sub config_bisect {
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
 
@@ -3416,9 +3327,9 @@ sub patchcheck_reboot {
 sub patchcheck {
     my ($i) = @_;
 
-    die "PATCHCHECK_START[$i] not defined\n"
+    dodie "PATCHCHECK_START[$i] not defined\n"
 	if (!defined($patchcheck_start));
-    die "PATCHCHECK_TYPE[$i] not defined\n"
+    dodie "PATCHCHECK_TYPE[$i] not defined\n"
 	if (!defined($patchcheck_type));
 
     my $start = $patchcheck_start;
@@ -3432,7 +3343,7 @@ sub patchcheck {
     if (defined($patchcheck_end)) {
 	$end = $patchcheck_end;
     } elsif ($cherry) {
-	die "PATCHCHECK_END must be defined with PATCHCHECK_CHERRY\n";
+	dodie "PATCHCHECK_END must be defined with PATCHCHECK_CHERRY\n";
     }
 
     # Get the true sha1's since we can use things like HEAD~3
@@ -3496,7 +3407,7 @@ sub patchcheck {
 	doprint "\nProcessing commit \"$item\"\n\n";
 
 	run_command "git checkout $sha1" or
-	    die "Failed to checkout $sha1";
+	    dodie "Failed to checkout $sha1";
 
 	# only clean on the first and last patch
 	if ($item eq $list[0] ||
@@ -3587,7 +3498,7 @@ sub read_kconfig {
     }
 
     open(KIN, "$kconfig")
-	or die "Can't open $kconfig";
+	or dodie "Can't open $kconfig";
     while (<KIN>) {
 	chomp;
 
@@ -3748,7 +3659,7 @@ sub get_depends {
 
 	    $dep =~ s/^[^$valid]*[$valid]+//;
 	} else {
-	    die "this should never happen";
+	    dodie "this should never happen";
 	}
     }
 
@@ -4009,7 +3920,7 @@ sub make_min_config {
 	    # update new ignore configs
 	    if (defined($ignore_config)) {
 		open (OUT, ">$temp_config")
-		    or die "Can't write to $temp_config";
+		    or dodie "Can't write to $temp_config";
 		foreach my $config (keys %save_configs) {
 		    print OUT "$save_configs{$config}\n";
 		}
@@ -4037,7 +3948,7 @@ sub make_min_config {
 
 	    # Save off all the current mandatory configs
 	    open (OUT, ">$temp_config")
-		or die "Can't write to $temp_config";
+		or dodie "Can't write to $temp_config";
 	    foreach my $config (keys %keep_configs) {
 		print OUT "$keep_configs{$config}\n";
 	    }
@@ -4224,6 +4135,74 @@ sub set_test_option {
     return eval_option($name, $option, $i);
 }
 
+sub find_mailer {
+    my ($mailer) = @_;
+
+    my @paths = split /:/, $ENV{PATH};
+
+    # sendmail is usually in /usr/sbin
+    $paths[$#paths + 1] = "/usr/sbin";
+
+    foreach my $path (@paths) {
+	if (-x "$path/$mailer") {
+	    return $path;
+	}
+    }
+
+    return undef;
+}
+
+sub do_send_mail {
+    my ($subject, $message) = @_;
+
+    if (!defined($mail_path)) {
+	# find the mailer
+	$mail_path = find_mailer $mailer;
+	if (!defined($mail_path)) {
+	    die "\nCan not find $mailer in PATH\n";
+	}
+    }
+
+    if (!defined($mail_command)) {
+	if ($mailer eq "mail" || $mailer eq "mailx") {
+	    $mail_command = "\$MAIL_PATH/\$MAILER -s \'\$SUBJECT\' \$MAILTO <<< \'\$MESSAGE\'";
+	} elsif ($mailer eq "sendmail" ) {
+	    $mail_command =  "echo \'Subject: \$SUBJECT\n\n\$MESSAGE\' | \$MAIL_PATH/\$MAILER -t \$MAILTO";
+	} else {
+	    die "\nYour mailer: $mailer is not supported.\n";
+	}
+    }
+
+    $mail_command =~ s/\$MAILER/$mailer/g;
+    $mail_command =~ s/\$MAIL_PATH/$mail_path/g;
+    $mail_command =~ s/\$MAILTO/$mailto/g;
+    $mail_command =~ s/\$SUBJECT/$subject/g;
+    $mail_command =~ s/\$MESSAGE/$message/g;
+
+    run_command $mail_command;
+}
+
+sub send_email {
+
+    if (defined($mailto)) {
+	if (!defined($mailer)) {
+	    doprint "No email sent: email or mailer not specified in config.\n";
+	    return;
+	}
+	do_send_mail @_;
+    }
+}
+
+sub cancel_test {
+    if ($email_when_canceled) {
+        send_email("KTEST: Your [$test_type] test was cancelled",
+                "Your test started at $script_start_time was cancelled: sig int");
+    }
+    die "\nCaught Sig Int, test interrupted: $!\n"
+}
+
+$SIG{INT} = qw(cancel_test);
+
 # First we need to do is the builds
 for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
@@ -4247,11 +4226,11 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
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
@@ -4264,9 +4243,15 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
     $start_minconfig_defined = 1;
 
     # The first test may override the PRE_KTEST option
-    if (defined($pre_ktest) && $i == 1) {
-	doprint "\n";
-	run_command $pre_ktest;
+    if ($i == 1) {
+        if (defined($pre_ktest)) {
+            doprint "\n";
+            run_command $pre_ktest;
+        }
+        if ($email_when_started) {
+            send_email("KTEST: Your [$test_type] test was started",
+                "Your test was started on $script_start_time");
+        }
     }
 
     # Any test can override the POST_KTEST option
@@ -4282,7 +4267,7 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     if (!-d $tmpdir) {
 	mkpath($tmpdir) or
-	    die "can't create $tmpdir";
+	    dodie "can't create $tmpdir";
     }
 
     $ENV{"SSH_USER"} = $ssh_user;
@@ -4355,7 +4340,7 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     if (defined($checkout)) {
 	run_command "git checkout $checkout" or
-	    die "failed to checkout $checkout";
+	    dodie "failed to checkout $checkout";
     }
 
     $no_reboot = 0;
@@ -4430,4 +4415,8 @@ if ($opt{"POWEROFF_ON_SUCCESS"}) {
 
 doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
 
+if ($email_when_finished) {
+    send_email("KTEST: Your [$test_type] test has finished!",
+            "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
+}
 exit 0;
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 6c58cd8bbbae..6ca6ca0ce695 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -1,6 +1,11 @@
 #
 # Config file for ktest.pl
 #
+# Place your customized version of this, in the working directory that
+# ktest.pl is run from. By default, ktest.pl will look for a file
+# called "ktest.conf", but you can name it anything you like and specify
+# the name of your config file as the first argument of ktest.pl.
+#
 # Note, all paths must be absolute
 #
 
@@ -396,6 +401,44 @@
 
 #### Optional Config Options (all have defaults) ####
 
+# Email options for receiving notifications. Users must setup
+# the specified mailer prior to using this feature.
+#
+# (default undefined)
+#MAILTO =
+#
+# Supported mailers: sendmail, mail, mailx
+# (default sendmail)
+#MAILER = sendmail
+#
+# The executable to run
+# (default: for sendmail "/usr/sbin/sendmail", otherwise equals ${MAILER})
+#MAIL_EXEC = /usr/sbin/sendmail
+#
+# The command used to send mail, which uses the above options
+# can be modified. By default if the mailer is "sendmail" then
+#  MAIL_COMMAND = echo \'Subject: $SUBJECT\n\n$MESSAGE\' | $MAIL_PATH/$MAILER -t $MAILTO
+# For mail or mailx:
+#  MAIL_COMMAND = "$MAIL_PATH/$MAILER -s \'$SUBJECT\' $MAILTO <<< \'$MESSAGE\'
+# ktest.pl will do the substitution for MAIL_PATH, MAILER, MAILTO at the time
+#    it sends the mail if "$FOO" format is used. If "${FOO}" format is used,
+#    then the substitutions will occur at the time the config file is read.
+#    But note, MAIL_PATH and MAILER require being set by the config file if
+#     ${MAIL_PATH} or ${MAILER} are used, but not if $MAIL_PATH or $MAILER are.
+#MAIL_COMMAND = echo \'Subject: $SUBJECT\n\n$MESSAGE\' | $MAIL_PATH/$MAILER -t $MAILTO
+#
+# Errors are defined as those would terminate the script
+# (default 1)
+#EMAIL_ON_ERROR = 1
+# (default 1)
+#EMAIL_WHEN_FINISHED = 1
+# (default 0)
+#EMAIL_WHEN_STARTED = 1
+#
+# Users can cancel the test by Ctrl^C
+# (default 0)
+#EMAIL_WHEN_CANCELED = 1
+
 # Start a test setup. If you leave this off, all options
 # will be default and the test will run once.
 # This is a label and not really an option (it takes no value).
@@ -725,6 +768,13 @@
 # (default 120)
 #TIMEOUT = 120
 
+# The timeout in seconds when to test if the box can be rebooted
+# or not. Before issuing the reboot command, a ssh connection
+# is attempted to see if the target machine is still active.
+# If the target does not connect within this timeout, a power cycle
+# is issued instead of a reboot.
+# CONNECT_TIMEOUT = 25
+
 # In between tests, a reboot of the box may occur, and this
 # is the time to wait for the console after it stops producing
 # output. Some machines may not produce a large lag on reboot
@@ -1167,6 +1217,16 @@
 #  Set it to "good" to test only the good config and set it
 #  to "bad" to only test the bad config.
 #
+# CONFIG_BISECT_EXEC (optional)
+#  The config bisect is a separate program that comes with ktest.pl.
+#  By befault, it will look for:
+#    `pwd`/config-bisect.pl # the location ktest.pl was executed from.
+#  If it does not find it there, it will look for:
+#    `dirname <ktest.pl>`/config-bisect.pl # The directory that holds ktest.pl
+#  If it does not find it there, it will look for:
+#    ${BUILD_DIR}/tools/testing/ktest/config-bisect.pl
+#  Setting CONFIG_BISECT_EXEC will override where it looks.
+#
 # Example:
 #   TEST_START
 #   TEST_TYPE = config_bisect
