Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB5BC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59B42086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfALREy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:04:54 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33754 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfALREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:04:54 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 36E789E789B;
        Sat, 12 Jan 2019 17:04:51 +0000 (GMT)
Date:   Sat, 12 Jan 2019 17:04:49 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: sps30: allow changing self cleaning
 period
Message-ID: <20190112170449.5418c9bf@archlinux>
In-Reply-To: <20190106105730.GA6449@arch>
References: <20181226193035.3144-1-tduszyns@gmail.com>
        <20190105165447.0056fb2e@archlinux>
        <20190106105730.GA6449@arch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2019 11:57:31 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> On Sat, Jan 05, 2019 at 04:54:47PM +0000, Jonathan Cameron wrote:
> > On Wed, 26 Dec 2018 20:30:35 +0100
> > Tomasz Duszynski <tduszyns@gmail.com> wrote:
> >  
> > > Sensor can periodically trigger self cleaning. Period can be changed by
> > > writing a new value to a dedicated attribute. Upon attribute read
> > > triplet representing respectively current, minimum and maximum period is
> > > returned.
> > >
> > > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>  
> >
> > Code is fine, but to end up with predictable generic interface
> > that fits with the rest of IIO we need a different userspace interface I think...
> >
> > See below.
> >
> > Jonathan  
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio-sps30 |  11 ++
> > >  drivers/iio/chemical/sps30.c                  | 134 +++++++++++++++---
> > >  2 files changed, 127 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sps30 b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> > > index e7ce2c57635e..d83d9192a3e0 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio-sps30
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> > > @@ -6,3 +6,14 @@ Description:
> > >  		Writing 1 starts sensor self cleaning. Internal fan accelerates
> > >  		to its maximum speed and keeps spinning for about 10 seconds in
> > >  		order to blow out accumulated dust.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/cleaning_interval
> > > +Date:		December 2018
> > > +KernelVersion:	4.22
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Sensor is capable of triggering self cleaning periodically.
> > > +		Period can be changed by writing a new value here. Upon reading
> > > +		three values are returned representing respectively current,
> > > +		minimum and maximum period. All values are in seconds.
> > > +		Writing 0 here disables periodical self cleaning entirely.  
> > Hmm. The issue here is that the value isn't:
> > 1. Intuitive
> > 2. A single value (requirement for sysfs interfaces - we stretch the meaning
> > a bit where there the values really don't have any meaning on their own but
> > that isn't true here).
> >  
> 
> This is not uncommon in sysfs for attributes to list both available
> range and current value. Hence I though I could try to sneak that here.
> 
> Turned out that without luck ;).
Indeed, in general some drivers an subsystems do that.   We decided not
to a long time ago.  Mainly because we already had an interface for
the value itself without the extras and so couldn't change it without
breaking the userspace ABI.

Even though we are looking at new interfaces, we need to be consistent!

> 
> > We have a syntax in IIO use when we want to specify a range of acceptable
> > values.  It's done for 'core' attributes using the available callback
> > (I need to write some proper docs for it though...)
> >
> > cleaning_period - the actual value.
> > cleaning_period_available
> > The range version (rather than list of values) is formatted
> > by iio_format_avail_range which generates [min step max]
> >
> > Please do something along those lines for this control as well.
> >  
> 
> Agree.
> 

Thanks,

Jonathan
