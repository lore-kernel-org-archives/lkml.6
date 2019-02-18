Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0583C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCC3214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550494567;
	bh=qmoKy6LAC+Dc6RBNmqa4PTQRicAMQLCe0cYMAmMOwnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sWhdoK2PBAPCWS4/zArrAWZ6PtHISx8gQ+IzXP0Y/FpIfcsilr1eRhQa805xV2XIy
	 dmQKBUzrnlJvm6+KiBZvhWZilOH+oESS3JYg81bSsc128fU1EdGIK18p+ITor3+Tvg
	 Gzlfvzn7DQ3LRp12fGLp7Vgi2fkyXqzFnaZU8tc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbfBRM4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:56:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:36936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfBRM4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:56:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0696AB4C;
        Mon, 18 Feb 2019 12:56:03 +0000 (UTC)
Date:   Mon, 18 Feb 2019 13:56:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        LKML <linux-kernel@vger.kernel.org>, graham@grahamc.com,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Userspace regression in LTS and stable kernels
Message-ID: <20190218125603.GO4525@dhcp22.suse.cz>
References: <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
 <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
 <20190214122027.c0df36282d65dc9979248117@linux-foundation.org>
 <20190215070022.GD14473@kroah.com>
 <20190215091000.GT4525@dhcp22.suse.cz>
 <20190215092013.GA32575@kroah.com>
 <20190215094205.GW4525@dhcp22.suse.cz>
 <20190215151912.GA10616@sasha-vm>
 <20190215155200.GB4525@dhcp22.suse.cz>
 <20190215180026.GB10616@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215180026.GB10616@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-02-19 13:00:26, Sasha Levin wrote:
