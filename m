Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502ABC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A29B21D6A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpOYzxxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A29B21D6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbeHIOng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:43:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32921 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbeHIOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:43:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id u14-v6so3968054lfu.0;
        Thu, 09 Aug 2018 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=amQGOAoSnUck4N60ioPfzzx7wRVh4MEOHob03zlHTxg=;
        b=SpOYzxxgnxo4ZSzMZr4OeiSQkIWUrfrJo2iSuOrzLuO+IvW0dG5FfCC+CHXdnbASh5
         6UXNissnn17BlP6KuPF8TlFczK1YjO9carjIMfSTWh3BBn7lAwQijCkzmET56qrXNfU2
         S3btaGAgieZagGSD8cV2zbXXh1kBsc6oixsFojFVqqtLbwzGqbhcyOFBtkOcOWC1pZNq
         xHc1SDB3cVOun4sPg/ZEW3/k9ek14hyl1sNBm1rhA9gSzD6D9klEai9IEpWUaHpvUhtN
         NMQdQlgo1ewCzTFPYfuhD0U/uFXoBsvlEVxy/8J63XWxJKo3g8h9lPPF7wIfE9nhULqW
         0EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=amQGOAoSnUck4N60ioPfzzx7wRVh4MEOHob03zlHTxg=;
        b=ncN5HTO7G7il8IIVTUM+/7D3VXPkVzF84vHarRpUG6LdMgum7/HT+drnNM63GfDXSS
         feVd2GNPW/NaBpAdnjCiMRjL4dgo0iD/HgdzCJj5akb9m20QB0355gfP3pEZ5ZKObP1L
         DPBc0eV76wyhyfqZ1oDyR6sA3ZWY1lLtAwQ5GKNFZO+FvRfzs66GX9QpjxxuRk4Q1G0u
         KJgltdvqFOR81pIqpMGyo67bqUsMo9BfNmA+l2aypBjsewJ9AEQ/bOwrHWfR/i50QQ2C
         x2HdstYM6dq4/GWS/7FiLWxO1cWfHTikjEDV7/ftkO3nHHtlx/cgC/7YQ5Kw/lRKluZt
         4X1A==
X-Gm-Message-State: AOUpUlGzBzZMf6Xb6KTiWGfyYVflohE/uKTbvpCAws6IIQgf4jVPXpHr
        cCUs7BOwZtFkp3JMIulDSVvcyISbUu7WgOUXGAk=
X-Google-Smtp-Source: AA+uWPwJ1RjECcwh1eh+RqtbrDsO5ES6fy1fYwhgaNDzsl9/0PswjkFJdRWP0f0KG1lnMy2h1ZxJGyShV4UUaFrN3Oo=
X-Received: by 2002:a19:f22:: with SMTP id e34-v6mr1397152lfi.1.1533817135831;
 Thu, 09 Aug 2018 05:18:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a87:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 05:18:55 -0700 (PDT)
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <20180809094449.ddmnrkz7qkvo3j2x@suse.de>
References: <20180809092420.094e8722@canb.auug.org.au> <20180809094449.ddmnrkz7qkvo3j2x@suse.de>
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 9 Aug 2018 14:18:55 +0200
Message-ID: <CA+icZUW0rFEFH-CVPv3istQLV9CeNvxQzZvHsHH9agxXHq_MrQ@mail.gmail.com>
Subject: Re: [PATCH] x86, relocs: Add __end_rodata_aligned to S_REL
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 11:44 AM, Joerg Roedel <jroedel@suse.de> wrote:
> This new symbol needs to be in the workaround-list for buggy
> binutils, otherwise the build with gcc-4.6 fails.
>
> Fixes: 39d668e04eda ('x86/mm/pti: Make pti_clone_kernel_text() compile on 32 bit')
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/tools/relocs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 220e97841e49..3a6c8ebc8032 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -67,6 +67,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
>         "__tracedata_(start|end)|"
>         "__(start|stop)_notes|"
>         "__end_rodata|"
> +       "__end_rodata_aligned|"
>         "__initramfs_start|"
>         "(jiffies|jiffies_64)|"
>  #if ELF_BITS == 64
> --
> 2.16.4
>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
