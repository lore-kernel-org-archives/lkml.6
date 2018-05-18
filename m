Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeERRuz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:50:55 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:51019 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752375AbeERRux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:50:53 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:305:355:379:541:599:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1719:1730:1747:1777:1792:2197:2199:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:7974:8660:8784:8957:8985:9025:10004:10400:10848:11026:11218:11232:11473:11658:11914:12043:12296:12555:12740:12760:12895:13148:13230:13439:14180:14181:14659:14721:21060:21080:21221:21324:21433:21451:21627:21740:30054:30070:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: art82_7bdd4c402ae56
X-Filterd-Recvd-Size: 3250
Message-ID: <33bbe7e9c0f41ee0ef73ffd5bbca1e9c84c259ec.camel@perches.com>
Subject: Re: seq_putc is preferable to seq_puts
From: Joe Perches <joe@perches.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 18 May 2018 10:50:49 -0700
In-Reply-To: <20180518140957.GB6361@bombadil.infradead.org>
References: <20180518140957.GB6361@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 07:09 -0700, Matthew Wilcox wrote:
> Hi Joe,
> 
> A nice checkpatch addition would be to look for seq_puts(x, "s")
> and recommend the author use seq_putc(x, 's') instead.  The primary
> offender is seq_puts(x, "\n") (a hundred or so, scattered throughout
> the kernel), but seq_puts(x, " ") has its adherents too.

Firstly, has Markus Elfring left the building?

Here's a grep to find the existing uses:

$ git grep -P '\b(?:seq_puts|seq_printf)\s*\(\s*[^,]+,\s*"(?:\\.|.)"\s*\)\s*;' | \
  wc -l
326

and a trivial script to convert them all treewide

$ git grep -P --name-only '\b(?:seq_puts|seq_printf)\s*\(\s*[^,]+,\s*"(?:\\.|.)"\s*\)\s*;' | \
  xargs perl -i -e 'local $/; while (<>) { s/\b(?:seq_puts|seq_printf)\s*\(\s*([^,]+),\s*"(\\.|.)"\s*\)\s*;/seq_putc(\1, '"'\2'"')/g; print;}'

Anyway, I still like a variant of Steven Rostedt's
trace_puts macro silliness hack that avoids all
this by allowing seq_printf without format arguments
to call the appropriate seq_puts/seq_putc invisibly.

https://groups.google.com/forum/#!topic/linux.kernel/YGZhTD-n4UA

It's relatively easy to expand this for seq_putc, but here's
an expanded checkpatch rule anyway that seems to work.
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index baddac9379f0..62b36d7bb3af 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5791,11 +5791,23 @@ sub process {
 			     "struct spinlock should be spinlock_t\n" . $herecurr);
 		}
 
-# check for seq_printf uses that could be seq_puts
-		if ($sline =~ /\bseq_printf\s*\(.*"\s*\)\s*;\s*$/) {
+# check for seq_printf/seq_puts uses that could be seq_puts or seq_putc
+		if ($sline =~ /\b(seq_(?:printf|puts))\s*\(.*"\s*\)\s*;\s*$/) {
+			my $call = $1;
 			my $fmt = get_quoted_string($line, $rawline);
+			my $fmt_nq = substr($fmt, 1, length($fmt) - 2); #strip outer quotes
 			$fmt =~ s/%%//g;
-			if ($fmt !~ /%/) {
+
+			if (length($fmt_nq) == 1 ||
+			    (length($fmt_nq) == 2 && ($fmt_nq =~ /^\\/ || $fmt_nq =~ /\%\%/))) {
+				my $fmt_sub = $fmt_nq;
+				$fmt_sub =~ s/\%\%/%/;
+				if (WARN("PREFER_SEQ_PUTC",
+					 "Prefer seq_putc to $call\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\b$call\s*\(\s*($FuncArg)\s*,\s*"\Q$fmt_nq\E"\s*\)/seq_putc($1, '$fmt_sub')/x;
+				}
+			} elsif ($fmt !~ /%/) {
 				if (WARN("PREFER_SEQ_PUTS",
 					 "Prefer seq_puts to seq_printf\n" . $herecurr) &&
 				    $fix) {
