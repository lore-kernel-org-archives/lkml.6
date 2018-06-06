Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NehdIRhnGFuHZAAAmS7hNA
	; Wed, 06 Jun 2018 23:12:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 56937608B8; Wed,  6 Jun 2018 23:12:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 67BA56074D;
	Wed,  6 Jun 2018 23:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67BA56074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbeFFXMx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:12:53 -0400
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:57468 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752053AbeFFXMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:12:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4DDC8181D3368;
        Wed,  6 Jun 2018 23:12:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lake26_701ea90f5d00b
X-Filterd-Recvd-Size: 2571
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Jun 2018 23:12:50 +0000 (UTC)
Message-ID: <a9fb505ccfedffc5869d08832a7ff05a21d85621.camel@perches.com>
Subject: [PATCH] checkpatch: Add --fix for CONCATENATED_STRING and
 STRING_FRAGMENTS
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date: Wed, 06 Jun 2018 16:12:48 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to --fix these string issues.

e.g.:
	printk(KERN_INFO"bar" "baz"QUX);
converts to
	printk(KERN_INFO "barbaz" QUX);

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3f936b046213..3b28306dc9d4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5334,15 +5334,28 @@ sub process {
 		}
 
 # concatenated string without spaces between elements
-		if ($line =~ /$String[A-Z_]/ || $line =~ /[A-Za-z0-9_]$String/) {
-			CHK("CONCATENATED_STRING",
-			    "Concatenated strings should use spaces between elements\n" . $herecurr);
+		if ($line =~ /$String[A-Za-z0-9_]/ || $line =~ /[A-Za-z0-9_]$String/) {
+			if (CHK("CONCATENATED_STRING",
+				"Concatenated strings should use spaces between elements\n" . $herecurr) &&
+			    $fix) {
+				while ($line =~ /($String)/g) {
+					my $extracted_string = substr($rawline, $-[0], $+[0] - $-[0]);
+					$fixed[$fixlinenr] =~ s/\Q$extracted_string\E([A-Za-z0-9_])/$extracted_string $1/;
+					$fixed[$fixlinenr] =~ s/([A-Za-z0-9_])\Q$extracted_string\E/$1 $extracted_string/;
+				}
+			}
 		}
 
 # uncoalesced string fragments
 		if ($line =~ /$String\s*"/) {
-			WARN("STRING_FRAGMENTS",
-			     "Consecutive strings are generally better as a single string\n" . $herecurr);
+			if (WARN("STRING_FRAGMENTS",
+				 "Consecutive strings are generally better as a single string\n" . $herecurr) &&
+			    $fix) {
+				while ($line =~ /($String)(?=\s*")/g) {
+					my $extracted_string = substr($rawline, $-[0], $+[0] - $-[0]);
+					$fixed[$fixlinenr] =~ s/\Q$extracted_string\E\s*"/substr($extracted_string, 0, -1)/e;
+				}
+			}
 		}
 
 # check for non-standard and hex prefixed decimal printf formats
