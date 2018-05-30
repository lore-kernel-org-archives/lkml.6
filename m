Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbeE3LZM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:25:12 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34777 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbeE3LZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:25:04 -0400
X-Google-Smtp-Source: ADUXVKK2MQzEEVrLWskicm0p9gWgH04HUO/GUzOX776pzXQJ7QjKAnhuxkcqrHo7yq1qO6aBkHU2ew==
Date: Wed, 30 May 2018 13:24:59 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] usb: gadget: ccid: add support for USB CCID
 Gadget Device
Message-ID: <20180530112459.GB2939@gmail.com>
References: <20180529185021.13738-1-marcus.folkesson@gmail.com>
 <CAHp75VeSbC3QBswCxZpoVpT4cL4pXC5eouCc9YtvBtXG3YddTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeSbC3QBswCxZpoVpT4cL4pXC5eouCc9YtvBtXG3YddTg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for your comments!
Many good catches here!

On Wed, May 30, 2018 at 03:55:39AM +0300, Andy Shevchenko wrote:
> On Tue, May 29, 2018 at 9:50 PM, Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> > Chip Card Interface Device (CCID) protocol is a USB protocol that
> > allows a smartcard device to be connected to a computer via a card
> > reader using a standard USB interface, without the need for each manufacturer
> > of smartcards to provide its own reader or protocol.
> >
> > This gadget driver makes Linux show up as a CCID device to the host and let a
> > userspace daemon act as the smartcard.
> >
> > This is useful when the Linux gadget itself should act as a cryptographic
> > device or forward APDUs to an embedded smartcard device.
> 
> > + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> 
> > + *
> 
> Redundant line
> 

Yep

> > +static DEFINE_IDA(ccidg_ida);
> 
> Where is it destroyed?

Hm, I'm not sure it needs to be destroyed. From lib/idr.c:

 * You can also use ida_get_new_above() if you need an ID to be allocated
 * above a particular number.  ida_destroy() can be used to dispose of an
 * IDA without needing to free the individual IDs in it.  You can use
 * ida_is_empty() to find out whether the IDA has any IDs currently allocated.


An empty ccidg_ida is the indication that we should clean up our
mess:

static void ccidg_free_inst(struct usb_function_instance *f)
...
	if (ida_is_empty(&ccidg_ida))
		ccidg_cleanup();

If the IDA is empty, should I call ida_destroy() anyway?
Other similiar drivers does not seems to do that.

I must say that I'm not very familiar with the IDA API.

> 
> > +               ccidg_class = NULL;
> > +               return PTR_ERR(ccidg_class);
> 
> Are you sure?

Heh, :-)

> 
> > +       if (!list_empty(head)) {
> > +               req = list_first_entry(head, struct usb_request, list);
> 
> list_first_entry_or_null()

Will do, thanks.

> 
> > +       req->length = len;
> 
> Perhaps assign this obly if malloc successedeed ?

Will do.

> 
> > +       req->buf = kmalloc(len, GFP_ATOMIC);
> 
> > +       if (req->buf == NULL) {
> 
> if (!req->buf) ?

Will do

> 
> > +               usb_ep_free_request(ep, req);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> 
> > +static void ccidg_request_free(struct usb_request *req, struct usb_ep *ep)
> > +{
> 
> > +       if (req) {
> 
> Is it even possible?
> 
> What about
> 
> if (!req)
>  return;
> 
> ?

Hmm, maybe it is not.
I think I remove this check.

> 
> > +               kfree(req->buf);
> > +               usb_ep_free_request(ep, req);
> > +       }
> > +}
> 
> > +                       *(__le32 *) req->buf = ccid_class_desc.dwDefaultClock;
> 
> Hmm... put_unaligned()? cpu_to_le32()? cpu_to_le32p()?
> 

Hmm, dwDefaultClock is already represented in little endian format. If I
use any of those functions, would not the byte order be swaped on a big
endian system?

dwDefaultClock is set as:
	.dwDefaultClock =	cpu_to_le32(3580),

I'm not sure what the best practice is here.

> > +                       *(__le32 *) req->buf = ccid_class_desc.dwDataRate;
> 
> Ditto.
> 
> > +               }
> > +               }
> 
> Indentation.

I remove the extra brackets from the case instead.
> 
> > +       /* responded with data transfer or status phase? */
> > +       if (ret >= 0) {
> 
> Why not
> 
> if (ret < 0)
>  return ret;
> 
> ?
> 

Will do

> > +       }
> > +
> > +       return ret;
> > +}
> 
> > +       atomic_set(&ccidg->online, 1);
> > +       return ret;
> 
> return 0; ?

Will do

> 
> > +       struct f_ccidg *ccidg;
> 
> > +       ccidg = container_of(inode->i_cdev, struct f_ccidg, cdev);
> 
> One line ?

The line exceeds 80 characters then, but I will put it like this:

	struct f_ccidg *ccidg = container_of(inode->i_cdev,
								struct f_ccidg, cdev);

> 
> > +       xfer = (req->actual < count) ? req->actual : count;
> 
> min_t()
> 

Thanks, will do

> > +       ret = wait_event_interruptible(bulk_dev->write_wq,
> > +               ((req = ccidg_req_get(ccidg, &bulk_dev->tx_idle))));
> > +
> > +       if (ret < 0)
> > +               return -ERESTARTSYS;
> 
> Redundant blank line above.
> 

I remove the extra blank line


> > +static void ccidg_function_free(struct usb_function *f)
> > +{
> 
> > +       struct f_ccidg_opts *opts;
> 
> > +       opts = container_of(f->fi, struct f_ccidg_opts, func_inst);
> 
> One line.

See above

> 
> 
> > +       mutex_lock(&opts->lock);
> > +       --opts->refcnt;
> 
> -- will work

Will do

> 
> > +       mutex_unlock(&opts->lock);
> > +}
> 
> > +       struct f_ccidg_opts *opts;
> 
> > +       opts = container_of(fi, struct f_ccidg_opts, func_inst);
> 
> Perhaps one line ?

See above


> > +       ++opts->refcnt;
> X++ would work as well.

Will do

> > +       struct f_ccidg_opts *opts;
> > +
> > +       opts = container_of(f, struct f_ccidg_opts, func_inst);
> 
> Perhaps one line?
> 

See above


> > +#define CCID_PINSUPOORT_NONE           0x00
> 
> (0 << 0)
> 
>  ?
> 
> for sake of consistency

Yep, will change

> 
> > +#define CCID_PINSUPOORT_VERIFICATION   (1 << 1)
> > +#define CCID_PINSUPOORT_MODIFICATION   (1 << 2)
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Best regards,
Marcus Folkesson
