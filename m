Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeFENV3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:21:29 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45501 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeFENV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:21:28 -0400
X-Google-Smtp-Source: ADUXVKKmXfw2mBERDZVeONqRVoZgzGjKiytW9Bv8IJ2gU1ZqxYb3P0Fx6vn5nehf8xJE+6bXHWkzsu+LXnnLyg4n7eg=
MIME-Version: 1.0
In-Reply-To: <1527765086-19873-15-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com> <1527765086-19873-15-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 16:21:26 +0300
Message-ID: <CAHp75VdSZCCqzJQ3k0ut0+USBxs0FdfjRXEC74yivQg7Vee3VA@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] sched/debug: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 2:11 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
> v2:
>  - rename i to ret to show the change in returned value meaning - per Andy
>
>  kernel/sched/debug.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 15b10e2..5591147 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -111,20 +111,19 @@ static int sched_feat_set(char *cmp)
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
> -               }
> +       i = match_string(sched_feat_names, __SCHED_FEAT_NR, cmp);
> +       if (i < 0)
> +               return i;
> +
> +       if (neg) {
> +               sysctl_sched_features &= ~(1UL << i);
> +               sched_feat_disable(i);
> +       } else {
> +               sysctl_sched_features |= (1UL << i);
> +               sched_feat_enable(i);
>         }
>
> -       return i;
> +       return 0;
>  }
>
>  static ssize_t
> @@ -133,7 +132,7 @@ static int sched_feat_set(char *cmp)
>  {
>         char buf[64];
>         char *cmp;
> -       int i;
> +       int ret;
>         struct inode *inode;
>
>         if (cnt > 63)
> @@ -148,10 +147,10 @@ static int sched_feat_set(char *cmp)
>         /* Ensure the static_key remains in a consistent state */
>         inode = file_inode(filp);
>         inode_lock(inode);
> -       i = sched_feat_set(cmp);
> +       ret = sched_feat_set(cmp);
>         inode_unlock(inode);
> -       if (i == __SCHED_FEAT_NR)
> -               return -EINVAL;
> +       if (ret < 0)
> +               return ret;
>
>         *ppos += cnt;
>
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
