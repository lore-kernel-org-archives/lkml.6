Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA81C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A0B2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfALUqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 15:46:01 -0500
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:54182 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbfALUqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 15:46:00 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6ABA2182CED28;
        Sat, 12 Jan 2019 20:45:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lead10_8b8053b338518
X-Filterd-Recvd-Size: 3610
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Jan 2019 20:45:58 +0000 (UTC)
Message-ID: <a5e60a2b93e10baf84af063f6c8e56402273105d.camel@perches.com>
Subject: [PATCH] checkpatch: Add some new alloc functions to various tests
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Sat, 12 Jan 2019 12:45:57 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many new generic allocation functions like the
kvmalloc family have been added recently to the kernel.

The allocation functions test now includes:

o kvmalloc and variants
o kstrdup_const
o kmemdup_nul
o dma_alloc_coherent
o alloc_skb and variants

Add a separate $allocFunctions variable to help make
the allocation functions test a bit more readable.

Miscellanea:

o Use $allocFunctions in the unnecessary OOM message test and
  add exclude uses with __GFP_NOWARN
o Use $allocFunctions in the unnecessary cast test
o Add the kvmalloc family to the preferred sizeof alloc style
  foo = kvmalloc(sizeof(*foo), ...)

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 155fa9305166..551da83cb00f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -466,6 +466,16 @@ our $logFunctions = qr{(?x:
 	seq_vprintf|seq_printf|seq_puts
 )};
 
+our $allocFunctions = qr{(?x:
+	(?:(?:devm_)?
+		(?:kv|k|v)[czm]alloc(?:_node|_array)? |
+		kstrdup(?:_const)? |
+		kmemdup(?:_nul)?) |
+	(?:\w+)?alloc_skb(?:ip_align)? |
+				# dev_alloc_skb/netdev_alloc_skb, et al
+	dma_alloc_coherent
+)};
+
 our $signature_tags = qr{(?xi:
 	Signed-off-by:|
 	Co-developed-by:|
@@ -5547,7 +5557,8 @@ sub process {
 			my ($s, $c) = ctx_statement_block($linenr - 3, $realcnt, 0);
 #			print("line: <$line>\nprevline: <$prevline>\ns: <$s>\nc: <$c>\n\n\n");
 
-			if ($s =~ /(?:^|\n)[ \+]\s*(?:$Type\s*)?\Q$testval\E\s*=\s*(?:\([^\)]*\)\s*)?\s*(?:devm_)?(?:[kv][czm]alloc(?:_node|_array)?\b|kstrdup|kmemdup|(?:dev_)?alloc_skb)/) {
+			if ($s =~ /(?:^|\n)[ \+]\s*(?:$Type\s*)?\Q$testval\E\s*=\s*(?:\([^\)]*\)\s*)?\s*$allocFunctions\s*\(/ &&
+			    $s !~ /\b__GFP_NOWARN\b/ ) {
 				WARN("OOM_MESSAGE",
 				     "Possible unnecessary 'out of memory' message\n" . $hereprev);
 			}
@@ -6198,8 +6209,8 @@ sub process {
 			}
 		}
 
-# check for pointless casting of kmalloc return
-		if ($line =~ /\*\s*\)\s*[kv][czm]alloc(_node){0,1}\b/) {
+# check for pointless casting of alloc functions
+		if ($line =~ /\*\s*\)\s*$allocFunctions\b/) {
 			WARN("UNNECESSARY_CASTS",
 			     "unnecessary cast may hide bugs, see http://c-faq.com/malloc/mallocnocast.html\n" . $herecurr);
 		}
@@ -6207,7 +6218,7 @@ sub process {
 # alloc style
 # p = alloc(sizeof(struct foo), ...) should be p = alloc(sizeof(*p), ...)
 		if ($perl_version_ok &&
-		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*([kv][mz]alloc(?:_node)?)\s*\(\s*(sizeof\s*\(\s*struct\s+$Lval\s*\))/) {
+		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k|v)[mz]alloc(?:_node)?)\s*\(\s*(sizeof\s*\(\s*struct\s+$Lval\s*\))/) {
 			CHK("ALLOC_SIZEOF_STRUCT",
 			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
 		}



