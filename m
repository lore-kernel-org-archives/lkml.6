Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AABC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D63B21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545406683;
	bh=1ftrQmt6RR+KLU+2Bdt2sEOt+/Q8sFC3jxAhGCkRj8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VZ+fX3m31lzLLgwPxA4oL/yRHwTN8vttaVNcFF2ymhu9iJFC0iFgjZgyuS0IN9xFQ
	 StPxPEBPqyaPAD5EKcYEn0RYbIT09dQa5MZ8XVPSqgVrjPEVmYDIC4rJe/WS98vcRT
	 emJyJ+pwDyXCzPELMLnsEiG8ReoYBEllRo3xgD68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbeLUPiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:38:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbeLUPiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:38:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 671DD21903;
        Fri, 21 Dec 2018 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545406680;
        bh=1ftrQmt6RR+KLU+2Bdt2sEOt+/Q8sFC3jxAhGCkRj8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfqZwMpcp6hl7v0YsA9gjngDAPjfZ2sw7DYN3qK/O0cv4B/etSCuqaUdq61hDdvVM
         isX/PPSaGL1pROozHc6epUW6RGgvhtE/dmKEqs3UlcbWsyRT2UPA0vvZyVLQYTdtx5
         yLxSLDyzL0eb+vIA+ui2q1apzvFp+EAwba9BCPPE=
Date:   Fri, 21 Dec 2018 16:37:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com,
        joel@joelfernandes.org, maco@android.com
Subject: Re: [PATCH] binderfs: implement sysctls
Message-ID: <20181221153758.GB14584@kroah.com>
References: <20181221133909.18794-1-christian@brauner.io>
 <20181221135509.GA30679@kroah.com>
 <20181221141241.gnxoiw7t5ajwcd6d@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221141241.gnxoiw7t5ajwcd6d@brauner.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 03:12:42PM +0100, Christian Brauner wrote:
> On Fri, Dec 21, 2018 at 02:55:09PM +0100, Greg KH wrote:
> > On Fri, Dec 21, 2018 at 02:39:09PM +0100, Christian Brauner wrote:
> > > This implements three sysctls that have very specific goals:
> > 
> > Ick, why?
> > 
> > What are these going to be used for?  Who will "control" them?  As you
> 
> Only global root in the initial user namespace. See the reasons below. :)
> 
> > are putting them in the "global" namespace, that feels like something
> > that binderfs was trying to avoid in the first place.
> 
> There are a couple of reason imho:
> - Global root needs a way to restrict how many binder devices can be
>   allocated across all user + ipc namespace pairs.
>   One obvious reason is that otherwise userns root in a non-initial user
>   namespace can allocate a huge number of binder devices (pick a random
>   number say 10.000) and use up a lot of kernel memory.

Root can do tons of other bad things too, why are you picking on
binderfs here?  :)

>   In addition they can pound on the binder.c code causing a lot of
>   contention for the remaining global lock in there.

That's the problem of that container, don't let it do that.  Or remove
the global lock :)

>   We should let global root explicitly restrict non-initial namespaces
>   in this respect. Imho, that's just good security design. :)

If you do not trust your container enough to have it properly allocate
the correct binder resources, then perhaps you shouldn't be allowing it
to allocate any resources at all?

> - The reason for having a number of reserved devices is when the initial
>   binderfs mount needs to bump the number of binder devices after the
>   initial allocation done during say boot (e.g. it could've removed
>   devices and wants to reallocate new ones but all binder minor numbers
>   have been given out or just needs additional devices). By reserving an
>   initial pool of binder devices this can be easily accounted for and
>   future proofs userspace. This is to say: global root in the initial
>   userns + ipcns gets dibs on however many devices it wants. :)

binder devices do not "come and go" at runtime, you need to set them up
initially and then all is fine.  So there should never be a need for the
"global" instance to need "more" binder devices once it is up and
running.  So I don't see what you are really trying to solve here.

You seem to be trying to protect the system from the container you just
gave root to and trusted it with creating its own binder instances.
If you do not trust it to create binder instances then do not allow it
to create binder instances!  :)

> - The fact that we have a single shared pool of binder device minor
>   numbers for all namespaces imho makes it necessary for the global root
>   user in the initial ipc + user namespace to manage device allocation
>   and delegation.

You are managing the allocation, you are giving who ever asks for one a
device.  If you run out of devices, oops, you run out of devices, that's
it.  Are you really ever going to run out of a major's number of binder
devices?

> The binderfs sysctl stuff is really small code-wise and adds a lot of
> security without any performance impact on the code itself. So we
> actually very strictly adhere to the requirement to not blindly
> sacrifice performance for security. :)

But you are adding a brand new user/kernel api by emulating one that is
very old and not the best at all, to try to protect from something that
seems like you can't really "protect" from in the first place.

You now have a mis-match of sysctls, ioctls and file operations all
working on the same logical thing.  And all interacting in different and
uncertian ways.  Are you sure that's wise?

If the binderfs code as-is isn't "safe enough" to use without this, then
we need to revisit it before someone starts to use it...

thanks,

greg k-h
