Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEC7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715D5214FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715D5214FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeGDQKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:10:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:33549 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752567AbeGDQJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:09:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 09:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="52624450"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2018 09:08:23 -0700
Message-ID: <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 04 Jul 2018 19:08:22 +0300
In-Reply-To: <20180704170310.56772d77@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
         <20180704170310.56772d77@xhacker.debian>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 17:03 +0800, Jisheng Zhang wrote:

Thanks for an update, my comments below.

> For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> valid divisor latch fraction register. The fractional divisor width is
> 4bits ~ 6bits.

I have read 4.00a spec a bit and didn't find this limitation.
The fractional divider can fit up to 32 bits.

> Now the preparation is done, it's easy to add the feature support.
> This patch firstly checks the component version during probe, if
> version >= 4.00a, then calculates the fractional divisor width, then
> setups dw specific get_divisor() and set_divisor() hook.
 
> +#define DW_FRAC_MIN_VERS		0x3430302A

Do we really need this? 

My intuition (I, unfortunately, didn't find any evidence in Synopsys
specs for UART) tells me that when it's unimplemented we would read back
0's, which is fine.

I would test this a bit later.

> 

> +	unsigned int		dlf_size:3;

These bit fields (besides the fact you need 5) more or less for software
quirk flags. In your case I would rather keep a u32 value of DFL mask as
done for msr slightly above in this structure.

>  };
>  
> +/*
> + * For version >= 4.00a, the dw uarts have a valid divisor latch
> fraction
> + * register. Calculate divisor with extra 4bits ~ 6bits fractional
> portion.
> + */

This comment kinda noise. Better to put actual formula from datasheet
how this fractional divider is involved into calculus.

> +static unsigned int dw8250_get_divisor(struct uart_port *p,
> +				       unsigned int baud,
> +				       unsigned int *frac)
> +{
> +	unsigned int quot;
> +	struct dw8250_data *d = p->private_data;
> +

> +	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4),
> baud);

If we have clock rate like 100MHz and 10 bits of fractional divider it
would give an integer overflow.

4 here is a magic. Needs to be commented / described better.

> +	*frac = quot & (~0U >> (32 - d->dlf_size));
> +

Operating on dfl_mask is simple as

u64 quot = p->uartclk * (p->dfl_mask + 1);

*frac = div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
return quot;

(Perhaps some magic with types is needed, but you get the idea)

> +	return quot >> d->dlf_size;
> +}
> +
> +static void dw8250_set_divisor(struct uart_port *p, unsigned int
> baud,
> +			       unsigned int quot, unsigned int
> quot_frac)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +
> +	serial_port_out(p, DW_UART_DLF >> p->regshift, quot_frac);

It should use the helper, not playing tricks with serial_port_out().

> +	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> +	serial_dl_write(up, quot);

At some point it would be a helper, I think. We can call
serial8250_do_set_divisor() here. So, perhaps we might export it.

> +}
> +
>  static void dw8250_quirks(struct uart_port *p, struct dw8250_data
> *data)
>  {
>  	if (p->dev->of_node) {
> @@ -414,6 +445,28 @@ static void dw8250_setup_port(struct uart_port
> *p)
>  	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
>  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) &
> 0xff);
>  
> +	/*
> +	 * For version >= 4.00a, the dw uarts have a valid divisor
> latch
> +	 * fraction register. Calculate the fractional divisor width.
> +	 */
> +	if (reg >= DW_FRAC_MIN_VERS) {
> +		struct dw8250_data *d = p->private_data;
> +

> +		if (p->iotype == UPIO_MEM32BE) {
> +			iowrite32be(~0U, p->membase + DW_UART_DLF);
> +			reg = ioread32be(p->membase + DW_UART_DLF);
> +		} else {
> +			writel(~0U, p->membase + DW_UART_DLF);
> +			reg = readl(p->membase + DW_UART_DLF);
> +		}

This should use some helpers. I'll prepare a patch soon and send it
here, you may include it in your series.

I think you need to clean up back them. So the flow like

1. Write all 1:s
2. Read back the value
3. Write all 0:s

> +		d->dlf_size = fls(reg);

Just save value itself as dfl_mask.

> +
> +		if (d->dlf_size) {
> +			p->get_divisor = dw8250_get_divisor;
> +			p->set_divisor = dw8250_set_divisor;
> +		}
> +	}
> +
>  	if (p->iotype == UPIO_MEM32BE)
>  		reg = ioread32be(p->membase + DW_UART_CPR);
>  	else

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
