Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8361CC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5575E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfA3JoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:44:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:45286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729050AbfA3JoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:44:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22EDFACC6;
        Wed, 30 Jan 2019 09:44:06 +0000 (UTC)
Date:   Wed, 30 Jan 2019 10:44:05 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] livepatch: Remove the redundant enabled flag in
 struct klp_patch
Message-ID: <20190130094405.qbm7nynam3dryq4h@pathway.suse.cz>
References: <20190116161720.796-1-pmladek@suse.com>
 <20190116161720.796-5-pmladek@suse.com>
 <alpine.LSU.2.21.1901221100020.16809@pobox.suse.cz>
 <d0f53387-1b6f-3d9a-2336-89485b0680ac@redhat.com>
 <20190129200049.aarlvssu7fihfpwh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129200049.aarlvssu7fihfpwh@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-01-29 14:00:49, Josh Poimboeuf wrote:
> On Wed, Jan 23, 2019 at 01:27:59PM -0500, Joe Lawrence wrote:
> > > I wanted to ask why there is list_empty() and not klp_patch_enabled(), so
> > > just to be sure... the patch was added to klp_patches list, so patch->list
> > > is not empty (should not be). We could achieve the same by calling
> > > !klp_patch_enabled() given its implementation, but it would look
> > > counter-intuitive here.
> > > 
> > > The rest looks fine.
> > > 
> > > However, I am not sure if the outcome is better than what we have. Yes,
> > > patch->enabled is not technically necessary and we can live with that (as
> > > the patch proves). On the other hand, it gives the reader clear guidance
> > > about the patch's state. klp_patch_enabled() is not a complete
> > > replacement. We have to call list_empty() in __klp_enable_patch() or check
> > > the original klp_target_state in klp_try_complete_transition().
> > > 
> > > I am not against the change, I am glad to see it is achievable, but I am
> > > not sure if the code is better with it. Joe acked it. What do the others
> > > think?
> > 
> > Let me qualify my ack -- I think minimizing the number of state variables
> > like patch->enabled can help readability... on the other hand, deducing the
> > same information from other properties like list-empty can be confusing, ie,
> > klp_patch_enabled() is generally a lot clearer than
> > list_empty(&patch->list)).
> > 
> > So I like this idea and would be interested to hear what folks think about
> > the exception cases you pointed out.
> 
> I share Miroslav and Joe's ambivalence.  It's interesting to see that it
> can be done, and normally I'd prefer to get rid of extraneous data
> fields, but the patch doesn't reduce code, and it even makes the code
> slightly more complex IMO, because klp_patch_enabled() doesn't always
> work like you'd expect.
> 
> So while I suggested it to begin with, I'm going to go with a NACK :-)

Fair enough. I took this patch as an experiment that might fail :-)

Best Regards,
Petr
