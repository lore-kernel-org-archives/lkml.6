Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAFBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8253B21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8253B21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeIRNHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:07:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeIRNH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:07:29 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3A9ECAE;
        Tue, 18 Sep 2018 07:36:07 +0000 (UTC)
Date:   Tue, 18 Sep 2018 09:20:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/sysrq: Make local variable 'killer' in
 sysrq_handle_crash() global
Message-ID: <20180918072037.GA4442@kroah.com>
References: <20180917213304.44476-1-mka@chromium.org>
 <a75e8a5d-25d0-83b8-6f7c-b80e69985b60@suse.cz>
 <ebea1697-cf33-675b-172c-3e80303a9ee9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebea1697-cf33-675b-172c-3e80303a9ee9@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:28:39PM +0530, Sai Prakash Ranjan wrote:
> On 9/18/2018 11:41 AM, Jiri Slaby wrote:
> > On 09/17/2018, 11:33 PM, Matthias Kaehlcke wrote:
> > > sysrq_handle_crash() dereferences a NULL pointer on purpose to force
> > > an exception, the local variable 'killer' is assigned to NULL and
> > > dereferenced later. Clang detects the NULL pointer dereference at compile
> > > time and emits a BRK instruction (on arm64) instead of the expected NULL
> > > pointer exception. Change 'killer' to a global variable (and rename it
> > > to 'sysrq_killer' to avoid possible clashes) to prevent Clang from
> > > detecting the condition. By default global variables are initialized
> > > with zero/NULL in C, therefore an explicit initialization is not needed.
> > > 
> > > Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > Suggested-by: Evan Green <evgreen@chromium.org>
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >   drivers/tty/sysrq.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > > index 06ed20dd01ba..49fa8e758690 100644
> > > --- a/drivers/tty/sysrq.c
> > > +++ b/drivers/tty/sysrq.c
> > > @@ -132,10 +132,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
> > >   #define sysrq_unraw_op (*(struct sysrq_key_op *)NULL)
> > >   #endif /* CONFIG_VT */
> > > +char *sysrq_killer;
> > > +
> > >   static void sysrq_handle_crash(int key)
> > >   {
> > > -	char *killer = NULL;
> > > -
> > >   	/* we need to release the RCU read lock here,
> > >   	 * otherwise we get an annoying
> > >   	 * 'BUG: sleeping function called from invalid context'
> > > @@ -144,7 +144,7 @@ static void sysrq_handle_crash(int key)
> > >   	rcu_read_unlock();
> > >   	panic_on_oops = 1;	/* force panic */
> > >   	wmb();
> > > -	*killer = 1;
> > > +	*sysrq_killer = 1;
> > 
> > Just because a static analyzer is wrong? Oh wait, even compiler is
> > wrong. At least make it a static global. Or what about OPTIMIZER_HIDE_VAR?
> > 
> 
> static global does not work, clang still inserts brk. As for
> OPTIMIZE_HIDE_VAR, it seems to work.
> But, I dont think it is defined for clang in which case it defaults to using
> barrier(). There is already one wmb(), so will it be right?

Ick, why is this needed at all?  Why are we trying to "roll our own
panic" in this code?

thanks,

greg k-h
