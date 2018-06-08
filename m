Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gdeUD/1mGltqOQAAmS7hNA
	; Fri, 08 Jun 2018 11:22:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2DEC86089E; Fri,  8 Jun 2018 11:22:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9B04B607A4;
	Fri,  8 Jun 2018 11:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B04B607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeFHLWe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:22:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:37380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbeFHLWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:22:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0B12DAC7D;
        Fri,  8 Jun 2018 11:22:32 +0000 (UTC)
Date: Fri, 8 Jun 2018 13:22:30 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests
Message-ID: <20180608112230.77zsd5y7we7hiqei@pathway.suse.cz>
References: <20180604113708.11554-1-thierry.escande@linaro.org>
 <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz>
 <d9ecdf72-7500-66d4-0360-231218cccbb4@linaro.org>
 <20180608080437.n2b5nv73d3kp6yhb@pathway.suse.cz>
 <0fa30e13-c16f-95d8-d1ef-fd45e7a99888@linaro.org>
 <CAHp75Vc5_+Kxsvgws9Oq-hOgbQ8-ocxeKa4AuhC0uJ0oKsu+BA@mail.gmail.com>
 <a8ab166e-a2b9-b0fc-9717-ffd8fcbcd386@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8ab166e-a2b9-b0fc-9717-ffd8fcbcd386@linaro.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-06-08 12:32:33, Thierry Escande wrote:
> On 08/06/2018 11:46, Andy Shevchenko wrote:
> > On Fri, Jun 8, 2018 at 12:07 PM, Thierry Escande
> > <thierry.escande@linaro.org> wrote:
> > 
> > > But as I type I realize it's not necessary. I will simply enclose the call
> > > to wait_for_random_bytes() by #if IS_MODULE() #endif so it gets called only
> > > if built as a module, which is how run_kselftest.sh wants it... If
> > > test_printf is compiled built-in and the crng is not yet initialized the
> > > test will fail anyway so there is no need to add an extra check.
> > 
> > Unfortunately I can't support this as is.
> > We have environments where crng will be ready minutes after the boot.
> > It's unacceptable.
> > 
> > So, we need to have means to not delay test for so long.
> 
> I agree we can't delay test execution for too long. In my case the crng is
> ready only a few seconds after the boot. So we may just skip this plain 'p'
> printf test if crng is not ready then.

Alternative solution would be to accept
const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
as a valid result. It would make sense to print some warning in that case.

In each case, it would look ugly to use add_random_ready_callback()
wihtout passing a callback. If you really needed to check crng_ready(),
it would be better to make it public.

Best Regards,
Petr
