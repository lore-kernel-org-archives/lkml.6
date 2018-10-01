Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A3CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A528D2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ltT/z4SX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A528D2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeJAW4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:56:52 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43049 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJAW4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:56:52 -0400
Received: by mail-yw1-f68.google.com with SMTP id j75-v6so778686ywj.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mjrj/52ELEUPwvDHD9CQckKpcS0lC8nynt7AJfYDKpc=;
        b=ltT/z4SXc8UMt3gq0Lyu7a6DPd6NOFDZ26ylZADHRBXMLmwIbvhYU8CUuaPPGgLTGg
         jkpslCLFph1NldkPEeH7Es2OkUk7CKGL2x0WmNKMRnOgGtUkCrSuQLRF66SH+P1zqJzr
         ZWZVeAX8+qCnfEB1NAiwCDnKFrSScjxeS2Z8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mjrj/52ELEUPwvDHD9CQckKpcS0lC8nynt7AJfYDKpc=;
        b=pUznnUjfOr7JnXZgsGM6RR7H0BcoMdExA3zP+4u2Rd4oig5kEdsiUhE/+ERfG+8iCO
         Plm4JOsdfLOB5+329U0kl+RgxkybVNLQNjv1hNKywmZk96fNCMkhc15JSblOt2xa3/x4
         nJmwwulC2tmEIFWXEV4HwpjT7zprr1ajOngobJEoVRTuSsv6xTYOYXTUlZ/Y8lZ3C97M
         Ih689g8LVgbkqOQC5xvn8+8VtOZOEmYQ+EyQ2rzMBei5ahJL/NvIbIRtYdRuQHr0S4bJ
         T+ipp+Ouf1pkeInu2aqloTWUiPu6widtUafV19+mglR1Nyi9Zham+aw9D67EhZefjJTU
         k66A==
X-Gm-Message-State: ABuFfogF3QzvQUa0RTL6NPjxBATHMbMpJH0rvSnQ9YsmSxVTTJKhy/ka
        x6nZsKQ8zW7PDsupJgg8mKVLLgKTAxo=
X-Google-Smtp-Source: ACcGV604mlC0/TZZMYxS1kP6y6DN4iEZ7w84m6TV0Qfbx3lB/NSF1xaZs3uF01RqCzxxabwc9lg60w==
X-Received: by 2002:a81:270d:: with SMTP id n13-v6mr6177142ywn.347.1538410697633;
        Mon, 01 Oct 2018 09:18:17 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id u8-v6sm7242716ywl.59.2018.10.01.09.18.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 09:18:16 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id p74-v6so5822369ybc.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:18:15 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr4807284yba.410.1538410695526;
 Mon, 01 Oct 2018 09:18:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 09:18:14 -0700 (PDT)
In-Reply-To: <20181001081324.11553-1-ard.biesheuvel@linaro.org>
References: <20181001081324.11553-1-ard.biesheuvel@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 09:18:14 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJhNLwt9U+73+X4-dmxOLkx-v5zvY3VN5TQz-ujipt-eA@mail.gmail.com>
Message-ID: <CAGXu5jJhNLwt9U+73+X4-dmxOLkx-v5zvY3VN5TQz-ujipt-eA@mail.gmail.com>
Subject: Re: [PATCH] kernel: jump_label: fix NULL dereference bug in __jump_label_mod_update()
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 1:13 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Commit 19483677684b ("jump_label: Annotate entries that operate on
> __init code earlier") refactored the code that manages runtime
> patching of jump labels in modules that are tied to static keys
> defined in other modules or in the core kernel.
>
> In the latter case, we may iterate over the static_key_mod linked
> list until we hit the entry for the core kernel, whose 'mod' field
> will be NULL, and attempt to dereference it to get at its 'state'
> member.
>
> So let's add a non-NULL check: this forces the 'init' argument of
> __jump_label_update() to false for static keys that are defined in
> the core kernel, which is appropriate given that __init annotated
> jump_label entries in the core kernel should no longer be active
> at this point (i.e., when loading modules).
>
> Fixes: 19483677684b ("jump_label: Annotate entries that operate on ...")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/jump_label.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index e8cf3ff3149c..14a7f9881745 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -516,7 +516,7 @@ static void __jump_label_mod_update(struct static_key *key)
>                 else
>                         stop = m->jump_entries + m->num_jump_entries;
>                 __jump_label_update(key, mod->entries, stop,
> -                                   m->state == MODULE_STATE_COMING);
> +                                   m && m->state == MODULE_STATE_COMING);
>         }
>  }
>
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
