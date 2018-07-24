Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D6320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D6320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbeGXSLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:11:47 -0400
Received: from smtprelay0093.hostedemail.com ([216.40.44.93]:36871 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388457AbeGXSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:11:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 0E181182CF66C;
        Tue, 24 Jul 2018 17:04:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hand83_7d1b9839a7547
X-Filterd-Recvd-Size: 2478
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Jul 2018 17:04:19 +0000 (UTC)
Message-ID: <05b832407b24e0a27e419906187cd863bc1617c7.camel@perches.com>
Subject: [PATCH] checkpatch: Validate SPDX license with spdxcheck.py
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Tue, 24 Jul 2018 10:04:18 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing scripts/spdxcheck.py to validate any
SPDX-License-Identifier found in line 1 or 2 of patches or files.

Miscellanea:

o Properly indent the existing SPDX-License-Identifier block.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 34e4683de7a3..4523dd6d0476 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -849,6 +849,16 @@ sub is_maintained_obsolete {
 	return $status =~ /obsolete/i;
 }
 
+sub is_SPDX_License_valid {
+	my ($license) = @_;
+
+	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py"));
+
+	my $status = `echo "$license" | python $root/scripts/spdxcheck.py -`;
+	return 0 if ($status ne "");
+	return 1;
+}
+
 my $camelcase_seeded = 0;
 sub seed_camelcase_includes {
 	return if ($camelcase_seeded);
@@ -2978,8 +2988,14 @@ sub process {
 
 				if ($comment !~ /^$/ &&
 				    $rawline !~ /^\+\Q$comment\E SPDX-License-Identifier: /) {
-					WARN("SPDX_LICENSE_TAG",
-					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
+					 WARN("SPDX_LICENSE_TAG",
+					      "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
+				} elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
+					 my $spdx_license = $1;
+					 if (!is_SPDX_License_valid($spdx_license)) {
+						  WARN("SPDX_LICENSE_TAG",
+						       "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
+					 }
 				}
 			}
 		}

