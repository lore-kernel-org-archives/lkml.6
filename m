Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELvdW7KaMkiOmKDX8ABP/BRtlK8C60I59H3pDxM6E4Exzdy+E1A5wcMk6dXrEYfBgWxIVHxP
ARC-Seal: i=1; a=rsa-sha256; t=1521029608; cv=none;
        d=google.com; s=arc-20160816;
        b=0SF8RFHN/sCZugIR3uePGkcY20X/AF7gNpzOw1Ed+7qBtpHIaGZN6Z2YXUekOy13qp
         nZe7dCcrU9T5RlLHiMYsMMKBxW9VzaLHccf4+a1REIJkKUiExm84lHYHGM3I6wz2Y6dy
         mmdPtgVatzuVj3INLBJdgjNi9vgEw+RakNNhU6bhINJYsllL6rPVQ7HRkvhw2B1qQ6n9
         hp31Oz5AQ/Qt7LWnK5m31fzNvzAaqiVxlgpbXPrZfLEbV9P3DGbYZvlewin4NVDiL0VG
         kGduLajn7mDl2WoTkq625wyTIhbsxbB6zVLN9NS0VGC7xYCsaVEuDvnI1maMzLncS6vC
         izeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=B4qO/Jvd17rJFeOUBTds+Wr15CkuB/VtpS813wGxZz0=;
        b=H4pCMD1RaF0Q+SiDfqnzAqwmE6k7r6M3NXvFUfTPVqBkKcuhSa2p2e+JeNTb/faMdL
         QhjzJcNqe1SzdjhPjWfaKUKc+v1bSFruekVGZ4urBOM5oaRN+j1jwv34ACCS6s4qqexT
         7dwT3DSvbMp48O9G1sNaWZf4wd4U5p5283yhvtmJJJu0tNtvA0or4d+RvPh80jUsUjoJ
         m19NaoHKSdHVQmWwo39TKsuT8RC+PWt7R8V62TPFdbug4a7pmblhutmW4TmzjaPDLN3a
         2adaBbcJTJ3wvgugFcsqzMJdb3kwMpMzaPsNgWH/QL41cyuOpW0B001EAV/AuaYJ61Wk
         KfQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="37985071"
Date: Wed, 14 Mar 2018 14:13:23 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v7 01/12] drivers: base: Unified device connection lookup
Message-ID: <20180314121323.GA10347@kuha.fi.intel.com>
References: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
 <20180312143431.82396-2-heikki.krogerus@linux.intel.com>
 <20180314111605.GA21241@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314111605.GA21241@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593820906030657716?=
