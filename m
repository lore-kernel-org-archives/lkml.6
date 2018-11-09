Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D273CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9390C20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pmv1WnNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9390C20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeKIXzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:55:48 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44865 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbeKIXzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:55:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so1414390lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLn+HK9QDuLOMgu6adkepEnVNp1iAcq2+lQnBNtoVOs=;
        b=Pmv1WnNzmqepX4C/1lwqdXj597aj15n+JvPJ6OzJ6XI4kPtAebeBII6UN8QVpfbYtW
         pKckBnTvlL/t8+XRCSSJSFNBTrxpTQjgltrU666jzBWMiTzcPjblrmurj7B6OW5n5n0T
         gY0UFzfr6UIB7o4ywoJHLsaxF6KcCerXOSSNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLn+HK9QDuLOMgu6adkepEnVNp1iAcq2+lQnBNtoVOs=;
        b=CFopgfjiHLQjuAcUy3pejWm94VNCk7vSi6w+qO3h0eepdcjxNlnqOCnqV7yOZV/REj
         nPwC+o3OaeL9aFGHJUdH6KU/Eh9SYRS4SlxBw64FAT51VReq1rQLPqRwW8zDxf4kBBLm
         dDgXyjY/vkbOY0meAnplzIdBKaVGEoX3Kz8SeYFU+dn78E5T11YS/+mD6o5DivZb2pJD
         Yh+aoU1OW+Gi58+5tua8JbVh48zOcPpRRwZ+MtMBEDAVxIydR0Gs77p617Vi3gPFn+Fk
         /9fbq//Rd1KIb3Wdu9MXv5tZZRV56t7Yb1uXj6K2QSiyl6GNY4X/DwZt6vcFqo5LEGBL
         2DCg==
X-Gm-Message-State: AGRZ1gL3WZ564ZodUJyEG4Ir5ia1rNJ+t8TuA2w/e9+IZj1lxY/oMGSI
        YcO3a+ofiyhy8aBKAOsfwGq3pSuMRpU=
X-Google-Smtp-Source: AJdET5fjojma/AVH/7iShLpzAsrXP+tJcBr6/OkrJEaDgQj/57TsOwINl8ZdjJ8qXzxbxAzS9X4gCg==
X-Received: by 2002:a19:4e59:: with SMTP id c86mr5760651lfb.132.1541772899217;
        Fri, 09 Nov 2018 06:14:59 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id o5-v6sm1330695ljh.75.2018.11.09.06.14.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 06:14:58 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id p86so1436966lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:14:58 -0800 (PST)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr5673962lfc.147.1541772510018;
 Fri, 09 Nov 2018 06:08:30 -0800 (PST)
MIME-Version: 1.0
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz> <20181108044510.GC2343@jagdpanzerIV>
 <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp> <20181109061204.GC599@jagdpanzerIV>
In-Reply-To: <20181109061204.GC599@jagdpanzerIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Nov 2018 08:08:13 -0600
X-Gmail-Original-Message-ID: <CAHk-=wizC7pn=+F5kNWaz65hb=meyVGLgkGGfZ82mNXp=-E=tQ@mail.gmail.com>
Message-ID: <CAHk-=wizC7pn=+F5kNWaz65hb=meyVGLgkGGfZ82mNXp=-E=tQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep messages.
To:     sergey.senozhatsky.work@gmail.com
Cc:     penguin-kernel@i-love.sakura.ne.jp, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dvyukov@google.com, Steven Rostedt <rostedt@goodmis.org>,
        glider@google.com, fengguang.wu@intel.com, jpoimboe@redhat.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 12:12 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> Dunno. I guess we still haven't heard from Linus because he did quite a good
> job setting up his 'email filters' ;)

Not filters, just long threads that I lurk on.

I don't actually care too much about this - the part I care about is
that when panics etc happen, things go out with a true best effort.

And "best effort" actually means "reality", not "theory". I don't care
one whit for some broken odd serial console that has a lock and
deadlocks if you get a panic just in the right place. I care about the
main printk/tty code doing the right thing, and avoiding the locks
with the scheduler and timers etc. So the timestamping and wakeup code
needing locks - or thinking you can delay things and print them out
later (when no later happens because you're panicing in an NMI) -
*that* is what I care deeply about.

Something like having a line buffering interface for random debugging
messages etc, I just don't get excited about. It just needs to be
simple enough and robust enough. You guys seem to be talking it out
ok.

             Linus
