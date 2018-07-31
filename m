Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938FDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455FE208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455FE208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbeGaNrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:47:10 -0400
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:59263 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729723AbeGaNrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:47:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E4A06182CED34;
        Tue, 31 Jul 2018 12:07:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: smoke48_787594989c043
X-Filterd-Recvd-Size: 2110
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 31 Jul 2018 12:07:07 +0000 (UTC)
Message-ID: <2b32864324ae9c92948b002ec4c0c22409ed98f1.camel@perches.com>
Subject: [PATCH] checkpatch: Fix SPDX license check with --root=<path>
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Charlemagne Lasse <charlemagnelasse@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Jul 2018 05:07:06 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch uses the in-kernel script spdxcheck.py to validate
the specific license in a file or script.

This check can currently fail for a couple reasons:

o spdxcheck.py assumes the existence of git tree that may not
  exist for a bare source tree from something like a tarball
o the spdxcheck.py must be run from the top level root directory

So add a git existence test and set the subprocess subdirectory.

Signed-off-by: Joe Perches <joe@perches.com>
Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
Tested-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f25f708cd2a7..ce72cc4784e6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -852,9 +852,10 @@ sub is_maintained_obsolete {
 sub is_SPDX_License_valid {
 	my ($license) = @_;
 
-	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py"));
+	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$root/.git"));
 
-	my $status = `echo "$license" | python $root/scripts/spdxcheck.py -`;
+	my $root_path = abs_path($root);
+	my $status = `cd "$root_path"; echo "$license" | python scripts/spdxcheck.py -`;
 	return 0 if ($status ne "");
 	return 1;
 }

