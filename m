Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99711ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261A4204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZolqAu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261A4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbeGTPUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:20:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34129 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733101AbeGTPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:20:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so11543620wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 07:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+TFdCDZJNr0T4JB7V0C2iAi94fNPoPFDJKITysrIN9c=;
        b=LZolqAu9i+A/CC2IBWYUkIO0OLlxy+Q+9ReyxZe+bgZZopvm1Q/k7ekJhCcoTNVwks
         M2bwSwVA/1y5e9aQ0b+VzOR+mKmwXisJoBX5iMLrnau06U/VQmSiSFULbyBNyYpoYrXC
         g5lHAkD/W8cgGnmwN++NAFeGzbFwMMCNqqZHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+TFdCDZJNr0T4JB7V0C2iAi94fNPoPFDJKITysrIN9c=;
        b=nMuIAahuq1tFhClSuVeZUyzDvbz4atdQ03lxi97WBmXkAp22TfU6FSQ0xodSA5ysyD
         1OLEpY7XmSQfngV3U9XoxfdfqCUujqm1dpiWb9h6kA0TGNPq1k9VmrgYBV840mwWkMK2
         G5EvZ8iQfH7guVLsBKcgtqHB0+1FoKYDp74vplss/5oC1f6CN0FZrtT8HzoUeF+tat5g
         Nirb6ULKP9ZYmKUPexJDtPjETASh8V5GcHMeWmniMqS12hdAysseM/pR/hfLnDOwx1+m
         Mglll4FZIZhg9wNa5YMsk9PPXSql4HQPqgYDgBnJrTheL84TE4qrp/IUYlBTZ8txW748
         Vy3w==
X-Gm-Message-State: AOUpUlEqOTHTDs3EkymRfFsI3zWVA1xXuRJY/mRtvOAaCiDYpW2C4g7i
        H37ysLHda3A7hnCoy5zwo5x6Qg==
X-Google-Smtp-Source: AAOMgpckDZ8ucCHQAZ8g4vaLt97Sw+iCij24gAjeaxi1+z5gD3oAIpjNOn873oD4iQIemmxsQFD3MQ==
X-Received: by 2002:adf:8062:: with SMTP id 89-v6mr1566675wrk.221.1532097097989;
        Fri, 20 Jul 2018 07:31:37 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b15-v6sm1628912wrs.96.2018.07.20.07.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 07:31:37 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v6 1/8] interconnect: Add generic on-chip interconnect API
To:     Evan Green <evgreen@chromium.org>
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
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-2-georgi.djakov@linaro.org>
 <CAE=gft51A7Jjvee=H-ury8EFB6AbMaywZ2Tw=EtjFjFPrpbmug@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <77abeeb8-234b-9b8c-71d4-bce8e403fe9f@linaro.org>
Date:   Fri, 20 Jul 2018 17:31:34 +0300
MIME-Version: 1.0
In-Reply-To: <CAE=gft51A7Jjvee=H-ury8EFB6AbMaywZ2Tw=EtjFjFPrpbmug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Thanks for helping to improve this!

On 07/11/2018 01:34 AM, Evan Green wrote:
> Ahoy Georgi!
> On Mon, Jul 9, 2018 at 8:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> This patch introduces a new API to get requirements and configure the
>> interconnect buses across the entire chipset to fit with the current
>> demand.
>>
>> The API is using a consumer/provider-based model, where the providers are
>> the interconnect buses and the consumers could be various drivers.
>> The consumers request interconnect resources (path) between endpoints and
>> set the desired constraints on this data flow path. The providers receive
>> requests from consumers and aggregate these requests for all master-slave
>> pairs on that path. Then the providers configure each participating in the
>> topology node according to the requested data flow path, physical links and
>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---

[..]

>> +Interconnect node is the software definition of the interconnect hardware
>> +port. Each interconnect provider consists of multiple interconnect nodes,
>> +which are connected to other SoC components including other interconnect
>> +providers. The point on the diagram where the CPUs connects to the memory is
> 
> CPUs connect

Ok.

[..]

>> +
>> +#include <linux/device.h>
>> +#include <linux/idr.h>
>> +#include <linux/init.h>
>> +#include <linux/interconnect.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
> 
> I needed to add #include <linux/overflow.h> to get struct_size() (used
> in path_init) in order to get this to compile, but maybe my kernel is
> missing some upstream picks.