> On Fri, Feb 15, 2019 at 04:52:00PM +0100, Michal Hocko wrote:
> > On Fri 15-02-19 10:19:12, Sasha Levin wrote:
> > > On Fri, Feb 15, 2019 at 10:42:05AM +0100, Michal Hocko wrote:
> > > > On Fri 15-02-19 10:20:13, Greg KH wrote:
> > > > > On Fri, Feb 15, 2019 at 10:10:00AM +0100, Michal Hocko wrote:
> > > > > > On Fri 15-02-19 08:00:22, Greg KH wrote:
> > > > > > > On Thu, Feb 14, 2019 at 12:20:27PM -0800, Andrew Morton wrote:
> > > > > > > > On Thu, 14 Feb 2019 09:56:46 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > > > > > >
> > > > > > > > > On Wed, Feb 13, 2019 at 3:37 PM Richard Weinberger
> > > > > > > > > <richard.weinberger@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Your shebang line exceeds BINPRM_BUF_SIZE.
> > > > > > > > > > Before the said commit the kernel silently truncated the shebang line
> > > > > > > > > > (and corrupted it),
> > > > > > > > > > now it tells the user that the line is too long.
> > > > > > > > >
> > > > > > > > > It doesn't matter if it "corrupted" things by truncating it. All that
> > > > > > > > > matters is "it used to work, now it doesn't"
> > > > > > > > >
> > > > > > > > > Yes, maybe it never *should* have worked. And yes, it's sad that
> > > > > > > > > people apparently had cases that depended on this odd behavior, but
> > > > > > > > > there we are.
> > > > > > > > >
> > > > > > > > > I see that Kees has a patch to fix it up.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Greg, I think we have a problem here.
> > > > > > > >
> > > > > > > > 8099b047ecc431518 ("exec: load_script: don't blindly truncate shebang
> > > > > > > > string") wasn't marked for backporting.  And, presumably as a
> > > > > > > > consequence, Kees's fix "exec: load_script: allow interpreter argument
> > > > > > > > truncation" was not marked for backporting.
> > > > > > > >
> > > > > > > > 8099b047ecc431518 hasn't even appeared in a Linus released kernel, yet
> > > > > > > > it is now present in 4.9.x, 4.14.x, 4.19.x and 4.20.x.
> > > > > > >
> > > > > > > It came in 5.0-rc1, so it fits the "in a Linus released kernel"
> > > > > > > requirement.  If we are to wait until it shows up in a -final, that
> > > > > > > would be months too late for almost all of these types of patches that
> > > > > > > are picked up.
> > > > > >
> > > > > > rc1 is just a too early. Waiting few more rcs or even a final release
> > > > > > for something that people do not see as an issue should be just fine.
> > > > > > Consider this particular patch and tell me why it had to be rushed in
> > > > > > the first place. The original code was broken for _years_ but I do not
> > > > > > remember anybody would be complaining.
> > > > >
> > > > > This patch was in 4.20.10, which was released on Feb 12 while 5.0-rc1
> > > > > came out on Jan 6.  Over a month delay.
> > > >
> > > > Obviously not long enough.
> > > 
> > > You're assuming that if we wouldn't have taken this patch to stable
> > > somehow someone else would notice this bug and fix it.
> > > 
> > > What test do we have that would catch this? Which testsuite tests for
> > > long shebang lines? Where is the test added together with this patch
> > > that covers this and similar cases?
> > 
> > The test is the "users out there". Right now we do not have any
> > specialized test case because we haven't even realized it might break
> > something. The main difference between breaking on the bleeding edge vs.
> > stable tree is that people running on bleeding edge are more likely to
> > expect a breakage while stable users would most likely prefer to not be
> > guinea pigs and have, well stable trees.
> > [...]
> 
> Exactly, and my argument here is that no one really tests Linus's tree.

I would beg to disagree. The testing coverage is smaller of course
because most people are running on a distribution/stable kernels.

> Sure, folks run -rc kernels and report bugs, but no one actually runs
> these kernels at larger scales.

And this just screams that a (much) more time has to pass before fixes
which are nice-to-have are passed to the stable tree - assuming they are
not fixing something that users of the said stable tree are seeing the
issue of course.

> Most "users out there" wouldn't see this patch until it ends up in a
> stable kernel.

...and this would be on a kernel version upgrade when some breakage is
expected and tolerated more than on minor version stable update.

[...]
> > But I guess we are just repeating the same discussion over and over. Our
> > expectations about what the stable kernel should be differs a lot. I
> > would like to see fewer but only important fixes while you would like to
> > take as many fixes as possible.
> 
> Maybe to clarify here: I don't want to blindly take as much patches as I
> can. I want to take patches based on testing results: if something looks
> like a fix and it passes all our tests, there shouldn't be a reason not
> to take it.

There are many things we do not have any tests for. E.g. I wasn't even
aware that Perl (and others) are dealing with an excessive shebang input
by re-reading the input. There are always going to be corner cases like
that. The underlying thing is that nobody seem to be complaining about
the original issue addressed by Oleg. So why the heck should we push it
to the stable tree and _risk_ a regression.

> My view is that humans are terrible at writing and understanding code:
> if folks fully understood the impact of their patches we would never
> have bugs, right? Assuming we both agree here that we make mistakes and
> introduce bugs, why do you think that these very same people fully
> understand whether a patch should go in stable or not?

I haven't really seen a script that would be more efficient in this
evaluation. With a lack of the full test coverage I do not see this
going to change anytime soon.

> The approach of manually deciding if a patch needs to go in stable is
> wrong and it doesn't scale. We need to beef up our testing story and
> make these decisions based off of that, and not our error-prone brains
> that introduced these bugs to begin with.
> 
> Look at the outcome of this very issue: people sprung into action and
> fixed this bug quickly, but how many tests were added as a result of
> this? How do we know it's not going to regress again?

Yes, the issue got identified and analyzed quickly. There was no
questioning this part. It is the regression in stable that bothers me.
You have exposed users of a tree, which is supposed to be stable, to a bug
which was totally unnecessary because nobody cared for the parsing
behavior for years.
-- 
Michal Hocko
SUSE Labs
