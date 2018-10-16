Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9916C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD6D2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWjbfROv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD6D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeJPSiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeJPSiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:38:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C05712089E;
        Tue, 16 Oct 2018 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539686896;
        bh=fE/XmmY2hkqcv6th2dVvPuRnofzNhARCYzY9GtU+phk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWjbfROvhmuFh+qacaL3pli/QvHcqLXzqg5xJO2LKEAyRmvlSvM7tWgtHE7Vh3I8H
         Z2SIsFDoPuuAZZzmtszK3XQVuC51EpOZgvDQzmFTzeyqZX+bF+RcMWkLgY8xkgGL9a
         h/eSA2O/+7rhAEpDsmCUSfBxXjwLjbnKDRiB7IM8=
Date:   Tue, 16 Oct 2018 12:48:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     "idryomov@gmail.com" <idryomov@gmail.com>,
        "sage@redhat.com" <sage@redhat.com>,
        "elder@kernel.org" <elder@kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] driver core: device: add BUS_ATTR_WO macro
Message-ID: <20181016104814.GA4768@kroah.com>
References: <1538407972-9340-1-git-send-email-ioana.ciornei@nxp.com>
 <20181001210804.GA24332@kroah.com>
 <HE1PR0401MB236354F325B7A56355068E35E0E80@HE1PR0401MB2363.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0401MB236354F325B7A56355068E35E0E80@HE1PR0401MB2363.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 09:43:35AM +0000, Ioana Ciornei wrote:
> > > Add BUS_ATTR_WO macro to make it easier to add attributes without
> > > auditing the mode settings. Also, use the newly added macro where
> > > appropriate.
> > >
> > > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > > ---
> > >  arch/powerpc/platforms/pseries/ibmebus.c | 12 ++++----
> > >  drivers/block/rbd.c                      | 48 ++++++++++++++++----------------
> > >  drivers/scsi/fcoe/fcoe_sysfs.c           |  4 +--
> > >  drivers/scsi/fcoe/fcoe_transport.c       | 10 +++----
> > >  include/linux/device.h                   |  2 ++
> > >  include/scsi/libfcoe.h                   |  8 +++---
> > >  6 files changed, 43 insertions(+), 41 deletions(-)
> > 
> > Nice!  This duplicates a lot of the work I did back in July but have not pushed out
> > very far due to the other things that ended up happening around that time:
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/log/?h=bus_cleanup 
> > 
> > As the patch series seen at that link shows, you can do this in more places than
> > just what you did here.
> > 
> > Either way, you should break this up into the individual patches, like I did or you
> > can take my patches if you want.  Getting the BUS_ATTR_WO() macro added is
> > good to do now, and then you can go and hit up all of the different subsystems
> > that should be converted over to it.
> 
> I can of course split my patch into individual ones and resubmit them, but as you already have the entire patch set ready, I feel like we can just push those. I looked through your changes and it seems like you covered all the subsystems. Please let me know if there is something else I should do.
> 
> My intention here was to first add the _WO attribute so that afterwards I can add a new bus attribute in the fsl-mc bus.

Ok, I've queued up the patch that adds the _WO attribute now, so that
you should be able to use this after 4.20-rc1.  I'll work on getting my
other patches merged in that series at that time as well.

thanks,

greg k-h
