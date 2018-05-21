Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbeEUWOB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:14:01 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34051 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeEUWN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:13:57 -0400
X-Google-Smtp-Source: AB8JxZoit+IudIqQ6U6Yhc4UFXRjL7/QjgJEYojFxlg/PZ8cl/oxcU9BVhbydNA9PTHSdSVjy+9K7wiGKpEoTP3NxfE=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-28-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-28-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:13:56 +0300
Message-ID: <CAHp75VcTpAkMeKa0YXpp91WooVPs5X7jPGk0w2ruitp4siKLVw@mail.gmail.com>
Subject: Re: [PATCH 27/33] sched/debug: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  kernel/sched/debug.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 15b10e2..9e34499 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -111,16 +111,14 @@ static int sched_feat_set(char *cmp)
>                 cmp += 3;
>         }
>
> -       for (i = 0; i < __SCHED_FEAT_NR; i++) {
> -               if (strcmp(cmp, sched_feat_names[i]) == 0) {
> -                       if (neg) {
> -                               sysctl_sched_features &= ~(1UL << i);
> -                               sched_feat_disable(i);
> -                       } else {
> -                               sysctl_sched_features |= (1UL << i);
> -                               sched_feat_enable(i);
> -                       }
> -                       break;
> +       i = match_string(sched_feat_names, __SCHED_FEAT_NR, cmp);

> +       if (i >= 0) {

Why not

if (i < 0)
 return i;

?

> +               if (neg) {
> +                       sysctl_sched_features &= ~(1UL << i);
> +                       sched_feat_disable(i);
> +               } else {
> +                       sysctl_sched_features |= (1UL << i);
> +                       sched_feat_enable(i);
>                 }
>         }
>
> @@ -150,7 +148,7 @@ static int sched_feat_set(char *cmp)
>         inode_lock(inode);
>         i = sched_feat_set(cmp);
>         inode_unlock(inode);

> -       if (i == __SCHED_FEAT_NR)
> +       if (i < 0)
>                 return -EINVAL;

Now it would be

if (i < 0)
 return i;

-- 
With Best Regards,
Andy Shevchenko
