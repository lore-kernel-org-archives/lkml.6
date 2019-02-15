Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB118C10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890E821916
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550221817;
	bh=gHKhT8eieWjF74KO2wgW5Hm/27IXGYrWzVhdvwy+GQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b8S2y4Ov3enhklV/Ac8yzwnSAXi9RP4hnSOOr+o4X0bG47InOq6DyXRrwQl7Kpbot
	 rRHgK9QgheMo1ysE+t11GDSoRdhfPg+2MV3/3MiwL4W1t5Azus8gjEKV99C4jtx4Gn
	 V1PYKb2xFlNvZaQqxPKRMQLtnqqIuKOSJxh7OG0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392153AbfBOJKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:10:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:38812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389014AbfBOJKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:10:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E509ABAC;
        Fri, 15 Feb 2019 09:10:01 +0000 (UTC)
Date:   Fri, 15 Feb 2019 10:10:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        LKML <linux-kernel@vger.kernel.org>, graham@grahamc.com,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Userspace regression in LTS and stable kernels
Message-ID: <20190215091000.GT4525@dhcp22.suse.cz>
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
 <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
 <20190214122027.c0df36282d65dc9979248117@linux-foundation.org>
 <20190215070022.GD14473@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215070022.GD14473@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-02-19 08:00:22, Greg KH wrote:
> On Thu, Feb 14, 2019 at 12:20:27PM -0800, Andrew Morton wrote:
> > On Thu, 14 Feb 2019 09:56:46 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > > On Wed, Feb 13, 2019 at 3:37 PM Richard Weinberger
> > > <richard.weinberger@gmail.com> wrote:
> > > >
> > > > Your shebang line exceeds BINPRM_BUF_SIZE.
> > > > Before the said commit the kernel silently truncated the shebang line
> > > > (and corrupted it),
> > > > now it tells the user that the line is too long.
> > > 
> > > It doesn't matter if it "corrupted" things by truncating it. All that
> > > matters is "it used to work, now it doesn't"
> > > 
> > > Yes, maybe it never *should* have worked. And yes, it's sad that
> > > people apparently had cases that depended on this odd behavior, but
> > > there we are.
> > > 
> > > I see that Kees has a patch to fix it up.
> > > 
> > 
> > Greg, I think we have a problem here.
> > 
> > 8099b047ecc431518 ("exec: load_script: don't blindly truncate shebang
> > string") wasn't marked for backporting.  And, presumably as a
> > consequence, Kees's fix "exec: load_script: allow interpreter argument
> > truncation" was not marked for backporting.
> > 
> > 8099b047ecc431518 hasn't even appeared in a Linus released kernel, yet
> > it is now present in 4.9.x, 4.14.x, 4.19.x and 4.20.x.
> 
> It came in 5.0-rc1, so it fits the "in a Linus released kernel"
> requirement.  If we are to wait until it shows up in a -final, that
> would be months too late for almost all of these types of patches that
> are picked up.

rc1 is just a too early. Waiting few more rcs or even a final release
for something that people do not see as an issue should be just fine.
Consider this particular patch and tell me why it had to be rushed in
the first place. The original code was broken for _years_ but I do not
remember anybody would be complaining.

> > I don't know if Oleg considered backporting that patch.  I certainly
> > did (I always do), and I decided against doing so.  Yet there it is.
> 
> This came in through Sasha's tools, which give people a week or so to
> say "hey, this isn't a stable patch!" and it seems everyone ignored that
> :(

I thought we were through this already. Automagic autoselection of
patches in the core kernel (or mmotm tree patches in particular) is too
dangerous. We try hard to consider each and every patch for stable. Even
if something slips through then it is much more preferred to ask for a
stable backport in the respective email thread and wait for a conclusion
before adding it.

-- 
Michal Hocko
SUSE Labs
