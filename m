Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032414AbeEZUrJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 16:47:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032376AbeEZUrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 16:47:07 -0400
Date: Sat, 26 May 2018 13:47:01 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Michael Shych <michaelsh@mellanox.com>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Subject: Re: [PATCH v2 6/7] platform/mellanox: Introduce support for Mellanox
 register access driver
Message-ID: <20180526204701.GF10172@fury>
References: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
 <1525675735-125547-4-git-send-email-vadimp@mellanox.com>
 <20180525003112.GC10172@fury>
 <HE1PR0502MB37530FE2CB64E415507244B1A2680@HE1PR0502MB3753.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0502MB37530FE2CB64E415507244B1A2680@HE1PR0502MB3753.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 11:15:35AM +0000, Vadim Pasternak wrote:
> 
> 
> > -----Original Message-----
> > From: Darren Hart [mailto:dvhart@infradead.org]
> > Sent: Friday, May 25, 2018 3:31 AM
> > To: Vadim Pasternak <vadimp@mellanox.com>
> > Cc: andy.shevchenko@gmail.com; gregkh@linuxfoundation.org; linux-
> > kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; jiri@resnulli.us;
> > Michael Shych <michaelsh@mellanox.com>; ivecera@redhat.com
> > Subject: Re: [PATCH v2 6/7] platform/mellanox: Introduce support for Mellanox
> > register access driver
> > 
> > On Mon, May 07, 2018 at 06:48:54AM +0000, Vadim Pasternak wrote:
> > > Introduce new Mellanox platform driver to allow access to Mellanox
> > > programmable device register space trough sysfs interface.
> > > The driver purpose is to provide sysfs interface for user space for
> > > the registers essential for system control and monitoring.
> > > The sets of registers for sysfs access are supposed to be defined per
> > > system type bases and include the registers related to system resets
> > > operation, system reset causes monitoring and some kinds of mux selection.
> > >
> > > Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> > > ---
> > 
> > One question on the attr init which I'm not familiar with... Andy, Greg - can you
> > offer your opinion below...
> > 
...
> > > +		priv->mlxreg_io_dev_attr[i].dev_attr.attr.mode =
> > > +						priv->pdata->data[i].mode;
> > > +		switch (priv->pdata->data[i].mode) {
> > 
> > This seemed a bit odd to me. Do we need to do this conditional assignment
> > within the kernel, or can these just be assigned, and the mode will guard against
> > the user being able to call store on a read only attr?
> > 
> > > +		case 0200:
> > > +			priv->mlxreg_io_dev_attr[i].dev_attr.store =
> > > +							mlxreg_io_attr_store;
> > > +			break;
> > > +
> > > +		case 0444:
> > > +			priv->mlxreg_io_dev_attr[i].dev_attr.show =
> > > +							mlxreg_io_attr_show;
> > > +			break;
> > > +
> > > +		case 0644:
> > > +			priv->mlxreg_io_dev_attr[i].dev_attr.show =
> > > +							mlxreg_io_attr_show;
> > > +			priv->mlxreg_io_dev_attr[i].dev_attr.store =
> > > +							mlxreg_io_attr_store;
> > > +			break;
> > 
> > If this is necessary, we can simplify this by checking for the read mask and the
> > write mask and setting each once - rather than duplicating this for r, w, and rw.
> > As it is a 0400 would not assign the show function, even though it is readable by
> > somebody.
> 
> Maybe I really can add something like
> static struct device_attribute mlxreg_io_devattr_rw = {
> 	.show	= mlxreg_io_attr_show,
> 	.store	= mlxreg_io_attr_store,
> };
> 
> And replace this whole switch statement just with:
> 		memcpy(&priv->mlxreg_io_dev_attr[i].dev_attr,
> 		       &mlxreg_io_devattr_rw, sizeof(struct device_attribute));

This is certainly preferable if it doesn't present any functional problems.
Seems to me it must be doable because the OS has to deny write for Group and
Other and allow for User with 644, similarly for read is other perm conditions.

-- 
Darren Hart
VMware Open Source Technology Center
