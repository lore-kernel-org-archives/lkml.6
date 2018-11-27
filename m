Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9619DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CADF2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LB7wb+pS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CADF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbeK0Tqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:46:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37475 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbeK0Tqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:46:30 -0500
Received: by mail-io1-f67.google.com with SMTP id a3so16321533ioc.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 00:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6MzyeTX6x4XLs2NcdInHXS3tZ8LYi3TzJEkNFkeSuQ=;
        b=LB7wb+pS2tSSR/8CZyTGpB5tTFNNCgdAK2Dx6hqRQdsK5aVXW2fc/eS12ACPQwj5Qv
         A50Jos/Z4DRZXZACzTXXSehh2bM8FSdywKTI407OwwqFWlM7qUTrzuquUT5bvqiXtSxJ
         9r25fYwhaEwD+dZWNM3DeKG1bRm3OmOPEWIVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6MzyeTX6x4XLs2NcdInHXS3tZ8LYi3TzJEkNFkeSuQ=;
        b=pDEOE8FOYjvphe5zXagZjpYZxLxIIJ5VesRN6r9Go/Y/Zz3n4q74dcV38P5TpYzrS2
         Kku57vehgZ6ykBKGA+R2Kp4KZDxmASqaAT/0ftHZXaFunmc2IhHtfUz0cJr4HUKrpMT0
         41OneGMLBPKIra6Css+/3dx5mxnRCBNlOZ9cBLvTTdwjsp7BaWCRWZLlkGmJI6CsYD6G
         c9q7ssR2OKm3ODWaJal9I3DCFjlebjkwJTeaFGW+psxVbrzF1sueO1g7uVe1wpav9kRE
         CgKnTcEAtTboIS//OxHr2pyeuWbkUemsOG5HaolAaxNcOWs3V4s1zf62Erwm9rBWZIH7
         URXw==
X-Gm-Message-State: AA+aEWbAxXZtI+LofwjiAh/4QjJrl2c+mj6/Y3ci7v1PFeoKqR/7mipg
        aZf19KimGvW0+JCW6XbqlqHxMNGLgnm/3tKvqPGNblyO
X-Google-Smtp-Source: AFSGD/VdsbJZiNF5HJS1LEwT9GDMTbbuqCngpw7wNp4cfmhITg0DsNwq7siqnyefDmHuWoDrlpZIyoN/RqA1Y4s+hGg=
X-Received: by 2002:a6b:7a46:: with SMTP id k6mr25241828iop.60.1543308560719;
 Tue, 27 Nov 2018 00:49:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543200841.git.jpoimboe@redhat.com> <0d708fd0a7d860766f027d8c07e9d97d52d997bf.1543200841.git.jpoimboe@redhat.com>
In-Reply-To: <0d708fd0a7d860766f027d8c07e9d97d52d997bf.1543200841.git.jpoimboe@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 27 Nov 2018 09:49:09 +0100
Message-ID: <CAKv+Gu87fxM3P386fdbjgu6Wu5VLrOHniTr7Mh8OMnGeXLmNfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] compiler.h: Make __ADDRESSABLE() symbol truly unique
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com,
        Jessica Yu <jeyu@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 at 14:55, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> The __ADDRESSABLE() macro uses the __LINE__ macro to create a temporary
> symbol which has a unique name.  However, if the macro is used multiple
> times from within another macro, the line number will always be the
> same, resulting in duplicate symbols.
>
> Make the temporary symbols truly unique by using __UNIQUE_ID instead of
> __LINE__.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 06396c1cf127..4bb73fd918b5 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -282,7 +282,7 @@ unsigned long read_word_at_a_time(const void *addr)
>   */
>  #define __ADDRESSABLE(sym) \
>         static void * __section(".discard.addressable") __used \
> -               __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
> +               __UNIQUE_ID(__addressable_##sym) = (void *)&sym;
>
>  /**
>   * offset_to_ptr - convert a relative memory offset to an absolute pointer
> --
> 2.17.2
>
