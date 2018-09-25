Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697A2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2138520896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2138520896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeIZADR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:03:17 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40072 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726304AbeIZADR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:03:17 -0400
Received: (qmail 6816 invoked by uid 2102); 25 Sep 2018 13:54:38 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Sep 2018 13:54:38 -0400
Date:   Tue, 25 Sep 2018 13:54:38 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     Vladis Dronov <vdronov@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        syzkaller <syzkaller@googlegroups.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: usbfs: fix crash in check_ctrlrecip()->usb_find_alt_setting()
In-Reply-To: <CAAeHK+weYa=d=dSgCJ0o6dZBAxBakeAy2hodHhuPSeTr3iesuA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1809251352540.1517-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018, Andrey Konovalov wrote:

> On Tue, Sep 25, 2018 at 5:15 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Tue, 25 Sep 2018, Vladis Dronov wrote:
> >
> >> > What reason is there for having two different fixes for the same bug?
> >> > This one isn't going to get into any mainline trees that don't already
> >> > have c9a4cb204e9e.
> >>
> >> I believe this is the right thing to do, so usb_find_alt_setting()
> >> is not called with a known-bad argument.
> >>
> >> Honestly, I would change "if (!config)" in usb_find_alt_setting() to
> >> "BUG_ON(!config)" so we know when its callers do smth wrong and go
> >
> > (You'll be lucky if Linus doesn't see that.  He yells at anybody who
> > suggests adding BUG_ON for anything that doesn't completely crash the
> > kernel.  The basic problem is that "BUG_ON" is not a good name: That
> > routine doesn't really report bugs; instead it brings everything to a
> > halt in situations where the kernel is unable to proceed.  In practice
> > this tends to make actual debugging more difficult.)
> 
> What about adding a WARN_ON()? It doesn't crash the kernel and it will
> be detected and reported by syzbot.

Sure, we could do that.  But would be the point?  After c9a4cb204e9e, 
calling usb_find_alt_setting() with a NULL config is no more of a bug 
than calling kfree() with a NULL pointer.  You wouldn't want to put a 
WARN_ON in kfree(), would you?

Alan Stern

