Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B94FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC4520936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LHg9PCNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC4520936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeGJWgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:36:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36265 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732305AbeGJWgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:36:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id u7-v6so15304837lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99PhnCI8SAO7VYII+DVXvsSRLduNltNFWXqELsb8mwE=;
        b=LHg9PCNi1gmycf8q6bFE1ulL7Q42qGM18Qw2tRzu3j+9nXQ3CHnTMu702qlLJfxrnO
         hE651vXVGHWyIazam85O2KEWuj/M++JlrQbS66UBKDJKYZ0R6095py7XjmNdG6I1a9I3
         YfoUto4N18JL+POfhcXon8yCKLIZJZ7xS8J/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99PhnCI8SAO7VYII+DVXvsSRLduNltNFWXqELsb8mwE=;
        b=sB2I3u7LJfq+DCGGY+5aew4+/KTT1iPRCt4E5b+l6YvVZiGAj8gxcj8hdrpoe7cB0F
         thOGL790V6YVYJLTHmC68cjIOHzWI5VEdsxGh3352pV2zIIZ6DKA0N1lecKK6Kg6QRC5
         RWnD/ZdimWou5koECiHsW047U/fj5V2gT78azKZCKPQ3Wz8yVUJL1DxFJKl/pw4kLVxC
         vLPU8gpjjK9Bu7XI6kprvjobSlQkZCUI1pH5Mg3kbxwJIunUfuKdI40sbgyLZ4MFMkHr
         sz5HniLKq+1kUeX/XFGRWJWZsx6PLQbULGNgr0LEnKsiIWqIKvrcdWEV0Wut++qI16ZZ
         hEJw==
X-Gm-Message-State: APt69E3iy7ADcMmaxmdGIrL+Qq1ed3qgMLw69Ha89KX/VIc7vnvc3YbF
        EzCn/ITqecAyJtDnDe21oBHWORp+6iM=
X-Google-Smtp-Source: AAOMgpfBTfOFoiBrbBH11t7afiiAYpo1e1akYKVH/sKXYpwONpP+I5PEXZ8d1E4oVyuaGtvithgh6A==
X-Received: by 2002:a2e:195c:: with SMTP id p89-v6mr17416582lje.138.1531262090002;
        Tue, 10 Jul 2018 15:34:50 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id o86-v6sm1498377lfi.82.2018.07.10.15.34.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 15:34:48 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 203-v6so6899822ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:34:47 -0700 (PDT)
X-Received: by 2002:a2e:5519:: with SMTP id j25-v6mr15971547ljb.124.1531262086972;
 Tue, 10 Jul 2018 15:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180709155104.25528-1-georgi.djakov@linaro.org> <20180709155104.25528-2-georgi.djakov@linaro.org>
