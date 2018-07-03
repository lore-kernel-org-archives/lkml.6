Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66ECC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F56F24BBA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F56F24BBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeGCNDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:03:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:7805 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752494AbeGCNDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:03:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 06:03:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,303,1526367600"; 
   d="scan'208";a="53741311"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 03 Jul 2018 06:02:58 -0700
Message-ID: <db3f1fbf30b1b2adcf9a6e1a84b21d9fd6c1bcf2.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] serial: 8250_dw: add fractional divisor support
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Tue, 03 Jul 2018 16:02:57 +0300
In-Reply-To: <20180703102257.678db6a8@xhacker.debian>
References: <20180702180428.331b36c5@xhacker.debian>
         <fef0bf484ead5e0998666168ced86438bf935ce5.camel@linux.intel.com>
         <59b14f97234271a7d859fa07f27bd66ec252ccc9.camel@linux.intel.com>
         <20180703102257.678db6a8@xhacker.debian>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 10:22 +0800, Jisheng Zhang wrote:
> Hi,
> 
> On Mon, 2 Jul 2018 14:51:03 +0300 Andy Shevchenko wrote:
> 
> > On Mon, 2018-07-02 at 13:18 +0300, Andy Shevchenko wrote:
> > > On Mon, 2018-07-02 at 18:04 +0800, Jisheng Zhang wrote:  
> > > > For Synopsys DesignWare 8250 uart which version >= 4.00a,
> > > > there's a
> > > > valid divisor latch fraction register. The fractional divisor
> > > > width
> > > > is
> > > > 4bits ~ 6bits.
> > > >   
> > > 
> > > There are several serial IPs that have fractional divider built-
> > > in.
> > > None
> > > is using any specific hooks. Why do you need in your case, esp.
> > > taking
> > > into consideration that we have a custom ->set_termios()
> > > callback?  
> > 
> > Okay, I see that in 8250 we have hooks embedded into 8250_port.c
> > which
> > is not the best solution.
> > 
> > For example it prevents better splitting Exar code.
> > So, we would need these hooks, but better to integrate them in the
> > same
> > way like it's done for the rest of 8250 ones, i.e.
> > - rename existing to have a "do" word
> > - create new functions which would be a replacement that choose
> > between
> > "do" variant and custom one
> > - not sure if we need to export "do" variants (at least for now)
> 
> So you mean add the support as following:
> 
> 1.rename current serial8250_set_divisor as serial8250_do_set_divisor
> 

Yes

> 2.add a new serial8250_set_divisor which will be as simple as

Yes and no. 

> 
> static void serial8250_set_divisor(struct uart_port *port, ...)
> {
> 	struct uart_8250_port *up = up_to_u8250p(port);
> 
> 	if (up->set_divisor)

port->

> 		up->set_divisor(...);

port->

> 	else
> 		serial8250_do_set_divisor(...);
> }
> 
> could you please confirm?

Yes.

> 
> Another issue is I'm not sure which struct to add the hook,
> struct uart_port or struct uart_8250_port? Currently, it seems that
> only
> uart_8250_port needs this hook,

Define "needs". 8250 _uses_ it, the rest which I easy grepped would be
able to use it if we provide such a possibility.

lantiq.c is one example (currently they don't use it), or
drivers/tty/serial/digicolor-usart.c limits baud rate choice b/c of
absence of a common way.

>  sure, adding the hook to struct uart_port
> is fine either. Could you please kindly give some suggestions?

See above. Thanks for doing this!

> 
> Thanks,
> Jisheng

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
