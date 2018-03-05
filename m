Return-Path: <mmoese@suse.de>
X-Google-Smtp-Source: AG47ELvWaMetjJauIoy5nrjvfCna2tm/bBEazzzlHNc89vO18XG+PU2tg6dI97V0C1+DzkNqtV8D
ARC-Seal: i=1; a=rsa-sha256; t=1520263332; cv=none;
        d=google.com; s=arc-20160816;
        b=E2qAmCnxyEuR3uMXxjGoi0C1MdRLezkg+CM7uhZjYK6+CC/Gb8gCtjm/s3SAxe0Wcv
         Tnm8zeCXkRTNHR6kKIA7k7sSK7hWdL4WSkkXza+KN5/Yy+5O8G8jPokX0NGIXdnt2dkm
         LKA2FO6aPBnuwwkZjCRORSewaGkEh+UCXucNXWToWOhhDTOA9G6IT/B3nIrLk02o8xds
         cSyMYi3fcl0IUPJsiv8P2FFtezmRceW6fNumoeCFQG85Xumrfi0VPW2tYlk/BJxC5z64
         jl0e9D52KReHv+q+e0sLJcAawrsD2JvGdCWzLoNKYNWYAI8EOaaxtvyD3F+gVJSf431M
         Dd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=dM8JcY6HXfiarys8P+QWKFdKyPEPKZk0qm/RMUnuYBs=;
        b=w6mJWvj9UZuLjiVnOgqr/xxf+fMZ7OM1/vKNiM0ujs9o0mGd/2rdWU4WcEoF1z3CfA
         JxYnpubsRkM9ZYaCXWkjKXrC4eRrKKPeaa1mR6+LNjSISyIjgccGFWF7o1ZhIx9+IYE3
         9QlOq/IZhV41/DgG2I+3bldg1BFfhWK4RGaijcRchl4sEULM3xw61NRyyKAz1WX21J94
         o77yCyFN5FZFm3cxURADA/4Yh0mUGyk3va9t6EMCaagqxDBdTAfrz97jYGu2/GmwdfFp
         KtD5IFggf3yKXvOqJVkYLjFJ1F0O2s5ocn5hdudmiGjZjsBsf2An6LNw2qPCt8fy12/I
         MVvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mmoese@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mmoese@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mmoese@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mmoese@suse.de
Date: Mon, 5 Mar 2018 16:22:11 +0100
From: Michael Moese <mmoese@suse.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Andreas Geissler <andreas.geissler@men.de>,
	Ben Turner <ben.turner@21net.com>
Subject: Re: [PATCH v3] 8250-men-mcb: add support for 16z025 and 16z057
Message-ID: <20180305152211.x423tgtwfanuwvwo@linux.suse.de>
References: <20180305082235.12777-1-mmoese@suse.de>
 <CAHp75VfVm5B7NawwYdzNFkCgJG+2Ht8pkAL0Drr08GJ+p2ZVow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfVm5B7NawwYdzNFkCgJG+2Ht8pkAL0Drr08GJ+p2ZVow@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594085248786012954?=
X-GMAIL-MSGID: =?utf-8?q?1594111644004604325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, sorry.. my bad. Not my day today. I forgot to commit :/

I'll resend.

On Mon, Mar 05, 2018 at 05:17:04PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 5, 2018 at 10:22 AM, Michael Moese <mmoese@suse.de> wrote:
> > Add support for two MEN UARTs (16z025 and 16z057) to the
> > 8250_men_mcb driver.
> > The 16z025 consists of up to four ports, the 16z057 has
> > exactly four ports. Apart from that, all of them share the
> > Port settings.
> 
> > Changes to v2:
> > Added include of linux/io.h due to finding of kbuild robot.
> 
> Hmm... Is it there?
> 
> >  static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
> >                                      const struct mcb_device_id *id)
> >  {
> 
> >         mem = mcb_get_resource(mdev, IORESOURCE_MEM);
> 
> >         if (mem == NULL)
> >                 return -ENXIO;
> 
> Redundant.
> 
> > +       membase = devm_ioremap_resource(&mdev->dev, mem);
> > +       if (IS_ERR(membase))
> > +               return PTR_ERR_OR_ZERO(membase);
> 
> > +       for (i = 0; i < num_ports; i++) {
> 
> > +               /* ok, register the port */
> > +               data[i].line = serial8250_register_8250_port(&data[i].uart);
> > +               if (data[i].line < 0) {
> > +                       dev_err(&mdev->dev, "unable to register UART port\n");
> > +                       return data[i].line;
> > +               }
> > +               dev_info(&mdev->dev, "found MCB UART: ttyS%d\n", data[i].line);
> 
> Consider to use  struct uart_port::name instead.
> 
> > +       }
> >
> >         return 0;
> >  }
> >
> >  static void serial_8250_men_mcb_remove(struct mcb_device *mdev)
> >  {
> 
> > +       if (!data)
> > +               return;
> 
> When it's possible?
> 
> >  }
> 
> -- 
> With Best Regards,
> Andy Shevchenko


-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
