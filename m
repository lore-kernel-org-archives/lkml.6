Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE971C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FF02147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gHRTxCw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FF02147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbeHPJ1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 05:27:38 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:36661 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbeHPJ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 05:27:37 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 57562312;
        Thu, 16 Aug 2018 06:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Kp3xcXSbPGeessTJYU9IK2fQQtg=; b=gHRTxC
        w4ahMSyke6p1/G87PlM5FJkOkRPlfxTbVtzVEQH7obQ3YL0rbi5aIpe9WFSmwJt0
        ZsseF1rtuTJJ1ELMU2Z7NyCQsw3sqUzcI70lLwEXLPRWktZ3MBCcDfXbgYPH5m23
        4TvB+Pxx+wUYQCOyTqjIwPN6+EffOZ9jEANL+uMa3qEdwwKm/gvpdjfGV7CVRc/n
        xUC3qZgYCZJA/AsuCp9nRlhFkE1tU/P39lJ1mVSZgD57OgVF+DbkoU+1xX15cdH/
        iHzcSzbC4EcX177oavckIE8hSQQXYfVMGVAwJ+FgML6kerMFY3nKQj7supXwVL/z
        +wZpakkNy09JgQ1g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 03e7d261 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 16 Aug 2018 06:18:03 +0000 (UTC)
Received: by mail-oi0-f51.google.com with SMTP id v8-v6so6174963oie.5;
        Wed, 15 Aug 2018 23:31:23 -0700 (PDT)
X-Gm-Message-State: AOUpUlENLmStZzKGrtTPtpXLJ+p89+aAxD/X83uylLaDqeq6gsjGwGOm
        wJdqXARNqJ/ajSJxO7V1R3jAribE9yEf/fy41uI=
X-Google-Smtp-Source: AA+uWPwKBlyW2+zcRqsPAHSkPL1NCaYCrIhg5cnKmSpBlvsLY54WJNY7ZrT8xR0Y17i2wjEHuKc/mChYug+C75kAGHA=
X-Received: by 2002:aca:fc94:: with SMTP id a142-v6mr28040733oii.29.1534401082674;
 Wed, 15 Aug 2018 23:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180801072246.GA15677@sol.localdomain> <CAHmME9pbwj0RaX4YM9epGOSgDRNUt=GA4UzO_iKcW=Md7kG6JQ@mail.gmail.com>
 <20180814211229.GB24575@gmail.com>
In-Reply-To: <20180814211229.GB24575@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 15 Aug 2018 23:31:11 -0700
X-Gmail-Original-Message-ID: <CAHmME9rtrnaU1LHM_dZ1WNw-Td4UhOz0kjmqb-e-0ykOnW7XyA@mail.gmail.com>
Message-ID: <CAHmME9rtrnaU1LHM_dZ1WNw-Td4UhOz0kjmqb-e-0ykOnW7XyA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        "Daniel J . Bernstein" <djb@cr.yp.to>,
        Tanja Lange <tanja@hyperelliptic.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tue, Aug 14, 2018 at 2:12 PM Eric Biggers <ebiggers@kernel.org> wrote:
> On ARM Cortex-A7, OpenSSL's ChaCha20 implementation is 13.9 cpb (cycles per
> byte), whereas Linux's is faster: 11.9 cpb.
>
> The reason Linux's ChaCha20 NEON implementation is faster than OpenSSL's
>
> I understand there are tradeoffs, and different implementations can be faster on
> different CPUs.
>
> So if your proposal goes in, I'd likely need to write a patch
> to get the old performance back, at least on Cortex-A7...

Yes, absolutely. Different CPUs behave differently indeed, but if you
have improvements for hardware that matters to you, we should
certainly incorporate these, and also loop Andy Polyakov in (I've
added him to the CC for the WIP v2). ChaCha is generally pretty
obvious, but for big integer algorithms -- like Poly1305 and
Curve25519 -- I think it's all the more important to involve Andy and
the rest of the world in general, so that Linux benefits from bug
research and fuzzing in places that are typically and classically
prone to nasty issues. In other words, let's definitely incorporate
your improvements after the patchset goes in, and at the same time
we'll try to bring Andy and others into the fold, where our
improvements can generally track each others.

> Also, I don't know whether Andy P. considered the 4xNEON implementation
> technique.  It could even be fastest on other ARM CPUs too, I don't know.

After v2, when he's CC'd in, let's plan to start discussing this with him.

Jason
