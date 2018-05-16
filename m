Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeEPVIX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:08:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44823 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeEPVIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:08:21 -0400
X-Google-Smtp-Source: AB8JxZp07eDrFXUQ50ANRdTx0f4sZJC3+gYTx61C3XJKPgVL9Ezm4wIu7fbXrwaP9cCJ5niPk0Giug==
Date: Wed, 16 May 2018 14:08:17 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgross@suse.com, lyan@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH v3 2/2] Input: xen-kbdfront - allow better run-time
 configuration
Message-ID: <20180516210817.GF21971@dtor-ws>
References: <20180514144029.16019-1-andr2000@gmail.com>
 <20180514144029.16019-2-andr2000@gmail.com>
 <20180516171528.GD21971@dtor-ws>
 <e9882c52-3641-7c32-1f64-dd9c4f35de5f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9882c52-3641-7c32-1f64-dd9c4f35de5f@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 08:47:30PM +0300, Oleksandr Andrushchenko wrote:
> On 05/16/2018 08:15 PM, Dmitry Torokhov wrote:
> > Hi Oleksandr,
> > 
> > On Mon, May 14, 2018 at 05:40:29PM +0300, Oleksandr Andrushchenko wrote:
> > > @@ -211,93 +220,114 @@ static int xenkbd_probe(struct xenbus_device *dev,
> > >   	if (!info->page)
> > >   		goto error_nomem;
> > > -	/* Set input abs params to match backend screen res */
> > > -	abs = xenbus_read_unsigned(dev->otherend,
> > > -				   XENKBD_FIELD_FEAT_ABS_POINTER, 0);
> > > -	ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend,
> > > -						  XENKBD_FIELD_WIDTH,
> > > -						  ptr_size[KPARAM_X]);
> > > -	ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend,
> > > -						  XENKBD_FIELD_HEIGHT,
> > > -						  ptr_size[KPARAM_Y]);
> > > -	if (abs) {
> > > -		ret = xenbus_write(XBT_NIL, dev->nodename,
> > > -				   XENKBD_FIELD_REQ_ABS_POINTER, "1");
> > > -		if (ret) {
> > > -			pr_warn("xenkbd: can't request abs-pointer\n");
> > > -			abs = 0;
> > > -		}
> > > -	}
> > > +	/*
> > > +	 * The below are reverse logic, e.g. if the feature is set, then
> > > +	 * do not expose the corresponding virtual device.
> > > +	 */
> > > +	with_kbd = !xenbus_read_unsigned(dev->nodename,
> > > +					 XENKBD_FIELD_FEAT_DSBL_KEYBRD, 0);
> > > -	touch = xenbus_read_unsigned(dev->nodename,
> > > -				     XENKBD_FIELD_FEAT_MTOUCH, 0);
> > > -	if (touch) {
> > > +	with_ptr = !xenbus_read_unsigned(dev->nodename,
> > > +					 XENKBD_FIELD_FEAT_DSBL_POINTER, 0);
> > > +
> > > +	/* Direct logic: if set, then create multi-touch device. */
> > > +	with_mtouch = xenbus_read_unsigned(dev->nodename,
> > > +					   XENKBD_FIELD_FEAT_MTOUCH, 0);
> > > +	if (with_mtouch) {
> > >   		ret = xenbus_write(XBT_NIL, dev->nodename,
> > >   				   XENKBD_FIELD_REQ_MTOUCH, "1");
> > >   		if (ret) {
> > >   			pr_warn("xenkbd: can't request multi-touch");
> > > -			touch = 0;
> > > +			with_mtouch = 0;
> > >   		}
> > >   	}
> > Does it make sense to still end up calling xenkbd_connect_backend() when
> > all interfaces (keyboard, pointer, and multitouch) are disabled? Should
> > we do:
> > 
> > 	if (!(with_kbd || || with_ptr || with_mtouch))
> > 		return -ENXIO;
> > 
> > ?
> It does make sense. Then we probably need to move all xenbus_read_unsigned
> calls to the very beginning of the .probe, so no memory allocations are made
> which will be useless if we return -ENXIO, e.g. something like
> 
> static int xenkbd_probe(struct xenbus_device *dev,
>                   const struct xenbus_device_id *id)
> {
>     int ret, i;
>     bool with_mtouch, with_kbd, with_ptr;
>     struct xenkbd_info *info;
>     struct input_dev *kbd, *ptr, *mtouch;
> 
> <read with_mtouch, with_kbd, with_ptr here>
> 
> if (!(with_kbd | with_ptr | with_mtouch))
>         return -ENXIO;
> 
> Does the above looks ok?

Yes. Another option is to keep the check where I suggested and do

	if (...) {
		ret = -ENXIO;
		goto error;
	}

Whichever you prefer is fine with me.

Thanks.

-- 
Dmitry
