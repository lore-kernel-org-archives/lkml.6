Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15176C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C774121903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545410000;
	bh=aCtKOoHSTs/V7p+iNrv78+lw4FuIIdiM/iZ5/FDZyME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=McLy+lLAlEpc69roZdYZBhKscuJzGlB8+dFmmzbZqB0jH1z9mHcNLEa7YHzwf8ljl
	 a6fIP05qo1HYxvu5c/AK5Z1JJzlv+ei/PC1tHml2Kp9QSuhK/0xGDo869b6wnR7Z/R
	 4LJgShtNo1/i6a42iZ8r4o5wFanIsECiG0dicbpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbeLUQdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:33:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbeLUQdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:33:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD96D218D3;
        Fri, 21 Dec 2018 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545409998;
        bh=aCtKOoHSTs/V7p+iNrv78+lw4FuIIdiM/iZ5/FDZyME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9nSFtGilPw3Q39d3rbRhVRj5Pzlx8knoq2QQNIxCJtCALu0VnBvu19Jj5znkKC01
         hmt7D7HlrwPASAKBAtFuhe1Zp5Y4nAMz7cGYGpGpK56DqFYvwj3K9ffiMIMiL8YTX7
         Kca1yUZLMhpYHdxpQ5ljaXCeL4FREgz59cWSBUzg=
Date:   Fri, 21 Dec 2018 17:33:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com,
        joel@joelfernandes.org, maco@android.com
Subject: Re: [PATCH] binderfs: implement sysctls
Message-ID: <20181221163316.GA8517@kroah.com>
References: <20181221133909.18794-1-christian@brauner.io>
 <20181221135509.GA30679@kroah.com>
 <20181221141241.gnxoiw7t5ajwcd6d@brauner.io>
 <20181221153758.GB14584@kroah.com>
 <20181221155918.b3sgv2adx5i74r6i@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221155918.b3sgv2adx5i74r6i@brauner.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 04:59:19PM +0100, Christian Brauner wrote:
> On Fri, Dec 21, 2018 at 04:37:58PM +0100, Greg KH wrote:
> > On Fri, Dec 21, 2018 at 03:12:42PM +0100, Christian Brauner wrote:
> > > On Fri, Dec 21, 2018 at 02:55:09PM +0100, Greg KH wrote:
> > > > On Fri, Dec 21, 2018 at 02:39:09PM +0100, Christian Brauner wrote:
> > > > > This implements three sysctls that have very specific goals:
> > > > 
> > > > Ick, why?
> > > > 
> > > > What are these going to be used for?  Who will "control" them?  As you
> > > 
> > > Only global root in the initial user namespace. See the reasons below. :)
> > > 
> > > > are putting them in the "global" namespace, that feels like something
> > > > that binderfs was trying to avoid in the first place.
> > > 
> > > There are a couple of reason imho:
> > > - Global root needs a way to restrict how many binder devices can be
> > >   allocated across all user + ipc namespace pairs.
> > >   One obvious reason is that otherwise userns root in a non-initial user
> > >   namespace can allocate a huge number of binder devices (pick a random
> > >   number say 10.000) and use up a lot of kernel memory.
> > 
> > Root can do tons of other bad things too, why are you picking on
> 
> That's global root not userns root though. :) These sysctls are about
> global root gaining the ability to proactively restrict binder device
> delegation.
> 
> > binderfs here?  :)
> > 
> > >   In addition they can pound on the binder.c code causing a lot of
> > >   contention for the remaining global lock in there.
> > 
> > That's the problem of that container, don't let it do that.  Or remove
> > the global lock :)
> > 
> > >   We should let global root explicitly restrict non-initial namespaces
> > >   in this respect. Imho, that's just good security design. :)
> > 
> > If you do not trust your container enough to have it properly allocate
> > the correct binder resources, then perhaps you shouldn't be allowing it
> > to allocate any resources at all?
> 
> Containers just like VMs get delegated and you might not have control
> over what is running in there. That's AWS in a nutshell. :) Restricting
> it by saying "just don't do that" seems not something that is
> appropriate given the workloads out there in the wild.
> In general, I do *understand* the reasoning but I think the premise is
> flawed if we can somewhat trivially make this safe.
> 
> > 
> > > - The reason for having a number of reserved devices is when the initial
> > >   binderfs mount needs to bump the number of binder devices after the
> > >   initial allocation done during say boot (e.g. it could've removed
> > >   devices and wants to reallocate new ones but all binder minor numbers
> > >   have been given out or just needs additional devices). By reserving an
> > >   initial pool of binder devices this can be easily accounted for and
> > >   future proofs userspace. This is to say: global root in the initial
> > >   userns + ipcns gets dibs on however many devices it wants. :)
> > 
> > binder devices do not "come and go" at runtime, you need to set them up
> > initially and then all is fine.  So there should never be a need for the
> > "global" instance to need "more" binder devices once it is up and
> > running.  So I don't see what you are really trying to solve here.
> 
> That's dismissing a whole range of use-cases where you might allocate
> and deallocate devices on the fly which this is somewhat designed for.
> But I guess ok for now.
> 
> > 
> > You seem to be trying to protect the system from the container you just
> > gave root to and trusted it with creating its own binder instances.
> > If you do not trust it to create binder instances then do not allow it
> > to create binder instances!  :)
> 
> Again, I get the reasoning but think that this dismisses major
> real-world use-cases not just for binderfs but for all instances where
> untrusted workloads are run which both containers and VMs aim to make
> sure are possible.
> Note, I mean untrusted not in the sense of necessarily being malicious
> but just "can't guarantee that things don't blow up in your face".
> 
> > 
> > > - The fact that we have a single shared pool of binder device minor
> > >   numbers for all namespaces imho makes it necessary for the global root
> > >   user in the initial ipc + user namespace to manage device allocation
> > >   and delegation.
> > 
> > You are managing the allocation, you are giving who ever asks for one a
> > device.  If you run out of devices, oops, you run out of devices, that's
> > it.  Are you really ever going to run out of a major's number of binder
> > devices?
> 
> The point is more about someone intentionally trying to do that.
> 
> > 
> > > The binderfs sysctl stuff is really small code-wise and adds a lot of
> > > security without any performance impact on the code itself. So we
> > > actually very strictly adhere to the requirement to not blindly
> > > sacrifice performance for security. :)
> > 
> > But you are adding a brand new user/kernel api by emulating one that is
> > very old and not the best at all, to try to protect from something that
> > seems like you can't really "protect" from in the first place.
> 
> Of course we can protect from that. It's about init root never running
> out of devices. We don't care about non-init-userns running out of
> devices at all.
> 
> > 
> > You now have a mis-match of sysctls, ioctls and file operations all
> > working on the same logical thing.  And all interacting in different and
> > uncertian ways.  Are you sure that's wise?
> 
> The sysctl approach is present in other pseudo-filesystems apart from
> devpts. For example, mqueue.
> 
> > 
> > If the binderfs code as-is isn't "safe enough" to use without this, then
> > we need to revisit it before someone starts to use it...
> 
> *It is safe.* I just don't see a good argument against additional
> hardening. *But I'm definitely not going to push this patch if it's
> additional hardening features are used to push the unsound argument that
> binderfs isn't safe.* :)

Ok, so what you really want is just "limits" to prevent a container from
doing something really crazy, right?  So, how about a limit of 10 binder
nodes per container?  Make it a kernel build option so it can be changed
by a vendor if they really find that is a problem.

Would that solve the issue you are thinking might be here?

thanks,

greg k-h
