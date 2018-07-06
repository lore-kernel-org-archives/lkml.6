Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDE8C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE20423C4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE20423C4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934180AbeGFRjh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:39:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:62173 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933633AbeGFRjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:39:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 10:39:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,317,1526367600"; 
   d="scan'208";a="53120091"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2018 10:39:30 -0700
Message-ID: <891eef6922d6ed2c69fa28241d047ae8fded7804.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Date:   Fri, 06 Jul 2018 20:39:30 +0300
In-Reply-To: <20180705145458.7e7d9b9f@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
         <20180704170310.56772d77@xhacker.debian>
         <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
         <20180705143921.6a8aeb50@xhacker.debian>
         <20180705145458.7e7d9b9f@xhacker.debian>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 14:54 +0800, Jisheng Zhang wrote:
> On Thu, 5 Jul 2018 14:39:21 +0800 Jisheng Zhang wrote:
> 
> <snip>
> 
> > >   
> > > > +	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > > > +	serial_dl_write(up, quot);    
> > > 
> > > At some point it would be a helper, I think. We can call
> > > serial8250_do_set_divisor() here. So, perhaps we might export
> > > it.  
> > 
> > serial8250_do_set_divisor will drop the frac, that's not we want ;)
> > 
> 
> And most importantly, serial8250_do_set_divisor() will set a wrong
> BRD(I)
> for fractional capable DW uarts. For example, clk = 25MHZ, baud =
> 115200.
> 
> In fractional capable DW uarts, we should set BRD(I) as
> 25000000/(16*115200) = 13
> 
> but serial8250_do_set_divisor() will set BRD(I) as
> DIV_ROUND_CLOSEST(25*1000000, 16*115200)) = 14

How come? It doesn't do any calculus (for DW 8250), it just writes few
registers based on input.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
