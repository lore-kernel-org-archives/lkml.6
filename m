Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C7CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15574214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15574214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeIZCxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:53:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40370 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726173AbeIZCxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:53:37 -0400
Received: (qmail 7819 invoked by uid 2102); 25 Sep 2018 16:44:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Sep 2018 16:44:14 -0400
Date:   Tue, 25 Sep 2018 16:44:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Vladis Dronov <vdronov@redhat.com>
cc:     Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        syzkaller <syzkaller@googlegroups.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: usbfs: fix crash in check_ctrlrecip()->usb_find_alt_setting()
In-Reply-To: <1810191004.16066868.1537901713871.JavaMail.zimbra@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1809251600150.1517-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018, Vladis Dronov wrote:

> > > What about adding a WARN_ON()? It doesn't crash the kernel and it will
> > > be detected and reported by syzbot.
> 
> Yes, that would be a great solution.
> 
> > Sure, we could do that.  But would be the point?
> 
> We know when usb_find_alt_setting() callers do smth weird and go fix them.
> 
> > After c9a4cb204e9e, calling usb_find_alt_setting() with a NULL config is
> > no more of a bug than calling kfree() with a NULL pointer.
> 
> Yes, exactly.
> 
> > You wouldn't want to put a WARN_ON in kfree(), would you?
> 
> Honestly, in the ideal world I would, again, to be aware when some code does
> something weird so we know about it. But this world is this world, it needs
> more performance to the throne of performance.

But is it really worthwhile?  In terms of catching bugs, this would
help in only one situation: when the programmer thinks the argument
should always be non-NULL because a NULL argument indicates a bug.  
Such situations seem to be relatively rare, and we can handle them by
inserting a WARN_ON() at the call site if need be.

So it's a choice between:

     1. Putting a single test for NULL in the function being called, 
	together with WARN_ON() at a small number of call sites, or

     2. Putting a WARN_ON() (or allowing a crash) in the function being
	called, together with tests for NULL at a potentially large 
	number of call sites.

1 has two advantages over 2.  First, it involves adding less code 
overall.  Second, it doesn't require the programmer to remember to add 
special code (a test or a WARN_ON) in situation where it doesn't 
matter -- presumably the majority of them.

Now consider the case at hand: the call to usb_find_alt_setting() from
check_ctrlrecip().  In this case ps->dev->actconfig being NULL doesn't
indicate an error or a bug; it merely indicates that the user is trying
to send a control request to a device which happens to be unconfigured,
which is a perfectly valid thing to do.  Therefore it shouldn't require 
any special handling at the call site.

Alan Stern

