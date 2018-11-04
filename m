Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D1BC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 21:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2B92082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 21:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2B92082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbeKEHIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 02:08:34 -0500
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:59791 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729557AbeKEHIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 02:08:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 258AF181D340F;
        Sun,  4 Nov 2018 21:52:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boys32_2f75dbdd2a313
X-Filterd-Recvd-Size: 2480
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun,  4 Nov 2018 21:52:05 +0000 (UTC)
Message-ID: <10ea5f4b087dc911e41e187a4a2b5e79c7529aa3.camel@perches.com>
Subject: [PATCH] checkpatch: Warn on const char foo[]  = "bar"; declarations
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Date:   Sun, 04 Nov 2018 13:52:04 -0800
In-Reply-To: <20181102230624.20064-1-linux@rasmusvillemoes.dk>
References: <20181102230624.20064-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These declarations should generally be static const to avoid
poor compilation and runtime performance where compilers
tend to initialize the const declaration for every call
instead of using .rodata for the string.

Miscellanea:

o Convert spaces to tabs for indentation in 2 adjacent checks

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c883ec55654f..7789e13dac9d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3869,14 +3869,23 @@ sub process {
 			WARN("STATIC_CONST_CHAR_ARRAY",
 			     "static const char * array should probably be static const char * const\n" .
 				$herecurr);
-               }
+		}
+
+# check for initialized const char arrays that should be static const
+		if ($line =~ /^\+\s*const\s+(char|unsigned\s+char|_*u8|(?:[us]_)?int8_t)\s+\w+\s*\[\s*(?:\w+\s*)?\]\s*=\s*"/) {
+			if (WARN("STATIC_CONST_CHAR_ARRAY",
+				 "const array should probably be static const\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/(^.\s*)const\b/${1}static const/;
+			}
+		}
 
 # check for static char foo[] = "bar" declarations.
 		if ($line =~ /\bstatic\s+char\s+(\w+)\s*\[\s*\]\s*=\s*"/) {
 			WARN("STATIC_CONST_CHAR_ARRAY",
 			     "static char array declaration should probably be static const char\n" .
 				$herecurr);
-               }
+		}
 
 # check for const <foo> const where <foo> is not a pointer or array type
 		if ($sline =~ /\bconst\s+($BasicType)\s+const\b/) {

