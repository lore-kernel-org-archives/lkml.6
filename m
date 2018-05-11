Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeEKVjZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:39:25 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:39961 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750746AbeEKVjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:39:23 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3871:3872:4321:4605:5007:7903:8603:10004:10400:10848:11026:11473:11658:11914:12296:12555:12760:13069:13311:13357:13439:14181:14394:14659:14721:21080:21433:21627:30054:30070:30090,0,RBL:172.58.39.76:@perches.com:.lbl8.mailshell.net-62.8.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: gold44_6edada88c1f1c
X-Filterd-Recvd-Size: 2241
Message-ID: <24f146a8726f391736bc79306e64b204435eb4ec.camel@perches.com>
Subject: [PATCH] ring_buffer: Update logging to use single line output
From: Joe Perches <joe@perches.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Fri, 11 May 2018 14:39:18 -0700
In-Reply-To: <20180510122843.0b69b41a@gandalf.local.home>
References: <cover.1525964381.git.joe@perches.com>
         <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
         <20180510122843.0b69b41a@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a possible change to pr_fmt coming, the logging output can
become unbalanced when an initial line has a prefix and subsequent
lines do not when a multiple line pr_<level> is emitted.

Fix it by emitting a single line.

 	Miscellanea:

o Convert consecutive tests of total_lost and !total_lost to if/else

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/trace/ring_buffer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c9cb9767d49b..ee74494a2da3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5132,10 +5132,9 @@ static __init int test_ringbuffer(void)
 		pr_info("        total events:   %ld\n", total_lost + total_read);
 		pr_info("  recorded len bytes:   %ld\n", total_len);
 		pr_info(" recorded size bytes:   %ld\n", total_size);
-		if (total_lost)
-			pr_info(" With dropped events, record len and size may not match\n"
-				" alloced and written from above\n");
-		if (!total_lost) {
+		if (total_lost) {
+			pr_info(" With dropped events, record len and size may not match alloced and written from above\n");
+		} else {
 			if (RB_WARN_ON(buffer, total_len != total_alloc ||
 				       total_size != total_written))
 				break;
