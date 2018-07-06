Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB978C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF86224F5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF86224F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933902AbeGFRhh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:37:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:57252 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932580AbeGFRhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:37:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 10:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,317,1526367600"; 
   d="scan'208";a="54568863"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2018 10:37:10 -0700
Message-ID: <66eff871bc97f24e7fbcc2494df1bb6fdd98d8da.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Date:   Fri, 06 Jul 2018 20:37:09 +0300
In-Reply-To: <20180705143921.6a8aeb50@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
         <20180704170310.56772d77@xhacker.debian>
         <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
         <20180705143921.6a8aeb50@xhacker.debian>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 14:39 +0800, Jisheng Zhang wrote:
> > On Wed, 2018-07-04 at 17:03 +0800, Jisheng Zhang wrote:

My comments below.

> > > For Synopsys DesignWare 8250 uart which version >= 4.00a, there's
> > > a
> > > valid divisor latch fraction register. The fractional divisor
> > > width is
> > > 4bits ~ 6bits.  
> > 
> > I have read 4.00a spec a bit and didn't find this limitation.
> > The fractional divider can fit up to 32 bits.
> 
> the limitation isn't put in the register description, but in the
> description
> about fractional divisor width configure parameters. Searching
> DLF_SIZE will
> find it.

Found, thanks.

> From another side, 32bits fractional div is a waste, for example,
> let's
> assume the fract divisor = 0.9, 
> if fractional width is 4 bits, DLF reg will be set to UP(0.9*2^4) =
> 15, the
> real frac divisor =  15/2^4 = 0.93;
> if fractional width is 32 bits, DLF reg will be set to UP(0.9*2^32) =
> 3865470567
> the real frac divisor = 3865470567/2^32 = 0.90;

So, your example shows that 32-bit gives better value. Where is
contradiction?

> > I would test this a bit later.

It reads back 0 on our hardware with 3.xx version of IP.
  
> > > +	unsigned int		dlf_size:3;  
> > 
> > These bit fields (besides the fact you need 5) more or less for
> > software
> > quirk flags. In your case I would rather keep a u32 value of DFL
> > mask as
> > done for msr slightly above in this structure.
> 
> OK. When setting the frac div, we use DLF size rather than mask, so
> could
> I only calculate the DLF size once then use an u8 value to hold the
> calculated DLF size rather than calculating every time?

Let's see below.

> > > +	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4),
> > > baud);  
> > 
> > If we have clock rate like 100MHz and 10 bits of fractional divider
> > it
> > would give an integer overflow.
> 
> This depends on the fraction divider width. If it's only 4~6 bits,
> then we are fine.

True.

> > 
> > 4 here is a magic. Needs to be commented / described better.
> 
> Yes. divisor = clk/(16*baud) = BRD(I) + BRD(F)
> "I" means integer, "F" means fractional
> 
> 2^dlf_size*clk/(16*baud) = 2^dlf_size*(BRD(I) + BRD(F))
> 
> clk*2^(dlf_size - 4)/baud = 2^dlf_size*((BRD(I) + BRD(F))
> 
> the left part is "DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4),
> baud)",
> let's assume it equals quot.
> 
> then, BRD(I) = quot / 2^dlf_size = quot >> dlf_size, this is where
> "quot >> d->dlf_size" below from.
> 
> BRD(F) = quot & dlf_mask = quot & (~0U >> (32 - dlf_size))

Yes, I understand from where it comes. It's a hard coded value of PS all
over the serial code.

And better use the same idiom as in other code, i.e. * 16 or / 16
depends on context.

> > > +	*frac = quot & (~0U >> (32 - d->dlf_size));
> > > +  
> > 
> > Operating on dfl_mask is simple as
> > 
> > u64 quot = p->uartclk * (p->dfl_mask + 1);
> 
> Since the dlf_mask is always 2^n - 1, 
> clk * (p->dlf_mask + 1) = clk << p->dlf_size, but the later
> is simpler
> 
> > 
> > *frac = div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
> > return quot;
> 
> quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud)
> *frac = quot & (~0U >> (32 - d->dlf_size))
> return quot >> d->dlf_size;
> 
> vs.
> 
> quot = p->uartclk * (p->dfl_mask + 1);
> *frac = div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
> return quot;
> 
> shift vs mul.
> 
> If the dlf width is only 4~6 bits, the first calculation can avoid
> 64bit div. I prefer the first calculation.

OK, taking that into consideration and looking at the code snippets
again I would to
 - keep two values

// mask we get for free because it's needed in intermediate calculus
//
and it doesn't overflow u8 (4-6 bits by spec)
u8 dlf_mask;
u8 dlf_size;

 - implement function like below

unsigned int quot;

/* Consider maximum possible DLF_SIZE, i.e. 6 bits */
quot = DIV_ROUND_CLOSEST(p->uartclk * 4, baud);

*frac = (quot >> (6 - dlf_size)) & dlf_mask;
return quot >> dlf_size;

Would you agree it looks slightly less complicated?

> > > +	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > > +	serial_dl_write(up, quot);  

(1)

> > 
> > At some point it would be a helper, I think. We can call
> > serial8250_do_set_divisor() here. So, perhaps we might export it.
> 
> serial8250_do_set_divisor will drop the frac, that's not we want ;)

Can you check again? What I see is that for DW 8250 the
_do_set_divisor() would be an equivalent to the two lines, i.e. (1).

And basically at the end it should become just those two lines when the
rest will implement their custom set_divisor().

> > This should use some helpers. I'll prepare a patch soon and send it
> > here, you may include it in your series.
> 
> Nice. Thanks.

Sent.

> > > +		d->dlf_size = fls(reg);  
> > 
> > Just save value itself as dfl_mask.
> 
> we use the dlf size during calculation, so it's better to hold the
> dlf_size
> instead.

See above.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
