Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA8BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8C92082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8C92082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeLGRJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:09:34 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:59446 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726045AbeLGRJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:09:33 -0500
Received: (qmail 2366 invoked by uid 2102); 7 Dec 2018 12:09:32 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Dec 2018 12:09:32 -0500
Date:   Fri, 7 Dec 2018 12:09:32 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Felipe Balbi <balbi@kernel.org>
cc:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
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
In-Reply-To: <877eglx45o.fsf@linux.intel.com>
Message-ID: <Pine.LNX.4.44L0.1812071158570.1560-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018, Felipe Balbi wrote:

> 
> hi,
> 
> Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
> >>Does the data book suggest a value for the timeout?
> >>
> >
> > No, the databook doesn't mention about the timeout value
> >
> >>> >At this point, it seems that the generic approach will be messier than having every
> >>> >controller driver implement its own fix.  At least, that's how it appears to me.
> 
> Why, if the UDC implementation will, anyway, be a timer?

It's mostly a question of what happens when the timer expires.  (After
all, starting a timer is just as easy to do in a UDC driver as it is in
the core.)  When the timer expires, what can the core do?

Don't say it can cancel the offending request and resubmit it.  That
leads to the sort of trouble we discussed earlier in this thread.  In
particular, we don't want the class driver's completion routine to be
called when the cancel occurs.  Furthermore, this leads to a race:  
Suppose the class driver decides to cancel the request at the same time
as the core does a cancel and resubmit.  Then the class driver's cancel
could get lost and the request would remain on the UDC's queue.

What you really want to do is issue the appropriate stop and restart
commands to the hardware, while leaving the request logically active
the entire time.  The UDC core can't do this, but a UDC driver can.

> >>(Especially if dwc3 is the only driver affected.)
> >
> > As discussed above, the issue may happen with other gadgets too. As I got divide opinions
> > on this implementation and both the implementations looks fine to me, I am little confused
> > on which should be implemented.
> >
> > @Felipe: Do you agree with Alan's implementation? Please let us know your suggestion
> > on this.
> 
> I still think a generic timer is a better solution since it has other uses.

Putting a struct timer into struct usb_request is okay with me, but I 
wouldn't go any farther than that.

> >>Since the purpose of the timeout is to detect a deadlock caused by a
> >>hardware bug, I suggest a fixed and relatively short timeout value such
> >>as one second.  Cancelling and requeuing a few requests at 1-second
> >>intervals shouldn't add very much overhead.
> 
> I wouldn't call this a HW bug though. This is just how the UDC
> behaves. There are N streams and host can move data in any stream at any
> time. This means that host & gadget _can_ disagree on what stream to
> start next.

But the USB 3 spec says what should happen when the host and gadget 
disagree in this way, doesn't it?  And it doesn't say that they should 
deadlock.  :-)  Or have I misread the spec?

> One way to avoid this would be to never pre-start any streams and always
> rely on XferNotReady, but that would mean greatly reduced throughput for
> streams.

It would be good if there was some way to actively detect the problem 
instead of passively waiting for a timer to expire.

Alan Stern

