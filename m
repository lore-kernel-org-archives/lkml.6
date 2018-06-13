Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E8388C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAF2208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YLGWeG5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAF2208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935756AbeFMOAv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:00:51 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55796 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934436AbeFMOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:00:49 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so3805069itl.5;
        Wed, 13 Jun 2018 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+NxCB/JxznDaH0WU/TqeygV0MEcoJ45yCWrp8f8T0g=;
        b=YLGWeG5+E1Qhr9lZHyOyhAY6R9IcDon+/PJERr1mHktKAoqqN4TK4xoZrE9tpVrtRf
         OSH+pAx5e1GWYHHuRYMyXTpN+mD+iesX+60IaSFNwRfXs+SwhU+3ukqMZPqmAqblbY7m
         QzZWG8Z4d6OOVZADWIX1jSE4/Q5oz8qjEsYq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+NxCB/JxznDaH0WU/TqeygV0MEcoJ45yCWrp8f8T0g=;
        b=lvUXyAjT1JT8HMM63VdU2wL+bmEP5FHcLmn8+RHfjoyXn7lD/p8ce7W6nsmzJ2ZRwO
         lnmsfBknjqSRMIPRkhIFGTM54FyUsXKWjBgZRCGrsAC4srQLIAK3qInHQJl2qNsMyVf+
         xOqT6X//v3IuKtxtYKQyjnr37E1dk9dYGNDRfTwi/kpa61WCuBvylqQ/jYHJ4oAit+2a
         ys0md86e0OFXO7H4R43kQpJ4hWg+RplqRq0xB4jogDULsuXM6Rq0ZbQFtM3NPBDu/iU8
         X0yQyHwqsYbequvfho0D0fJL32DhlVaRdT9uNLlI/7qm0YwEOOeKo6r1BipqvHAed5WI
         UYyg==
X-Gm-Message-State: APt69E0MlnFPReH0OtE2i6foYF0RxkygSqv9IFxRvO7Si7sV/lquVlN1
        0jXDeKK4Ws6FaQG9KzgKckSovQviE14842Fs7rI=
X-Google-Smtp-Source: ADUXVKK+RT6d4lou4MhqzM2MclrvBiPLZSRrr3lY0EwhQ/w856XjwXNUE+WQ7qz9SWU2uRq0ovZK49Y8XZ2FOkghqh4=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr4676034itd.16.1528898448641;
 Wed, 13 Jun 2018 07:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
 <6570c00b-bbec-82c3-16e2-1ba96d8e263b@redhat.com> <87y3fjossx.fsf@vitty.brq.redhat.com>
In-Reply-To: <87y3fjossx.fsf@vitty.brq.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jun 2018 07:00:37 -0700
Message-ID: <CA+55aFx5n6VJWhY5uNGYWi7ZHhT=FWjDrNK3Q_h5RssNcT0mrQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 4:00 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> This was reported before by Arnd Bergmann:
>
> https://www.spinics.net/lists/kvm/msg169536.html
>
> but it seems his patch got lost.

So I think his patch is closer to what the code *should* do. Mine was
a big ugly #if around the whole thing, but I really think that *all*
those

     if (static_branch_unlikely(&enable_evmcs)...

cases should probably be using IS_ENABLED(CONFIG_HYPERV) too.

Preferably by simply having a helper macro or inline function to do both tests.

I intentionally did just he big brute-force thing, I'm hoping the kvm
hyper-v people will clean this up.

But obviously this also showed a lack of testing.

                    Linus
