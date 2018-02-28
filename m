Return-Path: <mmoese@suse.de>
X-Google-Smtp-Source: AH8x224mHQTjcEii/BzAkipg/O/DQmkWWkl5S5IjfV6QZl6xu91ZFuFWfSkseZnSVDSKXqJbovLf
ARC-Seal: i=1; a=rsa-sha256; t=1519804598; cv=none;
        d=google.com; s=arc-20160816;
        b=JqRcTOmYANBGFK18olSVruWypT/yrr2380Jb4H7ykhSRQhD1Lvu2VQPTs5apVwIlWr
         IX9aQuoHlbC4K2TmZ5Cf2W44MZGKNLhlXm2jBvk6wyr0gXef93XnIbPffILaThGSBUzv
         2Nn9Mq4C33+PTg0vwbACrGC14GxwKVJTjjynCaYyN2LNPaFckdff1Om+NO6bfngwpaZ2
         AM3yLOZVHxsQ8c6+1ui6i09MZq8dCONQkBWeSMHjMwQ9zCrr36JC5MQWJudpgejvWVH6
         dWQKMduDw47BpxC4snblOkpLoX1TVHMUTWsVMCvI6m396aA66iMjbboe2Z9LM0eEFPqz
         ue8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=ix9fRneFvTElPm4SwAI4XYs3LJxqg7R1tDSmNDqTNro=;
        b=cVX8jKdHsG8BYPn0XrWRLH8A+v//DEjgmuPzNO72MNomJCIcIYayLZEx9rYv77D9Iz
         fSBPO4E5QYbTLlBVuSYjx7Nq3u+0imxAneUdkHUTkB8bpZouI6ZBjC+mdeZXEKMVAtOh
         kHJZAU/s82nwS9ojHCbXjaSYcI+cU9gyMzxsMGP4kNvHvrrX9UIV9A2ROa9asisUszlg
         5hQRp3NGaOmbi5WYHAWvZaE/64/N9xs2pJRFxFFsuqTzzCz36eDW+TMkrJhx4pHo+Hwj
         /6TcbdcSWSjqzZ8RNKea53pJqaiOZsOAixTwFzpumlj4WIBfmzm5rqpZaKFQTnDW2eSA
         fwTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mmoese@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mmoese@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mmoese@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mmoese@suse.de
Date: Wed, 28 Feb 2018 08:56:33 +0100
From: Michael Moese <mmoese@suse.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Andreas Geissler <andreas.geissler@men.de>,
	Ben Turner <ben.turner@21net.com>
Subject: Re: [PATCH] 8250-men-mcb: add support for 16z025 and 16z057
Message-ID: <20180228075633.zkqhiitxaeb5xlmi@linux.suse.de>
References: <20180227153106.3224-1-mmoese@suse.de>
 <CAHp75VddLV3Ke8J3hYw0wLO_77H8K20J_g=QeLG8B0XYt90ZRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VddLV3Ke8J3hYw0wLO_77H8K20J_g=QeLG8B0XYt90ZRA@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593568644699224821?=
X-GMAIL-MSGID: =?utf-8?q?1593630626096309328?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,
Thanks for your comments. Let me briefly respond.

On Tue, Feb 27, 2018 at 07:57:34PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 27, 2018 at 5:31 PM, Michael Moese <mmoese@suse.de> wrote:
> > -       else if  (strncmp(mdev->bus->name, "F216", 4) == 0)
> > +       else if (strncmp(mdev->bus->name, "F216", 4) == 0)
> 
> What's changed?
There were two spaces after that if.

> > +       switch (mdev->id) {
> > +       case MEN_UART_ID_Z125:
> > +               num_ports = 1U;
> > +               break;
> > +       case MEN_UART_ID_Z025:
> > +               num_ports = readb(membase) >> 4;
> > +               break;
> > +       case MEN_UART_ID_Z057:
> > +               num_ports = 4U;
> > +               break;
> > +       default:
> > +               dev_err(&mdev->dev, "no supported device!\n");
> > +               return -ENODEV;
> > +       }
> 
> (1)
> 
> > +               data[i].uart.port.mapbase = (unsigned long) mem->start
> > +                                           + (i * MEN_UART_MEM_SIZE);
> 
> Redundant parens.
Well, let me remove them. Gonna do a v2 anyway.

> 
> > +       switch (mdev->id) {
> > +       case MEN_UART_ID_Z125:
> > +               num_ports = 1U;
> > +               break;
> > +       case MEN_UART_ID_Z025:
> > +               num_ports = readb(data[0].uart.port.membase) >> 4;
> > +               break;
> > +       case MEN_UART_ID_Z057:
> > +               num_ports = 4U;
> > +               break;
> > +       default:
> > +               dev_err(&mdev->dev, "no supported device!\n");
> > +               return;
> > +       }
> 
> Can you deduplicate this with (1)?
Well, that sounds like a good idea. Will do this.

> -- 
> With Best Regards,
> Andy Shevchenko

Thanks,
Michael
-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
