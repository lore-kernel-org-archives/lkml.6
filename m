Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1EBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C652088E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G7m4WKVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C652088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966424AbeFOU1x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:27:53 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:53479 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966118AbeFOU1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:27:52 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d2b5ddeb
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jun 2018 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=3HdTvnwkOWFnpG7DplVEo34Vb+I=; b=G7m4WK
        VOotj2NnZGhhKT1Bzfg/gwJVkWWR339WXf317IjeugZM8p4L/aJAVL3cdC6fiXV5
        IQftCrkv8CuDlk5k9wwcEYZMPpFgtrCDSnERWIXEZ7mHE/YWiRGyjWTUnwxLh0VK
        vlXUUSf4v6HU9yUUDUfApxDvieOwmcp+N0FkFhW93bTp9N4xTVCmnDtCtN7Cs3nT
        WsjUl5lG9shXkHzfE034PP4d3tP+yxIoNt3nZDtFEco2zAKhHi8kRv7W9Lb5GuMB
        JbvtJWgjKVpIOhoimW6OwjXMBIQ3FIcN6cdqlpwgX/pr2TTbb6fRXImyLgjvkH9d
        mLRjM5zvLzPW5rEw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ad8772c6 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jun 2018 20:22:27 +0000 (UTC)
Received: by mail-oi0-f41.google.com with SMTP id k190-v6so9895106oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 13:27:51 -0700 (PDT)
X-Gm-Message-State: APt69E2YfEtuUF8NX+tcCKNYte7AWuhsQA5BFp2Fa7/IVtSVB1/mCbgW
        CgPagty3VscS38KScaelNc4MBBtCACzg+ldUiJw=
X-Google-Smtp-Source: ADUXVKJwUyEcrlyV7d4099M5oxO9jT6Pzn8kKFEhQw0BeQMFNbZYU0b4m0hiCYRU8B9Y6AjFCeOyJ1Jc8u9nLLRjL8o=
X-Received: by 2002:aca:4d0c:: with SMTP id a12-v6mr1671304oib.37.1529094470628;
 Fri, 15 Jun 2018 13:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
 <6eecf873-9d87-5345-70ba-5c064a31714b@linux.intel.com> <CALCETrWoDEXzH=y9sqoGWtzLPoeWgpRyUQw5AiCubX4O+UOa3w@mail.gmail.com>
In-Reply-To: <CALCETrWoDEXzH=y9sqoGWtzLPoeWgpRyUQw5AiCubX4O+UOa3w@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 15 Jun 2018 22:27:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9qBrmD3HJtXHiLYjxhrX=ZL2jNr9TRQayB6SyJcZLmgHg@mail.gmail.com>
Message-ID: <CAHmME9qBrmD3HJtXHiLYjxhrX=ZL2jNr9TRQayB6SyJcZLmgHg@mail.gmail.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     dave.hansen@linux.intel.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 8:53 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Jun 15, 2018 at 11:50 AM Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
> Even with the modified optimization, kernel_fpu_end() still needs to
> reload the state that was trashed by the kernel FPU use.  If the
> kernel is using something like AVX512 state, then kernel_fpu_end()
> will transfer an enormous amount of data no matter how clever the CPU
> is.  And I think I once measured XSAVEOPT taking a hundred cycles or
> so even when RFBM==0, so it's not exactly super fast.

Indeed the speed up is really significant, especially for the AVX512
case. Here are some numbers from my laptop and a server taken a few
seconds ago:

AVX2 - Intel(R) Xeon(R) CPU E3-1505M v5 @ 2.80GHz
Inside: 684617437
Outside: 547710093
Percent speedup: 24

AVX512 - Intel(R) Xeon(R) Gold 5120 CPU @ 2.20GHz
Inside: 634415672
Outside: 286698960
Percent speedup: 121

This is from this test -- https://xn--4db.cc/F7RF2fhv/c . There are
probably various issues with that test case, and it's possible there
are other effects going on (the avx512 case looks particularly insane)
to make the difference _that_ drastic, but I think there's no doubt
that the optimization here is a meaningful one.
