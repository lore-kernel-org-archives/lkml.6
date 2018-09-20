Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C287CECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3DB21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3DB21529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbeITROg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:14:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57318 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeITROg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:14:36 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5ABAFF70;
        Thu, 20 Sep 2018 11:31:32 +0000 (UTC)
Date:   Thu, 20 Sep 2018 13:31:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, jslaby@suse.com,
        LKML <linux-kernel@vger.kernel.org>, evgreen@chromium.org,
        saiprakash.ranjan@codeaurora.org,
        Doug Anderson <dianders@chromium.org>, swboyd@chromium.org,
        manojgupta@chromium.org, ani@arista.com
Subject: Re: [PATCH] sysrq: Use panic() to force a crash
Message-ID: <20180920113129.GA19892@kroah.com>
References: <20180919003147.55692-1-mka@chromium.org>
 <CAKwvOd=X1K4Gm0GyoDpmPTrTPQ_6+Nvzg9J8y4gdy-R=67_72A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=X1K4Gm0GyoDpmPTrTPQ_6+Nvzg9J8y4gdy-R=67_72A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:59:51AM -0700, Nick Desaulniers wrote:
> On Tue, Sep 18, 2018 at 5:32 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > sysrq_handle_crash() currently forces a crash by dereferencing a
> > NULL pointer, which is undefined behavior in C. Just call panic()
> > instead, which is simpler and doesn't depend on compiler specific
> > handling of the undefined behavior.
> >
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Not sure if it is strictly needed to release the RCU read lock now
> > that panic() is invoked directly (I couldn't repro the warning
> > without rcu_read_unlock()), but since this is a forced crash it
> > seems good practice to keep doing it.
> >
> > The commit that added rcu_read_unlock() and the comment is:
> >
> > commit 984cf355aeaa8f2eda3861b50d0e8d3e3f77e83b
> > Author: Ani Sinha <ani@arista.com>
> > Date:   Thu Dec 17 17:15:10 2015 -0800
> >
> >     sysrq: Fix warning in sysrq generated crash.
> >
> >     Commit 984d74a72076a1 ("sysrq: rcu-ify __handle_sysrq") replaced
> >     spin_lock_irqsave() calls with rcu_read_lock() calls in sysrq. Since
> >     rcu_read_lock() does not disable preemption, faulthandler_disabled() in
> >     __do_page_fault() in x86/fault.c returns false. When the code later calls
> >     might_sleep() in the pagefault handler, we get the following warning:
> >
> >     BUG: sleeping function called from invalid context at ../arch/x86/mm/fault.c:1187
> >     in_atomic(): 0, irqs_disabled(): 0, pid: 4706, name: bash
> >     Preemption disabled at:[<ffffffff81484339>] printk+0x48/0x4a
> >
> >     To fix this, we release the RCU read lock before we crash.
> >
> >     Tested this patch on linux 3.18 by booting off one of our boards.
> > ---
> >  drivers/tty/sysrq.c | 13 +++----------
> >  1 file changed, 3 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > index 06ed20dd01ba..d779a51499a0 100644
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -134,17 +134,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
> >
> >  static void sysrq_handle_crash(int key)
> >  {
> > -       char *killer = NULL;
> > -
> > -       /* we need to release the RCU read lock here,
> > -        * otherwise we get an annoying
> > -        * 'BUG: sleeping function called from invalid context'
> > -        * complaint from the kernel before the panic.
> > -        */
> > +       /* release the RCU read lock before crashing */
> 
> The comment probably could have stayed as is; folks will have to get
> context from git blame on the line immediately below now; while you
> added context in the patch file, it's below the line so wont be part
> of the commit message.
> 
> >         rcu_read_unlock();
> > -       panic_on_oops = 1;      /* force panic */
> > -       wmb();
> > -       *killer = 1;
> > +
> > +       panic("sysrq triggered crash\n");
> 
> Otherwise this part looks good. Maybe GKH can apply just this part
> rather than a v2 (if we even care about git blame on comments)?
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I can't pick and choose parts of a patch to apply, sorry.   Please fix
this up properly and resend it in the format that it should be applied
in.

thanks,

greg k-h
