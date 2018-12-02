Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E700C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 16:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6A920851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 16:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6A920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbeLBQgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 11:36:22 -0500
Received: from netrider.rowland.org ([192.131.102.5]:54227 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725901AbeLBQgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 11:36:22 -0500
Received: (qmail 17920 invoked by uid 500); 2 Dec 2018 11:36:20 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Dec 2018 11:36:20 -0500
Date:   Sun, 2 Dec 2018 11:36:20 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: Re: [PATCH v7 01/10] usb: gadget: udc: Add timer support for usb
 requests
In-Reply-To: <1543662811-5194-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
Message-ID: <Pine.LNX.4.44L0.1812021128460.17451-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2018, Anurag Kumar Vulisha wrote:

> In some corner cases the gadget controller may get out of sync
> with host and may get into hang state, thus creating a dealock.
> For example when bulk streams are enabled for an endpoint, there
> can be a condition where the gadget controller waits for the host
> to issue prime transaction and the host controller waits for the
> gadget to issue ERDY. This condition could create a deadlock.
> 
> To avoid such potential deadlocks, a timer is started after queuing
> any request for the endpoint in usb_ep_queue(). The gadget driver
> is expected to stop the timer if a valid event is found (ex: stream
> event for stream capable endpoints). If no valid event is found, the
> timer expires after the programmed timeout value and a timeout
> callback function registered would be called. This callback function
> dequeues the request and re-queues it again, doing so makes the
> controller restart the transfer, thus avoiding deadlocks.
> 
> This kind of behaviour is observed in dwc3 controller and expected
> to be generic issue with other controllers supporting bulk streams.

I find this whole approach rather dubious.

First of all, if some sort of deadlock causes a transfer to fail to 
complete, the host is expected to cancel and restart it.  Not the 
gadget.

Second, if a request timer expires and the request is cancelled, the 
gadget driver's completion handler will be called.  This is not what 
you want if the UDC core is going to resubmit the request 
automatically.

Third, if a request timer expires and the timer handler calls
usb_ep_dequeue() followed immediately by usb_ep_queue_timeout(), the
resubmit will probably fail because the dequeue won't have completed
yet.

Fourth, the patch contains a race between the timer expiring and the 
request completing.

Alan Stern

