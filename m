Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B14BC67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DE220866
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BESGVQqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DE220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJSIjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:39:11 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38783 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeJSIjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:39:10 -0400
Received: by mail-yw1-f68.google.com with SMTP id d126-v6so12561631ywa.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 17:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XFGV47EYPpkg1iMBAO5pEf/P11IDkhM5wpkVtNAVSCQ=;
        b=BESGVQqYw+MH/SpfnA4UG0wDU/ZoOGgOL0UcDRDjNAqX5C9HHPTAf55XnF05RxWSpu
         gWMQKQyjlii3AOjybPS4Ex4qWFHB9iLnao7PlcNQYGupKNLhRiO6fsw0uPau0KsAx/+S
         lbwetO7CQWBNvoDSB11+Rwu4uAtc+Q/csQilc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XFGV47EYPpkg1iMBAO5pEf/P11IDkhM5wpkVtNAVSCQ=;
        b=F2gWNcy7MgkTK4jCtiOEOI4OerP/1R7Y5i2Ycl8p9sE/SjeHjgETFJAd3/qsSbqj1f
         cPuk6empMEfCuE6RwINgXOjZeyQOiD+ZqhUARF4OxQE+ww6owW/kHbCe5PcfYQ/AUoch
         qAgJ4RyPM34gXJ6ewL5x0V94wT9L+cmzllDzEOk6C6sWY0fnI19sBHcZsySwInDPbbHy
         Cc/CXRz57WY5lzlNoWSkDx6gXJfs1Tm+CyYWJaJoYQoghFlGroNB/cxwcFA9OHoggtt0
         L8aa44D/arur1ztpD8c58ZMTt8xDwwNY6xfO3vlC5juSO15dCs5dNzUmNeqxJMEfUqw+
         RQNA==
X-Gm-Message-State: ABuFfojc9/STJaiyUyy65TbE/ny9qhXEtoLZC7OZtjoBxPL2zDLLZJOR
        DRNsNx3nbVFJJF93D+bsZY20k6nVp2w=
X-Google-Smtp-Source: ACcGV62yKpCOxdnZ0L6q6pywsxdVQefhWiVXbMQJzzwlVsJiQJXZ0xY16OKDKw3pXkyYG25OjCOnuA==
X-Received: by 2002:a81:d441:: with SMTP id g1-v6mr20725997ywl.405.1539909333764;
        Thu, 18 Oct 2018 17:35:33 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id l69-v6sm5260484ywl.51.2018.10.18.17.35.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 17:35:32 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id 130-v6so1196831ywl.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 17:35:32 -0700 (PDT)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr21937948ywd.124.1539909331615;
 Thu, 18 Oct 2018 17:35:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 17:35:30
 -0700 (PDT)
In-Reply-To: <20181017121000.30240-1-mpe@ellerman.id.au>
References: <20181017121000.30240-1-mpe@ellerman.id.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Oct 2018 17:35:30 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLzv4Gxyote5-5jMJSbfJ-EPpRDQNaz2jyANP2yEY=tgA@mail.gmail.com>
Message-ID: <CAGXu5jLzv4Gxyote5-5jMJSbfJ-EPpRDQNaz2jyANP2yEY=tgA@mail.gmail.com>
Subject: Re: [PATCH] seq_buf: Make seq_buf_puts() NULL terminate the buffer
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 5:10 AM, Michael Ellerman <mpe@ellerman.id.au> wrot=
e:
> Currently seq_buf_puts() will happily create a non NULL terminated
> string for you in the buffer. This is particularly dangerous if the
> buffer is on the stack.
>
> For example:
>
>   char buf[8];
>   char secret =3D "secret";
>   struct seq_buf s;
>
>   seq_buf_init(&s, buf, sizeof(buf));
>   seq_buf_puts(&s, "foo");
>   printk("Message is %s\n", buf);
>
> Can result in:
>
>   Message is foo=C2=AA=C2=AA=C2=AA=C2=AA=C2=AAsecret
>
> We could require all users to memset() their buffer to NULL before
> use. But that seems likely to be forgotten and lead to bugs.
>
> Instead we can change seq_buf_puts() to always leave the buffer in a
> NULL terminated state.
>
> The only downside is that this makes the buffer 1 character smaller
> for seq_buf_puts(), but that seems like a good trade off.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Yes, please! :) I prefer keeping the string terminated over needing to
remember to do it later.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/seq_buf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> I recently merged a patch which actually hit this behaviour. I worked
> around it by using seq_buf_printf(), but it would be good to fix the
> problem at the source.
>
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 11f2ae0f9099..b1570204cde3 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -144,9 +144,13 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
>
>         WARN_ON(s->size =3D=3D 0);
>
> +       /* Add 1 to len for the trailing NULL which must be there */
> +       len +=3D 1;
> +
>         if (seq_buf_can_fit(s, len)) {
>                 memcpy(s->buffer + s->len, str, len);
> -               s->len +=3D len;
> +               /* Don't count the trailing NULL against the capacity */
> +               s->len +=3D len - 1;
>                 return 0;
>         }
>         seq_buf_set_overflow(s);
> --
> 2.17.1
>



--=20
Kees Cook
Pixel Security
