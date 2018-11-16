Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139C3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D964D2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D964D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389988AbeKQBvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:51:09 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34480 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728175AbeKQBvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:51:09 -0500
Received: (qmail 1710 invoked by uid 2102); 16 Nov 2018 10:38:18 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Nov 2018 10:38:18 -0500
Date:   Fri, 16 Nov 2018 10:38:18 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ben Dooks <ben.dooks@codethink.co.uk>
cc:     Ben Dooks <ben-linux@fluff.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@lists.codethink.co.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: host: ehci: allow tine of highspeed nak-count
In-Reply-To: <39eb9e8b-2b5d-ea75-3232-be77c3743dbc@codethink.co.uk>
Message-ID: <Pine.LNX.4.44L0.1811161034500.1487-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018, Ben Dooks wrote:

> On 14/11/18 18:47, Alan Stern wrote:
> > On Wed, 14 Nov 2018, Ben Dooks wrote:
> > 
> >> From: Ben Dooks <ben.dooks@codethink.co.uk>
> >>
> >> At least some systems benefit with less scheduling if the NAK count
> >> value is set higher than the default 4. For instance a Tegra3 with
> >> an SMSC9512 showed less interrupt load when this was changed to 14.
> > 
> > Interesting.  Why do you think this is?  In theory, increasing the NAK
> > count RL value should cause a higher memory bus load and perhaps a
> > slight rise in the interrupt load (transfers will complete a little
> > more quickly because the controller tries harder to poll the endpoints
> > and see if they are ready).
> 
> I thought the NAK counter was decremented until the transfer is given
> up on.

That's right.  So if the RL value is higher, there will be more polling
attempts in quick succession before the NAK counter drops to 0 and the
controller gives up.  More polling attempts in quick succession means 
heavier memory bus usage.

> I'm going to have to go back and get some actual figures from
> a running system as this was originally done over a year ago with the
> SMSC9512 (IIRC) network driver.
> 
> >> To allow the changing of this value, add a sysfs node to each of
> >> the controllers to allow run-time changing.
> >>
> >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > 
> > The patch looks okay to me.
> 
> I'll look at getting some tracing from the SMSC driver to see what
> is going on.

Okay.  Should we consider the patch to be held in suspense until then?

Alan Stern

