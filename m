Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60581C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327EC2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327EC2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJPA64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:58:56 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55700 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726593AbeJPA64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:58:56 -0400
Received: (qmail 3743 invoked by uid 2102); 15 Oct 2018 13:12:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Oct 2018 13:12:49 -0400
Date:   Mon, 15 Oct 2018 13:12:49 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com>,
        <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: WARNING in usb_submit_urb (3)
In-Reply-To: <CAAeHK+zc-JyzxTAtv7tuVAw8Aut2uAfGP7FfNmseALY1ZBgcNQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1810151309030.1394-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Andrey Konovalov wrote:

> On Mon, Oct 15, 2018 at 5:22 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Fri, 12 Oct 2018, syzbot wrote:
> >
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    9dcd936c5312 Merge tag 'for-4.19/dm-fixes-4' of git://git...
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=123b8da1400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=24a30223a4b609bb802e
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13888991400000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1476e5e6400000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com
> >>
> >> IPVS: ftp: loaded support on port[0] = 21
> >> ------------[ cut here ]------------
> >> usb usb7: BOGUS urb flags, 1 --> 0
> >> WARNING: CPU: 0 PID: 5828 at drivers/usb/core/urb.c:503
> >> usb_submit_urb+0x717/0x14e0 drivers/usb/core/urb.c:502
> >> Kernel panic - not syncing: panic_on_warn set ...
> >
> > This should have been fixed by commit 7a68d9fb8510 ("USB: usbdevfs:
> > sanitize flags more").  Was that commit not present in the kernel you
> > tested?
> 
> The commit is there, AFAICT. This must be a different issue.

Ah, I see the problem.  In fact it is the same issue, but the commit
mentioned above contains an error (is_in gets tested too soon).  The
fix is below; can you check it?

Alan Stern



Index: usb-4.x/drivers/usb/core/devio.c
===================================================================
--- usb-4.x.orig/drivers/usb/core/devio.c
+++ usb-4.x/drivers/usb/core/devio.c
@@ -1474,8 +1474,6 @@ static int proc_do_submiturb(struct usb_
 	u = 0;
 	switch (uurb->type) {
 	case USBDEVFS_URB_TYPE_CONTROL:
-		if (is_in)
-			allow_short = true;
 		if (!usb_endpoint_xfer_control(&ep->desc))
 			return -EINVAL;
 		/* min 8 byte setup packet */
@@ -1505,6 +1503,8 @@ static int proc_do_submiturb(struct usb_
 			is_in = 0;
 			uurb->endpoint &= ~USB_DIR_IN;
 		}
+		if (is_in)
+			allow_short = true;
 		snoop(&ps->dev->dev, "control urb: bRequestType=%02x "
 			"bRequest=%02x wValue=%04x "
 			"wIndex=%04x wLength=%04x\n",

