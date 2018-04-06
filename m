Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48h7BIABilH+s4hi3EzQAOIeW2+FmstuGMie6R7aZ1n2hqEttV0WlGayG25Fm/1fVKjRtQQ
ARC-Seal: i=1; a=rsa-sha256; t=1523021721; cv=none;
        d=google.com; s=arc-20160816;
        b=oUHlN/UhCdrlR1xLa9wBTlTsHDUEhDBj/RK6dRta3zElHYdQFgo/7lV98NO5POYw8B
         NMAiFxQO/uQ1E2hfn1idrVy/refHpb04xg5bASkfiod2xtmZzdGd34S0gM7FP9+nGJsj
         9LXKODVl/3mC6Zur5+aL1+qvcuByy0sR82xiybSviUboFy9oibb5Qa5TO7B4cMEya+5U
         AOADUcchK4p4BQRm9ETi0CC8z91bQZ8eCgD9Xnz/MkkzVxg5Yo/AZAVip5r112XoVOa7
         g2zjm0STnGVHGhehVWryZtFhBBY+jvwWzjbdeNVrT7U/qsMTmPdEF+VgnNBYsncnAzv/
         CSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=y0OrqT6sb6zyh62v8Bw1rL0Mj4wnWbmO8/1oSx0FY04=;
        b=Ra5pifV3bpYKmJTmaqlb6tOUjPpAR7bnRZGOhXzEbEHueUsNJgH3G+NI3XKh/u8mSt
         sLrjlfGIKFYR6xVdq3Td2CUNgcpk+qsDHOpLapvaeGV3BQLvpMvou4H3ftMUVm8EvgEo
         Yf8MBQnr++3TRNGI9rW/tRelrDt9+CqUrQg1kW245N0R4egRVHYKfX/RvFLGyc4KdpPs
         /353dxYka1HQwuOMN5lnbhwIh3pG7pnjYRD/bChjXOW7elyl2qbLw0gey8RpoEsXhPqP
         R8jQUyYr1JyVQTjBjZcdwHsrZ4lULj+7veaSzkuO8DoQ3NsnOGB/W7e82DejSiw5QZeF
         Z1Zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 034/102] mm/vmscan.c: fix unsequenced modification and access warning
Date: Fri,  6 Apr 2018 15:23:15 +0200
Message-Id: <20180406084336.435349772@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004024515605999?=
X-GMAIL-MSGID: =?utf-8?q?1597004024515605999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <nick.desaulniers@gmail.com>

commit f2f43e566a02a3bdde0a65e6a2e88d707c212a29 upstream.

Clang and its -Wunsequenced emits a warning

  mm/vmscan.c:2961:25: error: unsequenced modification and access to 'gfp_mask' [-Wunsequenced]
                  .gfp_mask = (gfp_mask = current_gfp_context(gfp_mask)),
                                        ^

While it is not clear to me whether the initialization code violates the
specification (6.7.8 par 19 (ISO/IEC 9899) looks like it disagrees) the
code is quite confusing and worth cleaning up anyway.  Fix this by
reusing sc.gfp_mask rather than the updated input gfp_mask parameter.

Link: http://lkml.kernel.org/r/20170510154030.10720-1-nick.desaulniers@gmail.com
Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[natechancellor: Adjust context due to abscence of 7dea19f9ee63]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmscan.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2966,7 +2966,7 @@ unsigned long try_to_free_pages(struct z
 	unsigned long nr_reclaimed;
 	struct scan_control sc = {
 		.nr_to_reclaim = SWAP_CLUSTER_MAX,
-		.gfp_mask = (gfp_mask = memalloc_noio_flags(gfp_mask)),
+		.gfp_mask = memalloc_noio_flags(gfp_mask),
 		.reclaim_idx = gfp_zone(gfp_mask),
 		.order = order,
 		.nodemask = nodemask,
@@ -2981,12 +2981,12 @@ unsigned long try_to_free_pages(struct z
 	 * 1 is returned so that the page allocator does not OOM kill at this
 	 * point.
 	 */
-	if (throttle_direct_reclaim(gfp_mask, zonelist, nodemask))
+	if (throttle_direct_reclaim(sc.gfp_mask, zonelist, nodemask))
 		return 1;
 
 	trace_mm_vmscan_direct_reclaim_begin(order,
 				sc.may_writepage,
-				gfp_mask,
+				sc.gfp_mask,
 				sc.reclaim_idx);
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
@@ -3749,16 +3749,15 @@ static int __node_reclaim(struct pglist_
 	const unsigned long nr_pages = 1 << order;
 	struct task_struct *p = current;
 	struct reclaim_state reclaim_state;
-	int classzone_idx = gfp_zone(gfp_mask);
 	struct scan_control sc = {
 		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
-		.gfp_mask = (gfp_mask = memalloc_noio_flags(gfp_mask)),
+		.gfp_mask = memalloc_noio_flags(gfp_mask),
 		.order = order,
 		.priority = NODE_RECLAIM_PRIORITY,
 		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
 		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
 		.may_swap = 1,
-		.reclaim_idx = classzone_idx,
+		.reclaim_idx = gfp_zone(gfp_mask),
 	};
 
 	cond_resched();
@@ -3768,7 +3767,7 @@ static int __node_reclaim(struct pglist_
 	 * and RECLAIM_UNMAP.
 	 */
 	p->flags |= PF_MEMALLOC | PF_SWAPWRITE;
-	lockdep_set_current_reclaim_state(gfp_mask);
+	lockdep_set_current_reclaim_state(sc.gfp_mask);
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
