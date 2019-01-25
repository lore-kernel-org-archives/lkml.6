Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB47BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCDF218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IetaIi+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfAYN3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:29:00 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53762 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:29:00 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so10460727ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 05:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UA1u/pwBAu8VkY4HUBKZpTWyBGL19Q9Lbi20qNvOvvM=;
        b=IetaIi+vZ+vCbBJRpoN+msM0ark4i4fE62DMDqYXkk5lY2UcWJ1/Rgmx94Ei1IHQyf
         3dTZ4fbYa1BRaCkc4W5kAAy5H76BBaa+Nv6LK7fRmI7TAzCslqxjmUFnp/eywUZaYnBR
         05UNGU8rYWNOEytXp0somC0M67AI8s9R4VIgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UA1u/pwBAu8VkY4HUBKZpTWyBGL19Q9Lbi20qNvOvvM=;
        b=BCfzYIBuenyRUmQaU8sPGBoQqh/IKe9om5GcdWig3xpJJ+xaYxe0AWDwcuyFQvBYD4
         MIpek1B89jtn4I1e9+UGTTpwP+Pq0pVp9nwVUl+akDuLULNxDSvGRx1g0+f3YG4F3CoY
         X6DtN0a24gLnxtc7zQ592kRpA0xWyqyhnRcNftAgJoRm8P1r6ccbPFQmdYYWLjZA5wLf
         yGrz8bzFTM2MbN2ZNsxEIGfYlm8q/JUqU/xD2bzUB9PYhM42tj6rdiKBLjCrKVDDGbAv
         Eh8EdnA26FwNYWPlSHZBr4ztDAdgyYBS4+XT93nHOU8mWUrXeqxvJQRrDb80dqAmvse1
         0vAQ==
X-Gm-Message-State: AJcUukcOUqDtDcMX84iXklYWSB9BZA2w2HwmxVDCcFdgGq1wYxNLiHha
        P33hkKqI+nYPHlwlzsAV1nZrzTJ7uDAH+VQ3VE0crg==
X-Google-Smtp-Source: ALg8bN5paD7dKoOrV4GiWyKNUJyjyj0K747cSosInuqQXLdHKY3TY/JKBhKSN+GhmvgrrlvQHXRcLacoX/uyxTaZyFY=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr4213764itk.71.1548422939554;
 Fri, 25 Jan 2019 05:28:59 -0800 (PST)
MIME-Version: 1.0
References: <1547765160-15502-1-git-send-email-eugene.loh@oracle.com>
In-Reply-To: <1547765160-15502-1-git-send-email-eugene.loh@oracle.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 25 Jan 2019 14:28:48 +0100
Message-ID: <CAKv+Gu8BeYsq-_7KiANOjSN2fp25BP=71uLqKnkkYYJdhD2Bfw@mail.gmail.com>
Subject: Re: [PATCH] Kbuild: Handle too long symbols in kallsyms.c
To:     eugene.loh@oracle.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, andi@firstfloor.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 at 23:46, <eugene.loh@oracle.com> wrote:
>
> From: Eugene Loh <eugene.loh@oracle.com>
>
> When checking for symbols with excessively long names,
> account for null terminating character.
>
> Fixes: f3462aa952cf ("Kbuild: Handle longer symbols in kallsyms.c")
> Signed-off-by: Eugene Loh <eugene.loh@oracle.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  scripts/kallsyms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 77cebad..f75e7bd 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -118,8 +118,8 @@ static int read_symbol(FILE *in, struct sym_entry *s)
>                         fprintf(stderr, "Read error or end of file.\n");
>                 return -1;
>         }
> -       if (strlen(sym) > KSYM_NAME_LEN) {
> -               fprintf(stderr, "Symbol %s too long for kallsyms (%zu vs %d).\n"
> +       if (strlen(sym) >= KSYM_NAME_LEN) {
> +               fprintf(stderr, "Symbol %s too long for kallsyms (%zu >= %d).\n"
>                                 "Please increase KSYM_NAME_LEN both in kernel and kallsyms.c\n",
>                         sym, strlen(sym), KSYM_NAME_LEN);
>                 return -1;
> --
> 1.8.3.1
>