In-Reply-To: <20180709155104.25528-2-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 10 Jul 2018 15:34:09 -0700
X-Gmail-Original-Message-ID: <CAE=gft51A7Jjvee=H-ury8EFB6AbMaywZ2Tw=EtjFjFPrpbmug@mail.gmail.com>
Message-ID: <CAE=gft51A7Jjvee=H-ury8EFB6AbMaywZ2Tw=EtjFjFPrpbmug@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] interconnect: Add generic on-chip interconnect API
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Alexandre Bailon <abailon@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mka@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoy Georgi!
On Mon, Jul 9, 2018 at 8:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
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
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/interconnect/interconnect.rst |  96 ++++
>  drivers/Kconfig                             |   2 +
>  drivers/Makefile                            |   1 +
>  drivers/interconnect/Kconfig                |  10 +
>  drivers/interconnect/Makefile               |   2 +
>  drivers/interconnect/core.c                 | 597 ++++++++++++++++++++
>  include/linux/interconnect-provider.h       | 130 +++++
>  include/linux/interconnect.h                |  42 ++
>  8 files changed, 880 insertions(+)
>  create mode 100644 Documentation/interconnect/interconnect.rst
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/core.c
>  create mode 100644 include/linux/interconnect-provider.h
>  create mode 100644 include/linux/interconnect.h
>
> diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/interconnect/interconnect.rst
> new file mode 100644
> index 000000000000..a1ebd83ad0a1
> --- /dev/null
> +++ b/Documentation/interconnect/interconnect.rst
> @@ -0,0 +1,96 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +GENERIC SYSTEM INTERCONNECT SUBSYSTEM
> +=====================================
> +
> +Introduction
> +------------
> +
> +This framework is designed to provide a standard kernel interface to control
> +the settings of the interconnects on a SoC. These settings can be throughput,
> +latency and priority between multiple interconnected devices or functional
> +blocks. This can be controlled dynamically in order to save power or provide
> +maximum performance.
> +
> +The interconnect bus is a hardware with configurable parameters, which can be
> +set on a data path according to the requests received from various drivers.
> +An example of interconnect buses are the interconnects between various
> +components or functional blocks in chipsets. There can be multiple interconnects
> +on a SoC that can be multi-tiered.
> +
> +Below is a simplified diagram of a real-world SoC interconnect bus topology.
> +
> +::
> +
> + +----------------+    +----------------+
> + | HW Accelerator |--->|      M NoC     |<---------------+
> + +----------------+    +----------------+                |
> +                         |      |                    +------------+
> +  +-----+  +-------------+      V       +------+     |            |
> +  | DDR |  |                +--------+  | PCIe |     |            |
> +  +-----+  |                | Slaves |  +------+     |            |
> +    ^ ^    |                +--------+     |         |   C NoC    |
> +    | |    V                               V         |            |
> + +------------------+   +------------------------+   |            |   +-----+
> + |                  |-->|                        |-->|            |-->| CPU |
> + |                  |-->|                        |<--|            |   +-----+
> + |     Mem NoC      |   |         S NoC          |   +------------+
> + |                  |<--|                        |---------+    |
> + |                  |<--|                        |<------+ |    |   +--------+
> + +------------------+   +------------------------+       | |    +-->| Slaves |
> +   ^  ^    ^    ^          ^                             | |        +--------+
> +   |  |    |    |          |                             | V
> + +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
> + | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
> + +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
> +           |
> +       +-------+
> +       | Modem |
> +       +-------+
> +
> +Terminology
> +-----------
> +
> +Interconnect provider is the software definition of the interconnect hardware.
> +The interconnect providers on the above diagram are M NoC, S NoC, C NoC, P NoC
> +and Mem NoC.
> +
> +Interconnect node is the software definition of the interconnect hardware
> +port. Each interconnect provider consists of multiple interconnect nodes,
> +which are connected to other SoC components including other interconnect
> +providers. The point on the diagram where the CPUs connects to the memory is

CPUs connect

> +called an interconnect node, which belongs to the Mem NoC interconnect provider.
> +
> +Interconnect endpoints are the first or the last element of the path. Every
> +endpoint is a node, but not every node is an endpoint.
> +
> +Interconnect path is everything between two endpoints including all the nodes
> +that have to be traversed to reach from a source to destination node. It may
> +include multiple master-slave pairs across several interconnect providers.
> +
> +Interconnect consumers are the entities which make use of the data paths exposed
> +by the providers. The consumers send requests to providers requesting various
> +throughput, latency and priority. Usually the consumers are device drivers, that
> +send request based on their needs. An example for a consumer is a video decoder
> +that supports various formats and image sizes.
> +
> +Interconnect providers
> +----------------------
> +
> +Interconnect provider is an entity that implements methods to initialize and
> +configure a interconnect bus hardware. The interconnect provider drivers should
> +be registered with the interconnect provider core.
> +
> +The interconnect framework provider API functions are documented in
> +.. kernel-doc:: include/linux/interconnect-provider.h
> +
> +Interconnect consumers
> +----------------------
> +
> +Interconnect consumers are the clients which use the interconnect APIs to
> +get paths between endpoints and set their bandwidth/latency/QoS requirements
> +for these interconnect paths.
> +
> +The interconnect framework consumer API functions are documented in
> +.. kernel-doc:: include/linux/interconnect.h
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 95b9ccc08165..3ed6ede9d021 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -217,4 +217,6 @@ source "drivers/siox/Kconfig"
>
>  source "drivers/slimbus/Kconfig"
>
> +source "drivers/interconnect/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 24cd47014657..0cca95740d9b 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -185,3 +185,4 @@ obj-$(CONFIG_TEE)           += tee/
>  obj-$(CONFIG_MULTIPLEXER)      += mux/
>  obj-$(CONFIG_UNISYS_VISORBUS)  += visorbus/
>  obj-$(CONFIG_SIOX)             += siox/
> +obj-$(CONFIG_INTERCONNECT)     += interconnect/
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> new file mode 100644
> index 000000000000..a261c7d41deb
> --- /dev/null
> +++ b/drivers/interconnect/Kconfig
> @@ -0,0 +1,10 @@
> +menuconfig INTERCONNECT
> +       tristate "On-Chip Interconnect management support"
> +       help
> +         Support for management of the on-chip interconnects.
> +
> +         This framework is designed to provide a generic interface for
> +         managing the interconnects in a SoC.
> +
> +         If unsure, say no.
> +
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> new file mode 100644
> index 000000000000..97fca2e09d24
> --- /dev/null
> +++ b/drivers/interconnect/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_INTERCONNECT)             += core.o
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> new file mode 100644
> index 000000000000..63707c3c3d48
> --- /dev/null
> +++ b/drivers/interconnect/core.c
> @@ -0,0 +1,597 @@
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

