Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2D2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A42C20858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZTkD8mRR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qhd5gCMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A42C20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbeGMV5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:57:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeGMV5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:57:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7C62B60541; Fri, 13 Jul 2018 21:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531518040;
        bh=Pj6w1Rzq34H1wANo/TkGGUJ3jALRaGBh0eBlfnN5XF0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZTkD8mRRKPNP8BJhTRjUWBLX+l9XP2dzA4KfA68TJ1KQCmdpd1OJaAJNK5QOwbdZM
         Br+r3/gvdnMVRsCLLIRgrIkMhTazJg78flsRTWsepCz1Hzg10qzWsgFP7sadbIfI5I
         VU1WVUIY6dQxUKW7EM52h8hsL0sGsNC2U+UodB/4=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4AFEB60213;
        Fri, 13 Jul 2018 21:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531518039;
        bh=Pj6w1Rzq34H1wANo/TkGGUJ3jALRaGBh0eBlfnN5XF0=;
        h=From:To:Cc:Subject:Date:From;
        b=Qhd5gCMJuSjsUUREt6CFK2nvtxmr41gFfGh4xhkZb1Ih3UMnzyd9dS1VPLvVBfEd+
         S1InC4wNWgKt6qzTEAM0UtW7uSCOPonPtuzVAFuSwCPGI3p8YvbQO1FaZj1F1hAT5e
         Foqol6wjxCZ0yWR9oG/2UcFBLzhvV5JJyLDIPgEc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AFEB60213
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, ckadabi@codeaurora.org,
        David Keitel <dkeitel@codeaurora.org>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH] checkpatch: Require commit text and warn on long commit text lines
Date:   Fri, 13 Jul 2018 14:40:27 -0700
Message-Id: <1531518027-13318-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit text is almost always necessary to explain why a change is needed.
Also, warn on commit text lines longer than 75 characters. The commit text
are indented and may wrap on a terminal if they are longer than 75
characters.

Signed-off-by: David Keitel <dkeitel@codeaurora.org>
Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 scripts/checkpatch.pl | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c0550..336a8e5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -14,6 +14,13 @@ use File::Basename;
 use Cwd 'abs_path';
 use Term::ANSIColor qw(:constants);
 
+use constant BEFORE_SHORTTEXT => 0;
+use constant IN_SHORTTEXT_BLANKLINE => 1;
+use constant IN_SHORTTEXT => 2;
+use constant AFTER_SHORTTEXT => 3;
+use constant CHECK_NEXT_SHORTTEXT => 4;
+use constant SHORTTEXT_LIMIT => 75;
+
 my $P = $0;
 my $D = dirname(abs_path($P));
 
@@ -2227,6 +2234,8 @@ sub process {
 	my $prevrawline="";
 	my $stashline="";
 	my $stashrawline="";
+	my $subjectline="";
+	my $sublinenr="";
 
 	my $length;
 	my $indent;
@@ -2282,6 +2291,9 @@ sub process {
 	my $setup_docs = 0;
 
 	my $camelcase_file_seeded = 0;
+	my $shorttext = BEFORE_SHORTTEXT;
+	my $shorttext_exspc = 0;
+	my $commit_text_present = 0;
 
 	my $checklicenseline = 1;
 
@@ -2487,13 +2499,91 @@ sub process {
 			$checklicenseline = 1;
 			next;
 		}
-
 		$here .= "FILE: $realfile:$realline:" if ($realcnt != 0);
 
 		my $hereline = "$here\n$rawline\n";
 		my $herecurr = "$here\n$rawline\n";
 		my $hereprev = "$here\n$prevrawline\n$rawline\n";
 
+		if ($shorttext != AFTER_SHORTTEXT) {
+			if ($shorttext == IN_SHORTTEXT_BLANKLINE && $line=~/\S/) {
+				# the subject line was just processed,
+				# a blank line must be next
+				$shorttext = IN_SHORTTEXT;
+				# this non-blank line may or may not be commit text -
+				# a warning has been generated so assume it is commit
+				# text and move on
+				$commit_text_present = 1;
+				# fall through and treat this line as IN_SHORTTEXT
+			}
+			if ($shorttext == IN_SHORTTEXT) {
+				if ($line=~/^---/ || $line=~/^diff.*/) {
+					if ($commit_text_present == 0) {
+						WARN("NO_COMMIT_TEXT",
+						     "please add commit text explaining " .
+						     "*why* the change is needed\n" .
+						     $herecurr);
+					}
+					$shorttext = AFTER_SHORTTEXT;
+				} elsif (length($line) > (SHORTTEXT_LIMIT +
+							  $shorttext_exspc)
+					 && $line !~ /^:([0-7]{6}\s){2}
+						      ([[:xdigit:]]+\.*
+						       \s){2}\w+\s\w+/xms) {
+					WARN("LONG_COMMIT_TEXT",
+					     "commit text line over " .
+					     SHORTTEXT_LIMIT .
+					     " characters\n" . $herecurr);
+						$commit_text_present = 1;
+				} elsif ($line=~/^\s*[\x21-\x39\x3b-\x7e]+:/) {
+					# this is a tag, there must be commit
+					# text by now
+					if ($commit_text_present == 0) {
+						WARN("NO_COMMIT_TEXT",
+						     "please add commit text explaining " .
+						     "*why* the change is needed\n" .
+						     $herecurr);
+						# prevent duplicate warnings
+						$commit_text_present = 1;
+					}
+				} elsif ($line=~/\S/) {
+					$commit_text_present = 1;
+				}
+			} elsif ($shorttext == IN_SHORTTEXT_BLANKLINE) {
+				# case of non-blank line in this state handled above
+				$shorttext = IN_SHORTTEXT;
+			} elsif ($shorttext == CHECK_NEXT_SHORTTEXT) {
+# The Subject line doesn't have to be the last header in the patch.
+# Avoid moving to the IN_SHORTTEXT state until clear of all headers.
+# Per RFC5322, continuation lines must be folded, so any left-justified
+# text which looks like a header is definitely a header.
+				if ($line!~/^[\x21-\x39\x3b-\x7e]+:/) {
+					# Every rolled over summary-line leaves
+					# a space at the beginning
+					if ($line !~ /^\s/) {
+						$shorttext = IN_SHORTTEXT;
+						if (length($line) != 0) {
+							$commit_text_present = 1;
+						}
+					}
+				}
+			# The next two cases are BEFORE_SHORTTEXT.
+			} elsif ($line=~/^Subject: \[[^\]]*\] (.*)/) {
+				# This is the subject line. Go to
+				# CHECK_NEXT_SHORTTEXT to wait for the commit
+				# text to show up.
+				$shorttext = CHECK_NEXT_SHORTTEXT;
+				$subjectline = $line;
+				$sublinenr = "#$linenr & ";
+			} elsif ($line=~/^    (.*)/) {
+				# Indented format, this must be the summary
+				# line (i.e. git show). There will be no more
+				# headers so we are now in the shorttext.
+				$shorttext = IN_SHORTTEXT_BLANKLINE;
+				$shorttext_exspc = 4;
+			}
+		}
+
 		$cnt_lines++ if ($realcnt != 0);
 
 # Check if the commit log has what seems like a diff which can confuse patch
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

