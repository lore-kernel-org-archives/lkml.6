Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B2BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E161B20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJRiL9S3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E161B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeJFAOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:14:53 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50480 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJFAOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:14:52 -0400
Received: by mail-it1-f196.google.com with SMTP id j81-v6so3574203ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dU9e3rgpB1fsPGYP9fVdia6W/fR8iyw7Oa8Se3v/bRk=;
        b=FJRiL9S33QUtPnZ8LhpgH2DVhAXeRMRjeCmklufK77gqT1oh6Tb68pkyIrBX1JQTGx
         uiIpvb6qKPtxauC72/riYpuaKups5i/cygnQlKf5YLNFleXx/5CTdS61NtVQsSwbXEyj
         hXzyFXDnclJWjhVpY6/tN2hBtOudWCr1sXKKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dU9e3rgpB1fsPGYP9fVdia6W/fR8iyw7Oa8Se3v/bRk=;
        b=SSNSOwE27rf8ean+yPK2Lvuov3t/sFwgnVUQ/vVfwdquvxSnLzJqA6XqB86bE7t/Dr
         AEq5jbq1WDVBoJAlyWntg0/hcdCz3/VOZP9BwwkUm2HNMmhzxkE8hLGScgYYk7eLscyt
         5hYNGJYSL/NooxS0dBz6QJ4WfD88cslhfR3JYS8lDRAVvIV6omcx9d3wJfMplJuylVUo
         y4rLWlK4iAWlGtoYLrlkJEnQdRNmsdY3HWCGsAyQIi3YdoTcvtbg5Fkld0CMAUeMxKkA
         TotgXDtEXMCoNv3d6I+DO0QVihwRwc5nDw09IcwwNrHR/GZtIgSo1J4TE5ng47k4aPfX
         icvg==
X-Gm-Message-State: ABuFfoiB9sXIvTDzO/mE2tJ3bddcfkNrjy9n+KcnajQV1xFg3OA7R0X0
        b0h+ON0m8uFSSxbXnULuOH6SC70GCEz0o+m4kO7kIw==
X-Google-Smtp-Source: ACcGV63xsEJDmC4QBY9m900LfP+j45gZh9MtwHkoJdrsrYXSX9+DQR1U476LLXbyqOri9X52OIOYh77qtEABzeRZaAM=
X-Received: by 2002:a02:5147:: with SMTP id s68-v6mr9292226jaa.62.1538759713791;
 Fri, 05 Oct 2018 10:15:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 10:15:13 -0700 (PDT)
In-Reply-To: <20181005133705.GA4588@zx2c4.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org> <20181005133705.GA4588@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 5 Oct 2018 19:15:13 +0200
Message-ID: <CAKv+Gu-f4uKBF=gtFcNJEeoC2L4qShX0+3p7kVhjTn0tR+3Gng@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] patchable function pointers for pluggable crypto routines
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 October 2018 at 15:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
...
> Therefore, I think this patch goes in exactly the wrong direction. I
> mean, if you want to introduce dynamic patching as a means for making
> the crypto API's dynamic dispatch stuff not as slow in a post-spectre
> world, sure, go for it; that may very well be a good idea. But
> presenting it as an alternative to Zinc very widely misses the point and
> serves to prolong a series of bad design choices, which are now able to
> be rectified by putting energy into Zinc instead.
>

This series has nothing to do with dynamic dispatch: the call sites
call crypto functions using ordinary function calls (although my
example uses CRC-T10DIF), and these calls are redirected via what is
essentially a PLT entry, so that we can supsersede those routines at
runtime.