I needed to add #include <linux/overflow.h> to get struct_size() (used
in path_init) in order to get this to compile, but maybe my kernel is
missing some upstream picks.

> +#include <linux/slab.h>
> +
> +static DEFINE_IDR(icc_idr);
> +static LIST_HEAD(icc_provider_list);
> +static DEFINE_MUTEX(icc_lock);
> +
> +/**
> + * struct icc_req - constraints that are attached to each node
> + *
> + * @req_node: entry in list of requests for the particular @node
> + * @node: the interconnect node to which this constraint applies
> + * @dev: reference to the device that sets the constraints
> + * @avg_bw: an integer describing the average bandwidth in kbps
> + * @peak_bw: an integer describing the peak bandwidth in kbps
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

Wasn't there going to be a warning if the mutex is not held?

> +}
> +
> +static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
> +                                 ssize_t num_nodes)
> +{
> +       struct icc_node *node = dst;
> +       struct icc_path *path;
> +       size_t i;
> +
> +       path = kzalloc(struct_size(path, reqs, num_nodes), GFP_KERNEL);
> +       if (!path)
> +               return ERR_PTR(-ENOMEM);
> +
> +       path->num_nodes = num_nodes;
> +

There should probably also be a warning here about holding the lock,
since you're modifying node->req_list.

> +       for (i = 0; i < num_nodes; i++) {
> +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
> +
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
> +       struct icc_node *n, *node = NULL;
> +       struct icc_provider *provider;
> +       struct list_head traverse_list;
> +       struct list_head edge_list;
> +       struct list_head visited_list;
> +       size_t i, depth = 1;
> +       bool found = false;
> +       int ret = -EPROBE_DEFER;
> +
> +       INIT_LIST_HEAD(&traverse_list);
> +       INIT_LIST_HEAD(&edge_list);
> +       INIT_LIST_HEAD(&visited_list);
> +

A warning here too about holding the lock would also be good, since
multiple people in here at once would be bad.

> +       list_add_tail(&src->search_list, &traverse_list);
> +       src->reverse = NULL;
> +
> +       do {
> +               list_for_each_entry_safe(node, n, &traverse_list, search_list) {
> +                       if (node == dst) {
> +                               found = true;
> +                               list_add(&node->search_list, &visited_list);
> +                               break;
> +                       }
> +                       for (i = 0; i < node->num_links; i++) {
> +                               struct icc_node *tmp = node->links[i];
> +
> +                               if (!tmp) {
> +                                       ret = -ENOENT;
> +                                       goto out;
> +                               }
> +
> +                               if (tmp->is_traversed)
> +                                       continue;
> +
> +                               tmp->is_traversed = true;
> +                               tmp->reverse = node;
> +                               list_add(&tmp->search_list, &edge_list);
> +                       }
> +               }
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
> +       /* reset the traversed state */
> +       list_for_each_entry(provider, &icc_provider_list, provider_list)
> +               list_for_each_entry(n, &provider->nodes, node_list)
> +                       n->is_traversed = false;

I think I missed this on the last round. I thought you had been
keeping visited_list specifically so you could use it to reset
is_traversed here. But now it looks like you're going through the
entire graph. What happened?

