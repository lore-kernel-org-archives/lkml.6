Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723E2C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0621121A9A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/vRmbCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0621121A9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbeHIB2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:28:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39757 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIB2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:28:40 -0400
Received: by mail-pl0-f65.google.com with SMTP id w14-v6so1677272plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXq+SF45WaYMg/c75cyiPPvLilJePcdW2yfCMX9ZgXo=;
        b=Y/vRmbCptOKiN9JkKnAm0I9ROQRmvURzDyFX9h7X9jQSQhu+///F7MtloMK4Z/VpAo
         L5qwyn+KjCw1V3V2FvuSwupcRKtdVXEdos6h/6BbMqbOUzuth97EPKvdAjvL9XZSZ0Ay
         ef1uIJxTEu1WpswVDyTgEkhpJXRcb0qIDIUBHUGuzy9ECgwiOyZyRXM7NBSq/z2gNiB/
         Q7xRZq/0JJT5chPzDXEFi9c5xEdzz/P/P2ztnWungi2yn/1q1ECSUyk3kbekWnHVkUPP
         gH0zFpWcg7EAi9R3Yk0MO3KhIn/aVtVwees8cT3U1nDrKjnskQtX36InJsJ9FFpFwehl
         V9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXq+SF45WaYMg/c75cyiPPvLilJePcdW2yfCMX9ZgXo=;
        b=mpNUO0AJ2+3Mgeg1dthnOMjbnBbSHBb60UqJn+kB6dYOcN8YynS5zLL3BnUP7o6yoz
         NmIMmnFHRC1VpkMvQhZph9c04B/jGUDa/5Boy5i1sgCEsopONYgY4B7dJsnO9+092xEj
         PIHNI6AdJ2s36FND2gb5S25ZAIv7fDWQCWpnNe4Myvh64aQcnsK0DURLWznmH9sToCcg
         UsgnixoZ6yHP128fS0dXfO+KBrb3y3V4kp0qi3TBp5WoDWgrAZHZwP4BFt0z9zPEl+xd
         1ekyQa/0/P3T2DO/kVMyALPmtgHwZxocoR77i7fh0RU7WvU46PvBo4SqSGSoIhQHHsLS
         r3kw==
X-Gm-Message-State: AOUpUlFUwvyEMNFmH0YI3QvHBBZaviDLcnrqrTC4mgjRaXBhYrRdXu/k
        0zvKXaCMdaeaBwwJ3PA3epJai8psPLptUpnEwreq2Q==
X-Google-Smtp-Source: AA+uWPyLRWvUJw81uQGxqH6EseygqucCLOMrwiyj8/QkE4I+OHmtz/3EYfcgV7pmobT9+K8zN3nBuEEaU6yFklFGzxE=
X-Received: by 2002:a17:902:64d7:: with SMTP id y23-v6mr4243678pli.53.1533769608556;
 Wed, 08 Aug 2018 16:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180801210804.175176-1-ndesaulniers@google.com>
In-Reply-To: <20180801210804.175176-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 Aug 2018 16:06:37 -0700
Message-ID: <CAKwvOd=WZB=x86zqu=vFDoJgpWnfCj0K3qXv14vtysfv3ioi1w@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: prefer _THIS_IP_ to current_text_addr
To:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, x86@kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bumping for review
On Wed, Aug 1, 2018 at 2:08 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> As part of the effort to reduce the code duplication between _THIS_IP_
> and current_text_addr(), let's consolidate callers of
> current_text_addr() to use _THIS_IP_.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/x86/include/asm/kexec.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index f327236f0fa7..86924d594ecd 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -21,6 +21,7 @@
>  #ifndef __ASSEMBLY__
>
>  #include <linux/string.h>
> +#include <linux/kernel.h>
>
>  #include <asm/page.h>
>  #include <asm/ptrace.h>
> @@ -132,7 +133,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
>                 asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
>                 asm volatile("pushfq; popq %0" :"=m"(newregs->flags));
>  #endif
> -               newregs->ip = (unsigned long)current_text_addr();
> +               newregs->ip = _THIS_IP_;
>         }
>  }
>
> --
> 2.18.0.597.ga71716f1ad-goog
>


-- 
Thanks,
~Nick Desaulniers
