Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B308C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54672133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbeLRIvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:51:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:46908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbeLRIvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:51:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8FFB3AFD3;
        Tue, 18 Dec 2018 08:51:33 +0000 (UTC)
Date:   Tue, 18 Dec 2018 09:51:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 10/11] livepatch: Remove ordering and refuse loading
 conflicting patches
Message-ID: <20181218085132.6zukgqgi7kiyx3ni@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-11-pmladek@suse.com>
 <20181213230652.e2vn27qvqhumtaog@treble>
 <20181217160709.vnbxjo4mimy3dmm7@pathway.suse.cz>
 <20181217162729.orxq6i53m4kgekp3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217162729.orxq6i53m4kgekp3@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-12-17 10:27:29, Josh Poimboeuf wrote:
> On Mon, Dec 17, 2018 at 05:07:09PM +0100, Petr Mladek wrote:
> > On Thu 2018-12-13 17:06:52, Josh Poimboeuf wrote:
> > > On Thu, Nov 29, 2018 at 10:44:30AM +0100, Petr Mladek wrote:
> > > > The atomic replace and cumulative patches were introduced as a more secure
> > > > way to handle dependent patches. They simplify the logic:
> > > > 
> > > >   + Any new cumulative patch is supposed to take over shadow variables
> > > >     and changes made by callbacks from previous livepatches.
> > > > 
> > > >   + All replaced patches are discarded and the modules can be unloaded.
> > > >     As a result, there is only one scenario when a cumulative livepatch
> > > >     gets disabled.
> > > > 
> > > > The different handling of "normal" and cumulative patches might cause
> > > > confusion. It would make sense to keep only one mode. On the other hand,
> > > > it would be rude to enforce using the cumulative livepatches even for
> > > > trivial and independent (hot) fixes.
> > > > 
> > > > This patch removes the stack of patches. The list of enabled patches
> > > > is still needed but the ordering is not longer enforced.
> > > > 
> > > > Note that it is not possible to catch all possible dependencies. It is
> > > > the responsibility of the livepatch authors to decide.
> > > > 
> > > > Nevertheless this patch prevents having two patches for the same function
> > > > enabled at the same time after the transition finishes. It might help
> > > > to catch obvious mistakes. But more importantly, we do not need to
> > > > handle situation when a patch in the middle of the function stack
> > > > (ops->func_stack) is being removed.
> > > 
> > > I'm not sure about this patch.  I like the removal of the stacking.  But
> > > do we really want to enforce no dependencies between non-cumulative
> > > patches?  It can be done correctly if the user is careful.
> > > 
> > > Maybe we should just let users do it if they want to.  And then that
> > > also would mean less code for us to maintain.
> > > 
> > > And as usual, I apologize if I'm either contradicting or repeating past
> > > versions of myself. :-)
> > 
> > This patch was actually motivated by you. On some conference, we
> > discussed how to automatize the creation of livepatches. You wanted
> > to make livepatching more safe in general (by tools, by checks, ...).
> > Also you always wanted to make things easier and reduce possible
> > scenarios. I thought that this might be in line with your wishes.
> > 
> > The problem with this patch is that it forces people to use
> > cumulative patches. I am not sure if everyone is ready for it.
> > 
> > I do not resist on it. But I still think that it makes sense.
> 
> I do remember suggesting the removal of the stacking.  I think that's a
> good idea.
> 
> I don't remember suggesting the other part: trying to detect and prevent
> dependencies for non-replace users.  If I did suggest that, which is
> very possible, I apologize for being wishy-washy :-)

You remember it correctly. You proposed only the removing of the
stacking. The preventing dependent patches was my idea.

I thought that it might be in line with your vision. I was wrong ;-)


> The way I currently see it, there are two classes of users: cumulative
> and non-cumulative.  IMO we should accept both as reasonable
> possiblities.
> 
> Cumulative users will use 'replace'.  Non-cumulative users will do
> whatever they want, and we shouldn't try to restrict them.
> 
> So I would propose that we remove the stacking, and not try to enforce
> patch dependencies in any way.

OK, I will remove the restriction in v15.

Best Regards,
Petr