> +
> +       if (found) {
> +               struct icc_path *path = path_init(dev, dst, depth);
> +
> +               if (IS_ERR(path))
> +                       return path;
> +
> +               for (i = 0; i < path->num_nodes; i++) {
> +                       node = path->reqs[i].node;
> +                       node->provider->users++;

Hm, should this go in path_init as well? What do you think? You sort
of become a user once you tack your path.req_node on the
node.req_list.

> +               }
> +               return path;
> +       }
> +
> +       return ERR_PTR(ret);
> +}
> +
> +/*
> + * We want the path to honor all bandwidth requests, so the average
> + * bandwidth requirements from each consumer are aggregated at each node
> + * and provider level. By default the average bandwidth is the sum of all
> + * averages and the peak will be the highest of all peak bandwidth requests.
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

This doesn't have to be addressed in this series, but I wonder if the
aggregate() callback should be made aware of whether its aggregating
requests within a node, or nodes within a provider? Right now the
aggregate callback has no way of knowing what it's aggregating for; I
guess the question is: might it need to? I'm unsure.

> +
> +static void aggregate_provider(struct icc_provider *p)
> +{
> +       struct icc_node *n;
> +
> +       p->avg_bw = 0;
> +       p->peak_bw = 0;
> +
> +       list_for_each_entry(n, &p->nodes, node_list)
> +               p->aggregate(n, n->avg_bw, n->peak_bw,
> +                            &p->avg_bw, &p->peak_bw);
> +}
> +
> +static int apply_constraints(struct icc_path *path)
> +{
> +       struct icc_node *next, *prev = NULL;
> +       int ret;
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
> +
> +               p = next->provider;
> +
> +               aggregate_provider(p);
> +
> +               /* set the constraints */
> +               ret = p->set(prev, next, p->avg_bw, p->peak_bw);
> +               if (ret)
> +                       goto out;
> +       }
> +out:
> +       return ret;
> +}
> +
> +/**
> + * icc_set() - set constraints on an interconnect path between two endpoints
> + * @path: reference to the path returned by icc_get()
> + * @avg_bw: average bandwidth in kbps
> + * @peak_bw: peak bandwidth in kbps
> + *
> + * This function is used by an interconnect consumer to express its own needs
> + * in terms of bandwidth for a previously requested path between two endpoints.
> + * The requests are aggregated and each node is updated accordingly. The entire
> + * path is locked by a mutex to ensure that the set() is completed.
> + * The @path can be NULL when the "interconnects" DT properties is missing,
> + * which will mean that no constraints will be set.
> + *
> + * Returns 0 on success, or an appropriate error code otherwise.
> + */
> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
> +{
> +       struct icc_node *node;
> +       struct icc_provider *p;
> +       size_t i;
> +       int ret;
> +
> +       if (!path)
> +               return 0;
> +
> +       mutex_lock(&icc_lock);
> +
> +       for (i = 0; i < path->num_nodes; i++) {
> +               node = path->reqs[i].node;
> +               p = node->provider;
> +
> +               /* update the consumer request for this path */
> +               path->reqs[i].avg_bw = avg_bw;
> +               path->reqs[i].peak_bw = peak_bw;
> +
> +               /* aggregate requests for this node */
> +               aggregate_requests(node);
> +       }
> +
> +       ret = apply_constraints(path);
> +       if (ret)
> +               pr_err("interconnect: error applying constraints (%d)", ret);
> +
> +       mutex_unlock(&icc_lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(icc_set);
> +
> +/**
> + * icc_get() - return a handle for path between two endpoints
> + * @dev: the device requesting the path
> + * @src_id: source device port id
> + * @dst_id: destination device port id
> + *
> + * This function will search for a path between two endpoints and return an
> + * icc_path handle on success. Use icc_put() to release
> + * constraints when the they are not needed anymore.
> + *
> + * Return: icc_path pointer on success, or ERR_PTR() on error
> + */
> +struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
> +{
> +       struct icc_node *src, *dst;
> +       struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
> +
> +       mutex_lock(&icc_lock);
> +
> +       src = node_find(src_id);
> +       if (!src)
> +               goto out;
> +
> +       dst = node_find(dst_id);
> +       if (!dst)
> +               goto out;
> +
> +       path = path_find(dev, src, dst);
> +       if (IS_ERR(path))
> +               dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> +
> +out:
> +       mutex_unlock(&icc_lock);
> +       return path;
> +}
> +EXPORT_SYMBOL_GPL(icc_get);
> +
> +/**
> + * icc_put() - release the reference to the icc_path
> + * @path: interconnect path
> + *
> + * Use this function to release the constraints on a path when the path is
> + * no longer needed. The constraints will be re-aggregated.
> + */
> +void icc_put(struct icc_path *path)
> +{
> +       struct icc_node *node;
> +       size_t i;
> +       int ret;
> +
> +       if (!path || WARN_ON(IS_ERR(path)))
> +               return;
> +
> +       ret = icc_set(path, 0, 0);
> +       if (ret)
> +               pr_err("%s: error (%d)\n", __func__, ret);
> +
> +       mutex_lock(&icc_lock);
> +       for (i = 0; i < path->num_nodes; i++) {
> +               node = path->reqs[i].node;
> +               hlist_del(&path->reqs[i].req_node);
> +

Maybe a warning if users is zero?

> +               node->provider->users--;
> +       }
> +       mutex_unlock(&icc_lock);
> +
> +       kfree(path);
> +}
> +EXPORT_SYMBOL_GPL(icc_put);
> +
> +static struct icc_node *icc_node_create_nolock(int id)
> +{
> +       struct icc_node *node;
> +
> +       /* check if node already exists */
> +       node = node_find(id);
> +       if (node)
> +               goto out;
> +
> +       node = kzalloc(sizeof(*node), GFP_KERNEL);
> +       if (!node) {
> +               node = ERR_PTR(-ENOMEM);
> +               goto out;
> +       }
> +
> +       id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
> +       if (WARN(id < 0, "couldn't get idr")) {
> +               kfree(node);
> +               node = ERR_PTR(id);
> +               goto out;
> +       }
> +
> +       node->id = id;
> +
> +out:
> +       return node;
> +}
> +
> +/**
> + * icc_node_create() - create a node
> + * @id: node id
> + *
> + * Return: icc_node pointer on success, or ERR_PTR() on error
> + */
> +struct icc_node *icc_node_create(int id)
> +{
> +       struct icc_node *node;
> +
> +       mutex_lock(&icc_lock);
> +
> +       node = icc_node_create_nolock(id);
> +
> +       mutex_unlock(&icc_lock);
> +
> +       return node;
> +}
> +EXPORT_SYMBOL_GPL(icc_node_create);
> +
> +/**
> + * icc_node_destroy() - destroy a node
> + * @id: node id
> + *
> + */
> +void icc_node_destroy(int id)
> +{
> +       struct icc_node *node;
> +
> +       node = node_find(id);
> +       if (node) {
> +               mutex_lock(&icc_lock);

mutex_lock should be moved above node_find, since node_find needs the lock held.

> +               idr_remove(&icc_idr, node->id);
> +               WARN_ON(!hlist_empty(&node->req_list));
> +               mutex_unlock(&icc_lock);
> +       }
> +
> +       kfree(node);
> +}
> +EXPORT_SYMBOL_GPL(icc_node_destroy);
> +
> +/**
> + * icc_link_create() - create a link between two nodes
> + * @src_id: source node id
> + * @dst_id: destination node id
> + *
> + * Create a link between two nodes. The nodes might belong to different
> + * interconnect providers and the @dst_id node might not exist (if the
> + * provider driver has not probed yet). So just create the @dst_id node
> + * and when the actual provider driver is probed, the rest of the node
> + * data is filled.
> + *
> + * Return: 0 on success, or an error code otherwise
> + */
> +int icc_link_create(struct icc_node *node, const int dst_id)
> +{
> +       struct icc_node *dst;
> +       struct icc_node **new;
> +       int ret = 0;
> +
> +       if (!node->provider)
> +               return -EINVAL;
> +
> +       mutex_lock(&icc_lock);
> +
> +       dst = node_find(dst_id);
> +       if (!dst) {
> +               dst = icc_node_create_nolock(dst_id);
> +
> +               if (IS_ERR(dst)) {
> +                       ret = PTR_ERR(dst);
> +                       goto out;
> +               }
> +       }
> +
> +       new = krealloc(node->links,
> +                      (node->num_links + 1) * sizeof(*node->links),
> +                      GFP_KERNEL);
> +       if (!new) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       node->links = new;
> +       node->links[node->num_links++] = dst;
> +
> +out:
> +       mutex_unlock(&icc_lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(icc_link_create);
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
> +       struct icc_node *last;
> +       int ret = 0;
> +       size_t slot;
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

How about a warning or failure if slot == src->num_links, meaning
someone is trying to tear down a link they never set up.

> +       last = src->links[src->num_links];

Shouldn't it be src->num_links - 1?

> +
> +       new = krealloc(src->links,
> +                      (src->num_links - 1) * sizeof(*src->links),
> +                      GFP_KERNEL);
> +       if (!new) {
> +               ret = -ENOMEM;
> +               goto out;

It's technically not really a problem if this realloc fails, right?
Your old array should still be valid, and it's big enough to hold
everything you wanted. Just only assign src->link = new if realloc
succeeds.

> +       }
> +
> +       src->links = new;
> +
> +       if (slot < src->num_links - 1)
> +               /* move the last element to the slot that was freed */
> +               src->links[slot] = last;

If you moved this above the realloc, then you could do away with the
conditional part of it, since at worst it would end up being:
src->links[num_links - 1] = src->links[num_links - 1]; which is a
no-op. You also wouldn't need the "last" local either.
