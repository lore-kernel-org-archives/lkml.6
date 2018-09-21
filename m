Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E678C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D2C21536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YNoQaFeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D2C21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbeIUGEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:04:06 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:52297 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbeIUGEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:04:06 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 262efcd5;
        Fri, 21 Sep 2018 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ylQiYAOpzC9DXgMd3DD2vB5CocE=; b=YNoQaF
        eRXYnYcn8yHl1GZ0/YErZ/sT8q+hY8nCpBgOt2cW3Ik1QEBB2IYgDjka5FKx+Rcs
        mfIdrnH5tB9B0kdidyQpUQBGLWE0WDUKg03NmQm2jTe75f0kVhQDGuX7nwg6oFxj
        yCjt7Afz+0gFgOtO+Inx2KTRMv1+HHh9cPkhictj60dq2mfD7RHQVd2rwYJKbbBW
        g8713xrPbUrGggd56hTG0qukXLMe4vHB1q2BIrr6Q29eera+BkfskgJ3G0Zyppsj
        8FKEE/c6C5CUDPuIAfFAtSqEEXLq411FgsziQuXpsi9ex2EiDLy32drj0KWcg9lN
        OVsZgOJVXYGYYGMw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5bd95471 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 21 Sep 2018 00:00:05 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id a19-v6so11300386otl.12;
        Thu, 20 Sep 2018 17:17:57 -0700 (PDT)
X-Gm-Message-State: APzg51DhRiJVrJP1Kgtrci9fbFmgDMHN4qQbc7u2islQTSRAHkAgHEfb
        UdI3N3QNf+O8nSfHvjmxg1o1hu4DXQwK1pgPvTc=
X-Google-Smtp-Source: ANB0VdZlQg2+YCKePHzVM23Y2/jLf9j3+HmGmeJTmYq/GSYQL6rbXh4rvHcNnMB6cbsegyu3AWbelOBv5388ooZjh9w=
X-Received: by 2002:a9d:3a34:: with SMTP id j49-v6mr22800255otc.317.1537489076667;
 Thu, 20 Sep 2018 17:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com>
 <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
In-Reply-To: <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Sep 2018 02:17:45 +0200
X-Gmail-Original-Message-ID: <CAHmME9qeas57qQe=0yfCRPWz=gC1_F5+047s6b4CUwdXQeoOEA@mail.gmail.com>
Message-ID: <CAHmME9qeas57qQe=0yfCRPWz=gC1_F5+047s6b4CUwdXQeoOEA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Thu, Sep 20, 2018 at 5:42 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Apologies for not spotting these before:
>
> > +ccflags-y := -O3
>
> -O3 optimization has been problematic in the past, at least on x86 but
> I think on other architectures as well. Please stick with -O2.

Fixed up for v6.

>
> > +ccflags-y += -Wframe-larger-than=$(if (CONFIG_KASAN),16384,8192)
>
> There is no way we can support code in the kernel with that kind of
> stack space requirements. I will let Arnd comment on what we typically
> allow, since he deals with such issues on a regular basis.

Also fixed up for v6 by just removing that line entirely.

Jason
