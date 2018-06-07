Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id z566KQkkGVvnXwAAmS7hNA
	; Thu, 07 Jun 2018 12:24:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9AC0C6089E; Thu,  7 Jun 2018 12:24:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F296A601B4;
	Thu,  7 Jun 2018 12:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F296A601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeFGMYi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:24:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:43440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752972AbeFGMYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:24:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5A6B8ABF9;
        Thu,  7 Jun 2018 12:24:36 +0000 (UTC)
Date: Thu, 7 Jun 2018 14:24:34 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH RESEND] lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests
Message-ID: <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz>
References: <20180604113708.11554-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604113708.11554-1-thierry.escande@linaro.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-06-04 13:37:08, Thierry Escande wrote:
> If the test_printf module is loaded before the crng is initialized, the
> plain 'p' tests will fail because the printed address will not be hashed
> and the buffer will contain '(ptrval)' instead.
> This patch adds a call to wait_for_random_bytes() before plain 'p' tests
> to make sure the crng is initialized.

Hmm, my system did not boot with this patch and
CONFIG_TEST_PRINTF=y

I guess that there was not enough entropy. It is basically a deadlock.
The build-in module init calls are called when SMP is enabled but
there is no real activity and the init calls are called sequentially.
Therefore there is nothing that could produce some entropy, ...

I suggest to skip the test when crng is not ready.

Best Regards,
Petr

> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> Acked-by: Tobin C. Harding <me@tobin.cc>
> ---
>  lib/test_printf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 71ebfa43ad05..839be9385a8a 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -260,6 +260,13 @@ plain(void)
>  {
>  	int err;
>  
> +	/*
> +	 * Make sure crng is ready. Otherwise we get "(ptrval)" instead
> +	 * of a hashed address when printing '%p' in plain_hash() and
> +	 * plain_format().
> +	 */
> +	wait_for_random_bytes();
> +
>  	err = plain_hash();
>  	if (err) {
>  		pr_warn("plain 'p' does not appear to be hashed\n");
> -- 
> 2.14.1
> 