Yes, should be included.

>> +#include <linux/slab.h>
>> +
>> +static DEFINE_IDR(icc_idr);
>> +static LIST_HEAD(icc_provider_list);
>> +static DEFINE_MUTEX(icc_lock);
>> +
>> +/**
>> + * struct icc_req - constraints that are attached to each node
>> + *
>> + * @req_node: entry in list of requests for the particular @node
>> + * @node: the interconnect node to which this constraint applies
>> + * @dev: reference to the device that sets the constraints
>> + * @avg_bw: an integer describing the average bandwidth in kbps
>> + * @peak_bw: an integer describing the peak bandwidth in kbps
>> + */
>> +struct icc_req {
>> +       struct hlist_node req_node;
>> +       struct icc_node *node;
>> +       struct device *dev;
>> +       u32 avg_bw;
>> +       u32 peak_bw;
>> +};
>> +
>> +/**
>> + * struct icc_path - interconnect path structure
>> + * @num_nodes: number of hops (nodes)
>> + * @reqs: array of the requests applicable to this path of nodes
>> + */
>> +struct icc_path {
>> +       size_t num_nodes;
>> +       struct icc_req reqs[];
>> +};
>> +
>> +static struct icc_node *node_find(const int id)
>> +{
>> +       return idr_find(&icc_idr, id);
> 
> Wasn't there going to be a warning if the mutex is not held?

I think that it would be really useful if the functions are exported,
but for now let's skip it.

>> +}
>> +
>> +static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
>> +                                 ssize_t num_nodes)
>> +{
>> +       struct icc_node *node = dst;
>> +       struct icc_path *path;
>> +       size_t i;
>> +
>> +       path = kzalloc(struct_size(path, reqs, num_nodes), GFP_KERNEL);
>> +       if (!path)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       path->num_nodes = num_nodes;
>> +
> 
> There should probably also be a warning here about holding the lock,
> since you're modifying node->req_list.

This is called only by path_find() with the lock held.

>> +       for (i = 0; i < num_nodes; i++) {
>> +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
>> +
>> +               path->reqs[i].node = node;
>> +               path->reqs[i].dev = dev;
>> +               /* reference to previous node was saved during path traversal */
>> +               node = node->reverse;
>> +       }
>> +
>> +       return path;
>> +}
>> +
>> +static struct icc_path *path_find(struct device *dev, struct icc_node *src,
>> +                                 struct icc_node *dst)
>> +{
>> +       struct icc_node *n, *node = NULL;
>> +       struct icc_provider *provider;
>> +       struct list_head traverse_list;
>> +       struct list_head edge_list;
>> +       struct list_head visited_list;
>> +       size_t i, depth = 1;
>> +       bool found = false;
>> +       int ret = -EPROBE_DEFER;
>> +
>> +       INIT_LIST_HEAD(&traverse_list);
>> +       INIT_LIST_HEAD(&edge_list);
>> +       INIT_LIST_HEAD(&visited_list);
>> +
> 
> A warning here too about holding the lock would also be good, since
> multiple people in here at once would be bad.

This is only called by icc_get() with locked mutex.

>> +       list_add_tail(&src->search_list, &traverse_list);
>> +       src->reverse = NULL;
>> +
>> +       do {
>> +               list_for_each_entry_safe(node, n, &traverse_list, search_list) {
>> +                       if (node == dst) {
>> +                               found = true;
>> +                               list_add(&node->search_list, &visited_list);
>> +                               break;
>> +                       }
>> +                       for (i = 0; i < node->num_links; i++) {
>> +                               struct icc_node *tmp = node->links[i];
>> +
>> +                               if (!tmp) {
>> +                                       ret = -ENOENT;
>> +                                       goto out;
>> +                               }
>> +
>> +                               if (tmp->is_traversed)
>> +                                       continue;
>> +
>> +                               tmp->is_traversed = true;
>> +                               tmp->reverse = node;
>> +                               list_add(&tmp->search_list, &edge_list);
>> +                       }
>> +               }
>> +               if (found)
>> +                       break;
>> +
>> +               list_splice_init(&traverse_list, &visited_list);
>> +               list_splice_init(&edge_list, &traverse_list);
>> +
>> +               /* count the hops including the source */
>> +               depth++;
>> +
>> +       } while (!list_empty(&traverse_list));
>> +
>> +out:
>> +       /* reset the traversed state */
>> +       list_for_each_entry(provider, &icc_provider_list, provider_list)
>> +               list_for_each_entry(n, &provider->nodes, node_list)
>> +                       n->is_traversed = false;
> 
> I think I missed this on the last round. I thought you had been
> keeping visited_list specifically so you could use it to reset
> is_traversed here. But now it looks like you're going through the
> entire graph. What happened?

Hm, will review and fix.

>> +
>> +       if (found) {
>> +               struct icc_path *path = path_init(dev, dst, depth);
>> +
>> +               if (IS_ERR(path))
>> +                       return path;
>> +
>> +               for (i = 0; i < path->num_nodes; i++) {
>> +                       node = path->reqs[i].node;
>> +                       node->provider->users++;
> 
> Hm, should this go in path_init as well? What do you think? You sort
> of become a user once you tack your path.req_node on the
> node.req_list.

Ok, will move it.

>> +               }
>> +               return path;
>> +       }
>> +
>> +       return ERR_PTR(ret);
>> +}
>> +
>> +/*
>> + * We want the path to honor all bandwidth requests, so the average
>> + * bandwidth requirements from each consumer are aggregated at each node
>> + * and provider level. By default the average bandwidth is the sum of all
>> + * averages and the peak will be the highest of all peak bandwidth requests.
>> + */
>> +
>> +static int aggregate_requests(struct icc_node *node)
>> +{
>> +       struct icc_provider *p = node->provider;
>> +       struct icc_req *r;
>> +
>> +       node->avg_bw = 0;
>> +       node->peak_bw = 0;
>> +
>> +       hlist_for_each_entry(r, &node->req_list, req_node)
>> +               p->aggregate(node, r->avg_bw, r->peak_bw,
>> +                            &node->avg_bw, &node->peak_bw);
>> +
>> +       return 0;
>> +}
> 
> This doesn't have to be addressed in this series, but I wonder if the
> aggregate() callback should be made aware of whether its aggregating
> requests within a node, or nodes within a provider? Right now the
> aggregate callback has no way of knowing what it's aggregating for; I
> guess the question is: might it need to? I'm unsure.

