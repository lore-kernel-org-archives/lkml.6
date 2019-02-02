Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C9DC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A5920856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfBBRAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:00:09 -0500
Received: from netrider.rowland.org ([192.131.102.5]:55695 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726055AbfBBRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:00:09 -0500
Received: (qmail 14372 invoked by uid 500); 2 Feb 2019 12:00:08 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Feb 2019 12:00:08 -0500
Date:   Sat, 2 Feb 2019 12:00:08 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
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
In-Reply-To: <CALAqxLXy1zSTSoDEfYN0VJBbf=Q0N6kH+S_1hTTgEb6dQi0XrQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1902021155520.14150-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019, John Stultz wrote:

> Hey all,
>   Since the 5.0 merge window opened, I've been tripping on frequent
> dwc3 crashes on reboot and suspend, which I've added an example to the
> bottom of this mail.
> 
> I've dug in a little bit and sort of have a sense of whats going on.
> 
> In ffs_epfile_io():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/gadget/function/f_fs.c#n1065
> 
> The completion done is setup on the stack:
>   DECLARE_COMPLETION_ONSTACK(done);
> 
> Then later we setup a request and queue it:
>   req->context  = &done;
>   ...
>   ret = usb_ep_queue(ep->ep, req, GFP_ATOMIC);
> 
> Then wait for it:
>   if (unlikely(wait_for_completion_interruptible(&done))) {
>     /*
>     * To avoid race condition with ffs_epfile_io_complete,
>     * dequeue the request first then check
>     * status. usb_ep_dequeue API should guarantee no race
>     * condition with req->complete callback.
>     */
>     usb_ep_dequeue(ep->ep, req);

This code contains a bug: It assumes that usb_ep_dequeue() waits until 
the request has been completed.  You should insert

	wait_for_completion(&done);

right here.

>     interrupted = ep->status < 0;
>   }


> 
> The problem is, that we end up being interrupted, supposedly dequeue
> the request, and exit.
> 
> But then (or in parallel) the irq triggers and we try calling
> complete() on the context pointer which points to now random stack
> space, which results in the panic.

This is the natural result of not waiting for the request to complete.

> It seems like something is wrong with usb_ep_dequeue not really
> stopping the irq from happening?

Certainly.  usb_ep_dequeue() just speeds up the process of completing
the request; it doesn't wait for that process to finish.

Alan Stern

> If I revert all the changes to dwc3 back to 4.20, I don't see the issue.
> 
> I'll do some bisection to try to narrow things down, but I wanted to
> see if this was a known issue or if anyone had immediate ideas as to
> what might be wrong.
> 
> thanks
> -john

