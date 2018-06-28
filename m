Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAD6C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A552A27805
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A552A27805
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935991AbeF1S6X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:58:23 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:57560 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935200AbeF1S6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:58:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B47021800E8FB;
        Thu, 28 Jun 2018 18:58:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lunch41_2b99b04d0a54d
X-Filterd-Recvd-Size: 11967
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jun 2018 18:58:19 +0000 (UTC)
Message-ID: <db21aa9703833bad65ab70cc4e8a78da5b399138.camel@perches.com>
Subject: [PATCH] checkpatch: Improve runtime execution speed a little
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>
Date:   Thu, 28 Jun 2018 11:58:18 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch repeatedly uses a runtime minimum version check that
validates the minimum perl version required for a regex match
by using a "$^V ge 5.10.0" runtime string match.

Only perform that minimum version test once and store the result
to reduce string matching time.

This reduces runtime execution time for patches or files with high
line counts.

An example runtime improvement:

new: $ time ./scripts/checkpatch.pl -f drivers/net/ethernet/intel/i40e/i40e_main.c > /dev/null

real	0m11.856s
user	0m11.831s
sys	0m0.025s

old: $ time ./scripts/checkpatch.pl -f drivers/net/ethernet/intel/i40e/i40e_main.c > /dev/null

real	0m13.330s
user	0m13.282s
sys	0m0.049s

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 66 +++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2c792107dd01..bde77c5a661b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -240,11 +240,11 @@ $check_orig = $check;
 
 my $exit = 0;
 
+my $perl_version_ok = 1;
 if ($^V && $^V lt $minimum_perl_version) {
+	$perl_version_ok = 0;
 	printf "$P: requires at least perl version %vd\n", $minimum_perl_version;
-	if (!$ignore_perl_version) {
-		exit(1);
-	}
+	exit(1) if (!$ignore_perl_version);
 }
 
 #if no filenames are given, push '-' to read patch from stdin
