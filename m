Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EB0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE13B2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V9kHZiJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfAJOgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:36:14 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42078 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfAJOgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:36:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so13019494qtq.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mC1UYyNkxjhfXR+fI7Xv+DZHUBAMno2SWvT2ljgA1jA=;
        b=V9kHZiJHswrNAcQIIck34bLY9E/hy2VXPOJzEFedgo3kn9E5DO3nH2ydHzAS4KNiqR
         ixAgJpS6vOCARi+nQnGMlifZ+DP7Msy+HqqJA0aPxHcPwVVJaORQyIgPZ+Db6YBjsJ27
         NmXpEmuTstw6s1cyLQ0xunDv9HUrhqf30TvTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mC1UYyNkxjhfXR+fI7Xv+DZHUBAMno2SWvT2ljgA1jA=;
        b=ndekuTZkD4nAEX2eKuNNY3IGIxIcIUAfL5jPQzdNCpVxDhbqnM+4O1sJ0bs2voLEed
         ZdDCN4tSJ2Nt6oNvP8M6hzRIYgqQav6kcavYKWp0bLQkJduAQuOodBMTo/Ri2CeE06MW
         brq2WEpvUUQNyJH1cT26lyPiQCoau7Rzps75/AaDr88sZ+Fcdh4cxOMT9s4JtsGqJp9R
         HHkWxFR/dZ0mWuUO/IUoBnXSU3DD+RVgyGStX7yEorwBowtV/KkyxIRd+xcG4WEWZ3FC
         2VzezSaeDoKS3BzJfntvv5i9rKxuO7hEEqNmgzybTmTbqdXjRZZeIuaHFptVNJ3IPbdl
         9Xbg==
X-Gm-Message-State: AJcUukdXlATRV9ZtWlnT+Jz/Dw1rWYJ4SbHOMn5KSz4P9bFrDQDgTqKl
        MiMoD1+55GF5h7HWTDNksS3nmg==
X-Google-Smtp-Source: ALg8bN61CGZpgS/Hv5t7MxlCZcJJgR32f+zSD5NFD/FJvQQ373mVcwg6izMXdhjfIyJf6Srj3kgOSg==
X-Received: by 2002:a37:bd5:: with SMTP id 204mr9073704qkl.242.1547130972980;
        Thu, 10 Jan 2019 06:36:12 -0800 (PST)
Received: from google.com ([2620:0:1003:510:59af:10e9:2d49:6b0a])
        by smtp.gmail.com with ESMTPSA id f36sm36718254qtb.67.2019.01.10.06.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 06:36:12 -0800 (PST)
Date:   Thu, 10 Jan 2019 09:36:10 -0500
From:   Kyle Williams <kdgwill@chromium.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        Nico Sneck <snecknico@gmail.com>,
        Tim Anderson <tsa@biglakesoftware.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: quirks: add NO_LPM quirk for Logitech
 Flare|Meetup|Brio|Rally
Message-ID: <20190110143610.GA142026@google.com>
References: <CAAd214WBzcsFamzqkdTp0AYDRo1=Uq1=Z5fJhzkOZ6znVFo3MA@mail.gmail.com>
 <Pine.LNX.4.44L0.1812041633580.1537-100000@iolanthe.rowland.org>
 <20181207221841.GA161210@google.com>
 <9d5fc873-fc6d-797c-f1cb-573a784123b9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d5fc873-fc6d-797c-f1cb-573a784123b9@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 03:50:17PM +0200, Mathias Nyman wrote:
> On 08.12.2018 00:18, Kyle Williams wrote:
> > On Tue, Dec 04, 2018 at 04:36:18PM -0500, Alan Stern wrote:
> > > On Tue, 4 Dec 2018, Kyle Williams wrote:
> > > 
> > > > Description: Some USB device / host controller combinations seem to have
> > > > problems with Link Power management. In particular it is described that
> > > > the combination of certain Logitech devices and other powered media
> > > > devices such as the Atrus device causes 'not enough bandwidth for
> > > > new device state'error.
> > > > 
> > > > This patch creates quirk entries for the tested Logitech device
> > > > indicating LPM should remain disabled for the device.
> > > > 
> > > > Signed-off-by: Kyle Williams <kdgwill@chromium.org>
> > > > ---
> > > >   drivers/usb/core/quirks.c | 16 ++++++++++++++++
> > > >   1 file changed, 16 insertions(+)
> > > > 
> > > > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > > > index 0690fcff0ea2..9403edee4797 100644
> > > > --- a/drivers/usb/core/quirks.c
> > > > +++ b/drivers/usb/core/quirks.c
> > > > @@ -246,6 +246,22 @@ static const struct usb_device_id usb_quirk_list[] = {
> > > >          /* Logitech Harmony 700-series */
> > > >          { USB_DEVICE(0x046d, 0xc122), .driver_info = USB_QUIRK_DELAY_INIT },
> > > > 
> > > > +       /* Logitech Flare */
> > > > +       { USB_DEVICE(0x046d, 0x0876), .driver_info = USB_QUIRK_NO_LPM },
> > > 
> > > This entry is out of order with the preceding entry.  And some of the
> > > new entries below are out of order with each other (entries are
> > > supposed to be sorted by Vendor ID, then Product ID).
> > > 
> > > Also, perhaps instead of adding all these new entries, we should set
> > > the NO_LPM quirk flag for all Logitech devices?
> > > 
> > > Alan Stern
> > Setting USB_QUIRK_NO_LPM for all Logitech devices instead of specific
> > ones seem to be a better solution as there are a lot of other devices
> > that have the issue as well
> > 
> > Kyle Williams
> 
> I recently found a cause for the "not enough bandwidth for new device state" error.
> Patch just got applied to v4.20-rc6
> 0472bf0 xhci: Prevent U1/U2 link pm states if exit latency is too long
> 
> Does it work for your Logitech devices?
> 
> -Mathias
> 
Hey Mathias,

The fix specified solved the issues reported for all of the listed
products.

Cheers,
~Kyle

