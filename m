Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DCCC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFE1219A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFE1219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeHFE0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:26:17 -0400
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:35077 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725777AbeHFE0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:26:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 55FB51802958B;
        Mon,  6 Aug 2018 02:19:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boy38_8c97c662ee434
X-Filterd-Recvd-Size: 2667
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon,  6 Aug 2018 02:19:26 +0000 (UTC)
Message-ID: <7bbd97dc0a1e5896a0251fada7bb68bb33643f77.camel@perches.com>
Subject: [PATCH] checkpatch: warn on unnecessary int declarations
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 05 Aug 2018 19:19:23 -0700
In-Reply-To: <CA+55aFx1vbQWnQUVoieFgKrNECLKJs-RQi8z8cpe29g0aAiq3A@mail.gmail.com>
References: <20180805.004744.1043412275329854518.davem@davemloft.net>
         <CA+55aFx1vbQWnQUVoieFgKrNECLKJs-RQi8z8cpe29g0aAiq3A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-08-05 at 08:52 -0700, Linus Torvalds wrote:
> "long unsigned int" isn't _technically_ wrong. But we normally
> call that type "unsigned long".

So add a checkpatch test for it.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ce72cc4784e6..bc6dda34394e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3829,6 +3829,26 @@ sub process {
 			     "type '$tmp' should be specified in [[un]signed] [short|int|long|long long] order\n" . $herecurr);
 		}
 
+# check for unnecessary <signed> int declarations of short/long/long long
+		while ($sline =~ m{\b($TypeMisordered(\s*\*)*|$C90_int_types)\b}g) {
+			my $type = trim($1);
+			next if ($type !~ /\bint\b/);
+			next if ($type !~ /\b(?:short|long\s+long|long)\b/);
+			my $new_type = $type;
+			$new_type =~ s/\b\s*int\s*\b/ /;
+			$new_type =~ s/\b\s*(?:un)?signed\b\s*/ /;
+			$new_type =~ s/^const\s+//;
+			$new_type = "unsigned $new_type" if ($type =~ /\bunsigned\b/);
+			$new_type = "const $new_type" if ($type =~ /^const\b/);
+			$new_type =~ s/\s+/ /g;
+			$new_type = trim($new_type);
+			if (WARN("UNNECESSARY_INT",
+				 "Prefer '$new_type' over '$type' as the int is unnecessary\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\b\Q$type\E\b/$new_type/;
+			}
+		}
+
 # check for static const char * arrays.
 		if ($line =~ /\bstatic\s+const\s+char\s*\*\s*(\w+)\s*\[\s*\]\s*=\s*/) {
 			WARN("STATIC_CONST_CHAR_ARRAY",

