Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B090C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5512087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5512087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLCXIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:08:21 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40305 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725981AbeLCXIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:08:20 -0500
Received: (qmail 410 invoked by uid 500); 3 Dec 2018 18:08:19 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Dec 2018 18:08:19 -0500
Date:   Mon, 3 Dec 2018 18:08:19 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
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
In-Reply-To: <BL0PR02MB563382F544FBEA926452DCF1A7AE0@BL0PR02MB5633.namprd02.prod.outlook.com>
Message-ID: <Pine.LNX.4.44L0.1812031758080.31542-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018, Anurag Kumar Vulisha wrote:

> >On Mon, 3 Dec 2018, Anurag Kumar Vulisha wrote:
> >
> >> >First of all, if some sort of deadlock causes a transfer to fail to
> >> >complete, the host is expected to cancel and restart it.  Not the
> >> >gadget.
> >> >
> >>
> >> Thanks for spending your time in reviewing this patch.  The deadlock
> >> is  a very rare case scenario and is happening because both the gadget
> >> controller & host controllers get out of sync and are stuck waiting for the
> >> relevant event. For example this issue is observed in stream protocol where
> >> the gadget controller is waiting on Host controller to issue PRIME transaction
> >> and  Host controller is waiting on gadget to issue ERDY transaction. Since
> >> the stream protocol is gadget driven, the host may not proceed further until it
> >> receives a valid Start Stream (ERDY) transaction from gadget.
> >
> >That's not entirely true.  Can't the host cancel the transfer and then
> >restart it?
> >
> 
> Yes the host can cancel the transfer. This issue originated from the endpoints using bulk
> streaming protocol and may not occur with normal endpoints. AFAIK bulk streaming is
> gadget driven, where the gadget is allowed to select which stream id transfer the host
> should work on . Since the host doesn't have control on when the transfer would be
> selected by gadget, it may wait for longer timeouts before cancelling the transfer. 

You're missing the point.  Although the device selects which stream ID
gets transferred, the _host_ decides whether a stream transfer should
occur in the first place.  No matter how many ERDY packets the device
controller tries to send, no transfer will occur until the host wants
to do it.

In this sense, stream transfers (like all other USB interactions except
wakeup requests) are host-driven.

> >> Since the gadget
> >> controller driver is aware that the controller is stuck , makes it responsible
> >> to recover the controller from hang condition by restarting the transfer (which
> >> triggers the controller FSM to issue ERDY to host).
> >
> >Isn't there a cleaner way to recover than by cancelling the request and
> >resubmitting it?
> >
> 
> dequeuing the request issues the stop transfer command to the controller, which
> cleans all the hardware resource allocated for that endpoint. This also resets the
> hardware FSMs for that endpoint . So, when re-queuing of the transfer happens
> the controller starts allocating hardware resources again, thus avoiding the probability
> of entering into the issue. I am not sure of other controllers, but for dwc3, issuing
> the stop transfer is the only way to handle this issue. 

Again you're missing the point.  Can't the controller driver issue the
Stop Transfer command but still consider the request to be in progress
(i.e., don't dequeue the request) so that the gadget driver's
completion callback isn't invoked and the request does not need to be
explicitly resubmitted?

> @Felipe:  Can you please provide your suggestion on this.  

> >How can the gadget driver know what timeout to use?  The host is
> >allowed to be as slow as it wants; the gadget driver doesn't have any
> >way to tell when the host wants to start the transfer.
> 
> Yes , I agree with you that the timeout may vary from usage to usage. This timeout
> should be decided by the class driver which queues the request. As discussed above
> this issue was observed in streaming protocol , which  is very much faster than normal
> BOT modes and it works on super speed .

Although USB mass storage is currently the only user of the stream 
protocol, that may not be true in the future.  You should think in more 
general terms.  A timeout which is appropriate for mass storage may not 
be appropriate for some other application.

Alan Stern

>  More over the gadget controller decides
> the selection of the stream id on which the host should work , so taking all these into
> consideration I kept 50ms timeout for stream transfers, so that the performance may
> not get decreased.
> 
> Thanks,
> Anurag Kumar Vulisha

