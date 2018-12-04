Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3125EC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36E92082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36E92082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLDT3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:29:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:47014 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725912AbeLDT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:28:51 -0500
Received: (qmail 6603 invoked by uid 2102); 4 Dec 2018 14:28:50 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Dec 2018 14:28:50 -0500
Date:   Tue, 4 Dec 2018 14:28:50 -0500 (EST)
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
In-Reply-To: <SN6PR02MB56484B8D1F891926DA7D7900A7AF0@SN6PR02MB5648.namprd02.prod.outlook.com>
Message-ID: <Pine.LNX.4.44L0.1812041420200.1537-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Anurag Kumar Vulisha wrote:

> >Is there any way for the device controller driver to detect the problem without relying
> >on a timeout?
> >
> >In fact, is this problem a known bug in the existing device controller hardware?  Have
> >the controller manufacturers published a suggested scheme for working around it?
> >
> 
> Yes, this problem is mentioned in dwc3 controller data book and the workaround
> mentioned  is the same that we are doing , to implement timeout and if no valid
> stream event is found , after timeout issue end transfer followed by start transfer.

Okay.  But this implies that the problem is confined to DWC3 and
doesn't affect other types of controllers, which would mean modifying 
the UDC core would be inappropriate.

Does the data book suggest a value for the timeout?

> >At this point, it seems that the generic approach will be messier than having every
> >controller driver implement its own fix.  At least, that's how it appears to me.

(Especially if dwc3 is the only driver affected.)

> With the dequeue approach there is an advantage(not related to this issue) that the
> class driver can have control of the timed out transfer whether to requeue it or consider
> it as an error (based on implementation). This approach gives more flexibility to the class
> drivers. This may be out of context of this issue but wanted to point out that we may lose
> this advantage on switching to older implementation.

Class drivers can cancel and requeue requests at any time.  There's no 
extra flexibility.

> >Ideally it would not be necessary to rely on a timeout at all.
> >
> >Also, maintainers dislike module parameters.  It would be better not to add one.
> 
> Okay. I would be happy if any alternative for this issue is present but unfortunately
> I am not able to figure out any alternative other than timers. If not module_params()
> we can add an configfs entry in stream gadget to update the timeout. Please provide
> your opinion on this approach. 

Since the purpose of the timeout is to detect a deadlock caused by a
hardware bug, I suggest a fixed and relatively short timeout value such
as one second.  Cancelling and requeuing a few requests at 1-second
intervals shouldn't add very much overhead.

Alan Stern

