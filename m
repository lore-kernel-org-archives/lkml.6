Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24643C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C8420643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550214810;
	bh=uHa0ewdftxg6MCAtg1cwOGKFCgG1xNH5MAQOg7QL3Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C/vq0rseJBBxFLpBgOsui/NWqtdJG60ZqCTN8yq32PqBmL3tvk+MpdEHQHA4vwa6a
	 vUOkiUxrwqFCVph7mr0KAT/UKEq6G3f6oSdkfJ92sUcka7x+kEoGZsNupsEqC9nd2m
	 +XFGTJ1VvmZ3ct+J7WjJ3ia45xshtIX3yi0go5W8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389454AbfBOHNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:13:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfBOHNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:13:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24B7F206A3;
        Fri, 15 Feb 2019 07:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550214796;
        bh=uHa0ewdftxg6MCAtg1cwOGKFCgG1xNH5MAQOg7QL3Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o4K+plyueYuuAPOngKyNVCDMWdy0KLly9X8tr4JZ6smUBREfPsxsz6nCNqWz6oBju
         ePF2cx8WHN371VFb3S/0C+X5ytWYP3ED0XdT6UK7jlMI5Vxc3QTFtxIqHJM2+/Fv3t
         JO7cfxIuBuwSGosrm/gKgjP9DXUW1wLDaEklCO1U=
Date:   Fri, 15 Feb 2019 08:13:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        LKML <linux-kernel@vger.kernel.org>, graham@grahamc.com,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: Userspace regression in LTS and stable kernels
Message-ID: <20190215071303.GA29700@kroah.com>
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
 <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
 <20190214122027.c0df36282d65dc9979248117@linux-foundation.org>
 <20190215070022.GD14473@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215070022.GD14473@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 08:00:22AM +0100, Greg Kroah-Hartman wrote:
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
> 
> > I don't know if Oleg considered backporting that patch.  I certainly
> > did (I always do), and I decided against doing so.  Yet there it is.
> 
> This came in through Sasha's tools, which give people a week or so to
> say "hey, this isn't a stable patch!" and it seems everyone ignored that
> :(
> 
> Where is Kees's fix?  I'll be glad to queue it up, or just revert the
> above commit, which ever people think is easiest.

Ah, I see the fix now, _after_ I just pushed out a bunch of stable
releases.  I'll go queue it up and push it out with just that fix in it
now...

thanks,

greg k-h
