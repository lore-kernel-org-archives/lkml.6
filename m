Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589B7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2930321872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfBAQDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:03:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:03:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95E5CA7FDE;
        Fri,  1 Feb 2019 16:03:06 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FE1E27BB5;
        Fri,  1 Feb 2019 16:03:05 +0000 (UTC)
Date:   Fri, 1 Feb 2019 11:03:03 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] livepatch: Followup changes for the atomic replace
 patchset
Message-ID: <20190201160303.GA4241@redhat.com>
References: <20190116161720.796-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116161720.796-1-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 01 Feb 2019 16:03:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:17:16PM +0100, Petr Mladek wrote:
> This patchset implements ideas that were mentioned and postponed during
> the review of the atomic replace patchset. I hope that I did not miss
> anything.
> 
> Well, I did not add __used attribute to avoid non-static warnings
> in modules for the selftest. The work on the sample modules somehow
> stalled.
> 
> BTW: Does it make sense to maintain the sample modules any longer?
> We could point people to the modules used by the selftest instead.
> 
> 
> The patches apply on top of livepatching.git, branch
> origin/for-5.1/atomic-replace.
> 
> 
> Petr Mladek (4):
>   livepatch: Introduce klp_for_each_patch macro
>   livepatch: Handle failing allocation of shadow variables in the
>     selftest
>   livepatch: Module coming and going callbacks can proceed all listed
>     patches
>   livepatch: Remove the redundant enabled flag in struct klp_patch
> 
>  include/linux/livepatch.h            |  2 --
>  kernel/livepatch/core.c              | 57 ++++++++++++++++--------------------
>  kernel/livepatch/core.h              |  6 ++++
>  kernel/livepatch/transition.c        |  9 +++---
>  kernel/livepatch/transition.h        |  1 +
>  lib/livepatch/test_klp_shadow_vars.c |  8 ++---
>  6 files changed, 40 insertions(+), 43 deletions(-)
> 
> -- 
> 2.13.7
> 

Hi Petr,

This change is trivial, but since folks are letting loose various static
code analysers on the livepatch samples and selftests, could you add
this to your patchset.  The shadow variable selftest is happy with this
change since it expects to see specific (non-negative) ptr_id values.

Thanks,

-- Joe

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--

From e4c1e95a2145405115a984c6567740d12f20ccb7 Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence@redhat.com>
Date: Fri, 1 Feb 2019 10:53:25 -0500
Subject: [PATCH] livepatch: return -ENOMEM on ptr_id() allocation failure

Fixes the following smatch warning:

  lib/livepatch/test_klp_shadow_vars.c:47 ptr_id() warn: returning -1 instead of -ENOMEM is sloppy

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 lib/livepatch/test_klp_shadow_vars.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
index 02f892f941dc..f5441c193166 100644
--- a/lib/livepatch/test_klp_shadow_vars.c
+++ b/lib/livepatch/test_klp_shadow_vars.c
@@ -44,7 +44,7 @@ static int ptr_id(void *ptr)
 
 	sp = kmalloc(sizeof(*sp), GFP_ATOMIC);
 	if (!sp)
-		return -1;
+		return -ENOMEM;
 	sp->ptr = ptr;
 	sp->id = count++;
 
-- 
2.20.1

