Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E23C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91602089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4cbMOcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91602089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389190AbeKPQZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:25:50 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:33517 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeKPQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:25:50 -0500
Received: by mail-ua1-f45.google.com with SMTP id t8so191213uap.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 22:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzdSF647iqbefNCVxiSvHUbwkyyYuEACtF2iDJpNIzg=;
        b=Q4cbMOcpQSnJQyPBldPIgg9QcgtZtqMzo+xXh4sUxer66LJlYegphoNxRxypICVUY0
         OSTe72kelWwN5cPpjfl2NAO2DOyarXq8hqL+MOiP+VLLDky5+sYjeI0B4MfDPN7MhiXq
         qWxZI3KcXEN5qWjkrKke4K0zpbyhhyTEjayldcaLhPjwSSVbYi3nDOhjohQKZZCCO2jz
         8YA4St4SWkgUjfKyFOk9803gy8HWe/GJW04zbHL4GeAhz63RyuBm01/WIwpsW8a4DOZJ
         1hJ+pg6LINMWnwLHtqDGSXS0I5nNuv9hrrdLdKNqp3+BgrXYqrrNZMr7ztIwtyQzCOrN
         pRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzdSF647iqbefNCVxiSvHUbwkyyYuEACtF2iDJpNIzg=;
        b=pzkwmmJy3a7Nt2OgDJsgtZmBtcd9CkefOurWyo9eUqCtpahf7GoYQu+OdP5GejePdY
         /9OKxP89z7CkUx4g2Qv0lQhzcPI+Pfu17g+EfimrDDrHsBHumpqLlURLMa2bKROOFOjj
         3469g3Uhy4n0qwP3uXR0CillHTy9wkgzvPLyHKiu7XF3QswN0TVnQrsBswXuPkOUP6A2
         NntgOrpA2/DwPZLl50IUtf0p7gTh8BvsBXW2d6+74mRQpwSpGd762mumeXR4YzYWOAgu
         6uh/ovPW8jintWFDBdyGSTw2lx9+AOzRm9c/pongu3tlLOQbySflaCZdMasAbXo24ktg
         u0PQ==
X-Gm-Message-State: AGRZ1gJpB0s6WsdMVdt5X37JE5gcCOK19K6XmTwvO6CwIA+K+gjUbtWv
        mLVQ5lulhBxHTizSSutG1Kv4zq5tSfZWHKZdCMY=
X-Google-Smtp-Source: AJdET5eWf5eH6n64wPe6Rg35WlcUIoWefULQfDOV3zQK7Z7qPXDH6a8b6LmVUfZ2Feydh4mfTxYTkuJudD+0Uct2NRA=
X-Received: by 2002:ab0:8d9:: with SMTP id o25mr4300110uaf.127.1542348888362;
 Thu, 15 Nov 2018 22:14:48 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu>
In-Reply-To: <28496.1542300549@turing-police.cc.vt.edu>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 16 Nov 2018 11:44:36 +0530
Message-ID: <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
Subject: Re: [ARM64] Printing IRQ stack usage information
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        kernelnewbies@kernelnewbies.org,
        Jungseok Lee <jungseoklee85@gmail.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        mark.rutland@arm.com, Sungjinn Chung <barami97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018, 10:19 pm <valdis.kletnieks@vt.edu wrote:
>
> On Thu, 15 Nov 2018 18:52:39 +0530, Pintu Agarwal said:
>
> > Currently, when I tested this (as a proc interface), I got the below output:
> > CPU    UNUSED-STACK    ACTUAL-STACK
> >  0         16368                     16384
>
> > 3) How should I test it to get the different usage values for unused stack ?
> >     Can I get these values by implementing a sample interrupt handler,
> > and printing information from there?
>
> Hint 1:  If you're in a state where seq_printf() is legal, how many IRQ's are
> on this processor's IRQ stack?
>
> Hint 2:  What are the chances that some other CPU is currently in an IRQ?
> (run 'top' and look for what percent of time that's happening)
>
> Hint 3: what are the chances that the value of irq_stack_ptr is already stale
> by the time seq_printf() finishes running?
>
> Hint 4: what happens to the validity of your output if you get rescheduled
> in the middle of that for_each loop?
>
> (In other words, this code is terribly racy and is probably not going to answer
> whatever debugging question you were working on..

Okay. Thanks so much for your hints.
Yes, I understand that this code is horribly ugly and bad.
But this is only to understand if the below logic is fine to get the
irq stack usage:
{{{
        for_each_present_cpu(cpu) {
                irq_stack_ptr = IRQ_STACK_PTR(cpu);
                //unsigned long sp = current_stack_pointer;

                stack_start = (unsigned long)per_cpu(irq_stack, cpu);
                free_stack = irq_stack_ptr - stack_start;
                seq_printf(m, "%2d %10lu %10d\n", cpu, free_stack, actual);
        }
}}}
Of course, final plan is not the proc entry, but to find a relevant
place to invoke it, probably during boot time, or during backtrace.

> If your question is "Did one
> of the CPUs blow out its IRQ stack (or come close to doing so)?" there's better
> approaches.
>
Yes, exactly, this is what the main intention.
If you have any better idea about this approach, please refer me.
It will be of great help.

Thank You!

>
