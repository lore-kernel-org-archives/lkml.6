Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B74C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB633206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB633206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbeIYVXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:23:03 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:39150 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729436AbeIYVXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:23:03 -0400
Received: (qmail 4326 invoked by uid 2102); 25 Sep 2018 11:15:05 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Sep 2018 11:15:05 -0400
Date:   Tue, 25 Sep 2018 11:15:05 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Vladis Dronov <vdronov@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <syzkaller@googlegroups.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: usbfs: fix crash in check_ctrlrecip()->usb_find_alt_setting()
In-Reply-To: <13984886.16016319.1537887354102.JavaMail.zimbra@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1809251110170.1517-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018, Vladis Dronov wrote:

> > What reason is there for having two different fixes for the same bug?
> > This one isn't going to get into any mainline trees that don't already
> > have c9a4cb204e9e.
> 
> I believe this is the right thing to do, so usb_find_alt_setting()
> is not called with a known-bad argument.
> 
> Honestly, I would change "if (!config)" in usb_find_alt_setting() to
> "BUG_ON(!config)" so we know when its callers do smth wrong and go

(You'll be lucky if Linus doesn't see that.  He yells at anybody who
suggests adding BUG_ON for anything that doesn't completely crash the
kernel.  The basic problem is that "BUG_ON" is not a good name: That
routine doesn't really report bugs; instead it brings everything to a
halt in situations where the kernel is unable to proceed.  In practice 
this tends to make actual debugging more difficult.)

> fix callers. Unfortunately, I understand this hardly will be accepted.

How is this different from calling kfree() with a NULL argument?

Alan Stern

