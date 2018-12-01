Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC158C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB4620867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dFLi4bze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB4620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeLAL6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:58:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36076 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLAL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:58:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so5385341lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4itWQf5jcI2FQ6LzytrCcTth3VN6lWlS/82esdeH/kQ=;
        b=dFLi4bzeryMDW2gozr3dybSManbBPby/R8Xs5/eOZQYc2Cv8nR4iiJ0FXvt0VziayG
         kmvbL8LGQIqXhHGp5YyVGT052OyKkq5jaD/54cjei8abpglAUGiLp8OYjqoEz33xXrGY
         Jx+b13vDUbDLYj6XVtYpYlrMJTHueh6d+jGx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4itWQf5jcI2FQ6LzytrCcTth3VN6lWlS/82esdeH/kQ=;
        b=jUGWPH1aNQON5hQ09dywS4xLZpeDKEO+59tYEWw8wJuR1jbRImtssSTtFfnSkpojk/
         3B2fx2PnUmrolHMiPZVFyswgk6xxXt1hQxMB0jyF15wnqnfFRTxI+JKX9693EuUJeHes
         LVBlFrv6Xb8ltRZPQzGQw2iGUiJkFzwdW7TnaIJjDjtdxnoo0kKWvaR6f6eVgE7hv+ZR
         eGywGH9MDiIg/Y/lVLoQcxg8viczQ28E3SY7DBoFto02cXPh1lTYZcU5wwYswEvyv8xz
         4rCqlQHjywWuWYPudgDWH/XSx8BYHvIoQYe+VC2MSgPaMtEu0ujUjXe224Bg3plF9POz
         aKaQ==
X-Gm-Message-State: AA+aEWZy9ePgc0agdgmp1vF7vzZfOHVE2BraaEYbOdLF09rvD+I90Meq
        9ySkw6yzObuQiKlGrXOMhfDgK/iyptA=
X-Google-Smtp-Source: AFSGD/VzqYAPgBxGjaQf7xQSiLm8CBXzsP+XFfqEPJeN03p+JFiwoL6oMgwpqXcqH/cYmBeQ/amWuQ==
X-Received: by 2002:a19:d5:: with SMTP id 204mr4481273lfa.116.1543625229154;
        Fri, 30 Nov 2018 16:47:09 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id w193sm1068824lff.24.2018.11.30.16.47.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:47:09 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id u6-v6so6560893ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:47:09 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr5547506ljh.174.1543624729442;
 Fri, 30 Nov 2018 16:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org> <20181127180349.29997-2-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-2-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 30 Nov 2018 16:38:12 -0800
X-Gmail-Original-Message-ID: <CAE=gft5jWZgzRTNB4m0ES+g=rpjACYWVissmEQ+pgPGKEffgog@mail.gmail.com>
Message-ID: <CAE=gft5jWZgzRTNB4m0ES+g=rpjACYWVissmEQ+pgPGKEffgog@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] interconnect: Add generic on-chip interconnect API
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>,
        maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>,
        thierry.reding@gmail.com, ksitaraman@nvidia.com,
        sanjayc@nvidia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> This patch introduces a new API to get requirements and configure the
> interconnect buses across the entire chipset to fit with the current
> demand.
>
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) between endpoints and
> set the desired constraints on this data flow path. The providers receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and

Strange word ordering. Consider something like: "Then the providers
configure each node participating in the topology"

...Or a slightly different flavor: "Then the providers configure each
node along the path to support a bandwidth that satisfies all
bandwidth requests that cross through that node".

> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>

This already has my reviewed by, and I still stand by it, but I
couldn't help finding some nits anyway. Sorry :)

