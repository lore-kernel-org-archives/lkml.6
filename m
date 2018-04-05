Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeDEXzm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 19:55:42 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:43545 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750835AbeDEXzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:55:39 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3868:3870:3871:3872:3873:4321:4605:5007:6117:6119:9010:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12296:12438:12555:12740:12760:12895:12986:13439:14659:14721:19904:19999:21080:21324:21451:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: song43_4e17be816c543
X-Filterd-Recvd-Size: 3635
Message-ID: <1522972535.11185.49.camel@perches.com>
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown
 pointer specifiers
From: Joe Perches <joe@perches.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 16:55:35 -0700
In-Reply-To: <1522971908.11185.46.camel@perches.com>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-5-pmladek@suse.com>
         <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
         <1522971908.11185.46.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-05 at 16:45 -0700, Joe Perches wrote:
> On Thu, 2018-04-05 at 16:25 +0200, Rasmus Villemoes wrote:
> > Even just git grep -1 -E '%p"$' finds %pt and %po
> > which should get fixed before somebody claims those extensions.
> 
> Neither %pt nor %po is used in a vsprintf
> in the kernel.

Nope, you are right, both are defectively used in the
kernel via string concatenation.

Also there's a missing space in a concatenation adjacent.

---
 arch/s390/kernel/perf_cpum_sf.c           | 4 +---
 drivers/scsi/megaraid/megaraid_sas_base.c | 7 ++-----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 1c9ddd7aa5ec..458b8f321043 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -212,9 +212,7 @@ static int realloc_sampling_buffer(struct sf_buffer *sfb,
 	 * the sampling buffer origin.
 	 */
 	if (sfb->sdbt != get_next_sdbt(tail)) {
-		debug_sprintf_event(sfdbg, 3, "realloc_sampling_buffer: "
-				    "sampling buffer is not linked: origin=%p"
-				    "tail=%p\n",
+		debug_sprintf_event(sfdbg, 3, "%s: sampling buffer is not linked: origin=%p tail=%p\n",
 				    (void *) sfb->sdbt, (void *) tail);
 		return -EINVAL;
 	}
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index b89c6e6c0589..56f1c8132664 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3546,14 +3546,11 @@ megasas_internal_reset_defer_cmds(struct megasas_instance *instance)
 	for (i = 0; i < max_cmd; i++) {
 		cmd = instance->cmd_list[i];
 		if (cmd->sync_cmd == 1 || cmd->scmd) {
-			dev_notice(&instance->pdev->dev, "moving cmd[%d]:%p:%d:%p"
-					"on the defer queue as internal\n",
+			dev_notice(&instance->pdev->dev, "moving cmd[%d]:%p:%d:%p on the defer queue as internal\n",
 				defer_index, cmd, cmd->sync_cmd, cmd->scmd);
 
 			if (!list_empty(&cmd->list)) {
-				dev_notice(&instance->pdev->dev, "ERROR while"
-					" moving this cmd:%p, %d %p, it was"
-					"discovered on some list?\n",
+				dev_notice(&instance->pdev->dev, "ERROR while moving this cmd:%p, %d %p, it was discovered on some list?\n",
 					cmd, cmd->sync_cmd, cmd->scmd);
 
 				list_del_init(&cmd->list);
