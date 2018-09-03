Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3BDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3599120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3599120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbeICVxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:53:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeICVxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:53:19 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2471DD18;
        Mon,  3 Sep 2018 17:32:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.18 002/123] scripts/kernel-doc: Escape all literal braces in regexes
Date:   Mon,  3 Sep 2018 18:55:46 +0200
Message-Id: <20180903165719.598713258@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

commit 673bb2dfc36488abfdbbfc2ce2631204eaf682f2 upstream.

Commit 701b3a3c0ac4 ("PATCH scripts/kernel-doc") fixed the two
instances of literal braces that Perl 5.28 warns about, but there are
still more than it doesn't warn about.

Escape all left braces that are treated as literal characters.  Also
escape literal right braces, for consistency and to avoid confusing
bracket-matching in text editors.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/kernel-doc |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1062,7 +1062,7 @@ sub dump_struct($$) {
     my $x = shift;
     my $file = shift;
 
-    if ($x =~ /(struct|union)\s+(\w+)\s*{(.*)}/) {
+    if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}/) {
 	my $decl_type = $1;
 	$declaration_name = $2;
 	my $members = $3;
@@ -1148,20 +1148,20 @@ sub dump_struct($$) {
 				}
 			}
 		}
-		$members =~ s/(struct|union)([^\{\};]+)\{([^\{\}]*)}([^\{\}\;]*)\;/$newmember/;
+		$members =~ s/(struct|union)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;/$newmember/;
 	}
 
 	# Ignore other nested elements, like enums
-	$members =~ s/(\{[^\{\}]*})//g;
+	$members =~ s/(\{[^\{\}]*\})//g;
 
 	create_parameterlist($members, ';', $file, $declaration_name);
 	check_sections($file, $declaration_name, $decl_type, $sectcheck, $struct_actual);
 
 	# Adjust declaration for better display
-	$declaration =~ s/([{;])/$1\n/g;
-	$declaration =~ s/}\s+;/};/g;
+	$declaration =~ s/([\{;])/$1\n/g;
+	$declaration =~ s/\}\s+;/};/g;
 	# Better handle inlined enums
-	do {} while ($declaration =~ s/(enum\s+{[^}]+),([^\n])/$1,\n$2/);
+	do {} while ($declaration =~ s/(enum\s+\{[^\}]+),([^\n])/$1,\n$2/);
 
 	my @def_args = split /\n/, $declaration;
 	my $level = 1;
@@ -1171,12 +1171,12 @@ sub dump_struct($$) {
 		$clause =~ s/\s+$//;
 		$clause =~ s/\s+/ /;
 		next if (!$clause);
-		$level-- if ($clause =~ m/(})/ && $level > 1);
+		$level-- if ($clause =~ m/(\})/ && $level > 1);
 		if (!($clause =~ m/^\s*#/)) {
 			$declaration .= "\t" x $level;
 		}
 		$declaration .= "\t" . $clause . "\n";
-		$level++ if ($clause =~ m/(\{)/ && !($clause =~m/}/));
+		$level++ if ($clause =~ m/(\{)/ && !($clause =~m/\}/));
 	}
 	output_declaration($declaration_name,
 			   'struct',
@@ -1244,7 +1244,7 @@ sub dump_enum($$) {
     # strip #define macros inside enums
     $x =~ s@#\s*((define|ifdef)\s+|endif)[^;]*;@@gos;
 
-    if ($x =~ /enum\s+(\w+)\s*{(.*)}/) {
+    if ($x =~ /enum\s+(\w+)\s*\{(.*)\}/) {
 	$declaration_name = $1;
 	my $members = $2;
 	my %_members;
@@ -1785,7 +1785,7 @@ sub process_proto_type($$) {
     }
 
     while (1) {
-	if ( $x =~ /([^{};]*)([{};])(.*)/ ) {
+	if ( $x =~ /([^\{\};]*)([\{\};])(.*)/ ) {
             if( length $prototype ) {
                 $prototype .= " "
             }


