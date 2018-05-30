Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968296AbeE3Azn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 20:55:43 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38521 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964788AbeE3Azk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 20:55:40 -0400
X-Google-Smtp-Source: ADUXVKLPV+A2DKAANyiDdPhpgArNQrLENza8XSRuOSBxnMJopjUcvXySVcJy96JYgJaWBYkmzeOBSKh+BVJHJalUUA4=
MIME-Version: 1.0
In-Reply-To: <20180529185021.13738-1-marcus.folkesson@gmail.com>
References: <20180529185021.13738-1-marcus.folkesson@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 May 2018 03:55:39 +0300
Message-ID: <CAHp75VeSbC3QBswCxZpoVpT4cL4pXC5eouCc9YtvBtXG3YddTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] usb: gadget: ccid: add support for USB CCID Gadget Device
To: Marcus Folkesson <marcus.folkesson@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 9:50 PM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> Chip Card Interface Device (CCID) protocol is a USB protocol that
> allows a smartcard device to be connected to a computer via a card
> reader using a standard USB interface, without the need for each manufacturer
> of smartcards to provide its own reader or protocol.
>
> This gadget driver makes Linux show up as a CCID device to the host and let a
> userspace daemon act as the smartcard.
>
> This is useful when the Linux gadget itself should act as a cryptographic
> device or forward APDUs to an embedded smartcard device.

> + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>

> + *

Redundant line

> +static DEFINE_IDA(ccidg_ida);

Where is it destroyed?

> +               ccidg_class = NULL;
> +               return PTR_ERR(ccidg_class);

Are you sure?

> +       if (!list_empty(head)) {
> +               req = list_first_entry(head, struct usb_request, list);

list_first_entry_or_null()

> +       req->length = len;

Perhaps assign this obly if malloc successedeed ?

> +       req->buf = kmalloc(len, GFP_ATOMIC);

> +       if (req->buf == NULL) {

if (!req->buf) ?

> +               usb_ep_free_request(ep, req);
> +               return ERR_PTR(-ENOMEM);
> +       }

> +static void ccidg_request_free(struct usb_request *req, struct usb_ep *ep)
> +{

> +       if (req) {

Is it even possible?

What about

if (!req)
 return;

?

> +               kfree(req->buf);
> +               usb_ep_free_request(ep, req);
> +       }
> +}

> +                       *(__le32 *) req->buf = ccid_class_desc.dwDefaultClock;

Hmm... put_unaligned()? cpu_to_le32()? cpu_to_le32p()?

> +                       *(__le32 *) req->buf = ccid_class_desc.dwDataRate;

Ditto.

> +               }
> +               }

Indentation.

> +       /* responded with data transfer or status phase? */
> +       if (ret >= 0) {

Why not

if (ret < 0)
 return ret;

?

> +       }
> +
> +       return ret;
> +}

> +       atomic_set(&ccidg->online, 1);
> +       return ret;

return 0; ?

> +       struct f_ccidg *ccidg;

> +       ccidg = container_of(inode->i_cdev, struct f_ccidg, cdev);

One line ?

> +       xfer = (req->actual < count) ? req->actual : count;

min_t()

> +       ret = wait_event_interruptible(bulk_dev->write_wq,
> +               ((req = ccidg_req_get(ccidg, &bulk_dev->tx_idle))));
> +
> +       if (ret < 0)
> +               return -ERESTARTSYS;

Redundant blank line above.

> +static void ccidg_function_free(struct usb_function *f)
> +{

> +       struct f_ccidg_opts *opts;

> +       opts = container_of(f->fi, struct f_ccidg_opts, func_inst);

One line.


> +       mutex_lock(&opts->lock);
> +       --opts->refcnt;

-- will work

> +       mutex_unlock(&opts->lock);
> +}

> +       struct f_ccidg_opts *opts;

> +       opts = container_of(fi, struct f_ccidg_opts, func_inst);

Perhaps one line ?
> +       ++opts->refcnt;
X++ would work as well.
> +       struct f_ccidg_opts *opts;
> +
> +       opts = container_of(f, struct f_ccidg_opts, func_inst);

Perhaps one line?

> +#define CCID_PINSUPOORT_NONE           0x00

(0 << 0)

 ?

for sake of consistency

> +#define CCID_PINSUPOORT_VERIFICATION   (1 << 1)
> +#define CCID_PINSUPOORT_MODIFICATION   (1 << 2)

-- 
With Best Regards,
Andy Shevchenko
