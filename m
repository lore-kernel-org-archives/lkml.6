Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755225AbeE2IJ5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:09:57 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35083 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754922AbeE2IJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:09:53 -0400
X-Google-Smtp-Source: ADUXVKLi5eQ6YJ3uKmRVOqEsJpUEQ1hb0AvNKLZG0+BnZrEyQW4wcGjTY+fWNsgE0lYMtremUE2HnFznv7s/CDFxmvA=
MIME-Version: 1.0
In-Reply-To: <20180525101958.13277-2-bigeasy@linutronix.de>
References: <20180525101958.13277-1-bigeasy@linutronix.de> <20180525101958.13277-2-bigeasy@linutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 May 2018 10:09:51 +0200
X-Google-Sender-Auth: zyi70DPZAuJ7ER5isYCdoVdnIGU
Message-ID: <CAJZ5v0jEUR7YxzujvZn8WVK+dMxmOxoHNiLKcmgCq9awHR=vYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/SRCU: provide a static initializer
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 12:19 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> There are macros for static initializer for the three out of four
> possible notifier types, that are:
>         ATOMIC_NOTIFIER_HEAD()
>         BLOCKING_NOTIFIER_HEAD()
>         RAW_NOTIFIER_HEAD()
>
> This patch provides a static initilizer for the forth type to make it
> complete.
>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I cannot apply this without an ACK from Paul.

> ---
>  include/linux/notifier.h | 34 +++++++++++++++++++++++++++++-----
>  include/linux/srcutiny.h |  6 +++---
>  include/linux/srcutree.h |  6 +++---
>  3 files changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index 6d731110e0db..f35c7bf76143 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -43,9 +43,7 @@
>   * in srcu_notifier_call_chain(): no cache bounces and no memory barriers.
>   * As compensation, srcu_notifier_chain_unregister() is rather expensive.
>   * SRCU notifier chains should be used when the chain will be called very
> - * often but notifier_blocks will seldom be removed.  Also, SRCU notifier
> - * chains are slightly more difficult to use because they require special
> - * runtime initialization.
> + * often but notifier_blocks will seldom be removed.
>   */
>
>  struct notifier_block;
> @@ -91,7 +89,7 @@ struct srcu_notifier_head {
>                 (name)->head = NULL;            \
>         } while (0)
>
> -/* srcu_notifier_heads must be initialized and cleaned up dynamically */
> +/* srcu_notifier_heads must be cleaned up dynamically */
>  extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
>  #define srcu_cleanup_notifier_head(name)       \
>                 cleanup_srcu_struct(&(name)->srcu);
> @@ -104,7 +102,13 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
>                 .head = NULL }
>  #define RAW_NOTIFIER_INIT(name)        {                               \
>                 .head = NULL }
> -/* srcu_notifier_heads cannot be initialized statically */
> +
> +#define SRCU_NOTIFIER_INIT(name, pcpu)                         \
> +       {                                                       \
> +               .mutex = __MUTEX_INITIALIZER(name.mutex),       \
> +               .head = NULL,                                   \
> +               .srcu = __SRCU_STRUCT_INIT(name.srcu, pcpu),    \
> +       }
>
>  #define ATOMIC_NOTIFIER_HEAD(name)                             \
>         struct atomic_notifier_head name =                      \
> @@ -116,6 +120,26 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
>         struct raw_notifier_head name =                         \
>                 RAW_NOTIFIER_INIT(name)
>
> +#ifdef CONFIG_TREE_SRCU
> +#define _SRCU_NOTIFIER_HEAD(name, mod)                         \
> +       static DEFINE_PER_CPU(struct srcu_data,                 \
> +                       name##_head_srcu_data);                 \
> +       mod struct srcu_notifier_head name =                    \
> +                       SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
> +
> +#else
> +#define _SRCU_NOTIFIER_HEAD(name, mod)                         \
> +       mod struct srcu_notifier_head name =                    \
> +                       SRCU_NOTIFIER_INIT(name, name)
> +
> +#endif
> +
> +#define SRCU_NOTIFIER_HEAD(name)                               \
> +       _SRCU_NOTIFIER_HEAD(name, /* not static */)
> +
> +#define SRCU_NOTIFIER_HEAD_STATIC(name)                                \
> +       _SRCU_NOTIFIER_HEAD(name, static)
> +
>  #ifdef __KERNEL__
>
>  extern int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index 261471f407a5..f41d2fb09f87 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -43,7 +43,7 @@ struct srcu_struct {
>
>  void srcu_drive_gp(struct work_struct *wp);
>
> -#define __SRCU_STRUCT_INIT(name)                                       \
> +#define __SRCU_STRUCT_INIT(name, __ignored)                            \
>  {                                                                      \
>         .srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),        \
>         .srcu_cb_tail = &name.srcu_cb_head,                             \
> @@ -56,9 +56,9 @@ void srcu_drive_gp(struct work_struct *wp);
>   * Tree SRCU, which needs some per-CPU data.
>   */
>  #define DEFINE_SRCU(name) \
> -       struct srcu_struct name = __SRCU_STRUCT_INIT(name)
> +       struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
>  #define DEFINE_STATIC_SRCU(name) \
> -       static struct srcu_struct name = __SRCU_STRUCT_INIT(name)
> +       static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
>
>  void synchronize_srcu(struct srcu_struct *sp);
>
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 4eda108abee0..745d4ca4dd50 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -104,9 +104,9 @@ struct srcu_struct {
>  #define SRCU_STATE_SCAN1       1
>  #define SRCU_STATE_SCAN2       2
>
> -#define __SRCU_STRUCT_INIT(name)                                       \
> +#define __SRCU_STRUCT_INIT(name, pcpu_name)                            \
>         {                                                               \
> -               .sda = &name##_srcu_data,                               \
> +               .sda = &pcpu_name,                                      \
>                 .lock = __SPIN_LOCK_UNLOCKED(name.lock),                \
>                 .srcu_gp_seq_needed = 0 - 1,                            \
>                 __SRCU_DEP_MAP_INIT(name)                               \
> @@ -133,7 +133,7 @@ struct srcu_struct {
>   */
>  #define __DEFINE_SRCU(name, is_static)                                 \
>         static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);\
> -       is_static struct srcu_struct name = __SRCU_STRUCT_INIT(name)
> +       is_static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name##_srcu_data)
>  #define DEFINE_SRCU(name)              __DEFINE_SRCU(name, /* not static */)
>  #define DEFINE_STATIC_SRCU(name)       __DEFINE_SRCU(name, static)
>
> --
> 2.17.0
>
