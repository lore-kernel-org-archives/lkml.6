Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeECEus (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 00:50:48 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46708 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeECEuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 00:50:44 -0400
X-Google-Smtp-Source: AB8JxZqHG69EBXf//XQaL13JIv71QXlQR/JspeRkYLjqWycMeBhaAt8cMhsxLa8xPqy/yDQjDFXUH7pqfwxNqz+nCGc=
MIME-Version: 1.0
In-Reply-To: <CABvMjLTfuDqNEt4+1E6R47UFQOj7N1SAhb3KCwxjHsxm7itaog@mail.gmail.com>
References: <CABvMjLTfuDqNEt4+1E6R47UFQOj7N1SAhb3KCwxjHsxm7itaog@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 2 May 2018 21:50:41 -0700
X-Google-Sender-Auth: 7U48k3CtpIUXD-psZXi2SpRADhw
Message-ID: <CAGXu5j+xXbOaPyDrVHTBY3YKt_vEReFCgWCbw0q-220A5eh5RA@mail.gmail.com>
Subject: Re: [PATCH] kernel/exit.c: pointer sighand could be uninitialized
To: Yizhuo Zhai <yzhai003@ucr.edu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, Chengyu Song <csong@cs.ucr.edu>,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 6:48 PM, Yizhuo Zhai <yzhai003@ucr.edu> wrote:
> Variable 'sighand' could be uninitialized if probe_kernel_address fails
> (-EFAULT). The later use in the if statement may lead to undefined behavior.
>
> Signed-off-by: yzhai003@ucr.edu <yzhai003@ucr.edu>
> ---
>  kernel/exit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f6cad39..a353bd1 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -232,7 +232,7 @@ void release_task(struct task_struct *p)
>   */
>  struct task_struct *task_rcu_dereference(struct task_struct **ptask)
>  {
> - struct sighand_struct *sighand;
> + struct sighand_struct *sighand = NULL;
>   struct task_struct *task;
>
>   /*

Better would probably be to check the return of probe_kernel_address()
and take appropriate action...

-Kees

-- 
Kees Cook
Pixel Security
