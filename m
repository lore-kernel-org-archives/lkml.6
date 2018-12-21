Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CBDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543192186A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="b2rgiKsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbeLUP7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:59:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39029 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLUP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:59:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so5058870edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sTdXTdkmuEjIIVrAX9N73vk/d4ND9OmQ/Gc+vOkFwIA=;
        b=b2rgiKsbtLKF8wGkXZB4Zw61PhoguaML7qHVq0ZiwD+8Mo8SD3EGLCK7raPcef3V5f
         vxXu4kTdf7iXAfESs5QmEisu4gB58bVg3Ci8sVhgbzvsZxbhDRg3+DcEKxduU7B/NvlW
         VYSUnaF8umU00aU0wsLbmATG8j3//wjTMwNe12F8ZlXxlFuE1uZ8T4f9CQuxHcRjP2Lr
         MP6J7p9WfOyjhseCcZM79Fzw5U3QiVBgeh5XsSNcWEcOJhKEEtVmv1HcSUTiUNtQzHKf
         ADMoy1nmkU4U/R3gjvLzkAEl2g43U4aVS2EBJG57f1C2lC6CTrW/0wgA5DveoQccZe6W
         Sv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sTdXTdkmuEjIIVrAX9N73vk/d4ND9OmQ/Gc+vOkFwIA=;
        b=MR3bfejxm17+FGUo1sV5NZ1AWwUTFEDowfaQ9wVzkqsDDGd1oLcSSdy+FW5fCZ5+ZM
         EdM8XMAa4aYXVzTW5CP6Hjx2ueM+YRd9i5J10us+Y5GXPxdVhQsM5WPBPOaCWgd0W6WC
         0Tqb+0+qSWDauiKd7rTsF37SD2WB33Fg+byqeW4CNYjrNqazvaqW37xIhW36dfkZci60
         x7Kxy5SsKTYPK3AS4CENztl43iPOW5/Wxa8Y96qCovVdZTJ/xe/mfN1RSlFbOs88vzhE
         PbH6KXo65OEtRtb/FSAD557jIS0+2yUPLv7bvLziHx49QYDdLWIHIlRKDHbKC/1s8OiG
         x9Og==
X-Gm-Message-State: AA+aEWY/npwXczH+1XJf+RQgBrxVkiSDnNoWeiUGfZb+C2auAd3YPnT1
        qnlntSgkG1BTxLEf+NS0iAh9ng==
X-Google-Smtp-Source: AFSGD/WyEEF6/LC8j+ybeOcPFODhtXPFO0btEPoqRJEvKnpYqQc8m5ZB6m7FqTv3ZNMnc4drjegPcg==
X-Received: by 2002:a50:de49:: with SMTP id a9mr2890242edl.18.1545407960911;
        Fri, 21 Dec 2018 07:59:20 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:6c14:58a0:c7b2:d756:db85])
        by smtp.gmail.com with ESMTPSA id 97sm7082190edq.45.2018.12.21.07.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 07:59:20 -0800 (PST)
Date:   Fri, 21 Dec 2018 16:59:19 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com,
        joel@joelfernandes.org, maco@android.com
Subject: Re: [PATCH] binderfs: implement sysctls
Message-ID: <20181221155918.b3sgv2adx5i74r6i@brauner.io>
References: <20181221133909.18794-1-christian@brauner.io>
 <20181221135509.GA30679@kroah.com>
 <20181221141241.gnxoiw7t5ajwcd6d@brauner.io>
 <20181221153758.GB14584@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181221153758.GB14584@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 04:37:58PM +0100, Greg KH wrote:
> On Fri, Dec 21, 2018 at 03:12:42PM +0100, Christian Brauner wrote:
> > On Fri, Dec 21, 2018 at 02:55:09PM +0100, Greg KH wrote:
> > > On Fri, Dec 21, 2018 at 02:39:09PM +0100, Christian Brauner wrote:
> > > > This implements three sysctls that have very specific goals:
> > > 
> > > Ick, why?
> > > 
> > > What are these going to be used for?  Who will "control" them?  As you
> > 
> > Only global root in the initial user namespace. See the reasons below. :)
> > 
> > > are putting them in the "global" namespace, that feels like something
> > > that binderfs was trying to avoid in the first place.
> > 
> > There are a couple of reason imho:
> > - Global root needs a way to restrict how many binder devices can be
> >   allocated across all user + ipc namespace pairs.
> >   One obvious reason is that otherwise userns root in a non-initial user
> >   namespace can allocate a huge number of binder devices (pick a random
> >   number say 10.000) and use up a lot of kernel memory.
> 
> Root can do tons of other bad things too, why are you picking on

