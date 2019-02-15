Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B3C21925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550243957;
	bh=Uf8Xcrlvvln/nba+KUI5sC40U5pQoOw7T2CxKTwt6M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OvcoCGgvQNHNHf5K7A9I2G4juP/iO0rMTxDnvIOm46rR4+cDhM1Lp/afEvYDC+5VE
	 il/qRQcA3SbQ1CWT6LfkcvFb7idXLnAxngrS843GofaqIoQkTkUhu7UQG/iZJsihKv
	 vW0F5nwqZXTNGYy0Ftlu5P8TClNVWJYHwdyxqMbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388557AbfBOPTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:19:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbfBOPTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:19:15 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A7BA21925;
        Fri, 15 Feb 2019 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550243953;
        bh=Uf8Xcrlvvln/nba+KUI5sC40U5pQoOw7T2CxKTwt6M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0hj9NSOlVfTCXktPQu27eVOzmjofqrKZpYRcI8Josnl5tKlAc7X2RnzqWlDD+wmB9
         aEo9Arbjvn2i6WDnmQGiSHI2zaV74Tj9TFZRHsaWABnujabeeBRClLKagRXLUXnCQs
         kmlzVdQBJ+/7nsj2XkUxuDAQSf1QVviv1iIMcsXA=
Date:   Fri, 15 Feb 2019 10:19:12 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
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
Message-ID: <20190215151912.GA10616@sasha-vm>
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
 <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
 <20190214122027.c0df36282d65dc9979248117@linux-foundation.org>
 <20190215070022.GD14473@kroah.com>
 <20190215091000.GT4525@dhcp22.suse.cz>
 <20190215092013.GA32575@kroah.com>
 <20190215094205.GW4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190215094205.GW4525@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:42:05AM +0100, Michal Hocko wrote:
>On Fri 15-02-19 10:20:13, Greg KH wrote:
>> On Fri, Feb 15, 2019 at 10:10:00AM +0100, Michal Hocko wrote:
>> > On Fri 15-02-19 08:00:22, Greg KH wrote:
>> > > On Thu, Feb 14, 2019 at 12:20:27PM -0800, Andrew Morton wrote:
>> > > > On Thu, 14 Feb 2019 09:56:46 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> > > >
>> > > > > On Wed, Feb 13, 2019 at 3:37 PM Richard Weinberger
>> > > > > <richard.weinberger@gmail.com> wrote:
>> > > > > >
>> > > > > > Your shebang line exceeds BINPRM_BUF_SIZE.
>> > > > > > Before the said commit the kernel silently truncated the shebang line
>> > > > > > (and corrupted it),
>> > > > > > now it tells the user that the line is too long.
>> > > > >
>> > > > > It doesn't matter if it "corrupted" things by truncating it. All that
>> > > > > matters is "it used to work, now it doesn't"
>> > > > >
>> > > > > Yes, maybe it never *should* have worked. And yes, it's sad that
>> > > > > people apparently had cases that depended on this odd behavior, but
>> > > > > there we are.
>> > > > >
>> > > > > I see that Kees has a patch to fix it up.
>> > > > >
>> > > >
>> > > > Greg, I think we have a problem here.
>> > > >
>> > > > 8099b047ecc431518 ("exec: load_script: don't blindly truncate shebang
>> > > > string") wasn't marked for backporting.  And, presumably as a
>> > > > consequence, Kees's fix "exec: load_script: allow interpreter argument
>> > > > truncation" was not marked for backporting.
>> > > >
>> > > > 8099b047ecc431518 hasn't even appeared in a Linus released kernel, yet
>> > > > it is now present in 4.9.x, 4.14.x, 4.19.x and 4.20.x.
>> > >
>> > > It came in 5.0-rc1, so it fits the "in a Linus released kernel"
>> > > requirement.  If we are to wait until it shows up in a -final, that
>> > > would be months too late for almost all of these types of patches that
>> > > are picked up.
>> >
>> > rc1 is just a too early. Waiting few more rcs or even a final release
>> > for something that people do not see as an issue should be just fine.
>> > Consider this particular patch and tell me why it had to be rushed in
>> > the first place. The original code was broken for _years_ but I do not
>> > remember anybody would be complaining.
>>
>> This patch was in 4.20.10, which was released on Feb 12 while 5.0-rc1
>> came out on Jan 6.  Over a month delay.
>
>Obviously not long enough.

You're assuming that if we wouldn't have taken this patch to stable
somehow someone else would notice this bug and fix it.

What test do we have that would catch this? Which testsuite tests for
long shebang lines? Where is the test added together with this patch
that covers this and similar cases?

The fact is that many patches are not tested until they get to stable,
whether we add them the same week they went upstream or months later.
This is a great case for this: I doubt anyone but NixOS does this crazy
thing with shebang lines, so who else would discover the bug?

If this is indeed a case of us jumping the gun and shipping stuff too
early before all tests are complete, please point me to the test that we
missed and I'll make sure that for any future kernel release it gets run
before we ship a stable kernel.

>> > > > I don't know if Oleg considered backporting that patch.  I certainly
>> > > > did (I always do), and I decided against doing so.  Yet there it is.
>> > >
>> > > This came in through Sasha's tools, which give people a week or so to
>> > > say "hey, this isn't a stable patch!" and it seems everyone ignored that
>> > > :(
>> >
>> > I thought we were through this already. Automagic autoselection of
>> > patches in the core kernel (or mmotm tree patches in particular) is too
>> > dangerous. We try hard to consider each and every patch for stable. Even
>> > if something slips through then it is much more preferred to ask for a
>> > stable backport in the respective email thread and wait for a conclusion
>> > before adding it.
>>
>> We have a list of blacklisted files/subsystems for people that do not
>> want this to happen to their area of the kernel.  The patch seemed to
>> make sense, and it passed all known tests that we currently have.
>
>Yes, the patch makes sense (I wouldn't give my acked-by otherwise). But
>this is one of the area where things that make sense might still break
>because it is hard to assume what userspace depends on.

Great, so the solution is to just not take these things into stable at
all? The solution should be to add tests to the patches that go in there
to verify their correctness and that they don't regress in the future.

If you're really concerned about subsystems being brittle the solution
is to improve their testing rather push stuff in and hope nothing
explodes.

On one hand you Ack it saying it looks great to you and should be
merged, but on the other hand you're saying that you don't really trust
the patch?

Really, if I wouldn't pick this patch now what do you think would have
happened? It would just pop up in a few months as we roll our stable
kernel forward.

>> Sometimes things will slip through like this, it happens.  And really, a
>> 3 day turn-around-time to resolve this is pretty good, don't you think?
>
>Yes, but that doesn't make any difference on the fact that this was not
>marked for stable and I still think this is not a stable material - at
>least not at this moment.

Hindsight is 20/20 :)

If people were good at understanding the impact and implications their
patch has on the kernel we would never introduce new bugs!

I'll happily list a bunch more patches where folks didn't think they're
stable material, but turned out to be important fixes.

--
Thanks,
Sasha
