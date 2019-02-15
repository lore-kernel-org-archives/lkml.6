Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D746CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A147A222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550245925;
	bh=/8u+4vzVn7OrGpRgk2ietCEFCy+i+XryCDzK5wg3M9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JpTc3vpYFbEElZdJq3QVHOhm57HPeplqicAmvMG9SiRWQxhsIxA5xBTqhjFVNZm6w
	 T25DK/l5exjNUbjpxsrNeKIgaftyIhAtx04MsQMjBFIO8YuP0+2SR1NmtPjrIJv/w7
	 QRtnDzTKi9Yiw8Dq6EwYykHZOnk0naOgfSWmUZE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbfBOPwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:52:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:54550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbfBOPwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:52:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 076AAB009;
        Fri, 15 Feb 2019 15:52:00 +0000 (UTC)
Date:   Fri, 15 Feb 2019 16:52:00 +0100
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
Message-ID: <20190215155200.GB4525@dhcp22.suse.cz>
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
 <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
 <20190214122027.c0df36282d65dc9979248117@linux-foundation.org>
 <20190215070022.GD14473@kroah.com>
 <20190215091000.GT4525@dhcp22.suse.cz>
 <20190215092013.GA32575@kroah.com>
 <20190215094205.GW4525@dhcp22.suse.cz>
 <20190215151912.GA10616@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215151912.GA10616@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-02-19 10:19:12, Sasha Levin wrote:
> On Fri, Feb 15, 2019 at 10:42:05AM +0100, Michal Hocko wrote:
> > On Fri 15-02-19 10:20:13, Greg KH wrote:
> > > On Fri, Feb 15, 2019 at 10:10:00AM +0100, Michal Hocko wrote:
> > > > On Fri 15-02-19 08:00:22, Greg KH wrote:
> > > > > On Thu, Feb 14, 2019 at 12:20:27PM -0800, Andrew Morton wrote:
> > > > > > On Thu, 14 Feb 2019 09:56:46 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > > > >
> > > > > > > On Wed, Feb 13, 2019 at 3:37 PM Richard Weinberger
> > > > > > > <richard.weinberger@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Your shebang line exceeds BINPRM_BUF_SIZE.
> > > > > > > > Before the said commit the kernel silently truncated the shebang line
> > > > > > > > (and corrupted it),
> > > > > > > > now it tells the user that the line is too long.
> > > > > > >
> > > > > > > It doesn't matter if it "corrupted" things by truncating it. All that
> > > > > > > matters is "it used to work, now it doesn't"
> > > > > > >
> > > > > > > Yes, maybe it never *should* have worked. And yes, it's sad that
> > > > > > > people apparently had cases that depended on this odd behavior, but
> > > > > > > there we are.
> > > > > > >
> > > > > > > I see that Kees has a patch to fix it up.
> > > > > > >
> > > > > >
> > > > > > Greg, I think we have a problem here.
> > > > > >
> > > > > > 8099b047ecc431518 ("exec: load_script: don't blindly truncate shebang
> > > > > > string") wasn't marked for backporting.  And, presumably as a
> > > > > > consequence, Kees's fix "exec: load_script: allow interpreter argument
> > > > > > truncation" was not marked for backporting.
> > > > > >
> > > > > > 8099b047ecc431518 hasn't even appeared in a Linus released kernel, yet
> > > > > > it is now present in 4.9.x, 4.14.x, 4.19.x and 4.20.x.
> > > > >
> > > > > It came in 5.0-rc1, so it fits the "in a Linus released kernel"
> > > > > requirement.  If we are to wait until it shows up in a -final, that
> > > > > would be months too late for almost all of these types of patches that
> > > > > are picked up.
> > > >
> > > > rc1 is just a too early. Waiting few more rcs or even a final release
> > > > for something that people do not see as an issue should be just fine.
> > > > Consider this particular patch and tell me why it had to be rushed in
> > > > the first place. The original code was broken for _years_ but I do not
> > > > remember anybody would be complaining.
> > > 
> > > This patch was in 4.20.10, which was released on Feb 12 while 5.0-rc1
> > > came out on Jan 6.  Over a month delay.
> > 
> > Obviously not long enough.
> 
> You're assuming that if we wouldn't have taken this patch to stable
> somehow someone else would notice this bug and fix it.
> 
> What test do we have that would catch this? Which testsuite tests for
> long shebang lines? Where is the test added together with this patch
> that covers this and similar cases?

The test is the "users out there". Right now we do not have any
specialized test case because we haven't even realized it might break
something. The main difference between breaking on the bleeding edge vs.
stable tree is that people running on bleeding edge are more likely to
expect a breakage while stable users would most likely prefer to not be
guinea pigs and have, well stable trees.
[...]

> > > We have a list of blacklisted files/subsystems for people that do not
> > > want this to happen to their area of the kernel.  The patch seemed to
> > > make sense, and it passed all known tests that we currently have.
> > 
> > Yes, the patch makes sense (I wouldn't give my acked-by otherwise). But
> > this is one of the area where things that make sense might still break
> > because it is hard to assume what userspace depends on.
> 
> Great, so the solution is to just not take these things into stable at
> all?

No, but if the patch author and the maintainer have considered the
stable tree and haven't found convincing arguments to mark for stable
then it is likely that the patch doesn't need an urgent backporting.

> The solution should be to add tests to the patches that go in there
> to verify their correctness and that they don't regress in the future.
> 
> If you're really concerned about subsystems being brittle the solution
> is to improve their testing rather push stuff in and hope nothing
> explodes.
> 
> On one hand you Ack it saying it looks great to you and should be
> merged, but on the other hand you're saying that you don't really trust
> the patch?

No. But I didn't consider it a stable material. You just do not really
need all the patches in the stable, right? I have already said that this
code is there for ages and fixing it is good to have for future but
considering that nobody was really complaining then a backporting just
adds a risk and as it turned out that risk was really not zero.

> Really, if I wouldn't pick this patch now what do you think would have
> happened? It would just pop up in a few months as we roll our stable
> kernel forward.

and that would be a different kernel version and people kinda expect
bugs with newer versions. This is not the case with the stable update.

But I guess we are just repeating the same discussion over and over. Our
expectations about what the stable kernel should be differs a lot. I
would like to see fewer but only important fixes while you would like to
take as many fixes as possible. 
-- 
Michal Hocko
SUSE Labs
