Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB5FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B1B2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B1B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeLCOwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:52:21 -0500
Received: from netrider.rowland.org ([192.131.102.5]:36937 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726592AbeLCOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:52:20 -0500
Received: (qmail 23547 invoked by uid 500); 3 Dec 2018 09:51:01 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Dec 2018 09:51:01 -0500
Date:   Mon, 3 Dec 2018 09:51:01 -0500 (EST)
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
In-Reply-To: <BL0PR02MB563334585C8E1EEFF91EAA39A7AE0@BL0PR02MB5633.namprd02.prod.outlook.com>
Message-ID: <Pine.LNX.4.44L0.1812030945440.21114-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018, Anurag Kumar Vulisha wrote:

> >First of all, if some sort of deadlock causes a transfer to fail to
> >complete, the host is expected to cancel and restart it.  Not the
> >gadget.
> >
> 
> Thanks for spending your time in reviewing this patch.  The deadlock
> is  a very rare case scenario and is happening because both the gadget
> controller & host controllers get out of sync and are stuck waiting for the
> relevant event. For example this issue is observed in stream protocol where
> the gadget controller is waiting on Host controller to issue PRIME transaction
> and  Host controller is waiting on gadget to issue ERDY transaction. Since
> the stream protocol is gadget driven, the host may not proceed further until it
> receives a valid Start Stream (ERDY) transaction from gadget.

That's not entirely true.  Can't the host cancel the transfer and then 
restart it?

> Since the gadget
> controller driver is aware that the controller is stuck , makes it responsible
> to recover the controller from hang condition by restarting the transfer (which
> triggers the controller FSM to issue ERDY to host).

Isn't there a cleaner way to recover than by cancelling the request and 
resubmitting it?

> >Second, if a request timer expires and the request is cancelled, the
> >gadget driver's completion handler will be called.  This is not what
> >you want if the UDC core is going to resubmit the request
> >automatically.
> >
> >Third, if a request timer expires and the timer handler calls
> >usb_ep_dequeue() followed immediately by usb_ep_queue_timeout(), the
> >resubmit will probably fail because the dequeue won't have completed
> >yet.
> >
> >Fourth, the patch contains a race between the timer expiring and the
> >request completing.
> 
> Thanks for correcting, I agree with you on all the above 3 cases that the
> resubmission of the request should only be done from the class driver and 
> the udc core should simply dequeue the request on timeout. I am not sure
> why I haven't seen any issue while testing on this patch series. I will modify
> the code to handle the resubmitting of requests properly.

How can the gadget driver know what timeout to use?  The host is
allowed to be as slow as it wants; the gadget driver doesn't have any
way to tell when the host wants to start the transfer.

Alan Stern

