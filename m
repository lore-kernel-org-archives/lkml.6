Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32E4C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F0B2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F0B2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeLDQqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:46:39 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:46636 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727169AbeLDQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:46:38 -0500
Received: (qmail 5537 invoked by uid 2102); 4 Dec 2018 11:46:37 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Dec 2018 11:46:37 -0500
Date:   Tue, 4 Dec 2018 11:46:37 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>
cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v7 01/10] usb: gadget: udc: Add timer support for usb
 requests
In-Reply-To: <SN6PR02MB564841A6B40602168325B434A7AF0@SN6PR02MB5648.namprd02.prod.outlook.com>
Message-ID: <Pine.LNX.4.44L0.1812041138440.1537-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Anurag Kumar Vulisha wrote:

> >> Yes the host can cancel the transfer. This issue originated from the endpoints using
> >bulk
> >> streaming protocol and may not occur with normal endpoints. AFAIK bulk streaming
> >is
> >> gadget driven, where the gadget is allowed to select which stream id transfer the
> >host
> >> should work on . Since the host doesn't have control on when the transfer would be
> >> selected by gadget, it may wait for longer timeouts before cancelling the transfer.
> >
> >You're missing the point.  Although the device selects which stream ID
> >gets transferred, the _host_ decides whether a stream transfer should
> >occur in the first place.  No matter how many ERDY packets the device
> >controller tries to send, no transfer will occur until the host wants
> >to do it.
> >
> >In this sense, stream transfers (like all other USB interactions except
> >wakeup requests) are host-driven.
> >
> 
> I agree with you that without host willing to transfer, the transfer wouldn't have
> started and also agree the host always has the capability of detecting the hang. But
> we are not sure on what host platform and operating system the gadget would be
> tested and also not sure whether the host software is capable of handling the deadlock.
> Even if the host has a timer , it would be very long and waiting for the timer to get
> timedout  would reduce the performance. In this patch we are giving the user the
> flexibility to opt the timeout value, so that the deadlock can be avoided without
> effecting the performance. So I think adding the timer in gadget is more easier solution
> than handling in host. I have seen this workaround working for both linux & windows.

Is there any way for the device controller driver to detect the problem 
without relying on a timeout?

In fact, is this problem a known bug in the existing device controller
hardware?  Have the controller manufacturers published a suggested
scheme for working around it?

> >> >> Since the gadget
> >> >> controller driver is aware that the controller is stuck , makes it responsible
> >> >> to recover the controller from hang condition by restarting the transfer (which
> >> >> triggers the controller FSM to issue ERDY to host).
> >> >
> >> >Isn't there a cleaner way to recover than by cancelling the request and
> >> >resubmitting it?
> >> >
> >>
> >> dequeuing the request issues the stop transfer command to the controller, which
> >> cleans all the hardware resource allocated for that endpoint. This also resets the
> >> hardware FSMs for that endpoint . So, when re-queuing of the transfer happens
> >> the controller starts allocating hardware resources again, thus avoiding the
> >probability
> >> of entering into the issue. I am not sure of other controllers, but for dwc3, issuing
> >> the stop transfer is the only way to handle this issue.
> >
> >Again you're missing the point.  Can't the controller driver issue the
> >Stop Transfer command but still consider the request to be in progress
> >(i.e., don't dequeue the request) so that the gadget driver's
> >completion callback isn't invoked and the request does not need to be
> >explicitly resubmitted?
> >
> 
> Yes , what you are saying is correct. My initial patches were following the
> same approach that you have suggested. We switched to the dequeue
> approach because there can be different gadgets which may enter into
> this issue and it would be better to follow a generic approach rather than
> having every controller driver implementing their own workaround.
> Please find the conservation in this link  https://patchwork.kernel.org/patch/10640145/

At this point, it seems that the generic approach will be messier than 
having every controller driver implement its own fix.  At least, that's 
how it appears to me.

> >> @Felipe:  Can you please provide your suggestion on this.
> >
> >> >How can the gadget driver know what timeout to use?  The host is
> >> >allowed to be as slow as it wants; the gadget driver doesn't have any
> >> >way to tell when the host wants to start the transfer.
> >>
> >> Yes , I agree with you that the timeout may vary from usage to usage. This timeout
> >> should be decided by the class driver which queues the request. As discussed above
> >> this issue was observed in streaming protocol , which  is very much faster than
> >normal
> >> BOT modes and it works on super speed .
> >
> >Although USB mass storage is currently the only user of the stream
> >protocol, that may not be true in the future.  You should think in more
> >general terms.  A timeout which is appropriate for mass storage may not
> >be appropriate for some other application.
> >
> 
> You are correct , this timeout may not be ideal. Since  I was not able to reproduce this issue
> on non-stream capable transfers , at  present the only user of usb_ep_queue_timeout() API
> is the streaming gadget.  As we are not aware of the optimal timeout value,  instead of
> hardcoding the timeout value we can add module_param() for it.  So that the user can configure
> timeout based on their use case. Please let me know your suggestion on this.

Ideally it would not be necessary to rely on a timeout at all.

Also, maintainers dislike module parameters.  It would be better not to 
add one.

Alan Stern

