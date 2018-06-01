Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeFAQw6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:52:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752548AbeFAQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:52:56 -0400
Date: Fri, 1 Jun 2018 09:52:47 -0700
From: Darren Hart <dvhart@infradead.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Vadim Pasternak <vadimp@mellanox.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Michael Shych <michaelsh@mellanox.com>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Subject: Re: [PATCH v3 6/7] platform/mellanox: Introduce support for Mellanox
 register access driver
Message-ID: <20180601165247.GB3599@localhost.localdomain>
References: <1527439664-127317-1-git-send-email-vadimp@mellanox.com>
 <20180527151347.GA15487@kroah.com>
 <HE1PR0502MB375324E5F279A2733339365FA26F0@HE1PR0502MB3753.eurprd05.prod.outlook.com>
 <20180527153445.GA11051@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527153445.GA11051@kroah.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 05:34:45PM +0200, Greg Kroah-Hartman wrote:
> On Sun, May 27, 2018 at 03:22:06PM +0000, Vadim Pasternak wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > Sent: Sunday, May 27, 2018 6:14 PM
> > > To: Vadim Pasternak <vadimp@mellanox.com>
> > > Cc: dvhart@infradead.org; andy.shevchenko@gmail.com; linux-
> > > kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; jiri@resnulli.us;
> > > Michael Shych <michaelsh@mellanox.com>; ivecera@redhat.com
> > > Subject: Re: [PATCH v3 6/7] platform/mellanox: Introduce support for Mellanox
> > > register access driver
> > > 
> > > On Sun, May 27, 2018 at 04:47:43PM +0000, Vadim Pasternak wrote:
> > > > Introduce new Mellanox platform driver to allow access to Mellanox
> > > > programmable device register space trough sysfs interface.
> > > > The driver purpose is to provide sysfs interface for user space for
> > > > the registers essential for system control and monitoring.
> > > > The sets of registers for sysfs access are supposed to be defined per
> > > > system type bases and include the registers related to system resets
> > > > operation, system reset causes monitoring and some kinds of mux selection.
> > > >
> > > > Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> > > > ---
> > > > v1->v2:
> > > >  Changed added by Vadim:
> > > >  - Change ---help--- to help in Kconfig, according to new
> > > > requirements;
> > > > v2->v3:
> > > >  Comments pointed out by Darren:
> > > >  - Remove conditional assignment per attribute mode type, because mode
> > > >    will guard against not permitted access.
> > > >    Verified by Vadim.
> > > > ---
> > > >  drivers/platform/mellanox/Kconfig     |  11 ++
> > > >  drivers/platform/mellanox/Makefile    |   1 +
> > > >  drivers/platform/mellanox/mlxreg-io.c | 203
> > > > ++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 215 insertions(+)
> > > >  create mode 100644 drivers/platform/mellanox/mlxreg-io.c
> > > >
> > > > diff --git a/drivers/platform/mellanox/Kconfig
> > > > b/drivers/platform/mellanox/Kconfig
> > > > index 591bccd..ddfae9fc 100644
> > > > --- a/drivers/platform/mellanox/Kconfig
> > > > +++ b/drivers/platform/mellanox/Kconfig
> > > > @@ -23,4 +23,15 @@ config MLXREG_HOTPLUG
> > > >  	  This driver handles hot-plug events for the power suppliers, power
> > > >  	  cables and fans on the wide range Mellanox IB and Ethernet systems.
> > > >
> > > > +config MLXREG_IO
> > > > +	tristate "Mellanox platform register access driver support"
> > > > +	depends on REGMAP
> > > > +	depends on HWMON
> > > > +	help
> > > > +	  This driver allows access to Mellanox programmable device register
> > > > +	  space trough sysfs interface. The sets of registers for sysfs access
> > > > +	  are defined per system type bases and includes the registers related
> > > > +	  to system resets operation, system reset causes monitoring and some
> > > > +	  kinds of mux selection.
> > > 
> > > No Documentation/ABI/ entries for these new sysfs files?  Not good :(
> > > 
> > 
> > Thanks Greg for your comment.
> > 
> > Should I call doc file like:
> > Documentation/ABI/stable/sysfs-driver-mlxreg-io
> > ?
> 
> What ever matches the naming scheme for the driver, yes.

Vadim, I'm happy to help out with the docs if you like.

Will you be able to document this in a static way, or is this likely to change
significantly from platform to platform? I ask because of the automated
attribute creation in the code.


-- 
Darren Hart
VMware Open Source Technology Center
