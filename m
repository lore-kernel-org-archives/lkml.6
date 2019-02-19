Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C759C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A452177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550583769;
	bh=xKE7Tv9wcvizIbJLVbiYwe9gHlNPCU1bI/p+qI0PaeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BfL6xLTp/giSEnSYFIqG8xFM1Ze8cp33BtTq7NfMBWxgJUKETvVWpbIx3J/0ENCso
	 9agEZ1gnbYUwOB401yAS0lNpDLLOHBKBhWAdH62f+AdoJRijxrCFQCy1FdQbDo04eq
	 r2BI9ugqV+0MPntYaJKCASV3pFzEEZQmfE1HvLvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfBSNmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:42:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfBSNmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:42:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10AAC2147A;
        Tue, 19 Feb 2019 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550583766;
        bh=xKE7Tv9wcvizIbJLVbiYwe9gHlNPCU1bI/p+qI0PaeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hr6NdoxAa9Dl8/Unn1EkTtFY4LCAKB3W6R5nTXlMgP0ribzYy4na78bBEYdOzymLx
         D+NV/hQyBOrtWoIdajIKIOFAjxPUQ5XOXSi4RcOXWm8jI5z+snYXRVMFTikC0dr9nM
         1Ac2+451OKPMC1bx8+YJfSCZE62Hsyw7hVjPYJGQ=
Date:   Tue, 19 Feb 2019 14:42:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: skip interfaces disabled in devicetree
Message-ID: <20190219134244.GA6815@kroah.com>
References: <20190216170452.10884-1-mans@mansr.com>
 <20190219131149.GA20719@kroah.com>
 <yw1xftsjykpo.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xftsjykpo.fsf@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:24:51PM +0000, Måns Rullgård wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Sat, Feb 16, 2019 at 05:04:52PM +0000, Mans Rullgard wrote:
> >> If an interface has an associated devicetree node with status disabled,
> >> do not register the device.  This is useful for boards with a built-in
> >> multifunction USB device where some functions are broken or otherwise
> >> undesired.
> >> 
> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> ---
> >>  drivers/usb/core/message.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> >> index bfa5eda0cc26..6b45d4835e41 100644
> >> --- a/drivers/usb/core/message.c
> >> +++ b/drivers/usb/core/message.c
> >> @@ -2007,6 +2007,10 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> >>  	for (i = 0; i < nintf; ++i) {
> >>  		struct usb_interface *intf = cp->interface[i];
> >>  
> >> +		if (intf->dev.of_node &&
> >> +		    !of_device_is_available(intf->dev.of_node))
> >> +			continue;
> >
> > Shouldn't you at least print some message out saying you are skipping
> > this?  Odds are this is going to cause regressions in devices that were
> > not expecting this, right?  So pointing them at why their devices now no
> > longer work would be good :)
> 
> They will only be skipped if there is a device tree node for the
> interface _and_ it has and explicit status = "disabled" property.
> The default is still to create devices for all interfaces.

Yes, but today if you have such a status field set, it will not skip
them, so who knows who has their DT messed up :)

> That said, printing a message is probably a good idea anyway.  Would
> "info" level be appropriate for this?

That is a good idea.

thanks,

greg k-h
