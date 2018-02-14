Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754606AbeBNIIf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:08:35 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33251 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754530AbeBNIId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:08:33 -0500
X-Google-Smtp-Source: AH8x224Upg5NXtPS1Ozofvl3yoyvZXI2cvu3JdJG4tuQVYBIf0xaoO7jfH+rdyXmLEnZSMhj7y/GY46CmgrvSwakB58=
MIME-Version: 1.0
In-Reply-To: <20180214025653.132942-4-shakeelb@google.com>
References: <20180214025653.132942-1-shakeelb@google.com> <20180214025653.132942-4-shakeelb@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Feb 2018 10:08:31 +0200
Message-ID: <CAOQ4uxjHtV+9=T3wGdg9na0zPiBYzDtDAOJx7rWUMv5KS6Bi2g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] fs: fsnotify: account fsnotify metadata to kmemcg
To: Shakeel Butt <shakeelb@google.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 4:56 AM, Shakeel Butt <shakeelb@google.com> wrote:
> This is RFC patch and the discussion on the API is still happening at
> the following link but I am sending the early draft for feedback.
> [link] https://marc.info/?l=linux-api&m=151850343717274
>
> A lot of memory can be consumed by the events generated for the huge or
> unlimited queues if there is either no or slow listener. This can cause
> system level memory pressure or OOMs. So, it's better to account the
> fsnotify kmem caches to the memcg of the listener.
>
> There are seven fsnotify kmem caches and among them allocations from
> dnotify_struct_cache, dnotify_mark_cache, fanotify_mark_cache and
> inotify_inode_mark_cachep happens in the context of syscall from the

fsnotify_mark_connector_cachep as well.

> listener. So, SLAB_ACCOUNT is enough for these caches. The allocations
> from the remaining caches can happen in the context of the event

I would rephrase: "The allocations from the event caches happen in the
context of the event producer".

> producer. For such caches we will need to remote charge the allocations
> to the listener's memcg. Thus we save the memcg reference in the
> fsnotify_group structure of the listener.
>
> This patch has also moved the members of fsnotify_group to keep the
> size same, at least for 64 bit build, even with additional member by
> filling the holes.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Other than connector cache and the API issue, this looks good.
Only some nit picking below.

[...]
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 067d52e95f02..e1ed0f32ff92 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -84,6 +84,8 @@ struct fsnotify_event_private_data;
>  struct fsnotify_fname;
>  struct fsnotify_iter_info;
>
> +struct mem_cgroup;
> +
>  /*
>   * Each group much define these ops.  The fsnotify infrastructure will call
>   * these operations for each relevant group.
> @@ -129,6 +131,8 @@ struct fsnotify_event {
>   * everything will be cleaned up.
>   */
>  struct fsnotify_group {
> +       const struct fsnotify_ops *ops; /* how this group handles things */
> +
>         /*
>          * How the refcnt is used is up to each group.  When the refcnt hits 0
>          * fsnotify will clean up all of the resources associated with this group.
> @@ -139,8 +143,6 @@ struct fsnotify_group {
>          */
>         refcount_t refcnt;              /* things with interest in this group */
>
> -       const struct fsnotify_ops *ops; /* how this group handles things */
> -
>         /* needed to send notification to userspace */
>         spinlock_t notification_lock;           /* protect the notification_list */
>         struct list_head notification_list;     /* list of event_holder this group needs to send to userspace */
> @@ -162,6 +164,8 @@ struct fsnotify_group {
>         atomic_t num_marks;             /* 1 for each mark and 1 for not being
>                                          * past the point of no return when freeing
>                                          * a group */
> +       atomic_t user_waits;            /* Number of tasks waiting for user
> +                                        * response */
>         struct list_head marks_list;    /* all inode marks for this group */
>
>         struct fasync_struct *fsn_fa;    /* async notification */
> @@ -169,8 +173,8 @@ struct fsnotify_group {
>         struct fsnotify_event *overflow_event;  /* Event we queue when the
>                                                  * notification list is too
>                                                  * full */
> -       atomic_t user_waits;            /* Number of tasks waiting for user
> -                                        * response */
> +
> +       struct mem_cgroup *memcg_to_charge; /* memcg to charge allocations */
>

I am for brevity. IMO 'memcg' would be descriptive enough.

>         /* groups can define private fields here or use the void *private */
>         union {
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9dec8a5c0ca2..0c877ddae4ef 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -352,6 +352,7 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
>         return css ? container_of(css, struct mem_cgroup, css) : NULL;
>  }
>
> +struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);

Missing newline.

>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>         css_put(&memcg->css);

Thanks,
Amir.
