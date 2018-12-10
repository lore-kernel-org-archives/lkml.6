Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B73C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6738E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gHVqSDRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6738E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeLJSti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:49:38 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43704 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJSth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:49:37 -0500
Received: by mail-yb1-f196.google.com with SMTP id d136so1347404ybh.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czGEULu+vFz98WODjbJNT9XWTwaPmj7cnfc+RRTbl24=;
        b=gHVqSDRPAI2mewydtk8kXx7GuQyE8B2ZgfuXUWr0yNBp33QzhXU1uE7JQyshTWF5kM
         jw8QNr3VA/00GFk85lmulu5ECqcON3U5WmUFQztnG2iK0qCyxIM8xA8y8cJ77NkRVOw7
         fpcGwkUkrT2u2SW1wOaKCbs/nTt01VkDUbcN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czGEULu+vFz98WODjbJNT9XWTwaPmj7cnfc+RRTbl24=;
        b=Vqw+yv9dDjSYTUjpqMY8r0gxR5n0NaaHazfV22nnq2M2ksHaI3wu8u3R986tlyh7uj
         HHecXeL7FXpKznTvolYwetq1ODE/aF1kslF6dS0fB3Q3C4JKZ06qPSocSBqNL2mOHyIt
         2i5NHOEQ6SbDJ2GPKbBEgHPkiqDL+9i7Ly0hlhJr8PYPSx8LeoN8t/T2rGNsrEYEn+rM
         CcSf9G1S0OaovGTJKaxT4q4ksQAqXk9ZlYxlvxtCfiEueF/e8PJXm4LqpVNydr7fcGta
         BvJOdfoR4PHhKOglFa8kkAq76Mds0dBqzEukPZp0l3emWJMLuGDFBTT6UxGBTlyF0a7t
         72uA==
X-Gm-Message-State: AA+aEWZ8AfyD8JwGoIfLACAh676qrgu6zT13x6aY7iX47bQ/tem5y/To
        0Hnqp4TtHb+VxrlRkULUc/OrM2Di0Wg=
X-Google-Smtp-Source: AFSGD/Wi9oFqfIu7FuaJUWCrwL14Nfo6nvQo1QvMBEiO9CMxofG8bKooA6HL1McTFiCKFol//CMTEQ==
X-Received: by 2002:a25:2501:: with SMTP id l1mr13071315ybl.258.1544467775918;
        Mon, 10 Dec 2018 10:49:35 -0800 (PST)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id i128sm4106239ywb.82.2018.12.10.10.49.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 10:49:34 -0800 (PST)
Received: by mail-yw1-f46.google.com with SMTP id l200so4376431ywe.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 10:49:34 -0800 (PST)
X-Received: by 2002:a81:98e:: with SMTP id 136mr13236038ywj.47.1544467773942;
 Mon, 10 Dec 2018 10:49:33 -0800 (PST)
MIME-Version: 1.0
References: <1544176279-77828-1-git-send-email-feng.tang@intel.com> <20181210131729.04b8e0d3@gandalf.local.home>
In-Reply-To: <20181210131729.04b8e0d3@gandalf.local.home>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Dec 2018 10:49:22 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJrC5J7YNJ24JNNkNTRr7qRfQa+x+dePC0OOrpcEJFwaA@mail.gmail.com>
Message-ID: <CAGXu5jJrC5J7YNJ24JNNkNTRr7qRfQa+x+dePC0OOrpcEJFwaA@mail.gmail.com>
Subject: Re: [PATCH v4] panic: Avoid the extra noise dmesg
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:17 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri,  7 Dec 2018 17:51:19 +0800
> Feng Tang <feng.tang@intel.com> wrote:
>
> > When kernel panic happens, it will first print the panic call stack,
> > then the ending msg like:
> >
> > [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> > [   35.749975] ------------[ cut here ]------------
> >
> > The above message are very useful for debugging.
> >
> > But if system is configured to not reboot on panic, say the "panic_timeout"
> > parameter equals 0, it will likely print out many noisy message like
> > WARN() call stack for each and every CPU except the panic one, messages
> > like below:
>
>
> > Keeping the interrupt disabled will avoid the noisy message.
> >
> > When code runs to this point, it means user has chosed to not reboot, or
> > do any special handling by using the panic notifier method, the only reason
> > to enable the interrupt may be sysrq migic key and panic_blink function
> > (though may not work even with irq enabled).
> >
> > So make the irq disabled by default and add a cmdline parameter
> > "panic_keep_irq_on" to turn it on when needed.
> >
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> >
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I'm fine with the new boot param, but I think we need to leave it how
it was by default: systems that want to see the blinking aren't going
to have a screen to read about what boot param they need to add.
Currently, we'll blink and spew extra warnings. With this patch we'll
not blink and not spew: a headless machine will have no indication
that a panic happened.

-Kees

--
Kees Cook
