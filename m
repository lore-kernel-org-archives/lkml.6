Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FEDC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CBD20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CBD20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dei.uc.pt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeIKN7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:59:51 -0400
Received: from smtp.dei.uc.pt ([193.137.203.253]:54120 "EHLO smtp.dei.uc.pt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbeIKN7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:59:50 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (user=sneves mech=PLAIN bits=0)
        by smtp.dei.uc.pt (8.15.2/8.15.2) with ESMTPSA id w8B90lSL032577
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Sep 2018 10:00:53 +0100
Received: by mail-ed1-f46.google.com with SMTP id f38-v6so18602032edd.8;
        Tue, 11 Sep 2018 02:00:53 -0700 (PDT)
X-Gm-Message-State: APzg51CMG2lkDi/vhlL69/uHPh1ZS9ohnRskm0C+Cb09ollShlRN1O/P
        /mVbNPCN55lbGFIoFADTGeYa9AAKZm8PzBo9Ik0=
X-Google-Smtp-Source: ANB0VdYAhPWmLnQbQebZ1hiD56k9jwZx+retXVF8qeb3R/QZMWJKv6TMV4lNSkjIJmIDgaxOHKjvct6cBs9ok7DHGbM=
X-Received: by 2002:a50:95a8:: with SMTP id w37-v6mr28236833eda.33.1536656447546;
 Tue, 11 Sep 2018 02:00:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:92c5:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 02:00:07
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1809111021250.5110@nanos.tec.linutronix.de>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-6-Jason@zx2c4.com>
 <alpine.DEB.2.21.1809111021250.5110@nanos.tec.linutronix.de>
From:   Samuel Neves <sneves@dei.uc.pt>
Date:   Tue, 11 Sep 2018 10:00:07 +0100
X-Gmail-Original-Message-ID: <CAEX_ruFFWsW897DuFEbz9+6av02bMwDgiA9GxV+=SBtyKG7LJw@mail.gmail.com>
Message-ID: <CAEX_ruFFWsW897DuFEbz9+6av02bMwDgiA9GxV+=SBtyKG7LJw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/17] zinc: ChaCha20 x86_64 implementation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-FCTUC-DEI-SIC-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-FCTUC-DEI-SIC-MailScanner-ID: w8B90lSL032577
X-FCTUC-DEI-SIC-MailScanner: Found to be clean
X-FCTUC-DEI-SIC-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
        score=-60.1, required 3.252, autolearn=not spam, ALL_TRUSTED -10.00,
        BAYES_00 -0.10, L_SMTP_AUTH -50.00)
X-FCTUC-DEI-SIC-MailScanner-From: sneves@dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 9:22 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 10 Sep 2018, Jason A. Donenfeld wrote:
>>  lib/zinc/Makefile                        |    4 +
>>  lib/zinc/chacha20/chacha20-x86_64-glue.h |  102 +
>>  lib/zinc/chacha20/chacha20-x86_64.S      | 2632 ++++++++++++++++++++++
>
> Just a stupid question. What's the rationale of putting that into lib/zinc
> instead of having it in arch/x86/crypto?
>

This is covered on the 02/17 commit message, whose relevant paragraph follows:

> It also organizes the implementations in a simple, straight-forward,
> and direct manner, making it enjoyable and intuitive to work on.
> Rather than moving optimized assembly implementations into arch/, it
> keeps them all together in lib/zinc/, making it simple and obvious to
> compare and contrast what's happening. This is, notably, exactly what
> the lib/raid6/ tree does, and that seems to work out rather well. It's
> also the pattern of most successful crypto libraries. The architecture-
> specific glue-code is made a part of each translation unit, rather than
> being in a separate one, so that generic and architecture-optimized code
> are combined at compile-time, and incompatibility branches compiled out by
> the optimizer.
