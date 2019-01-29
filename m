Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82568C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539B4214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfA2QvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:51:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbfA2QvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:51:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCFE3356EC;
        Tue, 29 Jan 2019 16:51:00 +0000 (UTC)
Received: from treble (ovpn-120-147.rdu2.redhat.com [10.10.120.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E64617A79;
        Tue, 29 Jan 2019 16:50:56 +0000 (UTC)
Date:   Tue, 29 Jan 2019 10:50:54 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Alice Ferrazzi <alicef@alicef.me>, jeyu@kernel.org,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: Re: [PATCH] livepatch: core: Return ENOTSUPP instead of ENOSYS
Message-ID: <20190129165054.vyi7n6in5v2omkpu@treble>
References: <20190126192630.6163-1-alicef@alicef.me>
 <20190128194943.GA18515@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190128194943.GA18515@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 29 Jan 2019 16:51:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 02:49:43PM -0500, Joe Lawrence wrote:
> On Sun, Jan 27, 2019 at 04:26:30AM +0900, Alice Ferrazzi wrote:
> > This patch fixes a checkpatch warning:
> >     WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> > 
> > Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > ---
> >  kernel/livepatch/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 5b77a7314e01..eea6b94fef89 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -897,7 +897,7 @@ int klp_register_patch(struct klp_patch *patch)
> >  
> >  	if (!klp_have_reliable_stack()) {
> >  		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
> > -		return -ENOSYS;
> > +		return -ENOTSUPP;
> >  	}
> >  
> >  	return klp_init_patch(patch);
> > -- 
> > 2.19.2
> > 
> 
> Hi Alice,
> 
> Patches should be based off the upstream livepatching tree, found here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git
> 
> and in this case, the for-next branch, which holds patches that have
> already been queued up for the next release.  This one:
> 
>   958ef1e39d24 ("livepatch: Simplify API by removing registration step")
> 
> has moved the code in question from klp_register_patch() to
> klp_enable_patch().
> 
> 
> As far as the change itself, I don't have strong opinion about it
> either way.
> 
> On the one hand, there is the checkpatch warning and -ENOTSUPP reads
> more intuitively than -ENOSYS. 
> 
> However, the current pattern seems to be more prevelent in the kernel.
> I wonder if the checkpatch warning would be better specified for return
> values that are actually passed back to userspace.
> 
> Also, klp_register_patch(), now klp_enable_patch(), is exported for
> module use, though I don't believe anyone (samples / tests / kpatch /
> kgraft?) is inspecting which error value is returned.
> 
> I would defer to whichever convention the maintainers prefer here.

Based on the commit description from 91c9afaf97ee ("checkpatch.pl: new
instances of ENOSYS are errors"), it sounds like there was a decision at
Kernel Summit to limit ENOSYS to mean "bad syscall" and nothing else.

So I'm ok with this change, though the patch description should have a
little more background on why it's being done -- checkpatch.pl alone
isn't a good justification because some checkpatch warnings are best
taken with a grain of salt.

-- 
Josh
