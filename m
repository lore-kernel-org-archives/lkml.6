Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FAC2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FAC2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeIZOdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:33:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeIZOdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:33:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A42F530820DE;
        Wed, 26 Sep 2018 08:22:08 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C55E600C3;
        Wed, 26 Sep 2018 08:22:08 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 6033418005CF;
        Wed, 26 Sep 2018 08:22:08 +0000 (UTC)
Date:   Wed, 26 Sep 2018 04:22:08 -0400 (EDT)
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
Message-ID: <1046309093.16165115.1537950128159.JavaMail.zimbra@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.1809251600150.1517-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1809251600150.1517-100000@iolanthe.rowland.org>
Subject: Re: [PATCH] usb: usbfs: fix crash in
 check_ctrlrecip()->usb_find_alt_setting()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.5.28, 10.4.195.4]
Thread-Topic: usbfs: fix crash in check_ctrlrecip()->usb_find_alt_setting()
Thread-Index: Rx1OGlNRvM9VD0ne1YK/Rf3sXp8NqA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 26 Sep 2018 08:22:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alan,

> Now consider the case at hand: the call to usb_find_alt_setting() from
> check_ctrlrecip().  In this case ps->dev->actconfig being NULL doesn't
> indicate an error or a bug; it merely indicates that the user is trying
> to send a control request to a device which happens to be unconfigured,
> which is a perfectly valid thing to do.  Therefore it shouldn't require
> any special handling at the call site.
> 
> Alan Stern

Thank you for the explanation and a detailed response.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer

----- Original Message -----
> From: "Alan Stern" <stern@rowland.harvard.edu>
> To: "Vladis Dronov" <vdronov@redhat.com>
> Cc: "Andrey Konovalov" <andreyknvl@google.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Oliver Neukum"
> <oneukum@suse.com>, "Hans de Goede" <hdegoede@redhat.com>, "syzkaller" <syzkaller@googlegroups.com>, "USB list"
> <linux-usb@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>, "stable" <stable@vger.kernel.org>
> Sent: Tuesday, September 25, 2018 10:44:14 PM
> Subject: Re: [PATCH] usb: usbfs: fix crash in check_ctrlrecip()->usb_find_alt_setting()
> 
> On Tue, 25 Sep 2018, Vladis Dronov wrote:
> 
> > > > What about adding a WARN_ON()? It doesn't crash the kernel and it will
> > > > be detected and reported by syzbot.
> > 
> > Yes, that would be a great solution.
> > 
> > > Sure, we could do that.  But would be the point?
> > 
> > We know when usb_find_alt_setting() callers do smth weird and go fix them.
> > 
> > > After c9a4cb204e9e, calling usb_find_alt_setting() with a NULL config is
> > > no more of a bug than calling kfree() with a NULL pointer.
> > 
> > Yes, exactly.
> > 
> > > You wouldn't want to put a WARN_ON in kfree(), would you?
> > 
> > Honestly, in the ideal world I would, again, to be aware when some code
> > does
> > something weird so we know about it. But this world is this world, it needs
> > more performance to the throne of performance.
> 
> But is it really worthwhile?  In terms of catching bugs, this would
> help in only one situation: when the programmer thinks the argument
> should always be non-NULL because a NULL argument indicates a bug.
> Such situations seem to be relatively rare, and we can handle them by
> inserting a WARN_ON() at the call site if need be.
> 
> So it's a choice between:
> 
>      1. Putting a single test for NULL in the function being called,
> 	together with WARN_ON() at a small number of call sites, or
> 
>      2. Putting a WARN_ON() (or allowing a crash) in the function being
> 	called, together with tests for NULL at a potentially large
> 	number of call sites.
> 
> 1 has two advantages over 2.  First, it involves adding less code
> overall.  Second, it doesn't require the programmer to remember to add
> special code (a test or a WARN_ON) in situation where it doesn't
> matter -- presumably the majority of them.
> 
