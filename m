Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CB8C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D642075B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D642075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbeGVSsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:48:47 -0400
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:50075 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730076AbeGVSsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:48:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 67127837F27D;
        Sun, 22 Jul 2018 17:51:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: floor48_7fc522f383034
X-Filterd-Recvd-Size: 2016
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 22 Jul 2018 17:51:17 +0000 (UTC)
Message-ID: <e617ecb8c019a9c4c56540a1bec16c8aed43a4e4.camel@perches.com>
Subject: [PATCH] checkpatch: Fix krealloc reuse test
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     anirudh@xilinx.com, sgoud@xilinx.com, svemula@xilinx.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Manish Narani <manish.narani@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 22 Jul 2018 10:51:16 -0700
In-Reply-To: <1531922148-7423-1-git-send-email-manish.narani@xilinx.com>
References: <1531922148-7423-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current krealloc test does not function correctly when the
temporary pointer return name contains the original pointer name.

Fix that by maximally matching the return pointer name and the original
pointer name and doing a separate comparison of the both names.

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Joe Perches <joe@perches.com>
CC: Manish Narani <manish.narani@xilinx.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ed4fa986e8da..59eaaede757a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6149,7 +6149,8 @@ sub process {
 
 # check for krealloc arg reuse
 		if ($perl_version_ok &&
-		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*\1\s*,/) {
+		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*($Lval)\s*,/ &&
+		    $1 eq $3) {
 			WARN("KREALLOC_ARG_REUSE",
 			     "Reusing the krealloc arg is almost always a bug\n" . $herecurr);
 		}