@@ -1026,11 +1026,11 @@ if (!$quiet) {
 	hash_show_words(\%use_type, "Used");
 	hash_show_words(\%ignore_type, "Ignored");
 
-	if ($^V lt 5.10.0) {
+	if (!$perl_version_ok) {
 		print << "EOM"
 
 NOTE: perl $^V is not modern enough to detect all possible issues.
-      An upgrade to at least perl v5.10.0 is suggested.
+      An upgrade to at least perl $minimum_perl_version is suggested.
 EOM
 	}
 	if ($exit) {
@@ -3079,7 +3079,7 @@ sub process {
 		}
 
 # check indentation starts on a tab stop
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    $sline =~ /^\+\t+( +)(?:$c90_Keywords\b|\{\s*$|\}\s*(?:else\b|while\b|\s*$)|$Declare\s*$Ident\s*[;=])/) {
 			my $indent = length($1);
 			if ($indent % 8) {
@@ -3092,7 +3092,7 @@ sub process {
 		}
 
 # check multi-line statement indentation matches previous line
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    $prevline =~ /^\+([ \t]*)((?:$c90_Keywords(?:\s+if)\s*)|(?:$Declare\s*)?(?:$Ident|\(\s*\*\s*$Ident\s*\))\s*|(?:\*\s*)*$Lval\s*=\s*$Ident\s*)\(.*(\&\&|\|\||,)\s*$/) {
 			$prevline =~ /^\+(\t*)(.*)$/;
 			my $oldindent = $1;
@@ -3967,7 +3967,7 @@ sub process {
 
 # function brace can't be on same line, except for #defines of do while,
 # or if closed on same line
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    $sline =~ /$Type\s*$Ident\s*$balanced_parens\s*\{/ &&
 		    $sline !~ /\#\s*define\b.*do\s*\{/ &&
 		    $sline !~ /}/) {
@@ -4578,7 +4578,7 @@ sub process {
 # check for unnecessary parentheses around comparisons in if uses
 # when !drivers/staging or command-line uses --strict
 		if (($realfile !~ m@^(?:drivers/staging/)@ || $check_orig) &&
-		    $^V && $^V ge 5.10.0 && defined($stat) &&
+		    $perl_version_ok && defined($stat) &&
 		    $stat =~ /(^.\s*if\s*($balanced_parens))/) {
 			my $if_stat = $1;
 			my $test = substr($2, 1, -1);
@@ -4615,7 +4615,7 @@ sub process {
 # return is not a function
 		if (defined($stat) && $stat =~ /^.\s*return(\s*)\(/s) {
 			my $spacing = $1;
-			if ($^V && $^V ge 5.10.0 &&
+			if ($perl_version_ok &&
 			    $stat =~ /^.\s*return\s*($balanced_parens)\s*;\s*$/) {
 				my $value = $1;
 				$value = deparenthesize($value);
@@ -4642,7 +4642,7 @@ sub process {
                }
 
 # if statements using unnecessary parentheses - ie: if ((foo == bar))
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    $line =~ /\bif\s*((?:\(\s*){2,})/) {
 			my $openparens = $1;
 			my $count = $openparens =~ tr@\(@\(@;
@@ -4659,7 +4659,7 @@ sub process {
 #	avoid cases like "foo + BAR < baz"
 #	only fix matches surrounded by parentheses to avoid incorrect
 #	conversions like "FOO < baz() + 5" being "misfixed" to "baz() > FOO + 5"
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    $line =~ /^\+(.*)\b($Constant|[A-Z_][A-Z0-9_]*)\s*($Compare)\s*($LvalOrFunc)/) {
 			my $lead = $1;
 			my $const = $2;
@@ -5084,7 +5084,7 @@ sub process {
 # do {} while (0) macro tests:
 # single-statement macros do not need to be enclosed in do while (0) loop,
 # macro should not end with a semicolon
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    $realfile !~ m@/vmlinux.lds.h$@ &&
 		    $line =~ /^.\s*\#\s*define\s+$Ident(\()?/) {
 			my $ln = $linenr;
@@ -5460,7 +5460,7 @@ sub process {
 		}
 
 # check for mask then right shift without a parentheses
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    $line =~ /$LvalOrFunc\s*\&\s*($LvalOrFunc)\s*>>/ &&
 		    $4 !~ /^\&/) { # $LvalOrFunc may be &foo, ignore if so
 			WARN("MASK_THEN_SHIFT",
@@ -5468,7 +5468,7 @@ sub process {
 		}
 
 # check for pointer comparisons to NULL
-		if ($^V && $^V ge 5.10.0) {
+		if ($perl_version_ok) {
 			while ($line =~ /\b$LvalOrFunc\s*(==|\!=)\s*NULL\b/g) {
 				my $val = $1;
 				my $equal = "!";
@@ -5740,7 +5740,7 @@ sub process {
 		}
 
 # Check for __attribute__ weak, or __weak declarations (may have link issues)
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    $line =~ /(?:$Declare|$DeclareMisordered)\s*$Ident\s*$balanced_parens\s*(?:$Attribute)?\s*;/ &&
 		    ($line =~ /\b__attribute__\s*\(\s*\(.*\bweak\b/ ||
 		     $line =~ /\b__weak\b/)) {
@@ -5822,7 +5822,7 @@ sub process {
 		}
 
 # check for vsprintf extension %p<foo> misuses
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    defined $stat &&
 		    $stat =~ /^\+(?![^\{]*\{\s*).*\b(\w+)\s*\(.*$String\s*,/s &&
 		    $1 !~ /^_*volatile_*$/) {
@@ -5869,7 +5869,7 @@ sub process {
 		}
 
 # Check for misused memsets
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    defined $stat &&
 		    $stat =~ /^\+(?:.*?)\bmemset\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\,\s*$FuncArg\s*\)/) {
 
@@ -5887,7 +5887,7 @@ sub process {
 		}
 
 # Check for memcpy(foo, bar, ETH_ALEN) that could be ether_addr_copy(foo, bar)
-#		if ($^V && $^V ge 5.10.0 &&
+#		if ($perl_version_ok &&
 #		    defined $stat &&
 #		    $stat =~ /^\+(?:.*?)\bmemcpy\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\,\s*ETH_ALEN\s*\)/) {
 #			if (WARN("PREFER_ETHER_ADDR_COPY",
@@ -5898,7 +5898,7 @@ sub process {
 #		}
 
 # Check for memcmp(foo, bar, ETH_ALEN) that could be ether_addr_equal*(foo, bar)
-#		if ($^V && $^V ge 5.10.0 &&
+#		if ($perl_version_ok &&
 #		    defined $stat &&
 #		    $stat =~ /^\+(?:.*?)\bmemcmp\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\,\s*ETH_ALEN\s*\)/) {
 #			WARN("PREFER_ETHER_ADDR_EQUAL",
@@ -5907,7 +5907,7 @@ sub process {
 
 # check for memset(foo, 0x0, ETH_ALEN) that could be eth_zero_addr
 # check for memset(foo, 0xFF, ETH_ALEN) that could be eth_broadcast_addr
-#		if ($^V && $^V ge 5.10.0 &&
+#		if ($perl_version_ok &&
 #		    defined $stat &&
 #		    $stat =~ /^\+(?:.*?)\bmemset\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\,\s*ETH_ALEN\s*\)/) {
 #
@@ -5929,7 +5929,7 @@ sub process {
 #		}
 
 # typecasts on min/max could be min_t/max_t
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    defined $stat &&
 		    $stat =~ /^\+(?:.*?)\b(min|max)\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
 			if (defined $2 || defined $7) {
@@ -5953,7 +5953,7 @@ sub process {
 		}
 
 # check usleep_range arguments
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    defined $stat &&
 		    $stat =~ /^\+(?:.*?)\busleep_range\s*\(\s*($FuncArg)\s*,\s*($FuncArg)\s*\)/) {
 			my $min = $1;
@@ -5969,7 +5969,7 @@ sub process {
 		}
 
 # check for naked sscanf
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    defined $stat &&
 		    $line =~ /\bsscanf\b/ &&
 		    ($stat !~ /$Ident\s*=\s*sscanf\s*$balanced_parens/ &&
@@ -5983,7 +5983,7 @@ sub process {
 		}
 
 # check for simple sscanf that should be kstrto<foo>
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    defined $stat &&
 		    $line =~ /\bsscanf\b/) {
 			my $lc = $stat =~ tr@\n@@;
@@ -6055,7 +6055,7 @@ sub process {
 		}
 
 # check for function definitions
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    defined $stat &&
 		    $stat =~ /^.\s*(?:$Storage\s+)?$Type\s*($Ident)\s*$balanced_parens\s*{/s) {
 			$context_function = $1;
@@ -6095,14 +6095,14 @@ sub process {
 
 # alloc style
 # p = alloc(sizeof(struct foo), ...) should be p = alloc(sizeof(*p), ...)
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*([kv][mz]alloc(?:_node)?)\s*\(\s*(sizeof\s*\(\s*struct\s+$Lval\s*\))/) {
 			CHK("ALLOC_SIZEOF_STRUCT",
 			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
 		}
 
 # check for k[mz]alloc with multiplies that could be kmalloc_array/kcalloc
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    defined $stat &&
 		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
 			my $oldfunc = $3;
@@ -6131,7 +6131,7 @@ sub process {
 		}
 
 # check for krealloc arg reuse
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*\1\s*,/) {
 			WARN("KREALLOC_ARG_REUSE",
 			     "Reusing the krealloc arg is almost always a bug\n" . $herecurr);
@@ -6200,7 +6200,7 @@ sub process {
 		}
 
 # check for switch/default statements without a break;
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    defined $stat &&
 		    $stat =~ /^\+[$;\s]*(?:case[$;\s]+\w+[$;\s]*:[$;\s]*|)*[$;\s]*\bdefault[$;\s]*:[$;\s]*;/g) {
 			my $cnt = statement_rawlines($stat);
@@ -6317,7 +6317,7 @@ sub process {
 		}
 
 # likely/unlikely comparisons similar to "(likely(foo) > 0)"
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    $line =~ /\b((?:un)?likely)\s*\(\s*$FuncArg\s*\)\s*$Compare/) {
 			WARN("LIKELY_MISUSE",
 			     "Using $1 should generally have parentheses around the comparison\n" . $herecurr);
@@ -6360,7 +6360,7 @@ sub process {
 # check for DEVICE_ATTR uses that could be DEVICE_ATTR_<FOO>
 # and whether or not function naming is typical and if
 # DEVICE_ATTR permissions uses are unusual too
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    defined $stat &&
 		    $stat =~ /\bDEVICE_ATTR\s*\(\s*(\w+)\s*,\s*\(?\s*(\s*(?:${multi_mode_perms_string_search}|0[0-7]{3,3})\s*)\s*\)?\s*,\s*(\w+)\s*,\s*(\w+)\s*\)/) {
 			my $var = $1;
@@ -6420,7 +6420,7 @@ sub process {
 #   specific definition of not visible in sysfs.
 # o Ignore proc_create*(...) uses with a decimal 0 permission as that means
 #   use the default permissions
-		if ($^V && $^V ge 5.10.0 &&
+		if ($perl_version_ok &&
 		    defined $stat &&
 		    $line =~ /$mode_perms_search/) {
 			foreach my $entry (@mode_permission_funcs) {


