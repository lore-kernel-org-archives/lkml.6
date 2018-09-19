Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08FFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1521523
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SecQZJp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC1521523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbeISXwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:52:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35629 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeISXwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:52:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id 205-v6so2180742pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=piiayEhrDbWnO0pP+Td+0EjbKrdv6SfOlL2o2U3++ww=;
        b=SecQZJp24lpZXSZ0pYXXEvwy75T9ex9b+IQ/IJNeppBEvnBM/HD1YOYZ5ZanWSO7k+
         8JXTuQdValx5qAG325Vivi8HtxkxaVpE+h+w/8TYnXA8sSHio5yamds4neLru+U20QZ1
         cCznybE6Q7vViiv2FPYd3rT1BqsK/nAKppqg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=piiayEhrDbWnO0pP+Td+0EjbKrdv6SfOlL2o2U3++ww=;
        b=C65fKuQe5w+bE7nm2ryR6ZFlvLxCpsXvM75yMq5Nh+JCEyipW+IRc1Te+iC47BKGIy
         XstaLM87f8zwWt045Tl1oA0dn8jPlfb9kAmsVZsX3s+NkDS6cvKesdHMeP1z1PT+hCSk
         XLqSclP8OXPUro1vJypq/1O3qEqp88fcrdWALGUC091fD371h6GAU7dyfDsHeG0zpaiJ
         PWwSetsnEzPPC/2gdQErC11V4RdUxR38C9Q/DrjSg4TkFfF0K6nuhd189+kT5qe/yo43
         VaxLXaR/uEze2GD2Ul7daON2kJG1iaBhB0XMWKcPnABMMTHNe9/i+dXpprbrRAoWaFFz
         LxiA==
X-Gm-Message-State: APzg51CjrqiF4vGV105yXnyKvyNC/NoxmWN/6dAigLVM11u2XgSsEaGW
        1fQZcvR3qO8T4xwLpVjC2i2gyA==
X-Google-Smtp-Source: ANB0VdYSrKOrJ47ziwEXaAB1L9VKXNRUCZvNwey5oKLcAbuI4MrKgig0RwZjTVUDYP9Er9LEgM2vyw==
X-Received: by 2002:a65:448a:: with SMTP id l10-v6mr34032151pgq.382.1537380776313;
        Wed, 19 Sep 2018 11:12:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 71-v6sm29318032pfx.182.2018.09.19.11.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 11:12:55 -0700 (PDT)
Date:   Wed, 19 Sep 2018 11:12:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        LKML <linux-kernel@vger.kernel.org>, evgreen@chromium.org,
        saiprakash.ranjan@codeaurora.org,
        Doug Anderson <dianders@chromium.org>, swboyd@chromium.org,
        manojgupta@chromium.org, ani@arista.com
Subject: Re: [PATCH] sysrq: Use panic() to force a crash
Message-ID: <20180919181255.GS22824@google.com>
References: <20180919003147.55692-1-mka@chromium.org>
 <CAKwvOd=X1K4Gm0GyoDpmPTrTPQ_6+Nvzg9J8y4gdy-R=67_72A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=X1K4Gm0GyoDpmPTrTPQ_6+Nvzg9J8y4gdy-R=67_72A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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

I changed the comment since I have doubts whether it is still correct
with this change. Previously panic() was invoked through the exception
handler, now it is called directly. On the x86 system on which I
tested the patch the warning is not shown when the unlock() is
commented out.

I'm happy to respin if folks think the warning might still be raised
without releasing the lock.
