Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967314AbeE2Vav (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:30:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45371 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966945AbeE2Vat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:30:49 -0400
X-Google-Smtp-Source: ADUXVKLq3CzQ1VFugAukhJ2+Lm+O/fVfn3ypUIJFRB0+XI8li20xWeL5YI6D0rmgXR51GIqLXb9jmw==
Date: Tue, 29 May 2018 14:30:47 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 09/11] misc: throttler: Add core support for non-thermal
 throttling
Message-ID: <20180529213047.GK168650@google.com>
References: <20180525203043.249193-1-mka@chromium.org>
 <20180525203043.249193-10-mka@chromium.org>
 <20180528080826.GA17162@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180528080826.GA17162@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 10:08:26AM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 25, 2018 at 01:30:41PM -0700, Matthias Kaehlcke wrote:
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index 20be70c3f118..01a1714dd2ad 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -57,3 +57,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
> >  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
> >  obj-$(CONFIG_OCXL)		+= ocxl/
> >  obj-$(CONFIG_MISC_RTSX)		+= cardreader/
> > +obj-y				+= throttler/
> 
> Shouldn't you depend on a Kconfig option to traverse into this
> directory?

Ack

> > diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
> > new file mode 100644
> > index 000000000000..ef8388f6bc0a
> > --- /dev/null
> > +++ b/drivers/misc/throttler/Kconfig
> > @@ -0,0 +1,13 @@
> > +menuconfig THROTTLER
> > +	bool "Throttler support"
> > +	default n
> 
> the default is always 'n' no need to say it again here :)

Will remove

> > +	depends on OF
> > +	select CPU_FREQ
> > +	select PM_DEVFREQ
> > +	help
> > +	  This option enables core support for non-thermal throttling of CPUs
> > +	  and devfreq devices.
> > +
> > +	  Note that you also need a event monitor module usually called
> > +	  *_throttler.
> > +
> > diff --git a/drivers/misc/throttler/Makefile b/drivers/misc/throttler/Makefile
> > new file mode 100644
> > index 000000000000..c8d920cee315
> > --- /dev/null
> > +++ b/drivers/misc/throttler/Makefile
> > @@ -0,0 +1 @@
> > +obj-$(CONFIG_THROTTLER)		+= core.o
> > diff --git a/drivers/misc/throttler/core.c b/drivers/misc/throttler/core.c
> > new file mode 100644
> > index 000000000000..c058d03212b8
> > --- /dev/null
> > +++ b/drivers/misc/throttler/core.c
> > @@ -0,0 +1,373 @@
> > +/*
> > + * Core code for non-thermal throttling
> > + *
> > + * Copyright (C) 2018 Google, Inc.
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> 
> Please just use a single SPDX line, like checkpatch.pl would have warned
> you about.  No need for the full verbous license boiler-plate text here
> at all.

Ok
