Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E962DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940DB20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QlZsuJp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940DB20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeLMTGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:06:41 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45494 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMTGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:06:41 -0500
Received: by mail-io1-f67.google.com with SMTP id n3so2455571iog.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43z7sxCwsioeuUTMZ1cXwqY1NBaDS2DfjVGCxspeBxw=;
        b=QlZsuJp0sBhkp3igKmlBJSPaw/hJyDz89X3YmO8eZxakjZXVGpK2/Y4gxK0omw3/jd
         EfiIYXUIzf2cOqrKnuVeUzwHlOzimrzM0v/t+5EYj8Hboh70mp+1TzMtkDZ/ibm9PXEL
         uNTLU9Lu+aA2lif3hBGsvgl8goeYV8YOvMOSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43z7sxCwsioeuUTMZ1cXwqY1NBaDS2DfjVGCxspeBxw=;
        b=IpXUx+aZVh1QfWczy6XGpf7N8Q+yvXdkN4HqTnjCM6Tn29pK1SuF5E6AbuCzSdtbP5
         xNVK6LkJyAj9FxlkhJCDzGQC54im8PxQsUx3GgajZEZQIyZ2EFD+imlEg5IexbTIOoiA
         EdBT7s1BPoJiMpfF6Jf5aBy9w4lyPfY+gcOZNbogodf3Dp/K4DvlW8mUCwxJioqu55Hc
         5fjdcc6Lg2t0n1I3qBZicn97BTL/WIYr8X3qhJXppAtPrjZSA195bOniOSPsBn75YbpY
         seUQCSKUv6GdnzYPLDPPGRZ+18W/nDLjNgWMTSZ73FCSHBnaSPykD0GJcpZ5nZITKbyh
         4ICg==
X-Gm-Message-State: AA+aEWZByQgw/TQvEixMMVZ7hpeyy0y/1nhLRHrVl08RMHpLjyMc1tgk
        2eyXBnZ1RBIsImTUtCTa0We09rl8H/N2Yty4VenM97vs
X-Google-Smtp-Source: AFSGD/UsOcluBOvBaDwJckDa8x/5AuBcadqjPG+0B4nGmQVg0KlVzXaat113/aLq3gF2bzj4N9ZWDtCQFM8UOZtYj5g=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr19536ioa.34.1544728000350;
 Thu, 13 Dec 2018 11:06:40 -0800 (PST)
MIME-Version: 1.0
References: <7586985.G9YL5ver76@aspire.rjw.lan> <20181213185304.GB18107@kroah.com>
In-Reply-To: <20181213185304.GB18107@kroah.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 13 Dec 2018 20:06:28 +0100
Message-ID: <CAKMK7uFFpqFy8tksvMxW2X6_gT-Se8Y9Jbtcxun99e4vRSdgQA@mail.gmail.com>
Subject: Re: [PATCH] driver core: Add missing dev->bus->need_parent_lock checks
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, liumartin@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 7:53 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 13, 2018 at 07:27:47PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > __device_release_driver() has to check dev->bus->need_parent_lock
> > before dropping the parent lock and acquiring it again as it may
> > attempt to drop a lock that hasn't been acquired or lock a device
> > that shouldn't be locked and create a lock imbalance.
> >
> > Fixes: 8c97a46af04b (driver core: hold dev's parent lock when needed)
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This should go into -stable for everything over 4.18 methinks.
>
> Does this fix Daniel's lockdep splat?

Nah, separate issue. Afaiui bus->need_parent_lock is only set for usb,
I'm unbinding pci devices. I guess the combination of someone
unbinding an usb device through sysfs which also has some device links
attached doesn't happen.

Since I've dug around in this, for this patch here from Rafael:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel

>
> thanks,
>
> greg k-h



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
