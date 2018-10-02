Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E267C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D7E206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VC9rasqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D7E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJBJgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:36:55 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:60193 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeJBJgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:36:55 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 5c171a7e;
        Tue, 2 Oct 2018 02:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=B6UNkC0e+5Tk1etu2HrqzVnK3Xw=; b=VC9ras
        qyg7GGQZeXMIN91/oHQvR3E8qykqyVgmOwPhHsINLA7PfytVpkU/a3xsHZuY/ufc
        x/2yhYGKcH4ZEjBBwyGv7QXssTJoU15WLJJHhDawTpSm7Zl4Xklun6f9h0DbS1Na
        y3aQrCdtkSYjMIsrb6LoXmQoS6VxhriFF09/fR0frcASyC6qemsiu0CQASrzuxrx
        L8E7llU3oLK9T9ERoRVdNH+umwhEs/4fTTkMgRNwSzn2ExSfHhRT83WLQKeYQ58K
        czP/QtKCSECCeR+ct/e3+onMhymQWIZgkqg4UO7tKxIVmM4aTI/+gPoBK4dBmK5x
        6emCegsPK3J9X85A==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 64b574d3 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 2 Oct 2018 02:55:58 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id j68-v6so353293oib.7;
        Mon, 01 Oct 2018 19:55:58 -0700 (PDT)
X-Gm-Message-State: ABuFfoitU0ikMUi6cUVrou7ZJHRUiBoAJt3PEAznvVVQpM0L9G8RV8Qy
        7DMz53ZdXF+Tsy4/fGSeR/XcFLrBINJQD2rJn1A=
X-Google-Smtp-Source: ACcGV60+yuQDZyyYHPAwkZTvhgw7x76LWEssVmpeIoMmGWTCDL5pBXFQcPTvty/ox/m8KTqNMn93cyDrDNJod+iioUo=
X-Received: by 2002:aca:ce4c:: with SMTP id e73-v6mr5910332oig.225.1538442476733;
 Mon, 01 Oct 2018 18:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-5-Jason@zx2c4.com>
 <CAKv+Gu9aOiYdEzHHrHFHUFK=hNfeS=zEsvMe9OWD8hEdAYkffg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9aOiYdEzHHrHFHUFK=hNfeS=zEsvMe9OWD8hEdAYkffg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 03:07:45 +0200
X-Gmail-Original-Message-ID: <CAHmME9pGBnCFCd-dTi932FwR49fRyKt7fdBH9YixbhRQ1a+nhw@mail.gmail.com>
Message-ID: <CAHmME9pGBnCFCd-dTi932FwR49fRyKt7fdBH9YixbhRQ1a+nhw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/23] zinc: ChaCha20 x86_64 implementation
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

Hi Ard,

On Fri, Sep 28, 2018 at 5:47 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> > While this is CRYPTOGAMS code, the originating code for this happens to
> > be the same as OpenSSL's commit cded951378069a478391843f5f8653c1eb5128da
> >
>
> I'd still prefer the kernel side changes to be presented as a separate
> followup patch

I've restructured things for the MIPS64 and x86_64 and it will be as
you've asked for v7.

Jason