X-GMAIL-MSGID: =?utf-8?q?1594915142996769013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:16:05PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 12, 2018 at 05:34:20PM +0300, Heikki Krogerus wrote:
> > Several frameworks - clk, gpio, phy, pmw, etc. - maintain
> > lookup tables for describing connections and provide custom
> > API for handling them. This introduces a single generic
> > lookup table and API for the connections.
> > 
> > The motivation for this commit is centralizing the
> > connection lookup, but the goal is to ultimately extract the
> > connection descriptions also from firmware by using the
> > fwnode_graph_* functions and other mechanisms that are
> > available.
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> > Changes in v7:
> > - API naming improvements suggested by Greg
> > - Prototypes to device.h, also suggested by Greg
> > - I removed the DEVCON() macro as it was not used yet and it needs to be
> >   rewritten
> > 
> > Changes in v6:
> > -Fix data and match arguments being swapped in __device_find_connection()
> >  call in device_find_connection() (as noticed by Jun Li)
> > 
> > Changes in v5:
> > -Add missing documentation for @list struct devcon member
> > 
> > Changes in v4:
> > -Add Andy's Reviewed-by
> > 
> > Changes in v3:
> > -Various spelling and gramar fixes in the docs pointed out by Randy Dunlap
> > 
> > Changes in v2:
> > -Add a (struct devcon) cast to the DEVCON() macro
> > ---
> >  Documentation/driver-api/device_connection.rst |  43 ++++++++
> >  drivers/base/Makefile                          |   3 +-
> >  drivers/base/devcon.c                          | 141 +++++++++++++++++++++++++
> >  include/linux/device.h                         |  22 ++++
> >  4 files changed, 208 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/driver-api/device_connection.rst
> >  create mode 100644 drivers/base/devcon.c
> > 
> > diff --git a/Documentation/driver-api/device_connection.rst b/Documentation/driver-api/device_connection.rst
> > new file mode 100644
> > index 000000000000..affbc5566ab0
> > --- /dev/null
> > +++ b/Documentation/driver-api/device_connection.rst
> > @@ -0,0 +1,43 @@
> > +==================
> > +Device connections
> > +==================
> > +
> > +Introduction
> > +------------
> > +
> > +Devices often have connections to other devices that are outside of the direct
> > +child/parent relationship. A serial or network communication controller, which
> > +could be a PCI device, may need to be able to get a reference to its PHY
> > +component, which could be attached for example to the I2C bus. Some device
> > +drivers need to be able to control the clocks or the GPIOs for their devices,
> > +and so on.
> > +
> > +Device connections are generic descriptions of any type of connection between
> > +two separate devices.
> > +
> > +Device connections alone do not create a dependency between the two devices.
> > +They are only descriptions which are not tied to either of the devices directly.
> > +A dependency between the two devices exists only if one of the two endpoint
> > +devices requests a reference to the other. The descriptions themselves can be
> > +defined in firmware (not yet supported) or they can be built-in.
> > +
> > +Usage
> > +-----
> > +
> > +Device connections should exist before device ``->probe`` callback is called for
> > +either endpoint device in the description. If the connections are defined in
> > +firmware, this is not a problem. It should be considered if the connection
> > +descriptions are "built-in", and need to be added separately.
> > +
> > +The connection description consists of the names of the two devices with the
> > +connection, i.e. the endpoints, and unique identifier for the connection which
> > +is needed if there are multiple connections between the two devices.
> > +
> > +After a description exists, the devices in it can request reference to the other
> > +endpoint device, or they can request the description itself.
> > +
> > +API
> > +---
> > +
> > +.. kernel-doc:: drivers/base/devcon.c
> > +   : functions: device_connection_find_match device_connection_find device_connection_add device_connection_remove
> > diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> > index e32a52490051..12a7f64d35a9 100644
> > --- a/drivers/base/Makefile
> > +++ b/drivers/base/Makefile
> > @@ -5,7 +5,8 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
> >  			   driver.o class.o platform.o \
> >  			   cpu.o firmware.o init.o map.o devres.o \
> >  			   attribute_container.o transport_class.o \
> > -			   topology.o container.o property.o cacheinfo.o
> > +			   topology.o container.o property.o cacheinfo.o \
> > +			   devcon.o
> >  obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
> >  obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
> >  obj-y			+= power/
> > diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
> > new file mode 100644
> > index 000000000000..e783c2c2ed1a
> > --- /dev/null
> > +++ b/drivers/base/devcon.c
> > @@ -0,0 +1,141 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/**
> > + * Device connections
> > + *
> > + * Copyright (C) 2018 Intel Corporation
> > + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +
> > +static DEFINE_MUTEX(devcon_lock);
> > +static LIST_HEAD(devcon_list);
> > +
> > +/**
> > + * device_connection_find_match - Find physical connection to a device
> > + * @dev: Device with the connection
> > + * @con_id: Identifier for the connection
> > + * @data: Data for the match function
> > + * @match: Function to check and convert the connection description
> > + *
> > + * Find a connection with unique identifier @con_id between @dev and another
> > + * device. @match will be used to convert the connection description to data the
> > + * caller is expecting to be returned.
> > + */
> > +void *device_connection_find_match(struct device *dev, const char *con_id,
> > +			       void *data,
> > +			       void *(*match)(struct device_connection *con,
> > +					      int ep, void *data))
> > +{
> > +	const char *devname = dev_name(dev);
> > +	struct device_connection *con;
> > +	void *ret = NULL;
> > +	int ep;
> > +
> > +	if (!match)
> > +		return NULL;
> > +
> > +	rcu_read_lock();
> 
> Wait, why are you using rcu at all for this?  This is not a "heavy"
> operation that you need to care about speed for, right?  Why get rcu
> involved at all in this type of thing?
> 
> Yes, the links in the driver core seem to be using rcu, which I didn't
> notice until right now, and I can't remember why or when that happened.
> Let's not make this more complex than it has to be please.

OK. Makes sense.

> Sorry I missed this the last review cycles.

Np. I'll prepare v8. This will not affect the other patches, so is it
enough if I just update this patch? Or do you prefer that I re-send
the whole series?


Thanks,

-- 
heikki
