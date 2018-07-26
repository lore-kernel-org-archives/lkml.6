Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D744C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3204620846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3204620846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbeGZWLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:11:43 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:40928 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730392AbeGZWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:11:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BC5AE2200F;
        Thu, 26 Jul 2018 20:53:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: doll59_3899590fed32b
X-Filterd-Recvd-Size: 2898
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Jul 2018 20:53:08 +0000 (UTC)
Message-ID: <84972e19138f1f8eafe74c6b5f1ad874f8525706.camel@perches.com>
Subject: [PATCH] checkpatch: check for functions with 'passed by value'
 structs or unions
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 26 Jul 2018 13:53:07 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was cc'd on a patch where structs were passed by value instead
of using pointers to the structs.  This can cause defects when
the called function modifies the 'passed by value' struct instead
of the calling function's struct.

There are what seems to be some false positives for a few of the
.h files in include/linux/... where the false positives are for
very small structs where the indirection via a pointer might be
slower than than the passed by value use.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 34e4683de7a3..7ce0ec9c0d19 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6076,8 +6076,10 @@ sub process {
 # check for function definitions
 		if ($perl_version_ok &&
 		    defined $stat &&
-		    $stat =~ /^.\s*(?:$Storage\s+)?$Type\s*($Ident)\s*$balanced_parens\s*{/s) {
+		    $stat =~ /^.\s*(?:$Storage\s+)?$Type\s*($Ident)\s*$balanced_parens\s*([\{;])/s) {
 			$context_function = $1;
+			my $args = $2;
+			my $term = $3;
 
 # check for multiline function definition with misplaced open brace
 			my $ok = 0;
@@ -6088,12 +6090,26 @@ sub process {
 				$herectx .=  $rl . "\n";
 				$ok = 1 if ($rl =~ /^[ \+]\{/);
 				$ok = 1 if ($rl =~ /\{/ && $n == 0);
-				last if $rl =~ /^[ \+].*\{/;
+				last if ($rl =~ /^[ \+].*[\{;]/);
 			}
-			if (!$ok) {
+			if (!$ok && $term eq '{') {
 				ERROR("OPEN_BRACE",
 				      "open brace '{' following function definitions go on the next line\n" . $herectx);
 			}
+
+# check for 'passed by value' uses of a struct or a union that might
+# be better 'passed by reference'
+
+			while ($args =~ /(?:$Storage\s+)?($Type)\s*($Ident(?:\s*\[\s*\])?)?\s*,?/g) {
+				my $type = trim($1);
+				my $ident = defined($2) ? trim($2) : "";
+				if ($type =~ /\b(?:union|struct)\b/ &&
+				    !($type =~ /(?:\*|\bconst|\])$/ ||
+				      $ident =~ /\]$/)) {
+					WARN("AGGREGATE_BY_VALUE",
+					     "Unusual 'passed by value' use of '$type'\n" . $herectx);
+				}
+			}
 		}
 
 # checks for new __setup's
