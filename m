Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F247C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1C921480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1C921480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeHVS33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:29:29 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45961 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbeHVS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:29:28 -0400
Received: by mail-qt0-f194.google.com with SMTP id g44-v6so1726086qtb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 08:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FnfFr+Jm8bK9K32WfB8TUr6ib203wdkLbOcxKK71+I=;
        b=JfLFg0B3jsbR0DcdPKtCplElQxVTbymnvEaNdTkPGNXZ2rC7wxE9ggDvNiSNy6+EIs
         SomUU1yzIW52y7FfGWEmD/vwUHGM6XtNEk1/gH0glnsRkthQb6/D7dwsrL4Gs6mzM74W
         zkglw9IjKWna8t2MOFhVxU13Md06+zyf6kInQc3MOOzAgLGrmXffkBk9ps+n68rygRMY
         lb1/yt5GSNEPzV7J4tc/U3KpkZvj8jpMpzuZ4YcVuQeadDiT6lEAO+Qfhk4qpjdwCWqn
         VQObOP3+1aMQNiijVIdO5VcJdYBUZCDvL4Q8IS/bOn6aDBZ/3gSORA995Dw2s00+dsh7
         tjOA==
X-Gm-Message-State: APzg51CYFgH3Z23t4QFWpUviyI8kPEYXLQ3uHon5BD4MObrWgXQSBxh3
        CVNDO+If0lYs3UYwuYBELFv/nZRSzlAaMy77Ybg=
X-Google-Smtp-Source: ANB0VdYpPjsebv8vAcTqpVdkude0hi06Slk/1isO/3KF2F3gq1Neu2nMmVEpio5xyPxTSOe5kINR72+Qpn9f7bPlOZA=
X-Received: by 2002:ac8:6959:: with SMTP id n25-v6mr8175541qtr.9.1534950252587;
 Wed, 22 Aug 2018 08:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180821222416.7771-1-stefan@agner.ch> <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
 <77d139d225e16b90d9b8da1982a11707@agner.ch>
In-Reply-To: <77d139d225e16b90d9b8da1982a11707@agner.ch>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Aug 2018 17:03:56 +0200
Message-ID: <CAK8P3a0xNM6CK=rUUGX9eeO+OVrNGSYxiQ96gMVh6CrcpxVheg@mail.gmail.com>
Subject: Re: [PATCH] ARM: use choice for kernel unwinders
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 4:38 PM Stefan Agner <stefan@agner.ch> wrote:
> On 22.08.2018 12:02, Arnd Bergmann wrote:
> > On Wed, Aug 22, 2018 at 12:24 AM Stefan Agner <stefan@agner.ch> wrote:
> >
> > Looks ok to me. I've added it to my randconfig test environment, you
> > will hear from me within a day if I run into build regressions.
> >
> > We may still want to clean up these three lines:
> >
> > lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC &&
> > !ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !X86
> > lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
> > !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
> > lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
> > !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
> >
> > in which ARM is the odd case that currently depends on an architecture
> > specific rather than the architecture itself.
>
> I guess we would just follow X86 lead by saying ARM is guaranteed to
> have unwinding support, and hence we can add !ARM.

Right, that was the idea.

> > We could introduce a 'config ARCH_HAS_UNWINDER' symbol that gets
> > selected by mips, ppc, s390, microblaze, arm and x86 unconditionally,
> > and then simplify the 'select' statements here.
>
> Yeah I was thinking about something like that too.
>
> It seems to be a bit weird to me that lib/Kconfig.debug selects a
> specific stack unwinding technique...

This must be a historic artifact from the time when FRAME_POINTER
was the only unwinding method that existed. We may also have some
architectures that don't support any unwinding.

> Ideally other config symbol should just ask arch to make sure a
> unwinding technique is available (NEED_STACK_UNWINDING?) and arch then
> makes sure to provide a reasonable default.
>
> This then also would make it possible to select no stack unwinding in
> case arch supports that and all the users of stack unwinding are
> disabled too. Not sure how that exactly would look like in Kconfig, I
> was thinking like:
>
> choice
>     prompt "Choose kernel unwinder"
>     optional if !NEED_STACK_UNWINDING
>     default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
>     default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER
>
> But "optional if" does not exist yet :-)

You can write that as

choice
      prompt "Choose kernel unwinder" if NEED_STACK_UNWINDING

This will hide the prompt when NEED_STACK_UNWINDING is disabled,
making it impossible to pick one of the two unwinders.

> Reading the comments in arch/arm/Kconfig.debug seems to suggest that
> once upon a time it was possible to disable stack unwinding on ARM.
>
> But then, maybe we don't really want to go there? Might be interesting
> for tinification efforts.

I'd leave that for another day ;-)

      Arnd
