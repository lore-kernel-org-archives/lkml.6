Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647FEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2980E20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f/7Vcl/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2980E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbeKFT1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:27:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55786 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387480AbeKFT1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jyhp7u/yBIyHd3yzfIPFx52dzMQagyqE60Q+cB7LdQY=; b=f/7Vcl/5Whb6OLBDu09VWiCpjA
        zeGPlFFGNtIjocndrm0MhHP9l8YtEkS6OQSKV2jh11F3/CQZ4JJz4TmVKswOOa3a4qs+S/7SGyp46
        6yPuPdNP+woXdTkNAPkNMlXfWnlTsEmS2G+kLw4o9kWMrtkkRDTxMnAp3Y8zYHu8CM2RBXunuqX6G
        AtvLDnK4kRR+7Pe62FUXqTw75G5zAeZnvaPl1K1iJpjVyi1woPs4Ae2IirmgbSJFuUlOgfv9OeaVE
        bXHiQUeYph4g4sqyT0/bp5yVB0JIR7B3zpswciRzpK/1jEgKczt2BAiffLoSyOXqZQpmH8TZvQu9W
        6Bn2nxFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJyBu-00058m-D9; Tue, 06 Nov 2018 10:02:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E7EA2029F9FF; Tue,  6 Nov 2018 11:02:29 +0100 (CET)
Date:   Tue, 6 Nov 2018 11:02:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <namit@vmware.com>, Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC][PATCH] tree-wide: Remove __inline__ and __inline usage
Message-ID: <20181106100229.GI22431@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A proposed GCC asm extention:

  https://gcc.gnu.org/ml/gcc-patches/2018-10/msg01931.html

allows adding the "inline" keyword to 'asm ("")' statements. The
problem is that we're possibly redefining "inline" to
"inline __attribute__((__always_inline__))" which makes the proposed:

  asm volatile inline ("")

not compile.

However, since we've been depricating the use of the alternative
inline keywords: "__inline__" and "__inline", and there are only a
'few' uses left of them in the tree:

  $ git grep -e "\<__inline__\>" | wc -l
  487
  $ git grep -e "\<__inline\>" | wc -l
  56
  $ git grep -e "\<inline\>" | wc -l
  69957

let's finish them off now.

Therefore I'm proposing to run:

  git grep -l "\<__inline\(\|__\)\>" | while read file
  do
	sed -i -e 's/\<__inline\(\|__\)\>/inline/g' $file
  done

On your current tree, and apply the below fixup patch on top of that
result.

This would then allow us to do something like (+- GCC feature tests):

  #define asm_volatile(stmt...) asm volatile __inline__(stmt)

once that GCC patch lands.

Cc: Nadav Amit <namit@vmware.com>
Cc: Joe Perches <joe@perches.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/compiler_types.h |    3 ---
 scripts/checkpatch.pl          |   12 ++++++------
 scripts/genksyms/keywords.c    |    2 --
 scripts/kernel-doc             |    2 --
 4 files changed, 6 insertions(+), 13 deletions(-)

--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -202,9 +202,6 @@ struct ftrace_likely_data {
 	__maybe_unused notrace
 #endif
 
-#define inline inline
-#define inline   inline
-
 /*
  * Rather then using noinline to prevent stack consumption, use
  * noinline_for_stack instead.  For documentation reasons.
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -389,7 +389,7 @@ our $Attribute	= qr{
 			__weak
 		  }x;
 our $Modifier;
-our $Inline	= qr{inline|__always_inline|noinline|inline|inline};
+our $Inline	= qr{inline|__always_inline|noinline};
 our $Member	= qr{->$Ident|\.$Ident|\[[^]]*\]};
 our $Lval	= qr{$Ident(?:$Member)*};
 
@@ -5771,13 +5771,13 @@ sub process {
 			      "inline keyword should sit between storage class and type\n" . $herecurr);
 		}
 
-# Check for inline and inline, prefer inline
+# Check for __inline__ and __inline, prefer inline
 		if ($realfile !~ m@\binclude/uapi/@ &&
-		    $line =~ /\b(inline|inline)\b/) {
-			if (WARN("INLINE",
-				 "plain inline is preferred over $1\n" . $herecurr) &&
+		    $line =~ /\b(__inline__|__inline)\b/) {
+			if (ERROR("INLINE",
+				  "plain inline is preferred over $1\n" . $herecurr) &&
 			    $fix) {
-				$fixed[$fixlinenr] =~ s/\b(inline|inline)\b/inline/;
+				$fixed[$fixlinenr] =~ s/\b(__inline__|__inline)\b/inline/;
 
 			}
 		}
--- a/scripts/genksyms/keywords.c
+++ b/scripts/genksyms/keywords.c
@@ -14,8 +14,6 @@ static struct resword {
 	{ "__const", CONST_KEYW },
 	{ "__const__", CONST_KEYW },
 	{ "__extension__", EXTENSION_KEYW },
-	{ "inline", INLINE_KEYW },
-	{ "inline", INLINE_KEYW },
 	{ "__signed", SIGNED_KEYW },
 	{ "__signed__", SIGNED_KEYW },
 	{ "__typeof", TYPEOF_KEYW },
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1569,8 +1569,6 @@ sub dump_function($$) {
     $prototype =~ s/^extern +//;
     $prototype =~ s/^asmlinkage +//;
     $prototype =~ s/^inline +//;
-    $prototype =~ s/^inline +//;
-    $prototype =~ s/^inline +//;
     $prototype =~ s/^__always_inline +//;
     $prototype =~ s/^noinline +//;
     $prototype =~ s/__init +//;
