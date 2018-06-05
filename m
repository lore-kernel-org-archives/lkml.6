Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeFEQc7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:32:59 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44470 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeFEQc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:32:58 -0400
X-Google-Smtp-Source: ADUXVKKB8w6MD/glzI+JQVYgj3RWHKZsTOPp2ddTrTURN92gC9rXc6c8m3M1sFRoM+4DzJ7K12quZREq34JV6A+cKZk=
MIME-Version: 1.0
In-Reply-To: <1526546163-4609-1-git-send-email-xieyisheng1@huawei.com>
References: <1526546163-4609-1-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 19:32:57 +0300
Message-ID: <CAHp75VekpcEVjZy5+i-R-+QWtt8GED_MmF8Pffqm+MZ-LcuuYA@mail.gmail.com>
Subject: Re: [PATCH] tracing: use match_string() to simplify the code
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 11:36 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used to simplify the code.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  kernel/trace/trace.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 414d721..4bd653a 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4395,8 +4395,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
>  {
>         char *cmp;
>         int neg = 0;
> -       int ret = -ENODEV;
> -       int i;
> +       int ret;
>         size_t orig_len = strlen(option);
>
>         cmp = strstrip(option);
> @@ -4408,16 +4407,12 @@ static int trace_set_options(struct trace_array *tr, char *option)
>
>         mutex_lock(&trace_types_lock);
>
> -       for (i = 0; trace_options[i]; i++) {
> -               if (strcmp(cmp, trace_options[i]) == 0) {
> -                       ret = set_tracer_flag(tr, 1 << i, !neg);
> -                       break;
> -               }
> -       }
> -
> +       ret = match_string(trace_options, -1, cmp);
>         /* If no option could be set, test the specific tracer options */
> -       if (!trace_options[i])
> +       if (ret < 0)
>                 ret = set_tracer_option(tr, cmp, neg);
> +       else
> +               ret = set_tracer_flag(tr, 1 << ret, !neg);
>
>         mutex_unlock(&trace_types_lock);
>
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
