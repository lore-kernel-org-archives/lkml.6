Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeDJPlN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:41:13 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:43749 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751604AbeDJPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:41:11 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3865:3870:3871:4321:5007:10004:10400:10848:11658:11914:12043:12048:12555:12760:12895:12986:13069:13311:13357:13439:14181:14394:14659:14721:21080:21627:30054:30060:30070,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: pest08_7e34442566f4e
X-Filterd-Recvd-Size: 2214
Message-ID: <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
Subject: [PATCH] checkpatch: whinge about bool bitfields
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
Date: Tue, 10 Apr 2018 08:41:05 -0700
In-Reply-To: <20180410123305.GF4082@hirez.programming.kicks-ass.net>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
         <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
         <20180410123305.GF4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bool in a bitfield isn't a good idea as the
alignment behavior is arch implementation defined.

Suggest using unsigned int or u<8|16|32> instead.

Signed-off-by: Joe Perches <joe@perches.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eb534d48140e..e16d6713f236 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6251,6 +6251,12 @@ sub process {
 			}
 		}
 
+# check for bool bitfields
+		if ($sline =~ /^.\s+bool\s*$Ident\s*:\s*\d+\s*;/) {
+			WARN("BOOL_BITFIELD",
+			     "Avoid using bool as bitfield.  Prefer bool bitfields as unsigned int or u<8|16|32>\n" . $herecurr);
+		}
+
 # check for semaphores initialized locked
 		if ($line =~ /^.\s*sema_init.+,\W?0\W?\)/) {
 			WARN("CONSIDER_COMPLETION",
