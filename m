Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406BCC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FEF21530
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aY3NHhar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FEF21530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbeHOTrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:47:42 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38988 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbeHOTrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:47:41 -0400
Received: by mail-it0-f65.google.com with SMTP id g141-v6so2802051ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ciOGQyeV7HGfogv8AgnOybV1hGTcU+i6QaVs6QXagA=;
        b=aY3NHharI20BHj4G6GRHy3Q/2JgkNzxJg/EmPcxrIhWVT0N7dKfg2UqtmBE0r9uX5I
         U5G3XM/rBk7l43HZNGZnPc2OwejOBh5Z+XI80sg5kBcO6OwtxNIIEtPiQbhoxLgRYJk4
         p1jQKyba7ViBuVh91/snR5YZ/eR7A3SEPbGaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ciOGQyeV7HGfogv8AgnOybV1hGTcU+i6QaVs6QXagA=;
        b=pWR8nMkWS0pKbQyu93cYubhlhsJTxcyc6LODa/PTfNA0o3HWYwVAlU62zm7hfZLhGh
         Q1MsC6pP92gPWDey26K9otQLkl0dVZG5nsvjmRUR79cAu+MVaun2aKw3qn37vXUvnjom
         HMTKm39f0KeL2IG4dnLgWZyV7gF3NrWi/+i5GAtOI8jvg4dSElu8fpE+Ujam97jYEcIF
         T3WftagAiy8wBI2hKUqp12jsUiE7UjbUz50S05p2Z1YoFVD/9R8BuD2l9j28/5F9P8aa
         q18AGlcglI57I+a2h/5z+/XuiiXq7ZGAuXUSIGg9Rsi2UPcjaRzhS/k8fERPFDZMZ32a
         /U+w==
X-Gm-Message-State: AOUpUlHUdXzGjGWjb/sVcwrmX5YO51G4WFJ+G3bqzFquI8RHJfSa4w6e
        XPI0VHdUogpUH5kgbjQ7UxzUEY+b+v4Eqn6qhmw=
X-Google-Smtp-Source: AA+uWPz7bIFQDSw+UCxDhl1JMSqq54U9PutzYmxmH5BC9deS73kJcUOdkVg/sfBF3jsLQ+EtZ4XU6x1GczIicabCdKg=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr18172745ite.1.1534352085627;
 Wed, 15 Aug 2018 09:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180815100053.13609-1-yannik@sembritzki.me>
In-Reply-To: <20180815100053.13609-1-yannik@sembritzki.me>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 09:54:34 -0700
Message-ID: <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
To:     yannik@sembritzki.me, David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This needs more people involved, and at least a sign-off.

It looks ok, but I think we need a #define for the magical (void *)1UL
thing. I see the use in verify_pkcs7_signature(), but still.

              Linus



On Wed, Aug 15, 2018 at 3:11 AM Yannik Sembritzki <yannik@sembritzki.me> wrote:
>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 7326078e..eaaa125d 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -532,7 +532,7 @@ static int bzImage64_cleanup(void *loader_data)
>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
>         return verify_pefile_signature(kernel, kernel_len,
> -                                      NULL,
> +                                      (void *)1UL,
>                                        VERIFYING_KEXEC_PE_SIGNATURE);
>  }
>  #endif
> --
> 2.17.1
>
> The exact scenario under which this issue occurs is described here:
> https://bugzilla.redhat.com/show_bug.cgi?id=1554113
>
