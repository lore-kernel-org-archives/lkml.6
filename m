Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933072AbeEWNeM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:34:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932898AbeEWNeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:34:10 -0400
Date: Wed, 23 May 2018 15:34:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kwankhede@nvidia.com,
        Dong Jia <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] vfio/mdev: Device namespace protection
Message-ID: <20180523153403.01c84046.cohuck@redhat.com>
In-Reply-To: <dfeb44cc-39bf-1015-62d4-4644e6a8cf7b@linux.ibm.com>
References: <20180518190145.3187.7620.stgit@gimli.home>
        <c666f6b7-bd49-79e4-703d-2724f7549c53@linux.ibm.com>
        <20180522123829.4e758646@w520.home>
        <20180523105641.0d89701b.cohuck@redhat.com>
        <dfeb44cc-39bf-1015-62d4-4644e6a8cf7b@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2018 14:29:28 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 05/23/2018 10:56 AM, Cornelia Huck wrote:
> > On Tue, 22 May 2018 12:38:29 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> >> On Tue, 22 May 2018 19:17:07 +0200
> >> Halil Pasic <pasic@linux.ibm.com> wrote:
> >>  
> >>>   From vfio-ccw perspective I join Connie's assessment: vfio-ccw should
> >>> be fine with these changes. I'm however not too deeply involved with
> >>> the mdev framework, thus I don't feel comfortable r-b-ing. That results
> >>> in
> >>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> >>> for both patches.
> >>>
> >>> While at it I have would like to ask about the semantics and intended
> >>> use of the mdev interfaces.
> >>>
> >>> static int vfio_ccw_sch_probe(struct subchannel *sch)
> >>> {
> >>>
> >>> /* HALIL: 8< Not so interesting stuff happens here. >8 */  
> >>
> >> This was interesting:
> >>
> >> 	private->state = VFIO_CCW_STATE_NOT_OPER;
> >>  
> >>>           ret = vfio_ccw_mdev_reg(sch);
> >>>           if (ret)
> >>>                   goto out_disable;
> >>> /*
> >>>    * HALIL:
> >>>    * This might be racy. Somewhere in vfio_ccw_mdev_reg() the create attribute
> >>>    * is made available (it calls mdev_register_device()). For instance create will
> >>>    * attempt to decrement private->avail which is initialized below. I fail to
> >>>    * understand how is  this well synchronized.
> >>>    */
> >>>           INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
> >>>           atomic_set(&private->avail, 1);
> >>>           private->state = VFIO_CCW_STATE_STANDBY;
> >>>
> >>>           return 0;
> >>>
> >>> out_disable:
> >>>           cio_disable_subchannel(sch);
> >>> out_free:
> >>>           dev_set_drvdata(&sch->dev, NULL);
> >>>           kfree(private);
> >>>           return ret;
> >>> }
> >>>
> >>> Should not initialization  of go before mdev_register_device(), and then rolled
> >>> back if necessary if mdev_register_device() fails?
> >>>
> >>> In practice it does not seem very likely that userspace can trigger
> >>> mdev_device_create() before vfio_ccw_sch_probe() finishes so it should
> >>> not be a practical problem. But I would like to understand how synchronization
> >>> is supposed to work.
> >>>
> >>> [Added Dong Jia, maybe he is also able to answer my question.]  
> >>
> >> vfio_ccw_mdev_create() requires that private->state is not
> >> VFIO_CCW_STATE_NOT_OPER but vfio_ccw_sch_probe() explicitly sets state
> >> to this value before calling vfio_ccw_mdev_reg(), so a create should
> >> return -ENODEV if racing with parent registration.  Is there something
> >> else that I'm missing?  Thanks,
> >>  
> 
> 
> Disclaimer: I did not do much kernel work up until now. I still have
> much to learn.
> 
> I mostly agree with your analysis but I'm not sure if the conclusion should be
> 'and thus everything is good' or 'and thus indeed we do have a race, a
> poorly handled one'.

Let me throw in that there is more than one way to handle a race, and
one of them is to return an error if something happens at an
inconvenient time :)

> 
> One thing I'm not sure about is: can atomic_set(&private->avail, 1) and
> private->state = VFIO_CCW_STATE_STANDBY be perceived as reordered by
> e.g. some other cpu and thus vfio_ccw_mdev_create() or not. I tried to
> figure it out based on Documentation/atomic_t.txt but was not very successful.
> If these can be reordered we could observe -EPERM instead of -ENODEV, I
> think.

I don't think that matters (see below).

> 
> Furthermore from your analysis I deduce that the client code (I think mdev
> calls it vendor code) may rely on mdev_register_device() containing a
> (RELEASE) barrier. We use a mutex in there so the barrier is there. And
> the client code may rely on a (ACQUIRE) barrier before the create callback
> is called. That should also be true and was true in the past too again because
> of mutex usage.
> 
> 
> >> Alex  
> > 
> > No, I think your understanding is correct. We move the state from
> > NOT_OPER to STANDBY only after we're set up completely, so our create
> > callback will simply fail early with -ENODEV. This looks fine to me.
> >   
> 
> This -ENODEV looks strange to me. Which device does not exist?  The
> userspace were supposed to retry on this? It's not even -EAGAIN. Is it
> documented somewhere?

-ENODEV looks very reasonable if we consider a device in the NOT_OPER
state.

> 
> If it's unavoidable (which I don't see why) I would prefer -EAGAIN. I
> think throwing an -ENODEV at our userspace once in a blue moon (if ever)
> because that is the way we 'handle' races in our code instead of avoiding
> them is not very friendly.
> 
> And I'm not sure -EPERM is not possible (see my statement
> about reordering of the writes above).

I don't think the actual return code does matter in this case. User
space must be prepared for an error (and -ENODEV was even possible
before, see the discussion in the v3 thread.)

We're dealing with a hard to trigger corner case that is easily handled
by user space here: let's not overthink this.
