Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28123C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67EB218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550477257;
	bh=f1oyHMXR0H2RE4SVj30LyqSdSVFSIGLqTtQiDPrFDLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=grYV4GxhDiTmv0oNfXRjV+8iY8dc5TpAF7sd0a5yvG/LLI4Sg4erPdJXUNIVmVjdk
	 wRF9X3KTkd7Fe42VA3zH0ZDH1DuJzyo8wLNKnnv8nkb7fBWVlMMAu9diHm6Lj8sraa
	 J5kIwgeAXbsdh1/NiMVP1CaZsifUi1hDu6raI7M4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfBRIHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:07:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBRIHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:07:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CB92070D;
        Mon, 18 Feb 2019 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550477250;
        bh=f1oyHMXR0H2RE4SVj30LyqSdSVFSIGLqTtQiDPrFDLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlZWe5zAe7yCtpAkEKqvZZlS7ER4ao+iIbEbRxliJ+lJsxfOt1EdLY5bhGrZeNsvK
         c7bphLp6E8uNP5eOBdElop3Q5UZsX0Tvh1vQV0nfHZuk2VrGb3KPCv6uTbF/LxE3Ex
         5LSabqAT90Q1lWBmwVBiiKsx04e7+GRJ0S/L/+CM=
Date:   Mon, 18 Feb 2019 09:07:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] device connection: Add support for device graphs
Message-ID: <20190218080727.GA21246@kroah.com>
References: <20190213074557.66028-1-heikki.krogerus@linux.intel.com>
 <20190214101043.GA4316@kroah.com>
 <20190215124715.GA10182@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215124715.GA10182@kuha.fi.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 02:47:15PM +0200, Heikki Krogerus wrote:
> Hi Greg,
> 
> On Thu, Feb 14, 2019 at 11:10:44AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Feb 13, 2019 at 10:45:48AM +0300, Heikki Krogerus wrote:
> > > Hi,
> > > 
> > > This is the third version of my proposal to add device graph parsing
> > > to the device connection API. There was only one problem reported in
> > > v2 by Jun - kernel-doc entry was missing for the new fwnode member in
> > > struct usb_role_switch_desc - and it's now fixed.
> > > 
> > > The second version of the series:
> > > https://lkml.org/lkml/2019/1/30/622
> > > 
> > > The commit message from v1:
> > > 
> > > This series adds support for OF and ACPI device graph parsing to the
> > > device connection API.
> > > 
> > > Handling the graph is straightforward, but because I'm adding that
> > > fwnode member to struct device_connection, I had to make sure all the
> > > existing users consider it.
> > > 
> > > The plan is to only support matching with fwnode in the future, so no
> > > more device name matching. The software fwnodes that we now have in
> > > kernel should make that possible, once we add support for references
> > > to them.
> > > 
> > > The original RFC:
> > > https://lkml.org/lkml/2018/10/24/619
> > 
> > All now merged, thanks.
> 
> It looks like you have not followed the order of the patches in this
> series.
> 
> You applied at least the patch 4/9 ("device connection: Add fwnode
> member to struct device_connection") as the last patch to your
> usb-next branch. The rest of the series, patches starting from 5/9,
> depend on that patch.

Ugh, did I just apply them out of order?  I can't rewrite my tree now,
sorry about that, odd that my sorting didn't work.

I think all of the patches are now in the tree, so I didn't miss
anything, is there anything I can do now?  Want me to revert them and
then add them back in the correct order?

thanks,

greg k-h