Currently the platforms that would be using this do not need this
differentiation, but this can be revised if needed in the future.

>> +
>> +static void aggregate_provider(struct icc_provider *p)
>> +{
>> +       struct icc_node *n;
>> +
>> +       p->avg_bw = 0;
>> +       p->peak_bw = 0;
>> +
>> +       list_for_each_entry(n, &p->nodes, node_list)
>> +               p->aggregate(n, n->avg_bw, n->peak_bw,
>> +                            &p->avg_bw, &p->peak_bw);
>> +}
>> +
>> +static int apply_constraints(struct icc_path *path)
>> +{
>> +       struct icc_node *next, *prev = NULL;
>> +       int ret;
>> +       int i;
>> +
>> +       for (i = 0; i < path->num_nodes; i++, prev = next) {
>> +               struct icc_provider *p;
>> +
>> +               next = path->reqs[i].node;
>> +               /*
>> +                * Both endpoints should be valid master-slave pairs of the
>> +                * same interconnect provider that will be configured.
>> +                */
>> +               if (!prev || next->provider != prev->provider)
>> +                       continue;
>> +
>> +               p = next->provider;
>> +
>> +               aggregate_provider(p);
>> +
>> +               /* set the constraints */
>> +               ret = p->set(prev, next, p->avg_bw, p->peak_bw);
>> +               if (ret)
>> +                       goto out;
>> +       }
>> +out:
>> +       return ret;
>> +}
>> +
>> +/**
>> + * icc_set() - set constraints on an interconnect path between two endpoints
>> + * @path: reference to the path returned by icc_get()
>> + * @avg_bw: average bandwidth in kbps
>> + * @peak_bw: peak bandwidth in kbps
>> + *
>> + * This function is used by an interconnect consumer to express its own needs
>> + * in terms of bandwidth for a previously requested path between two endpoints.
>> + * The requests are aggregated and each node is updated accordingly. The entire
>> + * path is locked by a mutex to ensure that the set() is completed.
>> + * The @path can be NULL when the "interconnects" DT properties is missing,
>> + * which will mean that no constraints will be set.
>> + *
>> + * Returns 0 on success, or an appropriate error code otherwise.
>> + */
>> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>> +{
>> +       struct icc_node *node;
>> +       struct icc_provider *p;
>> +       size_t i;
>> +       int ret;
>> +
>> +       if (!path)
>> +               return 0;
>> +
>> +       mutex_lock(&icc_lock);
>> +
>> +       for (i = 0; i < path->num_nodes; i++) {
>> +               node = path->reqs[i].node;
>> +               p = node->provider;
>> +
>> +               /* update the consumer request for this path */
>> +               path->reqs[i].avg_bw = avg_bw;
>> +               path->reqs[i].peak_bw = peak_bw;
>> +
>> +               /* aggregate requests for this node */
>> +               aggregate_requests(node);
>> +       }
>> +
>> +       ret = apply_constraints(path);
>> +       if (ret)
>> +               pr_err("interconnect: error applying constraints (%d)", ret);
>> +
>> +       mutex_unlock(&icc_lock);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_set);
>> +
>> +/**
>> + * icc_get() - return a handle for path between two endpoints
>> + * @dev: the device requesting the path
>> + * @src_id: source device port id
>> + * @dst_id: destination device port id
>> + *
>> + * This function will search for a path between two endpoints and return an
>> + * icc_path handle on success. Use icc_put() to release
>> + * constraints when the they are not needed anymore.
>> + *
>> + * Return: icc_path pointer on success, or ERR_PTR() on error
>> + */
>> +struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
>> +{
>> +       struct icc_node *src, *dst;
>> +       struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>> +
>> +       mutex_lock(&icc_lock);
>> +
>> +       src = node_find(src_id);
>> +       if (!src)
>> +               goto out;
>> +
>> +       dst = node_find(dst_id);
>> +       if (!dst)
>> +               goto out;
>> +
>> +       path = path_find(dev, src, dst);
>> +       if (IS_ERR(path))
>> +               dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
>> +
>> +out:
>> +       mutex_unlock(&icc_lock);
>> +       return path;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_get);
>> +
>> +/**
>> + * icc_put() - release the reference to the icc_path
>> + * @path: interconnect path
>> + *
>> + * Use this function to release the constraints on a path when the path is
>> + * no longer needed. The constraints will be re-aggregated.
>> + */
>> +void icc_put(struct icc_path *path)
>> +{
>> +       struct icc_node *node;
>> +       size_t i;
>> +       int ret;
>> +
>> +       if (!path || WARN_ON(IS_ERR(path)))
>> +               return;
>> +
>> +       ret = icc_set(path, 0, 0);
>> +       if (ret)
>> +               pr_err("%s: error (%d)\n", __func__, ret);
>> +
>> +       mutex_lock(&icc_lock);
>> +       for (i = 0; i < path->num_nodes; i++) {
>> +               node = path->reqs[i].node;
>> +               hlist_del(&path->reqs[i].req_node);
>> +
> 
> Maybe a warning if users is zero?

Yes, good idea.

>> +               node->provider->users--;
>> +       }
>> +       mutex_unlock(&icc_lock);
>> +
>> +       kfree(path);
>> +}
>> +EXPORT_SYMBOL_GPL(icc_put);
>> +
>> +static struct icc_node *icc_node_create_nolock(int id)
>> +{
>> +       struct icc_node *node;
>> +
>> +       /* check if node already exists */
>> +       node = node_find(id);
>> +       if (node)
>> +               goto out;
>> +
>> +       node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +       if (!node) {
>> +               node = ERR_PTR(-ENOMEM);
>> +               goto out;
>> +       }
>> +
>> +       id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
>> +       if (WARN(id < 0, "couldn't get idr")) {
>> +               kfree(node);
>> +               node = ERR_PTR(id);
>> +               goto out;
>> +       }
>> +
>> +       node->id = id;
>> +
>> +out:
>> +       return node;
>> +}
>> +
>> +/**
>> + * icc_node_create() - create a node
>> + * @id: node id
>> + *
>> + * Return: icc_node pointer on success, or ERR_PTR() on error
>> + */
>> +struct icc_node *icc_node_create(int id)
>> +{
>> +       struct icc_node *node;
>> +
>> +       mutex_lock(&icc_lock);
>> +
>> +       node = icc_node_create_nolock(id);
>> +
>> +       mutex_unlock(&icc_lock);
>> +
>> +       return node;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_node_create);
>> +
>> +/**
>> + * icc_node_destroy() - destroy a node
>> + * @id: node id
>> + *
>> + */
>> +void icc_node_destroy(int id)
>> +{
>> +       struct icc_node *node;
>> +
>> +       node = node_find(id);
>> +       if (node) {
>> +               mutex_lock(&icc_lock);
> 
> mutex_lock should be moved above node_find, since node_find needs the lock held.

Ok.

>> +               idr_remove(&icc_idr, node->id);
>> +               WARN_ON(!hlist_empty(&node->req_list));
>> +               mutex_unlock(&icc_lock);
>> +       }
>> +
>> +       kfree(node);
>> +}
>> +EXPORT_SYMBOL_GPL(icc_node_destroy);
>> +
>> +/**
>> + * icc_link_create() - create a link between two nodes
>> + * @src_id: source node id
>> + * @dst_id: destination node id
>> + *
>> + * Create a link between two nodes. The nodes might belong to different
>> + * interconnect providers and the @dst_id node might not exist (if the
>> + * provider driver has not probed yet). So just create the @dst_id node
>> + * and when the actual provider driver is probed, the rest of the node
>> + * data is filled.
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_link_create(struct icc_node *node, const int dst_id)
>> +{
>> +       struct icc_node *dst;
>> +       struct icc_node **new;
>> +       int ret = 0;
>> +
>> +       if (!node->provider)
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&icc_lock);
>> +
>> +       dst = node_find(dst_id);
>> +       if (!dst) {
>> +               dst = icc_node_create_nolock(dst_id);
>> +
>> +               if (IS_ERR(dst)) {
>> +                       ret = PTR_ERR(dst);
>> +                       goto out;
>> +               }
>> +       }
>> +
>> +       new = krealloc(node->links,
>> +                      (node->num_links + 1) * sizeof(*node->links),
>> +                      GFP_KERNEL);
>> +       if (!new) {
>> +               ret = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       node->links = new;
>> +       node->links[node->num_links++] = dst;
>> +
>> +out:
>> +       mutex_unlock(&icc_lock);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_link_create);
>> +
>> +/**
>> + * icc_link_destroy() - destroy a link between two nodes
>> + * @src: pointer to source node
>> + * @dst: pointer to destination node
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
>> +{
>> +       struct icc_node **new;
>> +       struct icc_node *last;
>> +       int ret = 0;
>> +       size_t slot;
>> +
>> +       if (IS_ERR_OR_NULL(src))
>> +               return -EINVAL;
>> +
>> +       if (IS_ERR_OR_NULL(dst))
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&icc_lock);
>> +
>> +       for (slot = 0; slot < src->num_links; slot++)
>> +               if (src->links[slot] == dst)
>> +                       break;
>> +
> 
> How about a warning or failure if slot == src->num_links, meaning
> someone is trying to tear down a link they never set up.

Ok.

>> +       last = src->links[src->num_links];
> 
> Shouldn't it be src->num_links - 1?

Yes, indeed.

>> +
>> +       new = krealloc(src->links,
>> +                      (src->num_links - 1) * sizeof(*src->links),
>> +                      GFP_KERNEL);
>> +       if (!new) {
>> +               ret = -ENOMEM;
>> +               goto out;
> 
> It's technically not really a problem if this realloc fails, right?
> Your old array should still be valid, and it's big enough to hold
> everything you wanted. Just only assign src->link = new if realloc
> succeeds.
> 
>> +       }
>> +
>> +       src->links = new;
>> +
>> +       if (slot < src->num_links - 1)
>> +               /* move the last element to the slot that was freed */
>> +               src->links[slot] = last;
> 
> If you moved this above the realloc, then you could do away with the
> conditional part of it, since at worst it would end up being:
> src->links[num_links - 1] = src->links[num_links - 1]; which is a
> no-op. You also wouldn't need the "last" local either.

Ok. Will simplify it!

Thanks,
Georgi
