Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeDFTIs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:08:48 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:42888 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751312AbeDFTIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:08:47 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:960:969:973:988:989:1260:1277:1311:1313:1314:1345:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3740:3865:3866:3867:3868:3870:3871:4470:4605:5007:6117:7557:7903:8660:10004:10400:10848:11026:11658:11914:12043:12296:12438:12555:12760:13148:13161:13229:13230:13439:14181:14659:14721:21080:21094:21323:21324:21451:21622:30054:30056:30070:30080,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: desk47_698de06465520
X-Filterd-Recvd-Size: 3388
Message-ID: <1523041723.6127.33.camel@perches.com>
Subject: s390: defective uses of va_arg in __debug_sprintf_event
From: Joe Perches <joe@perches.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>
Date: Fri, 06 Apr 2018 12:08:43 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debug_sprintf_event calls __debug_sprintf_event
with a format and arguments.

There various types of arguments used in these
call, but __debug_sprintf_event uses va_arg
with only long as the type argument so random
errors could occur because the type and argument
are supposed to match.

    debug_entry_t *__debug_sprintf_event(debug_info_t *id, int level, char *string, ...)
    {
    	    [...]
    	    va_start(ap, string);
    	    curr_event->string = string;
    	    for (idx = 0; idx < min(numargs, (int)(id->buf_size / sizeof(long)) - 1); idx++)
    	    	    curr_event->args[idx] = va_arg(ap, long);
    	    va_end(ap);
    	    [...]
    }

from man va_arg

    va_arg()

    if type is not compatible with the type of the actual next argument
    (as promoted according to the default argument promotions),
    random errors will occur.

For instance, uses like:

arch/s390/kernel/perf_cpum_sf.c:919:    debug_sprintf_event(sfdbg, 6, "pmu_enable: es=%i cs=%i ed=%i cd=%i "
arch/s390/kernel/perf_cpum_sf.c-920-                        "tear=%p dear=%p\n", cpuhw->lsctl.es, cpuhw->lsctl.cs,
arch/s390/kernel/perf_cpum_sf.c-921-                        cpuhw->lsctl.ed, cpuhw->lsctl.cd,
arch/s390/kernel/perf_cpum_sf.c-922-                        (void *) cpuhw->lsctl.tear, (void *) cpuhw->lsctl.dear);

where the first 3 arguments are int but their type
as used by va_arg in __debug_sprintf_event is long
which could produce random errors.

Instead of adding complete format % decoding,
perhaps the easiest solution is to change all
the formats to use %lu or %ld and cast each
argument as appropriate.

And I found this when looking at another defect
in debug_sprintf_event where a %p<foo> extension
is unintentionally used via a string concatenation.
as pointed out by Rasmus Villemoes
---
 arch/s390/kernel/perf_cpum_sf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 1c9ddd7aa5ec..1c449a6f841a 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -212,9 +212,7 @@ static int realloc_sampling_buffer(struct sf_buffer *sfb,
 	 * the sampling buffer origin.
 	 */
 	if (sfb->sdbt != get_next_sdbt(tail)) {
-		debug_sprintf_event(sfdbg, 3, "realloc_sampling_buffer: "
-				    "sampling buffer is not linked: origin=%p"
-				    "tail=%p\n",
+		debug_sprintf_event(sfdbg, 3, "realloc_sampling_buffer: sampling buffer is not linked: origin=%p tail=%p\n",
 				    (void *) sfb->sdbt, (void *) tail);
 		return -EINVAL;
 	}
