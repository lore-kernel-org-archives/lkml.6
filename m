Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD17C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5EE2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5EE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeIZBEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:04:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3039 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbeIZBEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:04:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65C38792C0;
        Tue, 25 Sep 2018 18:55:14 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DEF95D76C;
        Tue, 25 Sep 2018 18:55:14 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 02B4A181A12E;
        Tue, 25 Sep 2018 18:55:13 +0000 (UTC)
Date:   Tue, 25 Sep 2018 14:55:13 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        syzkaller <syzkaller@googlegroups.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Message-ID: <1810191004.16066868.1537901713871.JavaMail.zimbra@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.1809251352540.1517-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1809251352540.1517-100000@iolanthe.rowland.org>
Subject: Re: [PATCH] usb: usbfs: fix crash in
 check_ctrlrecip()->usb_find_alt_setting()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.200.19, 10.4.195.30]
Thread-Topic: usbfs: fix crash in check_ctrlrecip()->usb_find_alt_setting()
Thread-Index: 769AhKLgnsn5MS0mertdHakXGYdjeg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 25 Sep 2018 18:55:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alan, Andrey, all,

> > > (You'll be lucky if Linus doesn't see that.  He yells at anybody who
> > > suggests adding BUG_ON for anything that doesn't completely crash

Now, may be not )

> > > How is this different from calling kfree() with a NULL argument?

It is not, it is the same case.

> > What about adding a WARN_ON()? It doesn't crash the kernel and it will
> > be detected and reported by syzbot.

Yes, that would be a great solution.

> Sure, we could do that.  But would be the point?

We know when usb_find_alt_setting() callers do smth weird and go fix them.

> After c9a4cb204e9e, calling usb_find_alt_setting() with a NULL config is
> no more of a bug than calling kfree() with a NULL pointer.

Yes, exactly.

> You wouldn't want to put a WARN_ON in kfree(), would you?

Honestly, in the ideal world I would, again, to be aware when some code does
something weird so we know about it. But this world is this world, it needs
more performance to the throne of performance.

I have no other arguments except the above, please, feel free to not to accept
my patch.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer
