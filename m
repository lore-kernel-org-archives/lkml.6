Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E639BECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 16:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD1D208EA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 16:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD1D208EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeGOQ6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 12:58:05 -0400
Received: from smtprelay0171.hostedemail.com ([216.40.44.171]:48666 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbeGOQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 12:58:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5B5AA181D3417;
        Sun, 15 Jul 2018 16:34:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brush48_45116a7d63d16
X-Filterd-Recvd-Size: 1871
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 15 Jul 2018 16:34:34 +0000 (UTC)
Message-ID: <86cdb43a4db70670c102020093f7fb4eb3003e01.camel@perches.com>
Subject: [PATCH] checkpatch: Fix macro argument reuse test
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Date:   Sun, 15 Jul 2018 09:34:33 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple line macro definitions where the arguments are
separated by line continuations can cause checkpatch to
emit invalid syntax regex tests.

This can occur when a single argument is modified in a
part of a patch.

For example: (to not add a diff in the commit message)

$ ./scripts/checkpatch.pl --git db023296f0115d2fe01fdabad54678f2b806da23
Unterminated \g... pattern in regex; <very long regex omitted>

And, the test does not work correctly when these arguments
are all new as the initial patch line addition "+" is used
in the argument name.

Fix this by stripping the line continuations and any "+"
from the list of arguments.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b5c875d7132b..fa29aebff5a1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4950,6 +4950,7 @@ sub process {
 			if (defined $define_args && $define_args ne "") {
 				$define_args = substr($define_args, 1, length($define_args) - 2);
 				$define_args =~ s/\s*//g;
+				$define_args =~ s/\\\+?//g;
 				@def_args = split(",", $define_args);
 			}
 