That's global root not userns root though. :) These sysctls are about
global root gaining the ability to proactively restrict binder device
delegation.

> binderfs here?  :)
> 
> >   In addition they can pound on the binder.c code causing a lot of
> >   contention for the remaining global lock in there.
> 
> That's the problem of that container, don't let it do that.  Or remove
> the global lock :)
> 
> >   We should let global root explicitly restrict non-initial namespaces
> >   in this respect. Imho, that's just good security design. :)
> 
> If you do not trust your container enough to have it properly allocate
> the correct binder resources, then perhaps you shouldn't be allowing it
> to allocate any resources at all?

Containers just like VMs get delegated and you might not have control
over what is running in there. That's AWS in a nutshell. :) Restricting
it by saying "just don't do that" seems not something that is
appropriate given the workloads out there in the wild.
In general, I do *understand* the reasoning but I think the premise is
flawed if we can somewhat trivially make this safe.

> 
> > - The reason for having a number of reserved devices is when the initial
> >   binderfs mount needs to bump the number of binder devices after the
> >   initial allocation done during say boot (e.g. it could've removed
> >   devices and wants to reallocate new ones but all binder minor numbers
> >   have been given out or just needs additional devices). By reserving an
> >   initial pool of binder devices this can be easily accounted for and
> >   future proofs userspace. This is to say: global root in the initial
> >   userns + ipcns gets dibs on however many devices it wants. :)
> 
> binder devices do not "come and go" at runtime, you need to set them up
> initially and then all is fine.  So there should never be a need for the
> "global" instance to need "more" binder devices once it is up and
> running.  So I don't see what you are really trying to solve here.

That's dismissing a whole range of use-cases where you might allocate
and deallocate devices on the fly which this is somewhat designed for.
But I guess ok for now.

> 
> You seem to be trying to protect the system from the container you just
> gave root to and trusted it with creating its own binder instances.
> If you do not trust it to create binder instances then do not allow it
> to create binder instances!  :)

Again, I get the reasoning but think that this dismisses major
real-world use-cases not just for binderfs but for all instances where
untrusted workloads are run which both containers and VMs aim to make
sure are possible.
Note, I mean untrusted not in the sense of necessarily being malicious
but just "can't guarantee that things don't blow up in your face".

> 
> > - The fact that we have a single shared pool of binder device minor
> >   numbers for all namespaces imho makes it necessary for the global root
> >   user in the initial ipc + user namespace to manage device allocation
> >   and delegation.
> 
> You are managing the allocation, you are giving who ever asks for one a
> device.  If you run out of devices, oops, you run out of devices, that's
> it.  Are you really ever going to run out of a major's number of binder
> devices?

The point is more about someone intentionally trying to do that.

> 
> > The binderfs sysctl stuff is really small code-wise and adds a lot of
> > security without any performance impact on the code itself. So we
> > actually very strictly adhere to the requirement to not blindly
> > sacrifice performance for security. :)
> 
> But you are adding a brand new user/kernel api by emulating one that is
> very old and not the best at all, to try to protect from something that
> seems like you can't really "protect" from in the first place.

Of course we can protect from that. It's about init root never running
out of devices. We don't care about non-init-userns running out of
devices at all.

> 
> You now have a mis-match of sysctls, ioctls and file operations all
> working on the same logical thing.  And all interacting in different and
> uncertian ways.  Are you sure that's wise?

The sysctl approach is present in other pseudo-filesystems apart from
devpts. For example, mqueue.

> 
> If the binderfs code as-is isn't "safe enough" to use without this, then
> we need to revisit it before someone starts to use it...

*It is safe.* I just don't see a good argument against additional
hardening. *But I'm definitely not going to push this patch if it's
additional hardening features are used to push the unsound argument that
binderfs isn't safe.* :)

Christian
