Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A5CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568AC20857
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568AC20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932821AbeGIJXd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:23:33 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35858 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932431AbeGIJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:23:31 -0400
Received: by mail-ua0-f196.google.com with SMTP id y8-v6so11278430uan.3;
        Mon, 09 Jul 2018 02:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtgZh7aWIm+e4IJUwxxS6DFphYJ6JhlG/9v1/DeW2C8=;
        b=PloS3/DlHloQiDPOy2igNmaynAIAbq6WCjvCFeTPluB++9Q/YIzyaI89ys4H0QRBTk
         Wy2MsWm99VNy4HR2M46Nzg2YQQbgzVVpJX+efbDYYDRmQ1VWxbihAiRvvZErYX3wsqST
         AqjEYb1Ygdxy8aIhPOWTlT9WB439qafXskKAUl/8xOo5l7IzJ5TBoD0EXyaUlnRGeuhi
         ZW5nDH2osanbgsTGw/74ioX0qzUnU46WXXF8TnxL5hRvjEw01yLCkQxd0j5qMYPDNj1N
         3NX9T1p2L1z/IwDnnXqJLh9jgG19fWyDHN8dSI6H2NGm2VdSq3KvWpb7luKy79r3LLfW
         yXyA==
X-Gm-Message-State: APt69E0pVLYsgijAoDo8JN3mR4Swj89I9fEm3nDCldANheR5/OAtsVo0
        F7ln0Rysw+6O+xVlvzGyQXg/OZ+JwJmPVSHdLhI=
X-Google-Smtp-Source: AAOMgpf26WJzp3VLAqTw0cpymxst/5RoXcUIGICh42oe4jn5HjlZkEtzXidxt14QGuGrjHQ42U6PQLthwSdVUSNY4TU=
X-Received: by 2002:ab0:221:: with SMTP id 30-v6mr2544654uas.26.1531128210652;
 Mon, 09 Jul 2018 02:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180709044444.6397-1-abrodkin@synopsys.com> <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
In-Reply-To: <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jul 2018 11:23:19 +0200
Message-ID: <CAMuHMdUdTNpt6G1gzdd6tg9cTo4+kOQCP0Ekouhogug_1sJNPg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
To:     David Laight <David.Laight@aculab.com>
Cc:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Greg KH <greg@kroah.com>, Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 11:15 AM David Laight <David.Laight@aculab.com> wrote:
> From: Alexey Brodkin
> > Sent: 09 July 2018 05:45
> > Depending on ABI "long long" type of a particular 32-bit CPU
> > might be aligned by either word (32-bits) or double word (64-bits).
> > Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> >
> > At least for 32-bit ARC cores ABI requires "long long" types
> > to be aligned by normal 32-bit word. This makes "data" field aligned to
> > 12 bytes. Which is still OK as long as we use 32-bit data only.
> >
> > But once we want to use native atomic64_t type (i.e. when we use special
> > instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> > misaligned access exception.
>
> Shouldn't there be a typedef for the actual type.
> Perhaps it is even atomic64_t ?
> And have the __aligned(8) applied to that typedef ??

That indeed sounds like the best thing to do, as it will fix this issue in other
places, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
