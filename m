Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeDJSUA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:20:00 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:45272 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751961AbeDJST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:19:58 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3870:3871:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:5007:8603:9025:10004:10400:10848:11658:11914:12043:12048:12555:12740:12760:12895:12986:13069:13095:13161:13229:13255:13311:13357:13439:14181:14394:14659:14721:21080:21433:21627:30054:30060:30070,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: offer42_3995c20971129
X-Filterd-Recvd-Size: 2801
Message-ID: <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
Subject: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
From: Joe Perches <joe@perches.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc: yuankuiz@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 10 Apr 2018 11:19:54 -0700
In-Reply-To: <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
         <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
         <20180410123305.GF4082@hirez.programming.kicks-ass.net>
         <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A struct with a bool member can have different sizes on various
architectures because neither bool size nor alignment is standardized.

So emit a message on the use of bool in structs only in .h files and
not .c files.

There is the real possibility that this test could have a false positive
when a bool is declared as an automatic, so limit the test to .h files
where the only false positive is for declarations in static inline functions.

Signed-off-by: Joe Perches <joe@perches.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e16d6713f236..24618dffc5cb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6257,6 +6257,13 @@ sub process {
 			     "Avoid using bool as bitfield.  Prefer bool bitfields as unsigned int or u<8|16|32>\n" . $herecurr);
 		}
 
+# check for bool use in .h files
+		if ($realfile =~ /\.h$/ &&
+		    $sline =~ /^.\s+bool\s*$Ident\s*(?::\s*d+\s*)?;/) {
+			CHK("BOOL_MEMBER",
+			    "Avoid using bool structure members because of possible alignment issues - see: https://lkml.org/lkml/2017/11/21/384\n" . $herecurr);
+		}
+
 # check for semaphores initialized locked
 		if ($line =~ /^.\s*sema_init.+,\W?0\W?\)/) {
 			WARN("CONSIDER_COMPLETION",
-- 
2.15.0
