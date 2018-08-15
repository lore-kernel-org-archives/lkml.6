Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A95AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8192152A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8192152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeHPBK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:10:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38406 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeHPBK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:10:59 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C8E6D5A;
        Wed, 15 Aug 2018 22:16:53 +0000 (UTC)
Date:   Wed, 15 Aug 2018 15:16:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm, page_alloc: actually ignore mempolicies for high
 priority allocations
Message-Id: <20180815151652.05d4c4684b7dff2282b5c046@linux-foundation.org>
In-Reply-To: <20180612122624.8045-1-vbabka@suse.cz>
References: <20180612122624.8045-1-vbabka@suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 14:26:24 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> The __alloc_pages_slowpath() function has for a long time contained code to
> ignore node restrictions from memory policies for high priority allocations.
> The current code that resets the zonelist iterator however does effectively
> nothing after commit 7810e6781e0f ("mm, page_alloc: do not break __GFP_THISNODE
> by zonelist reset") removed a buggy zonelist reset. Even before that commit,
> mempolicy restrictions were still not ignored, as they are passed in
> ac->nodemask which is untouched by the code.
> 
> We can either remove the code, or make it work as intended. Since
> ac->nodemask can be set from task's mempolicy via alloc_pages_current() and
> thus also alloc_pages(), it may indeed affect kernel allocations, and it makes
> sense to ignore it to allow progress for high priority allocations.
> 
> Thus, this patch resets ac->nodemask to NULL in such cases. This assumes all
> callers can handle it (i.e. there are no guarantees as in the case of
> __GFP_THISNODE) which seems to be the case. The same assumption is already
> present in check_retry_cpuset() for some time.
> 
> The expected effect is that high priority kernel allocations in the context of
> userspace tasks (e.g. OOM victims) restricted by mempolicies will have higher
> chance to succeed if they are restricted to nodes with depleted memory, while
> there are other nodes with free memory left.

We don't have any reviews or acks on ths one, perhaps because linux-mm
wasn't cc'ed.  Could people please take a look?


From: Vlastimil Babka <vbabka@suse.cz>
Subject: mm, page_alloc: actually ignore mempolicies for high priority allocations

The __alloc_pages_slowpath() function has for a long time contained code
to ignore node restrictions from memory policies for high priority
allocations.  The current code that resets the zonelist iterator however
does effectively nothing after commit 7810e6781e0f ("mm, page_alloc: do
not break __GFP_THISNODE by zonelist reset") removed a buggy zonelist
reset.  Even before that commit, mempolicy restrictions were still not
ignored, as they are passed in ac->nodemask which is untouched by the
code.

We can either remove the code, or make it work as intended.  Since
ac->nodemask can be set from task's mempolicy via alloc_pages_current()
and thus also alloc_pages(), it may indeed affect kernel allocations, and
it makes sense to ignore it to allow progress for high priority
allocations.

Thus, this patch resets ac->nodemask to NULL in such cases.  This assumes
all callers can handle it (i.e.  there are no guarantees as in the case of
__GFP_THISNODE) which seems to be the case.  The same assumption is
already present in check_retry_cpuset() for some time.

The expected effect is that high priority kernel allocations in the
context of userspace tasks (e.g.  OOM victims) restricted by mempolicies
will have higher chance to succeed if they are restricted to nodes with
depleted memory, while there are other nodes with free memory left.


Ot's not a new intention, but for the first time the code will match the
intention, AFAICS.  It was intended by commit 183f6371aac2 ("mm: ignore
mempolicies when using ALLOC_NO_WATERMARK") in v3.6 but I think it never
really worked, as mempolicy restriction was already encoded in nodemask,
not zonelist, at that time.

So originally that was for ALLOC_NO_WATERMARK only.  Then it was adjusted
by e46e7b77c909 ("mm, page_alloc: recalculate the preferred zoneref if the
context can ignore memory policies") and cd04ae1e2dc8 ("mm, oom: do not
rely on TIF_MEMDIE for memory reserves access") to the current state.  So
even GFP_ATOMIC would now ignore mempolicies after the initial attempts
fail - if the code worked as people thought it does.

Link: http://lkml.kernel.org/r/20180612122624.8045-1-vbabka@suse.cz
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/mm/page_alloc.c~mm-page_alloc-actually-ignore-mempolicies-for-high-priority-allocations
+++ a/mm/page_alloc.c
@@ -4165,11 +4165,12 @@ retry:
 		alloc_flags = reserve_flags;
 
 	/*
-	 * Reset the zonelist iterators if memory policies can be ignored.
-	 * These allocations are high priority and system rather than user
-	 * orientated.
+	 * Reset the nodemask and zonelist iterators if memory policies can be
+	 * ignored. These allocations are high priority and system rather than
+	 * user oriented.
 	 */
 	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
+		ac->nodemask = NULL;
 		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
 					ac->high_zoneidx, ac->nodemask);
 	}
_


