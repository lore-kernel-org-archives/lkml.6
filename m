Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B71DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274BD206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AF1+wmbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274BD206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeJBJel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:34:41 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:48973 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeJBJel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:34:41 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0ad1a8a3;
        Tue, 2 Oct 2018 02:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ISvqMpsAG/VEX7bNh/cfNbyuUuo=; b=AF1+wm
        bSXZ81A8vW0sc0rvEtKgtLmeMpM+KbV/gKeLafjoV/DxUkHWVq1Jk3v3z/tbcwoZ
        FX6egdCMhCy1Cztc3EUhvbJkI+qEae+FiiBcbxoX+jO3lC67PC/firGBZMqu72St
        4tqjBChCYdvJtyxkbYCJ/VqFXHFC7isgMl4I1ieEiE8oBdmQwgUrGBoPDovnjH0i
        ov6vdWceU4v5wyxDmcbqhUrmZibUhYE34RJg3r0+EjkFceZIEwTMvlYoK6Q4RHg7
        C4MJypa0Yhx3f4mI6Lwz8CcfKzlsWxBTaM9mPfTK8/bV7FWbpzRcSGW/LS8CuJSd
        HCH4jsdebM2N3pPQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8d9ec874 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 2 Oct 2018 02:53:43 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id m11-v6so366684oic.2;
        Mon, 01 Oct 2018 19:53:43 -0700 (PDT)
X-Gm-Message-State: ABuFfohM6BpCJ6769q5vACkQbghO8Lx5g1I1Eew6ukOuC2+0aU+hgMCb
        BGW0G5/aEmM0JzFjdrxuQaSQXqwqBmw6jPFSa/0=
X-Google-Smtp-Source: ACcGV6220j4y6H0xfor1kOAGrPzuxWR9U1Nqw/U1Xk6hct+073BDossnqP5J31Z4MVzfYCaVjjVqUQOohonQ7MpjpL0=
X-Received: by 2002:aca:ac4:: with SMTP id k65-v6mr6765654oiy.265.1538442570654;
 Mon, 01 Oct 2018 18:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-5-Jason@zx2c4.com>
 <CAKv+Gu9aOiYdEzHHrHFHUFK=hNfeS=zEsvMe9OWD8hEdAYkffg@mail.gmail.com>
 <CAHmME9rc5zgN4HhBy0_oq+EbEXdS8nePzA7qW39nocx_y4ay1Q@mail.gmail.com> <20180929075601.GA11115@zn.tnic>
In-Reply-To: <20180929075601.GA11115@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 03:09:19 +0200
X-Gmail-Original-Message-ID: <CAHmME9ros3qk3F=E0-J416qPaFNvC8Cu3XCw4wwacfOwy9Gupw@mail.gmail.com>
Message-ID: <CAHmME9ros3qk3F=E0-J416qPaFNvC8Cu3XCw4wwacfOwy9Gupw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/23] zinc: ChaCha20 x86_64 implementation
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Sat, Sep 29, 2018 at 9:56 AM Borislav Petkov <bp@alien8.de> wrote:
> Documentation/process/submitting-patches.rst
>
> section 12, first sentence.
>
> The SOB chain needs to clearly express the path of the patch from
> author(s) to the upstream kernel.

Thanks for the clarification.

I've received the SOB directly from the individual in question as it
traveled through an intermediate tree on its way to the tree being
submitted here. Therefore I will retain that SOB so that it shows the
full path.

Jason
