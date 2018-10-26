Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED506C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 03:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B54B2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 03:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dz1VTobS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B54B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeJZMFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 08:05:05 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36214 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeJZMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 08:05:04 -0400
Received: by mail-it1-f195.google.com with SMTP id h14-v6so35291itf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 20:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T5P+7+1/GuIEttNWY+yqGtmQVIjb7W31z/R2eGq/fi8=;
        b=Dz1VTobSwRQWuHjJzYoXOptyIsD4HMp/fzdqL7UPfFsTtT+qrkzUHxbm72Gt+XtWlb
         CQuCiEslDJBTX2nmG+f12Rqo3KvllAZLeCmO/DbaEOB+a1byhXr+sp8fX7/V+VCDHyHJ
         1Q3KbueYU4r0jeL0e9sQTbdx78Xo/nluoI+ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5P+7+1/GuIEttNWY+yqGtmQVIjb7W31z/R2eGq/fi8=;
        b=HngzPVHaD28CMaEWaZ3oRtelU7eLetiyb7CaohEH3aB/x5mEdWdYCdX4aKkQKjcYr4
         otf/4BBkA4fO2+TRQdCptPyduShjfgnAyz7I9hF15mCt5gSl81exCc+TSvrVdnW6Ciya
         W7pR5m3kdmDYoN2dLtwoEeNo/NSz8H+oJz5ZN4BbWcsLn6879oD8bEMjW+m+0UBE4pma
         3oi3m8TF4+ZNmp/OFL9uBH5WjZENIg8N5jtHlCyfQ3KqlFzKNgpIO3T7N5bgHMmrTArd
         cxBBsSO1wuH4yKBEt5hkb4v2tuXBYOpu1/mG8e2kkM7n2oE1X5QlNu6X/dgMDeQlW54V
         nyFQ==
X-Gm-Message-State: AGRZ1gIi2BsUJAio5i7OFyI5tFyQ+ch6cVBuvvTgppghO4W8qhNy3uPN
        3qemgTW2dYjLIW7QPZZjeAlygwuUQB2ChpoScR9als2OyK4=
X-Google-Smtp-Source: AJdET5fxLbjpRW2lTfrJsOx5sHY1JXnB34KD9lEFM33SwiXVSlXx8jFhgTptUmDSkq/y+fiyALyQYH7+PLTNuCoaV94=
X-Received: by 2002:a24:4169:: with SMTP id x102-v6mr2811404ita.128.1540524587984;
 Thu, 25 Oct 2018 20:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181024013132.115907-1-dbasehore@chromium.org> <20181024013132.115907-4-dbasehore@chromium.org>
