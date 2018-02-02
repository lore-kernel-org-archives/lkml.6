Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeBBRJW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:09:22 -0500
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:32906 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752919AbeBBRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:04:58 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2692:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3873:3874:4321:4605:5007:6119:7903:10004:10400:10848:11026:11232:11658:11914:12043:12296:12438:12555:12660:12740:12760:12895:13161:13229:13439:14659:14721:21080:21433:21451:21611:21627:30012:30029:30045:30046:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: word00_def2ff0a2f33
X-Filterd-Recvd-Size: 3346
Message-ID: <1517591094.7489.103.camel@perches.com>
Subject: Re: [PATCH 5/7] [HACK] avoid gcc-8 ICE on LTO
From: Joe Perches <joe@perches.com>
To: Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Date: Fri, 02 Feb 2018 09:04:54 -0800
In-Reply-To: <20180202162104.2300532-5-arnd@arndb.de>
References: <20180202161550.2106846-1-arnd@arndb.de>
         <20180202162104.2300532-5-arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 17:21 +0100, Arnd Bergmann wrote:
> I ran into a build error:
> 
> /git/arm-soc/net/sctp/sm_sideeffect.c: In function 'sctp_do_sm':
> /git/arm-soc/net/sctp/sm_sideeffect.c:1155:5: internal compiler error: Segmentation fault
>  int sctp_do_sm(struct net *net, enum sctp_event event_type,
>      ^
> 0xa42b7f crash_signal
> 
> The bug is fixed in mainline gcc now, but I carry this as I have
> not yet upgrade.
[]
> diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
[]
> @@ -1152,12 +1152,12 @@ static void sctp_cmd_send_asconf(struct sctp_association *asoc)
>   * If you want to understand all of lksctp, this is a
>   * good place to start.
>   */
> +typedef const char *(printfn_t)(union sctp_subtype);

This typedef is only used in this file twice.
Perhaps removing the typedef is clearer.

Given the debug_fn use is only in another
used-once macro, convert that debug_fn in
the macro too and avoid the unnecessary
variable initialization.

The debug_[pre|post]_[sfn|sfx] macros are
probably unnecessary indirections and could
be removed too but the code might read worse.

---
 net/sctp/sm_sideeffect.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index b71e7fb0a20a..5a6de0070b71 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1133,8 +1133,9 @@ static void sctp_cmd_send_asconf(struct sctp_association *asoc)
  * functionality there.
  */
 #define debug_pre_sfn() \
-	pr_debug("%s[pre-fn]: ep:%p, %s, %s, asoc:%p[%s], %s\n", __func__, \
-		 ep, sctp_evttype_tbl[event_type], (*debug_fn)(subtype),   \
+	pr_debug("%s[pre-fn]: ep:%p, %s, %s, asoc:%p[%s], %s\n",	\
+		 __func__, ep, sctp_evttype_tbl[event_type],		\
+		 (*table[event_type])(subtype),				\
 		 asoc, sctp_state_tbl[state], state_fn->name)
 
 #define debug_post_sfn() \
@@ -1157,11 +1158,9 @@ int sctp_do_sm(struct net *net, enum sctp_event event_type,
 	       struct sctp_endpoint *ep, struct sctp_association *asoc,
 	       void *event_arg, gfp_t gfp)
 {
-	typedef const char *(printfn_t)(union sctp_subtype);
-	static printfn_t *table[] = {
+	static const char *(*table[])(union sctp_subtype) = {
 		NULL, sctp_cname, sctp_tname, sctp_oname, sctp_pname,
 	};
-	printfn_t *debug_fn  __attribute__ ((unused)) = table[event_type];
 	const struct sctp_sm_table_entry *state_fn;
 	struct sctp_cmd_seq commands;
 	enum sctp_disposition status;