> ---
>  Documentation/interconnect/interconnect.rst |  94 ++++
>  drivers/Kconfig                             |   2 +
>  drivers/Makefile                            |   1 +
>  drivers/interconnect/Kconfig                |  10 +
>  drivers/interconnect/Makefile               |   5 +
>  drivers/interconnect/core.c                 | 569 ++++++++++++++++++++
>  include/linux/interconnect-provider.h       | 125 +++++
>  include/linux/interconnect.h                |  51 ++
>  8 files changed, 857 insertions(+)
>  create mode 100644 Documentation/interconnect/interconnect.rst
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/core.c
>  create mode 100644 include/linux/interconnect-provider.h
>  create mode 100644 include/linux/interconnect.h
>
...
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> new file mode 100644
> index 000000000000..3ae8e5a58969
> --- /dev/null
> +++ b/drivers/interconnect/core.c
> @@ -0,0 +1,569 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Interconnect framework core driver
> + *
> + * Copyright (c) 2018, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/idr.h>
> +#include <linux/init.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/overflow.h>
> +
> +static DEFINE_IDR(icc_idr);
> +static LIST_HEAD(icc_providers);
> +static DEFINE_MUTEX(icc_lock);
> +
> +/**
> + * struct icc_req - constraints that are attached to each node
> + * @req_node: entry in list of requests for the particular @node
> + * @node: the interconnect node to which this constraint applies
> + * @dev: reference to the device that sets the constraints
> + * @avg_bw: an integer describing the average bandwidth in kBps
> + * @peak_bw: an integer describing the peak bandwidth in kBps
> + */
> +struct icc_req {
> +       struct hlist_node req_node;
> +       struct icc_node *node;
> +       struct device *dev;
> +       u32 avg_bw;
> +       u32 peak_bw;
> +};
> +
> +/**
> + * struct icc_path - interconnect path structure
> + * @num_nodes: number of hops (nodes)
> + * @reqs: array of the requests applicable to this path of nodes
> + */
> +struct icc_path {
> +       size_t num_nodes;
> +       struct icc_req reqs[];
> +};
> +
> +static struct icc_node *node_find(const int id)
> +{
> +       return idr_find(&icc_idr, id);
> +}
> +
> +static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
> +                                 ssize_t num_nodes)
> +{
> +       struct icc_node *node = dst;
> +       struct icc_path *path;
> +       int i;
> +
> +       path = kzalloc(struct_size(path, reqs, num_nodes), GFP_KERNEL);
> +       if (!path)
> +               return ERR_PTR(-ENOMEM);
> +
> +       path->num_nodes = num_nodes;
> +
> +       for (i = num_nodes - 1; i >= 0; i--) {
> +               node->provider->users++;
> +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
> +               path->reqs[i].node = node;
> +               path->reqs[i].dev = dev;
> +               /* reference to previous node was saved during path traversal */
> +               node = node->reverse;
> +       }
> +
> +       return path;
> +}
> +
> +static struct icc_path *path_find(struct device *dev, struct icc_node *src,
> +                                 struct icc_node *dst)
> +{
> +       struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
> +       struct icc_node *n, *node = NULL;
> +       struct list_head traverse_list;
> +       struct list_head edge_list;
> +       struct list_head visited_list;
> +       size_t i, depth = 1;
> +       bool found = false;
> +
> +       INIT_LIST_HEAD(&traverse_list);
> +       INIT_LIST_HEAD(&edge_list);
> +       INIT_LIST_HEAD(&visited_list);
> +
> +       list_add(&src->search_list, &traverse_list);
> +       src->reverse = NULL;
> +
> +       do {
> +               list_for_each_entry_safe(node, n, &traverse_list, search_list) {
> +                       if (node == dst) {
> +                               found = true;
> +                               list_splice_init(&edge_list, &visited_list);
> +                               list_splice_init(&traverse_list, &visited_list);
> +                               break;
> +                       }
> +                       for (i = 0; i < node->num_links; i++) {
> +                               struct icc_node *tmp = node->links[i];
> +
> +                               if (!tmp) {
> +                                       path = ERR_PTR(-ENOENT);
> +                                       goto out;
> +                               }
> +
> +                               if (tmp->is_traversed)
> +                                       continue;
> +
> +                               tmp->is_traversed = true;
> +                               tmp->reverse = node;
> +                               list_add_tail(&tmp->search_list, &edge_list);
> +                       }
> +               }
> +
> +               if (found)
> +                       break;
> +
> +               list_splice_init(&traverse_list, &visited_list);
> +               list_splice_init(&edge_list, &traverse_list);
> +
> +               /* count the hops including the source */
> +               depth++;
> +
> +       } while (!list_empty(&traverse_list));
> +
> +out:
> +
> +       /* reset the traversed state */
> +       list_for_each_entry_reverse(n, &visited_list, search_list)
> +               n->is_traversed = false;
> +
> +       if (found)
> +               path = path_init(dev, dst, depth);
> +
> +       return path;
> +}
> +
> +/*
> + * We want the path to honor all bandwidth requests, so the average and peak
> + * bandwidth requirements from each consumer are aggregated at each node.
> + * The aggregation is platform specific, so each platform can customize it by
> + * implementing it's own aggregate() function.

Grammar police: remove the apostrophe in its.

> + */
> +
> +static int aggregate_requests(struct icc_node *node)
> +{
> +       struct icc_provider *p = node->provider;
> +       struct icc_req *r;
> +
> +       node->avg_bw = 0;
> +       node->peak_bw = 0;
> +
> +       hlist_for_each_entry(r, &node->req_list, req_node)
> +               p->aggregate(node, r->avg_bw, r->peak_bw,
> +                            &node->avg_bw, &node->peak_bw);
> +
> +       return 0;
> +}
> +
> +static int apply_constraints(struct icc_path *path)
> +{
> +       struct icc_node *next, *prev = NULL;
> +       int ret = -EINVAL;
> +       int i;
> +
> +       for (i = 0; i < path->num_nodes; i++, prev = next) {
> +               struct icc_provider *p;
> +
> +               next = path->reqs[i].node;
> +               /*
> +                * Both endpoints should be valid master-slave pairs of the
> +                * same interconnect provider that will be configured.
> +                */
> +               if (!prev || next->provider != prev->provider)
> +                       continue;

I wonder if we should explicitly ban paths where we bounce through an
odd number of nodes within one provider. Otherwise, set() won't be
called on all nodes in the path. Or, if we wanted to support those
kinds of topologies, you could call set with one of the nodes set to
NULL to represent either the ingress or egress bandwidth to this NoC.
This doesn't necessarily need to be addressed in this series, but is
something that other providers might bump into when implementing their
topologies.

> +
> +               p = next->provider;
> +
> +               /* set the constraints */
> +               ret = p->set(prev, next);
> +               if (ret)
> +                       goto out;
> +       }
> +out:
> +       return ret;
> +}
> +
...
> +
> +/**
> + * icc_link_destroy() - destroy a link between two nodes
> + * @src: pointer to source node
> + * @dst: pointer to destination node
> + *
> + * Return: 0 on success, or an error code otherwise
> + */
> +int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
> +{
> +       struct icc_node **new;
> +       size_t slot;
> +       int ret = 0;
> +
> +       if (IS_ERR_OR_NULL(src))
> +               return -EINVAL;
> +
> +       if (IS_ERR_OR_NULL(dst))
> +               return -EINVAL;
> +
> +       mutex_lock(&icc_lock);
> +
> +       for (slot = 0; slot < src->num_links; slot++)
> +               if (src->links[slot] == dst)
> +                       break;
> +
> +       if (WARN_ON(slot == src->num_links)) {
> +               ret = -ENXIO;
> +               goto out;
> +       }
> +
> +       src->links[slot] = src->links[--src->num_links];
> +
> +       new = krealloc(src->links,
> +                      (src->num_links) * sizeof(*src->links),

These parentheses aren't needed.

> +                      GFP_KERNEL);
> +       if (new)
> +               src->links = new;
> +
> +out:
> +       mutex_unlock(&icc_lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(icc_link_destroy);
> +
> +/**
> + * icc_node_add() - add interconnect node to interconnect provider
> + * @node: pointer to the interconnect node
> + * @provider: pointer to the interconnect provider
> + */
> +void icc_node_add(struct icc_node *node, struct icc_provider *provider)
> +{
> +       mutex_lock(&icc_lock);
> +
> +       node->provider = provider;
> +       list_add_tail(&node->node_list, &provider->nodes);
> +
> +       mutex_unlock(&icc_lock);
> +}
> +EXPORT_SYMBOL_GPL(icc_node_add);
> +
> +/**
> + * icc_node_del() - delete interconnect node from interconnect provider
> + * @node: pointer to the interconnect node
> + */
> +void icc_node_del(struct icc_node *node)
> +{
> +       mutex_lock(&icc_lock);
> +
> +       list_del(&node->node_list);
> +
> +       mutex_unlock(&icc_lock);
> +}
> +EXPORT_SYMBOL_GPL(icc_node_del);
> +
> +/**
> + * icc_provider_add() - add a new interconnect provider
> + * @provider: the interconnect provider that will be added into topology
> + *
> + * Return: 0 on success, or an error code otherwise
> + */
> +int icc_provider_add(struct icc_provider *provider)
> +{
> +       if (WARN_ON(!provider->set))
> +               return -EINVAL;
> +
> +       mutex_lock(&icc_lock);
> +
> +       INIT_LIST_HEAD(&provider->nodes);
> +       list_add_tail(&provider->provider_list, &icc_providers);
> +
> +       mutex_unlock(&icc_lock);
> +
> +       dev_dbg(provider->dev, "interconnect provider added to topology\n");
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(icc_provider_add);
> +
> +/**
> + * icc_provider_del() - delete previously added interconnect provider
> + * @provider: the interconnect provider that will be removed from topology
> + *
> + * Return: 0 on success, or an error code otherwise
> + */
> +int icc_provider_del(struct icc_provider *provider)
> +{
> +       mutex_lock(&icc_lock);
> +       if (provider->users) {
> +               pr_warn("interconnect provider still has %d users\n",
> +                       provider->users);
> +               mutex_unlock(&icc_lock);
> +               return -EBUSY;
> +       }
> +
> +       if (!list_empty(&provider->nodes)) {
> +               pr_warn("interconnect provider still has nodes\n");
> +               mutex_unlock(&icc_lock);
> +               return -EBUSY;
> +       }
> +
> +       list_del(&provider->provider_list);
> +       mutex_unlock(&icc_lock);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(icc_provider_del);
> +
> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");

This is missing the closing >

> +MODULE_DESCRIPTION("Interconnect Driver Core");
> +MODULE_LICENSE("GPL v2");
...
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> new file mode 100644
> index 000000000000..04b2966ded9f
> --- /dev/null
> +++ b/include/linux/interconnect.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#ifndef __LINUX_INTERCONNECT_H
> +#define __LINUX_INTERCONNECT_H
> +
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +/* macros for converting to icc units */
> +#define bps_to_icc(x)  (1)
> +#define kBps_to_icc(x) (x)
> +#define MBps_to_icc(x) (x * 1000)
> +#define GBps_to_icc(x) (x * 1000 * 1000)
> +#define kbps_to_icc(x) (x / 8 + ((x) % 8 ? 1 : 0))
> +#define Mbps_to_icc(x) (x * 1000 / 8 )

Remove extra space before )

> +#define Gbps_to_icc(x) (x * 1000 * 1000 / 8)
> +
> +struct icc_path;
> +struct device;
> +
> +#if IS_ENABLED(CONFIG_INTERCONNECT)
> +
> +struct icc_path *icc_get(struct device *dev, const int src_id,
> +                        const int dst_id);
> +void icc_put(struct icc_path *path);
> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
> +
> +#else
> +
> +static inline struct icc_path *icc_get(struct device *dev, const int src_id,
> +                                      const int dst_id)
> +{
> +       return NULL;
> +}
> +
> +static inline void icc_put(struct icc_path *path)
> +{
> +}
> +
> +static inline int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
> +{
> +       return 0;

Should this really succeed?

> +}
> +
> +#endif /* CONFIG_INTERCONNECT */
> +
> +#endif /* __LINUX_INTERCONNECT_H */
