Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102AFC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED77204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbfBKOjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:01 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:40460 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbfBKOiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:38:55 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A20943A7A69;
        Mon, 11 Feb 2019 15:32:02 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4EEA2200006;
        Mon, 11 Feb 2019 14:32:00 +0000 (UTC)
Date:   Mon, 11 Feb 2019 15:31:59 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] net: phy: mdio_bus: add missing device_del() in
 mdiobus_register() error handling
Message-ID: <20190211153159.6b13a687@windsurf>
In-Reply-To: <20190116154439.GA29244@lunn.ch>
References: <20190116095358.28354-1-thomas.petazzoni@bootlin.com>
        <20190116144829.GC25731@lunn.ch>
        <20190116161855.1d01e083@windsurf>
        <20190116154439.GA29244@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Wed, 16 Jan 2019 16:44:39 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > On Wed, 16 Jan 2019 15:48:29 +0100, Andrew Lunn wrote:
> >   
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > > 
> > > However, i wounder if it makes sense to add a label before the
> > > existing device_del() at the end of the function, and convert this,
> > > and the case above into a goto? That might scale better, avoiding the
> > > same issue in the future?  
> > 
> > That's another option indeed.
> > 
> > Hmm, now that I looked at it, I think we should use device_unregister()
> > instead. device_unregister() does both device_del() and put_device().  
> 
> Hi Thomas
> 
> device_unregister() does seem symmetrical with device_register() which
> is what we are trying to undo.

Even if DaveM already merged my simple fix, I had a further look at
whether we should be using device_unregister(), and in fact we should
not, but not really for a good reason: because the mdio API is not very
symmetrical.

The typical flow is:

	probe() {
		bus = mdiobus_alloc();
		if (!bus)
			return -ENOMEM;

		ret = mdiobus_register(&bus);
		if (ret) {
			mdiobus_free(bus);

		...
	}

	remove() {
		mdiobus_unregister();
		mdiobus_free();
	}

mdiobus_alloc() only does memory allocation, i.e it has no side effects
on the device model data structures.

mdiobus_register() does a device_register(). If it fails, it only
cleans up with a device_del(), i.e it doesn't do the put_device() that
it should do to fully "undo" its effect.

mdiobus_unregister() does a device_del(), i.e it also doesn't do the
opposite of mdiobus_register(), which should be device_del() +
put_device() (device_unregister() is a shortcut for both).

mdiobus_free() does the put_device()

So:

 * mdiobus_alloc() / mdiobus_free() are not symmetrical in terms of
   their interaction with the device model data structures

 * On error, mdiobus_register() leaves a non-zero reference count to the
   bus->dev structure, which will be freed up by mdiobus_free()

 * mdiobus_unregister() leaves a non-zero reference count to the
   bus->dev structure, which will be freed up by mdiobus_free()

So, if we were to use device_unregister() in the error path of
mdiobus_register() and in mdiobus_unregister(), it would break how
mdiobus_free() works.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
