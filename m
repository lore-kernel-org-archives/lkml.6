Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pFG9G584GlvCFAAAmS7hNA
	; Fri, 08 Jun 2018 08:04:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 55DDB607A4; Fri,  8 Jun 2018 08:04:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C5765602FC;
	Fri,  8 Jun 2018 08:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5765602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeFHIEn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:04:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:40914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751138AbeFHIEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:04:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E9DA5AE54;
        Fri,  8 Jun 2018 08:04:38 +0000 (UTC)
Date: Fri, 8 Jun 2018 10:04:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH RESEND] lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests
Message-ID: <20180608080437.n2b5nv73d3kp6yhb@pathway.suse.cz>
References: <20180604113708.11554-1-thierry.escande@linaro.org>
 <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz>
 <d9ecdf72-7500-66d4-0360-231218cccbb4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ecdf72-7500-66d4-0360-231218cccbb4@linaro.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-06-07 20:47:25, Thierry Escande wrote:
> Hi Petr,
> 
> On 07/06/2018 14:24, Petr Mladek wrote:
> > On Mon 2018-06-04 13:37:08, Thierry Escande wrote:
> > > If the test_printf module is loaded before the crng is initialized, the
> > > plain 'p' tests will fail because the printed address will not be hashed
> > > and the buffer will contain '(ptrval)' instead.
> > > This patch adds a call to wait_for_random_bytes() before plain 'p' tests
> > > to make sure the crng is initialized.
> > 
> > Hmm, my system did not boot with this patch and
> > CONFIG_TEST_PRINTF=y
> > 
> > I guess that there was not enough entropy. It is basically a deadlock.
> > The build-in module init calls are called when SMP is enabled but
> > there is no real activity and the init calls are called sequentially.
> > Therefore there is nothing that could produce some entropy, ...
> > 
> > I suggest to skip the test when crng is not ready.
> 
> Thanks for pointing this out.
> 
> The issue is that the crng_ready() is not available outside of random.c.
> I'll leave the call to wait_for_random_bytes() if test_printf is compiled as
> a module and use add_random_ready_callback() to check if crng is initialized
> otherwise. Does that sound ok to you?

Great, I was not aware of add_random_ready_callback().

I suggest to make the decision in test_printf_init()
and run all tests either as the callback or immediately.

Best Regards,
Petr
