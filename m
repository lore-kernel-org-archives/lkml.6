Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755265AbeE3B5h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:57:37 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46237 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeE3B5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:57:36 -0400
X-Google-Smtp-Source: ADUXVKJIFXDFLYgnd3s6/FjI8HBs6XBcLUFbq8ct5TvfHdU5TCRUhKcFJs9Ht6Uph+tU123hJ9ySwoW5TN7R6CbZTjI=
MIME-Version: 1.0
In-Reply-To: <1527575488-31305-1-git-send-email-nick.desaulniers@gmail.com>
References: <1527575488-31305-1-git-send-email-nick.desaulniers@gmail.com>
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Tue, 29 May 2018 18:57:35 -0700
Message-ID: <CAH7mPvhfjddD2=o=HMw0nJZ3snqe8Lu=7eoOT=AeaO6MJ2fVgQ@mail.gmail.com>
Subject: Re: [PATCH] blk-wbt: tracing: prefer strlcpy to strncpy
To: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ebiggers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:31 PM, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> Fixes a stringop-truncation warning from gcc-8.
>
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  include/trace/events/wbt.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
> index b048694..305252d 100644
> --- a/include/trace/events/wbt.h
> +++ b/include/trace/events/wbt.h
> @@ -33,7 +33,7 @@ TRACE_EVENT(wbt_stat,
>         ),
>
>         TP_fast_assign(
> -               strncpy(__entry->name, dev_name(bdi->dev), 32);
> +               strlcpy(__entry->name, dev_name(bdi->dev), 32);
>                 __entry->rmean          = stat[0].mean;
>                 __entry->rmin           = stat[0].min;
>                 __entry->rmax           = stat[0].max;
> @@ -67,7 +67,7 @@ TRACE_EVENT(wbt_lat,
>         ),
>
>         TP_fast_assign(
> -               strncpy(__entry->name, dev_name(bdi->dev), 32);
> +               strlcpy(__entry->name, dev_name(bdi->dev), 32);
>                 __entry->lat = div_u64(lat, 1000);
>         ),
>
> @@ -103,7 +103,7 @@ TRACE_EVENT(wbt_step,
>         ),
>
>         TP_fast_assign(
> -               strncpy(__entry->name, dev_name(bdi->dev), 32);
> +               strlcpy(__entry->name, dev_name(bdi->dev), 32);
>                 __entry->msg    = msg;
>                 __entry->step   = step;
>                 __entry->window = div_u64(window, 1000);
> @@ -138,7 +138,7 @@ TRACE_EVENT(wbt_timer,
>         ),
>
>         TP_fast_assign(
> -               strncpy(__entry->name, dev_name(bdi->dev), 32);
> +               strlcpy(__entry->name, dev_name(bdi->dev), 32);
>                 __entry->status         = status;
>                 __entry->step           = step;
>                 __entry->inflight       = inflight;
> --
> 2.7.4
>

Eric points out this doesn't initialize the rest of dest if src is
less than size.
