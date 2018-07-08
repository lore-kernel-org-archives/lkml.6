Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ED0C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 18:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A01B20890
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 18:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A01B20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754360AbeGHSSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 14:18:12 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:57058 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754255AbeGHSSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 14:18:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B42F6100E86C3;
        Sun,  8 Jul 2018 18:18:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: unit78_8155def4f0663
X-Filterd-Recvd-Size: 2544
Received: from XPS-9350 (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Jul 2018 18:18:08 +0000 (UTC)
Message-ID: <9e8341bbe4c9877d159cb512bb701043cbfbb10b.camel@perches.com>
Subject: [PATCH] checkpatch: Fix duplicate invalid vsprintf pointer
 extension '%p<foo>' messages
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>, Andy Whitcroft <apw@shadowen.org>
Date:   Sun, 08 Jul 2018 11:18:06 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiline statements with invalid %p<foo> uses produce multiple
warnings.  Fix that.

e.g.:

$ cat t_block.c
void foo(void)
{
	MY_DEBUG(drv->foo,
		 "%pk",
		 foo->boo);
}

$ ./scripts/checkpatch.pl -f t_block.c
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#1: FILE: t_block.c:1:
+void foo(void)

WARNING: Invalid vsprintf pointer extension '%pk'
#3: FILE: t_block.c:3:
+	MY_DEBUG(drv->foo,
+		 "%pk",
+		 foo->boo);

WARNING: Invalid vsprintf pointer extension '%pk'
#3: FILE: t_block.c:3:
+	MY_DEBUG(drv->foo,
+		 "%pk",
+		 foo->boo);

total: 0 errors, 3 warnings, 6 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

t_block.c has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bde77c5a661b..0f9788ab988b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5826,14 +5826,14 @@ sub process {
 		    defined $stat &&
 		    $stat =~ /^\+(?![^\{]*\{\s*).*\b(\w+)\s*\(.*$String\s*,/s &&
 		    $1 !~ /^_*volatile_*$/) {
-			my $specifier;
-			my $extension;
-			my $bad_specifier = "";
 			my $stat_real;
 
 			my $lc = $stat =~ tr@\n@@;
 			$lc = $lc + $linenr;
 		        for (my $count = $linenr; $count <= $lc; $count++) {
+				my $specifier;
+				my $extension;
+				my $bad_specifier = "";
 				my $fmt = get_quoted_string($lines[$count - 1], raw_line($count, 0));
 				$fmt =~ s/%%//g;
 

