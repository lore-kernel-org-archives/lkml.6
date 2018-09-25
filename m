Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4C0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709832098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709832098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeIYVDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:03:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbeIYVDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:03:46 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B99F136A5E6;
        Tue, 25 Sep 2018 14:55:54 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 804AE30A606B;
        Tue, 25 Sep 2018 14:55:54 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 664991808872;
        Tue, 25 Sep 2018 14:55:54 +0000 (UTC)
Date:   Tue, 25 Sep 2018 10:55:54 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        syzkaller@googlegroups.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Message-ID: <13984886.16016319.1537887354102.JavaMail.zimbra@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.1809251012040.1517-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1809251012040.1517-100000@iolanthe.rowland.org>
Subject: Re: [PATCH] usb: usbfs: fix crash in
 check_ctrlrecip()->usb_find_alt_setting()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.5.28, 10.4.195.22]
Thread-Topic: usbfs: fix crash in check_ctrlrecip()->usb_find_alt_setting()
Thread-Index: N1pN1orxDvlqdu0l2DHznH0UzA/W0g==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 25 Sep 2018 14:55:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What reason is there for having two different fixes for the same bug?
> This one isn't going to get into any mainline trees that don't already
> have c9a4cb204e9e.

I believe this is the right thing to do, so usb_find_alt_setting()
is not called with a known-bad argument.

Honestly, I would change "if (!config)" in usb_find_alt_setting() to
"BUG_ON(!config)" so we know when its callers do smth wrong and go
fix callers. Unfortunately, I understand this hardly will be accepted.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer
