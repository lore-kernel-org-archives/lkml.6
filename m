Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0EBECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D7E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D7E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbeGRMND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:13:03 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:41468 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeGRMND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:13:03 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id CBbX1y00W3XaVaC01BbXt6; Wed, 18 Jul 2018 13:35:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1ffkjz-0006xI-QC; Wed, 18 Jul 2018 13:35:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ffkjz-00045E-NC; Wed, 18 Jul 2018 13:35:31 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] checkpatch: Only encode UTF-8 quoted printable mail headers
Date:   Wed, 18 Jul 2018 13:35:29 +0200
Message-Id: <20180718113529.15652-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As PERL uses its own internal character encoding, always calling
encode("utf8", ...) on the author name may cause corruption, leading to
an author signoff mismatch.

This happens in the following cases:
  - If a patch is in ISO-8859, and contains a non-ASCII author name in
    the From: line, it is converted to UTF-8, while the Signed-off-by
    line will still be in ISO-8859.
  - If a patch is in UTF-8, and contains a non-ASCII author name in the
    body (not header) From: line, it is assumed to be encoded in PERL's
    internal character encoding, and converted to UTF-8 incorrectly,
    while the Signed-off-by line will be in real UTF-8.

Fix this by only doing the encode step if the From: line used UTF-8
quoted printable encoding.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Fixes: bc76e3a125b44379 ("checkpatch: warn if missing author Signed-off-by")
in -next

To be folded into "checkpatch: Warn if missing author Signed-off-by" in
Andrew's tree.
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d01fee203c4775d..e847377779e7804f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2523,7 +2523,8 @@ sub process {
 
 # Check the patch for a From:
 		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
-			$author = encode("utf8", $1);
+			$author = $1;
+			$author = encode("utf8", $author) if $line =~ /=\?utf-8\?/i;
 			$author =~ s/"//g;
 		}
 
-- 
2.17.1

