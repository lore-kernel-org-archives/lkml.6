Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9F3C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DD320833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DG4V8xi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DD320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeI3X3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 19:29:05 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35445 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeI3X3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 19:29:05 -0400
Received: by mail-yw1-f68.google.com with SMTP id y76-v6so4586917ywd.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UqkVJiOAKV7vz+zGLp0JsG6E5mB7xxNSq0E0LWO7XQo=;
        b=DG4V8xi6gyDln/ygDHLdqnzZSINZ3zpWEvEp9Zo1QG8g2Dc2sAKQxTE2E46nw/yQu/
         fl/hRLA/Lu+CFg0xVgdoShGhI4cDJ/mffFoBd5zaIU34AOeGbkZl58NgQ9a9Khfw5I34
         x7UtZWtY8FlK/qSTORwlYg6i1bmpZpnwoObwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UqkVJiOAKV7vz+zGLp0JsG6E5mB7xxNSq0E0LWO7XQo=;
        b=UpjES5fzV8gguwzyNNq0anmdDAO8w/QTEffGUxs5+00dL6GAiU6AV15y3OcIo1S5TH
         AZYOrLT0CSBFzqg5r92HPt0HnJnnOtL5WlCJkjrD+Q0iPnvA205d8WuBzps5TBm6QJhA
         /X8d5YkQnvQfqQHGnxLQzGUbqTH6wTZZPsAXToWdSKWzqw039blLLDmG3uVX96cgRJvE
         90iIL3p3aF8r7y6Oprcb+FIzb4tHYKhlP/zJYjIRlIegpmJyBHgJu7n4IZeYR47VOk84
         /dOweclzf5k5nqA8y2/i5QyZ2wBBjXndwnEjXW9/Ovy23P1oYU02neOX98B7HZjbsuL/
         0Mjw==
X-Gm-Message-State: ABuFfohVFNXlOSq8XjRdnosMVNcXzjVlRfMIaFOhtPzMxd+YAJ2NO6DC
        7ztLMDaouoYmLTGTHy+cEIM2OzjFQSs=
X-Google-Smtp-Source: ACcGV62rpREk5Iq1JXsPKJxqbQ1FubmFM5Frhez4tPkgEsx/y1nJ/rEmj5adY9WsYo0jlHIbXyJffg==
X-Received: by 2002:a81:2803:: with SMTP id o3-v6mr3829710ywo.299.1538326517813;
        Sun, 30 Sep 2018 09:55:17 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id k184-v6sm4187272ywc.62.2018.09.30.09.55.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 09:55:15 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id c4-v6so4663172ybl.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 09:55:14 -0700 (PDT)
X-Received: by 2002:a25:8091:: with SMTP id n17-v6mr3974253ybk.209.1538326514459;
 Sun, 30 Sep 2018 09:55:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Sun, 30 Sep 2018 09:55:13
 -0700 (PDT)
In-Reply-To: <20180930164950.3841-1-ard.biesheuvel@linaro.org>
References: <20180930164950.3841-1-ard.biesheuvel@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 30 Sep 2018 09:55:13 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKL9H+VKr=J8iXEBOVagr5ZxRdYw-KUqMtM=qhpkrv+Rg@mail.gmail.com>
Message-ID: <CAGXu5jKL9H+VKr=J8iXEBOVagr5ZxRdYw-KUqMtM=qhpkrv+Rg@mail.gmail.com>
Subject: Re: [PATCH] s390: vmlinux.lds: move JUMP_TABLE_DATA into output section
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 9:49 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Commit e872267b8bcbb179 ("jump_table: move entries into ro_after_init
> region") moved the __jump_table input section into the __ro_after_init
> output section, but inadvertently put the macro in the wrong place in
> the s390 linker script. Let's fix that.
>
> Fixes: e872267b8bcbb179 ("jump_table: move entries into ro_after_init region")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/s390/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 4042bbf3f9ad..457713f48734 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -64,9 +64,9 @@ SECTIONS
>         __start_ro_after_init = .;
>         .data..ro_after_init : {
>                  *(.data..ro_after_init)
> +               JUMP_TABLE_DATA
>         }
>         EXCEPTION_TABLE(16)
> -       JUMP_TABLE_DATA
>         . = ALIGN(PAGE_SIZE);
>         __end_ro_after_init = .;
>
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
