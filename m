Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B338C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46C121D67
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46C121D67
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934677AbeGDKSh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:18:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64515 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934134AbeGDKSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:32 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 95ef34fe818df8e9; Wed, 4 Jul 2018 12:18:29 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCHv3 3/4] drivers/base: clean up the usage of devices_kset_move_last()
Date:   Wed, 04 Jul 2018 12:17:06 +0200
Message-ID: <2842715.a5PfnD4e6X@aspire.rjw.lan>
In-Reply-To: <CAFgQCTtu7jaUfWV4xq8CfWb7vuS5=+HuNpNxeMm9UawoUZ2CBg@mail.gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com> <3375966.ydPZj5TMVj@aspire.rjw.lan> <CAFgQCTtu7jaUfWV4xq8CfWb7vuS5=+HuNpNxeMm9UawoUZ2CBg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 4, 2018 6:40:09 AM CEST Pingfan Liu wrote:
> On Tue, Jul 3, 2018 at 10:28 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Tuesday, July 3, 2018 8:50:41 AM CEST Pingfan Liu wrote:
> > > Clean up the referring to the code in commit 52cdbdd49853 ("driver core:
> > > correct device's shutdown order"). So later we can revert it safely.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > ---
> > >  drivers/base/core.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 684b994..db3deb8 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -127,13 +127,6 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
> > >  {
> > >       struct device_link *link;
> > >
> > > -     /*
> > > -      * Devices that have not been registered yet will be put to the ends
> > > -      * of the lists during the registration, so skip them here.
> > > -      */
> > > -     if (device_is_registered(dev))
> > > -             devices_kset_move_last(dev);
> > > -
> > >       if (device_pm_initialized(dev))
> > >               device_pm_move_last(dev);
> >
> > You can't do this.
> >
> > If you do it, that will break power management in some situations.
> >
> Could you shed light on it? I had a quick browsing of pm code, but it
> is a big function, and I got lost in it.
> If the above code causes failure, then does it imply that the seq in
> devices_kset should be the same as dpm_list?

Generally, yes it should.

> But in device_shutdown(), it only intersect with pm by
> pm_runtime_get_noresume(dev) and pm_runtime_barrier(dev). How do these
> function affect the seq in dpm_list?

They are not related to dpm_list directly.

However, if you shut down a supplier device before its consumer and that
involves power management, then the consumer shutdown may fail and lock up
the system

I asked you elsewhere to clearly describe the problem you are trying to
address.  Please do that in the first place.

Thanks,
Rafael

