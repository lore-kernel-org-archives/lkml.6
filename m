Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41DDC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897AA2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfBEP6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:58:01 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:52378 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726550AbfBEP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:58:01 -0500
Received: (qmail 2431 invoked by uid 2102); 5 Feb 2019 10:58:00 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2019 10:58:00 -0500
Date:   Tue, 5 Feb 2019 10:58:00 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     John Stultz <john.stultz@linaro.org>
cc:     Felipe Balbi <balbi@kernel.org>,
        Zeng Tao <prime.zeng@hisilicon.com>,
        Jack Pham <jackp@codeaurora.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Frequent dwc3 crashes on suspend or reboot since 5.0-rc1
In-Reply-To: <CALAqxLU1uLAAzPWK0MYLauAP9AfPY=9CFNYgFHxLxKxsCdhGrw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1902051053480.1472-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019, John Stultz wrote:

> On Sat, Feb 2, 2019 at 9:00 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, 1 Feb 2019, John Stultz wrote:
> >
> > > Hey all,
> > >   Since the 5.0 merge window opened, I've been tripping on frequent
> > > dwc3 crashes on reboot and suspend, which I've added an example to the
> > > bottom of this mail.
> > >
> > > I've dug in a little bit and sort of have a sense of whats going on.
> > >
> > > In ffs_epfile_io():
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/gadget/function/f_fs.c#n1065
> > >
> > > The completion done is setup on the stack:
> > >   DECLARE_COMPLETION_ONSTACK(done);
> > >
> > > Then later we setup a request and queue it:
> > >   req->context  = &done;
> > >   ...
> > >   ret = usb_ep_queue(ep->ep, req, GFP_ATOMIC);
> > >
> > > Then wait for it:
> > >   if (unlikely(wait_for_completion_interruptible(&done))) {
> > >     /*
> > >     * To avoid race condition with ffs_epfile_io_complete,
> > >     * dequeue the request first then check
> > >     * status. usb_ep_dequeue API should guarantee no race
> > >     * condition with req->complete callback.
> > >     */
> > >     usb_ep_dequeue(ep->ep, req);
> >
> > This code contains a bug: It assumes that usb_ep_dequeue() waits until
> > the request has been completed.  You should insert
> >
> >         wait_for_completion(&done);
> >
> > right here.
> >
> > >     interrupted = ep->status < 0;
> > >   }
> >
> 
> Thanks! This does seem to resolve the issue I'm seeing.
> 
> Are you planning to send in such a patch, or would it help if I sent it out?

Either way, whatever you prefer.

If you decide to write the patch yourself, consider editing the
preceding comment (which is confusing if not outright wrong).  Also,
there is an earlier call of usb_ep_dequeue() in __ffs_ep0_queue_wait()
which might need to be fixed as well -- I'm not sure.

Alan Stern

