Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69CC2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfA3NA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:00:56 -0500
Received: from www1392ue.sakura.ne.jp ([219.94.233.166]:57280 "EHLO
        www1392ue.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfA3NAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:00:55 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: alicef@alicef.me)
        by www1392ue.sakura.ne.jp (Postcow) with ESMTPSA id 5522B20C51;
        Wed, 30 Jan 2019 22:00:52 +0900 (JST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Jan 2019 22:00:51 +0900
From:   alicef <alicef@alicef.me>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, jeyu@kernel.org,
        jikos@kernel.org, mbenes@suse.cz, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
        live-patching-owner@vger.kernel.org
Subject: Re: [PATCH] livepatch: core: Return ENOTSUPP instead of ENOSYS
In-Reply-To: <20190130124156.qjtbvrkjctu6wi62@pathway.suse.cz>
References: <20190126192630.6163-1-alicef@alicef.me>
 <20190128194943.GA18515@redhat.com> <20190129165054.vyi7n6in5v2omkpu@treble>
 <20190130124156.qjtbvrkjctu6wi62@pathway.suse.cz>
Message-ID: <0ae0746120590dc3c5f7c1d602321f28@alicef.me>
X-Sender: alicef@alicef.me
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-30 21:41, Petr Mladek wrote:
> On Tue 2019-01-29 10:50:54, Josh Poimboeuf wrote:
>> On Mon, Jan 28, 2019 at 02:49:43PM -0500, Joe Lawrence wrote:
>> > On Sun, Jan 27, 2019 at 04:26:30AM +0900, Alice Ferrazzi wrote:
>> > > This patch fixes a checkpatch warning:
>> > >     WARNING: ENOSYS means 'invalid syscall nr' and nothing else
>> > >
>> > > Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
>> > > ---
>> > >  kernel/livepatch/core.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
>> > > index 5b77a7314e01..eea6b94fef89 100644
>> > > --- a/kernel/livepatch/core.c
>> > > +++ b/kernel/livepatch/core.c
>> > > @@ -897,7 +897,7 @@ int klp_register_patch(struct klp_patch *patch)
>> > >
>> > >  	if (!klp_have_reliable_stack()) {
>> > >  		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
>> > > -		return -ENOSYS;
>> > > +		return -ENOTSUPP;
>> > >  	}
>> > >
>> > >  	return klp_init_patch(patch);
>> > > --
>> > > 2.19.2
>> > >
>> >
>> > Hi Alice,
>> >
>> > Patches should be based off the upstream livepatching tree, found here:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git
>> >
>> > and in this case, the for-next branch, which holds patches that have
>> > already been queued up for the next release.  This one:
>> >
>> >   958ef1e39d24 ("livepatch: Simplify API by removing registration step")
>> >
>> > has moved the code in question from klp_register_patch() to
>> > klp_enable_patch().
>> >
>> >
>> > As far as the change itself, I don't have strong opinion about it
>> > either way.
>> >
>> > On the one hand, there is the checkpatch warning and -ENOTSUPP reads
>> > more intuitively than -ENOSYS.
>> >
>> > However, the current pattern seems to be more prevelent in the kernel.
>> > I wonder if the checkpatch warning would be better specified for return
>> > values that are actually passed back to userspace.
>> >
>> > Also, klp_register_patch(), now klp_enable_patch(), is exported for
>> > module use, though I don't believe anyone (samples / tests / kpatch /
>> > kgraft?) is inspecting which error value is returned.
>> >
>> > I would defer to whichever convention the maintainers prefer here.
>> 
>> Based on the commit description from 91c9afaf97ee ("checkpatch.pl: new
>> instances of ENOSYS are errors"), it sounds like there was a decision 
>> at
>> Kernel Summit to limit ENOSYS to mean "bad syscall" and nothing else.
> 
> Hmm, the error code is passed to the syscall, for example:
> 
> + SYSCALL_DEFINE3(init_module
>   + load_module()
>     + do_init_module()
>       + do_one_initcall(mod->init);
> 
> I am not sure if we are allowed to return -ENOTSUPP (-524).
> It is defined in the internal include/linux/errno.h. There
> is the following commnent:
> 
> /*
>  * These should never be seen by user programs...
> 
> 
> 
> I tried to find a better alternative and found:
> 
> #define	EOPNOTSUPP	95	/* Operation not supported on transport endpoint 
> */
> 
> 
> There is the following note in man errno:
> 
>        ENOTSUP         Operation not supported (POSIX.1)
> 
>        EOPNOTSUPP      Operation not supported on socket (POSIX.1)
> 		       (ENOTSUP and EOPNOTSUPP have the same value
> 		       on Linux, but according to POSIX.1 these error
> 		       values should be distinct.)
> 
> And it looks that -EOPNOTSUPP is used widely in many subsystes (not
> only network).
> 
> Best Regards,
> Petr


EOPNOTSUPP works also for me.
looks better adopted than ENOTSUP.

I will send a new patch based off the upstream from 
git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git 
as suggested by Joe

Thanks,
Alice


-- 
======================================
Alice Ferrazzi
alicef@alicef.me
PGP: 2E4E 0856 461C 0585 1336 F496 5621 A6B2 8638 781A
======================================
