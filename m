Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02698C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7EF20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbeLQQV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:21:57 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:56526 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2387944AbeLQQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:21:56 -0500
Received: (qmail 2085 invoked by uid 2102); 17 Dec 2018 11:21:55 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Dec 2018 11:21:55 -0500
Date:   Mon, 17 Dec 2018 11:21:55 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrew Worsley <amworsley@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bin Liu <b-liu@ti.com>, Benson Leung <bleung@chromium.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent race condition between USB authorisation and
 USB discovery events
In-Reply-To: <20181217061036.24143-1-amworsley@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1812171114170.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018, Andrew Worsley wrote:

> A sysfs driven USB authorisation change can trigger a usb_set_configuration
> while a hub_event worker thread is running. This can result in a USB device
> being disabled just after it was configured and bringing down all the
> devices and impacting hardware and user processes that were established on
> top of this these interfaces. In some cases the USB disable never completed
> and the whole system hung.

Can you be more specific about this?  Disabling a USB device shouldn't
cause these kinds of problems, regardless of whether or not the device
was just configured.

> At my work I had an occasional hang due to this race condition. Roughly 1
> in 50 boots had the race occurrence and 1 in 4 of those resulted in a hang.
> This patch fixed the problem and I had no problems (spurious disables
> or hangs) in 750+ boots.

usb_authorize_device, usb_deauthorize_device, and hub_event all acquire 
the device mutex.  Why should adding another mutex make any difference?

In fact there's an actual disadvantage: Making hub_event acquire a
global mutex will prevent us from handling multiple hubs concurrently.  
Although we don't do this now, we might want to in the future.

Alan Stern

