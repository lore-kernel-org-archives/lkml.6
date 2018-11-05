Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ABBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1992D20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxLjWnNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1992D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbeKEXV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729549AbeKEXV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:21:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C12204FD;
        Mon,  5 Nov 2018 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541426524;
        bh=BS+RtQd4SFh1nbCiGv9mMTn2KNAoBgLcEec5r+vZUkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CxLjWnNS14QkYlU7/IF0WPMvNERgAP7vO4/AZLLvw6zzBUhsexW+2s4ALv2AhkVee
         KrR/9zfZuYRZIfd/5dyXSHVIexzY+9M5Cu6+VwxUa49VlAmAX2zDaj2O6XTRkCYSxy
         WDBmiyovVgefY1w2o97zP84ZAnfa8cPB7GuvW7DA=
Date:   Mon, 5 Nov 2018 15:02:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: KOBJ_BIND uevent
Message-ID: <20181105140202.GA14870@kroah.com>
References: <f844342b-14fd-6ce5-55b0-5c224d0c841b@norrbonn.se>
 <20181105132106.GB20797@kroah.com>
 <c9fffc1c-b12c-537f-20a2-6c4ab3b0430c@norrbonn.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9fffc1c-b12c-537f-20a2-6c4ab3b0430c@norrbonn.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 02:44:21PM +0100, Jonas Bonn wrote:
> Hi,
> 
> On 05/11/2018 14:21, Greg KH wrote:
> > On Mon, Nov 05, 2018 at 11:35:57AM +0100, Jonas Bonn wrote:
> > > Hi,
> > > 
> > > I have a question about the ordering of uevents, specifically concerning
> > > complex USB devices that present multiple interfaces/functions.
> > > 
> > > Before KOBJ_BIND, a USB device would typically present itself as:
> > > 
> > > add usb_device
> > > add usb_interface-1
> > > add subsystem-device-1.0
> > > add subsystem-device-1.1
> > > add usb_interface-2
> > > add subsystem-device-2.0
> > > 
> > > I have noted that the recently added "bind" actions, however, present in the
> > > reverse order.
> > > 
> > > bind subsystem-device-1.0
> > > bind subsystem-device-1.1
> > > bind usb-interface-1
> > > bind subsystem-device-2.0
> > > bind usb_interface-2
> > > bind usb_device
> > > 
> > > This secondary ordering could be useful in the sense that the final "bind"
> > > action on the usb_device is an indication that the kernel has finished
> > > enumeration of all endpoints and has bound all drivers that it could to the
> > > available interfaces... i.e. no further events for this device are expected.
> > 
> > Maybe.  Maybe not, as userspace might still be in the process of loading
> > new kernel drivers based on the add uevents that got sent out.  Then
> > binding would happen later after the usb_device was "bound".
> > 
> > > The question, then, is:  is the above ordering of "bind" events stable, or
> > > is it just a consequence of the current implementation and may change in the
> > > future?
> > 
> > Not stable at all, sorry, you can not depend on it.
> > 
> > Nor should you even try to, what problem are you wanting to solve here?
> 
> Specifically, I'm dealing with USB modems that fall into two categories:
> 
> i)  present a bunch of USB interfaces with one ACM (or similar) class device
> on each interface (one TTY for data, control, GPS, etc.)
> 
> ii)  present one interface with multiple endpoints that end up as multiple
> Linux devices (typically usbmisc device + network interface)
> 
> In both cases, the modem really isn't useful until all the
> interfaces/endpoints are ready.  It would be nice to be able to have one
> uevent that indicates that the kernel has done all it can with the device so
> we can evaluate whether we have everything we need.

Yes, many many many people have wanted that pony for a few decades now,
there is no way for the kernel to provide you this "flag", sorry.

> Currently, we set a 1 second delay from the "add usb_device" before
> proceeding to evaluate the available modem interfaces; this delay is
> normally sufficient for everything to be enumerated and drivers bound, but
> it's still just an arbitrary delay.

If all of the kernel drivers are in the kernel at the moment, that
should be fine.  But yes, it is arbitrary, which is what happens with
dynamic devices, sorry.

good luck!

greg k-h
