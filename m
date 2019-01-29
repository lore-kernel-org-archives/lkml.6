Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21EBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD55A2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfA2UA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:00:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfA2UA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:00:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05E17CCB94;
        Tue, 29 Jan 2019 20:00:56 +0000 (UTC)
Received: from treble (ovpn-120-147.rdu2.redhat.com [10.10.120.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6C5862671;
        Tue, 29 Jan 2019 20:00:51 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:00:49 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] livepatch: Remove the redundant enabled flag in
 struct klp_patch
Message-ID: <20190129200049.aarlvssu7fihfpwh@treble>
References: <20190116161720.796-1-pmladek@suse.com>
 <20190116161720.796-5-pmladek@suse.com>
 <alpine.LSU.2.21.1901221100020.16809@pobox.suse.cz>
 <d0f53387-1b6f-3d9a-2336-89485b0680ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0f53387-1b6f-3d9a-2336-89485b0680ac@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 29 Jan 2019 20:00:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 01:27:59PM -0500, Joe Lawrence wrote:
> > I wanted to ask why there is list_empty() and not klp_patch_enabled(), so
> > just to be sure... the patch was added to klp_patches list, so patch->list
> > is not empty (should not be). We could achieve the same by calling
> > !klp_patch_enabled() given its implementation, but it would look
> > counter-intuitive here.
> > 
> > The rest looks fine.
> > 
> > However, I am not sure if the outcome is better than what we have. Yes,
> > patch->enabled is not technically necessary and we can live with that (as
> > the patch proves). On the other hand, it gives the reader clear guidance
> > about the patch's state. klp_patch_enabled() is not a complete
> > replacement. We have to call list_empty() in __klp_enable_patch() or check
> > the original klp_target_state in klp_try_complete_transition().
> > 
> > I am not against the change, I am glad to see it is achievable, but I am
> > not sure if the code is better with it. Joe acked it. What do the others
> > think?
> 
> Let me qualify my ack -- I think minimizing the number of state variables
> like patch->enabled can help readability... on the other hand, deducing the
> same information from other properties like list-empty can be confusing, ie,
> klp_patch_enabled() is generally a lot clearer than
> list_empty(&patch->list)).
> 
> So I like this idea and would be interested to hear what folks think about
> the exception cases you pointed out.

I share Miroslav and Joe's ambivalence.  It's interesting to see that it
can be done, and normally I'd prefer to get rid of extraneous data
fields, but the patch doesn't reduce code, and it even makes the code
slightly more complex IMO, because klp_patch_enabled() doesn't always
work like you'd expect.

So while I suggested it to begin with, I'm going to go with a NACK :-)

-- 
Josh
