Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD026C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6497A248C4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6497A248C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933453AbeFVUxv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754178AbeFVUxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:53:50 -0400
Received: from home.goodmis.org (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A770A248C2;
        Fri, 22 Jun 2018 20:53:48 +0000 (UTC)
Date:   Fri, 22 Jun 2018 16:53:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Thierry Escande <thierry.escande@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RESEND] lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests
Message-ID: <20180622205346.owyjk33wplzh7nhs@home.goodmis.org>
References: <20180604113708.11554-1-thierry.escande@linaro.org>
 <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 02:24:34PM +0200, Petr Mladek wrote:
> On Mon 2018-06-04 13:37:08, Thierry Escande wrote:
> > If the test_printf module is loaded before the crng is initialized, the
> > plain 'p' tests will fail because the printed address will not be hashed
> > and the buffer will contain '(ptrval)' instead.
> > This patch adds a call to wait_for_random_bytes() before plain 'p' tests
> > to make sure the crng is initialized.
> 
> Hmm, my system did not boot with this patch and
> CONFIG_TEST_PRINTF=y

And neither does my test box. It killed my tests I was running, as one of the
configs I test has this set.

It appears that Andrew pulled it in and sent it to Linus, as it is in
4.18-rc1, and I need to now revert this patch to make my tests work.

-- Steve


> 
> I guess that there was not enough entropy. It is basically a deadlock.
> The build-in module init calls are called when SMP is enabled but
> there is no real activity and the init calls are called sequentially.
> Therefore there is nothing that could produce some entropy, ...
> 
> I suggest to skip the test when crng is not ready.
> 
> Best Regards,
> Petr
> 
> > Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> > Acked-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  lib/test_printf.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/lib/test_printf.c b/lib/test_printf.c
> > index 71ebfa43ad05..839be9385a8a 100644
> > --- a/lib/test_printf.c
> > +++ b/lib/test_printf.c
> > @@ -260,6 +260,13 @@ plain(void)
> >  {
> >  	int err;
> >  
> > +	/*
> > +	 * Make sure crng is ready. Otherwise we get "(ptrval)" instead
> > +	 * of a hashed address when printing '%p' in plain_hash() and
> > +	 * plain_format().
> > +	 */
> > +	wait_for_random_bytes();
> > +
> >  	err = plain_hash();
> >  	if (err) {
> >  		pr_warn("plain 'p' does not appear to be hashed\n");
> > -- 
> > 2.14.1
> > 
