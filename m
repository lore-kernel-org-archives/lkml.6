Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A096FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6E221924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222535;
	bh=X6UzpgOGmO/BbjvSs333tpbchi6leRPQor5DjTTJLm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oSzxfY+xSeVZ08z/fzLkYDWzFgL7kQbS4L5VEKvDAtmHzNoagzFluwuRgReyYErye
	 sKbL4EUzxF2ByX0QW1ytiMxp2sDXXFRlqbrlvj7mXJ0G7sGlsLNcNyDOhmup3EiVLc
	 8paXEDMuRJl6POeQx0GbNlAnY8loOrsXhnUZIvqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392474AbfBOJWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:22:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfBOJWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:22:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2FE21924;
        Fri, 15 Feb 2019 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222519;
        bh=X6UzpgOGmO/BbjvSs333tpbchi6leRPQor5DjTTJLm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u0oWt6I2H2bVlv/y+ckjjrSkt8SZcfIGrb+/FcAh0EW9nfCTVJu/n8hGk9NI+ikhx
         qBudU0QoYcSf6iNqAhfQxDJqPbDyhgCAMv642KZX5IpK+OQ2ghOmaXHeX+z7j3+o3l
         s1pEcbgKYWpH3en3aOiTfZ92KEu6RyQR7QDKLxY8=
Date:   Fri, 15 Feb 2019 10:20:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        LKML <linux-kernel@vger.kernel.org>, graham@grahamc.com,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Userspace regression in LTS and stable kernels
Message-ID: <20190215092013.GA32575@kroah.com>
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
 <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
 <20190214122027.c0df36282d65dc9979248117@linux-foundation.org>
 <20190215070022.GD14473@kroah.com>
 <20190215091000.GT4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215091000.GT4525@dhcp22.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:10:00AM +0100, Michal Hocko wrote:
> On Fri 15-02-19 08:00:22, Greg KH wrote:
> > On Thu, Feb 14, 2019 at 12:20:27PM -0800, Andrew Morton wrote:
> > > On Thu, 14 Feb 2019 09:56:46 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > 
> > > > On Wed, Feb 13, 2019 at 3:37 PM Richard Weinberger
> > > > <richard.weinberger@gmail.com> wrote:
> > > > >
> > > > > Your shebang line exceeds BINPRM_BUF_SIZE.
> > > > > Before the said commit the kernel silently truncated the shebang line
> > > > > (and corrupted it),
> > > > > now it tells the user that the line is too long.
> > > > 
> > > > It doesn't matter if it "corrupted" things by truncating it. All that
> > > > matters is "it used to work, now it doesn't"
> > > > 
> > > > Yes, maybe it never *should* have worked. And yes, it's sad that
> > > > people apparently had cases that depended on this odd behavior, but
> > > > there we are.
> > > > 
> > > > I see that Kees has a patch to fix it up.
> > > > 
> > > 
> > > Greg, I think we have a problem here.
> > > 
> > > 8099b047ecc431518 ("exec: load_script: don't blindly truncate shebang
> > > string") wasn't marked for backporting.  And, presumably as a
> > > consequence, Kees's fix "exec: load_script: allow interpreter argument
> > > truncation" was not marked for backporting.
> > > 
> > > 8099b047ecc431518 hasn't even appeared in a Linus released kernel, yet
> > > it is now present in 4.9.x, 4.14.x, 4.19.x and 4.20.x.
> > 
> > It came in 5.0-rc1, so it fits the "in a Linus released kernel"
> > requirement.  If we are to wait until it shows up in a -final, that
> > would be months too late for almost all of these types of patches that
> > are picked up.
> 
> rc1 is just a too early. Waiting few more rcs or even a final release
> for something that people do not see as an issue should be just fine.
> Consider this particular patch and tell me why it had to be rushed in
> the first place. The original code was broken for _years_ but I do not
> remember anybody would be complaining.

This patch was in 4.20.10, which was released on Feb 12 while 5.0-rc1
came out on Jan 6.  Over a month delay.

> > > I don't know if Oleg considered backporting that patch.  I certainly
> > > did (I always do), and I decided against doing so.  Yet there it is.
> > 
> > This came in through Sasha's tools, which give people a week or so to
> > say "hey, this isn't a stable patch!" and it seems everyone ignored that
> > :(
> 
> I thought we were through this already. Automagic autoselection of
> patches in the core kernel (or mmotm tree patches in particular) is too
> dangerous. We try hard to consider each and every patch for stable. Even
> if something slips through then it is much more preferred to ask for a
> stable backport in the respective email thread and wait for a conclusion
> before adding it.

We have a list of blacklisted files/subsystems for people that do not
want this to happen to their area of the kernel.  The patch seemed to
make sense, and it passed all known tests that we currently have.

Sometimes things will slip through like this, it happens.  And really, a
3 day turn-around-time to resolve this is pretty good, don't you think?

It also seems like we need another test to catch this problem from ever
happening again :)

thanks,

greg k-h
