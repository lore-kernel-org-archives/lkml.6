Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F00DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D60208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D60208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934568AbeGJQT1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:19:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:15989 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934501AbeGJQTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:19:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 09:19:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,335,1526367600"; 
   d="scan'208";a="73684449"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2018 09:19:22 -0700
Message-ID: <8c5b6bbbde12b0836e1f833c86b805a817596654.camel@linux.intel.com>
Subject: Re: [PATCH v4 3/3] serial: 8250_dw: add fractional divisor support
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Date:   Tue, 10 Jul 2018 19:19:21 +0300
In-Reply-To: <20180710111516.13b8c570@xhacker.debian>
References: <20180710110942.5b0a016e@xhacker.debian>
         <20180710111516.13b8c570@xhacker.debian>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 11:15 +0800, Jisheng Zhang wrote:
> For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> valid divisor latch fraction register. The fractional divisor width is
> 4bits ~ 6bits.
> 
> Now the preparation is done, it's easy to add the feature support.
> This patch firstly tries to get the fractional divisor width during
> probe, then setups dw specific get_divisor() and set_divisor() hook.

Thanks for an update, my comments below.

> +/*
> + * divisor = div(I) + div(F)
> + * "I" means integer, "F" means fractional
> + * quot = div(I) = clk / (16 * baud)
> + * frac = div(F) * 2^dlf_size
> + *
> + * let rem = clk % (16 * baud)
> + * we have: div(F) * (16 * baud) = rem
> + * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16
> * baud)
> + */
> +static unsigned int dw8250_get_divisor(struct uart_port *p,
> +				       unsigned int baud,
> +				       unsigned int *frac)
> +{

unsigned int base_baud = baud * 16;

> +	unsigned int quot, rem;
> +	struct dw8250_data *d = p->private_data;
> +
> +	quot = p->uartclk / (16 * baud);
> +	rem = p->uartclk % (16 * baud);
> +	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, 16 * baud);
> +

While it looks indeed better, I would rather like to have a confirmation
it's working as designed.

For example, when I did some calculus, I cooked a preliminary check in
Python (easy and fast to prototype), for example:
https://gist.github.com/andy-shev/06b084488b3629898121 in Python, or
commit 9df461eca18f ("spi: pxa2xx: replace ugly table by approximation")
in the kernel.

Or another one here https://gist.github.com/andy-shev/8b2a73aeca2874f4cc
89 and commits c1a67b48f6a5 ("serial: 8250_pci: replace switch-case by
formula for Intel MID"), 21947ba654a6 ("serial: 8250_pci: replace
switch-case by formula")

P.S. The code itself looks good to me, thanks!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