In-Reply-To: <20181024013132.115907-4-dbasehore@chromium.org>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Thu, 25 Oct 2018 20:29:35 -0700
Message-ID: <CAGAzgsrMiXHQ9_UMsPp8Wch-3LLkwS+uJgYKOBr_NjNMtcvOaQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] clk: change rates via list iteration
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 6:31 PM Derek Basehore <dbasehore@chromium.org> wrote:
>
> This changes the clk_set_rate code to use lists instead of recursion.
> While making this change, also add error handling for clk_set_rate.
> This means that errors in the set_rate/set_parent/set_rate_and_parent
> functions will not longer be ignored. When an error occurs, the clk
> rates and parents are reset, unless an error occurs here, in which we
> bail and cross our fingers.
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/clk/clk.c | 225 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 153 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 61de8ad3e4cf..1db44b4e46b0 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -42,6 +42,13 @@ static LIST_HEAD(clk_notifier_list);
>
>  /***    private data structures    ***/
>
> +struct clk_change {
> +       struct list_head        change_list;
> +       unsigned long           rate;
> +       struct clk_core         *core;
> +       struct clk_core         *parent;
> +};
> +
>  struct clk_core {
>         const char              *name;
>         const struct clk_ops    *ops;
> @@ -52,11 +59,9 @@ struct clk_core {
>         const char              **parent_names;
>         struct clk_core         **parents;
>         u8                      num_parents;
> -       u8                      new_parent_index;
>         unsigned long           rate;
>         unsigned long           req_rate;
> -       unsigned long           new_rate;
> -       struct clk_core         *new_parent;
> +       struct clk_change       change;
>         struct clk_core         *new_child;
>         unsigned long           flags;
>         bool                    orphan;
> @@ -1719,20 +1724,53 @@ static int __clk_speculate_rates(struct clk_core *core,
>
>  static void clk_calc_subtree(struct clk_core *core)
>  {
> -       struct clk_core *child;
> +       LIST_HEAD(tmp_list);
>
> -       hlist_for_each_entry(child, &core->children, child_node) {
> -               child->new_rate = clk_recalc(child, core->new_rate);
> -               clk_calc_subtree(child);
> +       list_add(&core->change.change_list, &tmp_list);
> +       while (!list_empty(&tmp_list)) {
> +               struct clk_change *change = list_first_entry(&tmp_list,
> +                               struct clk_change, change_list);
> +               struct clk_core *tmp = change->core;
> +               struct clk_core *child;
> +
> +               hlist_for_each_entry(child, &tmp->children, child_node) {
> +                       child->change.rate = clk_recalc(child,
> +                                       tmp->change.rate);
> +                       list_add_tail(&child->change.change_list, &tmp_list);
> +               }
> +
> +               list_del_init(&change->change_list);
> +       }
> +}
> +
> +static void clk_prepare_changes(struct list_head *change_list,
> +                               struct clk_core *core)
> +{
> +       LIST_HEAD(tmp_list);
> +
> +       list_add(&core->change.change_list, &tmp_list);
> +       while (!list_empty(&tmp_list)) {
> +               struct clk_change *change = list_first_entry(&tmp_list,
> +                               struct clk_change, change_list);
> +               struct clk_core *tmp = change->core;
> +               struct clk_core *child;
> +
> +               hlist_for_each_entry(child, &tmp->children, child_node)
> +                       list_add_tail(&child->change.change_list, &tmp_list);
> +
> +               child = tmp->new_child;
> +               if (child)
> +                       list_add_tail(&child->change.change_list, &tmp_list);
> +
> +               list_move_tail(&tmp->change.change_list, change_list);
>         }
>  }
>
>  static void clk_set_change(struct clk_core *core, unsigned long new_rate,
> -                          struct clk_core *new_parent, u8 p_index)
> +                          struct clk_core *new_parent)
>  {
> -       core->new_rate = new_rate;
> -       core->new_parent = new_parent;
> -       core->new_parent_index = p_index;
> +       core->change.rate = new_rate;
> +       core->change.parent = new_parent;
>         /* include clk in new parent's PRE_RATE_CHANGE notifications */
>         core->new_child = NULL;
>         if (new_parent && new_parent != core->parent)
> @@ -1752,7 +1790,6 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
>         unsigned long new_rate;
>         unsigned long min_rate;
>         unsigned long max_rate;
> -       int p_index = 0;
>         long ret;
>
>         /* sanity */
> @@ -1788,14 +1825,13 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
>                         return NULL;
>         } else if (!parent || !(core->flags & CLK_SET_RATE_PARENT)) {
>                 /* pass-through clock without adjustable parent */
> -               core->new_rate = core->rate;
>                 return NULL;
>         } else {
>                 /* pass-through clock with adjustable parent */
>                 top = clk_calc_new_rates(parent, rate);
> -               new_rate = parent->new_rate;
> +               new_rate = parent->change.rate;
>                 hlist_for_each_entry(child, &parent->children, child_node)
> -                       child->new_rate = clk_recalc(child, new_rate);
> +                       child->change.rate = clk_recalc(child, new_rate);
>                 goto out;
>         }
>
> @@ -1807,25 +1843,16 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
>                 return NULL;
>         }
>
> -       /* try finding the new parent index */
> -       if (parent && core->num_parents > 1) {
> -               p_index = clk_fetch_parent_index(core, parent);
> -               if (p_index < 0) {
> -                       pr_debug("%s: clk %s can not be parent of clk %s\n",
> -                                __func__, parent->name, core->name);
> -                       return NULL;
> -               }
> -       }
> -
>         if ((core->flags & CLK_SET_RATE_PARENT) && parent &&
>             best_parent_rate != parent->rate) {
>                 top = clk_calc_new_rates(parent, best_parent_rate);
>                 hlist_for_each_entry(child, &parent->children, child_node)
> -                       child->new_rate = clk_recalc(child, parent->new_rate);
> +                       child->change.rate = clk_recalc(child,
> +                                       parent->change.rate);
>         }
>
>  out:
> -       clk_set_change(core, new_rate, parent, p_index);
> +       clk_set_change(core, new_rate, parent);
>
>         return top;
>  }
> @@ -1841,18 +1868,18 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
>         struct clk_core *child, *tmp_clk, *fail_clk = NULL;
>         int ret = NOTIFY_DONE;
>
> -       if (core->rate == core->new_rate)
> +       if (core->rate == core->change.rate)
>                 return NULL;
>
>         if (core->notifier_count) {
> -               ret = __clk_notify(core, event, core->rate, core->new_rate);
> +               ret = __clk_notify(core, event, core->rate, core->change.rate);
>                 if (ret & NOTIFY_STOP_MASK)
>                         fail_clk = core;
>         }
>
>         hlist_for_each_entry(child, &core->children, child_node) {
>                 /* Skip children who will be reparented to another clock */
> -               if (child->new_parent && child->new_parent != core)
> +               if (child->change.parent && child->change.parent != core)
>                         continue;
>                 tmp_clk = clk_propagate_rate_change(child, event);
>                 if (tmp_clk)
> @@ -1873,28 +1900,30 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
>   * walk down a subtree and set the new rates notifying the rate
>   * change on the way
>   */
> -static void clk_change_rate(struct clk_core *core)
> +static int clk_change_rate(struct clk_change *change)
>  {
> -       struct clk_core *child;
> -       struct hlist_node *tmp;
> +       struct clk_core *core = change->core;
>         unsigned long old_rate;
>         unsigned long best_parent_rate = 0;
>         bool skip_set_rate = false;
> -       struct clk_core *old_parent;
> +       struct clk_core *old_parent = NULL;
>         struct clk_core *parent = NULL;
> +       int p_index;
> +       int ret = 0;
>
>         old_rate = core->rate;
>
> -       if (core->new_parent) {
> -               parent = core->new_parent;
> -               best_parent_rate = core->new_parent->rate;
> +       if (change->parent) {
> +               parent = change->parent;
> +               best_parent_rate = parent->rate;
>         } else if (core->parent) {
>                 parent = core->parent;
> -               best_parent_rate = core->parent->rate;
> +               best_parent_rate = parent->rate;
>         }
>
> -       if (clk_pm_runtime_get(core))
> -               return;
> +       ret = clk_pm_runtime_get(core);
> +       if (ret)
> +               return ret;
>
>         if (core->flags & CLK_SET_RATE_UNGATE) {
>                 unsigned long flags;
> @@ -1905,35 +1934,55 @@ static void clk_change_rate(struct clk_core *core)
>                 clk_enable_unlock(flags);
>         }
>
> -       if (core->new_parent && core->new_parent != core->parent) {
> -               old_parent = __clk_set_parent_before(core, core->new_parent);
> -               trace_clk_set_parent(core, core->new_parent);
> +       if (core->flags & CLK_OPS_PARENT_ENABLE)
> +               clk_core_prepare_enable(parent);
> +
> +       if (parent != core->parent) {
> +               p_index = clk_fetch_parent_index(core, parent);
> +               if (p_index < 0) {
> +                       pr_debug("%s: clk %s can not be parent of clk %s\n",
> +                                __func__, parent->name, core->name);
> +                       ret = p_index;
> +                       goto out;
> +               }
> +               old_parent = __clk_set_parent_before(core, parent);
> +
> +               trace_clk_set_parent(core, change->parent);
>
>                 if (core->ops->set_rate_and_parent) {
>                         skip_set_rate = true;
> -                       core->ops->set_rate_and_parent(core->hw, core->new_rate,
> +                       ret = core->ops->set_rate_and_parent(core->hw,
> +                                       change->rate,
>                                         best_parent_rate,
> -                                       core->new_parent_index);
> +                                       p_index);
>                 } else if (core->ops->set_parent) {
> -                       core->ops->set_parent(core->hw, core->new_parent_index);
> +                       ret = core->ops->set_parent(core->hw, p_index);
>                 }
>
> -               trace_clk_set_parent_complete(core, core->new_parent);
> -               __clk_set_parent_after(core, core->new_parent, old_parent);
> -       }
> +               trace_clk_set_parent_complete(core, change->parent);
> +               __clk_set_parent_after(core, change->parent, old_parent);
> +               if (ret)
> +                       goto out;

Need to handle the set_parent op failing here. __clk_set_parent_before
needs to be undone, and we need to not call __clk_set_parent_after
with the failed state.

>
> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
> -               clk_core_prepare_enable(parent);
> +       }
>
> -       trace_clk_set_rate(core, core->new_rate);
> +       trace_clk_set_rate(core, change->rate);
>
>         if (!skip_set_rate && core->ops->set_rate)
> -               core->ops->set_rate(core->hw, core->new_rate, best_parent_rate);
> +               ret = core->ops->set_rate(core->hw, change->rate,
> +                               best_parent_rate);
>
> -       trace_clk_set_rate_complete(core, core->new_rate);
> +       trace_clk_set_rate_complete(core, change->rate);
>
>         core->rate = clk_recalc(core, best_parent_rate);
>
> +out:
> +       if (core->flags & CLK_OPS_PARENT_ENABLE)
> +               clk_core_disable_unprepare(parent);
> +
> +       if (core->notifier_count && old_rate != core->rate)
> +               __clk_notify(core, POST_RATE_CHANGE, old_rate, core->rate);
> +
>         if (core->flags & CLK_SET_RATE_UNGATE) {
>                 unsigned long flags;
>
> @@ -1943,31 +1992,44 @@ static void clk_change_rate(struct clk_core *core)
>                 clk_core_unprepare(core);
>         }
>
> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
> -               clk_core_disable_unprepare(parent);
> -
> -       if (core->notifier_count && old_rate != core->rate)
> -               __clk_notify(core, POST_RATE_CHANGE, old_rate, core->rate);
> +       clk_pm_runtime_put(core);
>
>         if (core->flags & CLK_RECALC_NEW_RATES)
> -               (void)clk_calc_new_rates(core, core->new_rate);
> +               (void)clk_calc_new_rates(core, change->rate);
>
>         /*
> -        * Use safe iteration, as change_rate can actually swap parents
> -        * for certain clock types.
> +        * Keep track of old parent and requested rate in case we have
> +        * to undo the change due to an error.
>          */
> -       hlist_for_each_entry_safe(child, tmp, &core->children, child_node) {
> -               /* Skip children who will be reparented to another clock */
> -               if (child->new_parent && child->new_parent != core)
> -                       continue;
> -               clk_change_rate(child);
> +       change->parent = old_parent;
> +       change->rate = old_rate;
> +       return ret;
> +}
> +
> +static int clk_change_rates(struct list_head *list)
> +{
> +       struct clk_change *change, *tmp;
> +       int ret = 0;
> +
> +       list_for_each_entry(change, list, change_list) {
> +               ret = clk_change_rate(change);
> +               if (ret)
> +                       goto err;
>         }
>
> -       /* handle the new child who might not be in core->children yet */
> -       if (core->new_child)
> -               clk_change_rate(core->new_child);
> +       return 0;
> +err:
> +       list_for_each_entry_safe_continue(change, tmp, list, change_list)
> +               list_del_init(&change->change_list);
>
> -       clk_pm_runtime_put(core);
> +       list_for_each_entry(change, list, change_list) {
> +               /* Give up. Driver might want to shutdown/reboot. */
> +               ret = clk_change_rate(change);
> +               if (WARN_ON(ret))
> +                       return ret;
> +       }
> +
> +       return ret;
>  }
>
>  static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
> @@ -2001,7 +2063,9 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>                                     unsigned long req_rate)
>  {
>         struct clk_core *top, *fail_clk;
> +       struct clk_change *change, *tmp;
>         unsigned long rate;
> +       LIST_HEAD(changes);
>         int ret = 0;
>
>         if (!core)
> @@ -2028,6 +2092,9 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>
>         clk_calc_subtree(core);
>
> +       /* Construct the list of changes */
> +       clk_prepare_changes(&changes, top);
> +
>         /* notify that we are about to change rates */
>         fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
>         if (fail_clk) {
> @@ -2039,7 +2106,19 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>         }
>
>         /* change the rates */
> -       clk_change_rate(top);
> +       ret = clk_change_rates(&changes);
> +       list_for_each_entry_safe(change, tmp, &changes, change_list) {
> +               change->rate = 0;
> +               change->parent = NULL;
> +               list_del_init(&change->change_list);
> +       }
> +
> +       if (ret) {
> +               pr_debug("%s: failed to set %s rate via top clk %s\n", __func__,
> +                               core->name, top->name);
> +               clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
> +               goto err;
> +       }
>
>         core->req_rate = req_rate;
>  err:
> @@ -3306,6 +3385,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>         core->max_rate = ULONG_MAX;
>         INIT_LIST_HEAD(&core->prepare_list);
>         INIT_LIST_HEAD(&core->enable_list);
> +       INIT_LIST_HEAD(&core->change.change_list);
> +       core->change.core = core;
>         hw->core = core;
>
>         /* allocate local copy in case parent_names is __initdata */
> --
> 2.19.1.568.g152ad8e336-goog
>
