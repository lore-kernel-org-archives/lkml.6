Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE3F2695A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SK1UniiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE3F2695A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbeFZXec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:34:32 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42034 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbeFZXe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:34:29 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so72616pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 16:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4NoK6Tck95gwqa4XuNsQJD0wftpbR8Mn4w7mzWDbI90=;
        b=SK1UniiE1d86cTKOvdSscRTlfHl9e0Dn6huIA35SLcPl8MZBw4unkdHmD8UYbcKPdX
         BfIHZtJAGSmug/m3XdpfEeoZzB92tzXGtS2q3V4igYm7EzE2oL85s3FcyA04q3zcGc+v
         TCsHz/dgnCJbjfmDr11a8enuNu8A39il4+Yms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4NoK6Tck95gwqa4XuNsQJD0wftpbR8Mn4w7mzWDbI90=;
        b=N8suZA8PtjMzz9+yonAf82ui3PZPAFYjbZobiXOJBXQxDlJDhmsFqHxxa5sltxCS8c
         PxZxn5KeL1WFtB9cRkcQzMJlzf0ifqAandNoxQLUZ0Di5S0stfWPJGkiu8z69r7OTo0k
         rGi+eggI/gf82wdBRI8wvQVjIYdB0UoT3KrFZxvnHMBqqA45Z3W3M4cd9tHhaW6YbBJ6
         OfFcpWTLjQPXB7d+xENZDag0Qt3oRFkQGJTDpt70MHkL53hRLDLbfiu7CTUKOYDYn9cC
         DO4g9/S0Tt34HRWWVtIj36Ftc3o143E/ixqu1YV4/KyulYwoc6ZycfTwnN1be+W7hK4U
         aI0A==
X-Gm-Message-State: APt69E2Q5f+bA0MqX1sxCvIiOUrkO92dhqJAP2OT9Ts5f2ZIjNFYjytd
        TqIwUpcXAofHHQgLwyYGFHOZzw==
X-Google-Smtp-Source: AAOMgpdGrtsQxny+2wPO8UjRC7i+9OCLXqq+uVLLVhYv/SlNxUkyJ6Lijv4zBLc1aZ+Jz4HLoPz2Dg==
X-Received: by 2002:a62:d955:: with SMTP id s82-v6mr3464550pfg.216.1530056069185;
        Tue, 26 Jun 2018 16:34:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id t6-v6sm3455175pgp.3.2018.06.26.16.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 16:34:28 -0700 (PDT)
Date:   Tue, 26 Jun 2018 16:34:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
Message-ID: <20180626233427.GR129942@google.com>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180620121141.15403-2-georgi.djakov@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

On Wed, Jun 20, 2018 at 03:11:34PM +0300, Georgi Djakov wrote:
> This patch introduce a new API to get requirements and configure the

nit: s/introduce/introduces/

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
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>
> ...
>
> +static struct icc_path *path_find(struct device *dev, struct icc_node *src,
> +				  struct icc_node *dst)
> +{
> +	struct icc_node *n, *node = NULL;
> +	struct icc_provider *provider;
> +	struct list_head traverse_list;
> +	struct list_head edge_list;
> +	struct list_head visited_list;
> +	size_t i, depth = 0;
> +	bool found = false;
> +	int ret = -EPROBE_DEFER;
> +
> +	INIT_LIST_HEAD(&traverse_list);
> +	INIT_LIST_HEAD(&edge_list);
> +	INIT_LIST_HEAD(&visited_list);
> +
> +	list_add_tail(&src->search_list, &traverse_list);
> +	src->reverse = NULL;
> +
> +	do {
> +		list_for_each_entry_safe(node, n, &traverse_list, search_list) {
> +			if (node == dst) {
> +				found = true;
> +				list_add(&node->search_list, &visited_list);
> +				break;
> +			}
> +			for (i = 0; i < node->num_links; i++) {
> +				struct icc_node *tmp = node->links[i];
> +
> +				if (!tmp) {
> +					ret = -ENOENT;
> +					goto out;
> +				}
> +
> +				if (tmp->is_traversed)
> +					continue;
> +
> +				tmp->is_traversed = true;
> +				tmp->reverse = node;
> +				list_add(&tmp->search_list, &edge_list);
> +			}
> +		}
> +		if (found)
> +			break;
> +
> +		list_splice_init(&traverse_list, &visited_list);
> +		list_splice_init(&edge_list, &traverse_list);
> +
> +		/* count the hops away from the source */
> +		depth++;
> +
> +	} while (!list_empty(&traverse_list));
> +
> +out:
> +	/* reset the traversed state */
> +	list_for_each_entry(provider, &icc_provider_list, provider_list) {
> +		list_for_each_entry(n, &provider->nodes, node_list)
> +			if (n->is_traversed)
> +				n->is_traversed = false;
> +	}
> +
> +	if (found) {
> +		struct icc_path *path = path_allocate(dst, depth);
> +
> +		if (IS_ERR(path))
> +			return path;
> +
> +		/* initialize the path */
> +		for (i = 0; i < path->num_nodes; i++) {
> +			node = path->reqs[i].node;
> +			path->reqs[i].dev = dev;
> +			node->provider->users++;

nit: doing the assignment of path->reqs[i].dev before assiging 'node'
or after incrementing the 'users' would slightly improve readability.

> +static int apply_constraints(struct icc_path *path)
> +{
> +	struct icc_node *next, *prev = NULL;
> +	int ret = 0;
> +	int i;
> +
> +	for (i = 0; i < path->num_nodes; i++, prev = next) {
> +		struct icc_provider *p;
> +
> +		next = path->reqs[i].node;
> +		/*
> +		 * Both endpoints should be valid master-slave pairs of the
> +		 * same interconnect provider that will be configured.
> +		 */
> +		if (!prev || next->provider != prev->provider)
> +			continue;
> +
> +		p = next->provider;
> +
> +		aggregate_provider(p);
> +
> +		if (p->set) {
> +			/* set the constraints */
> +			ret = p->set(prev, next, p->avg_bw, p->peak_bw);
> +		}

remove curly brackets

EDIT: actually the condition can be removed, icc_provider_add() fails
when p->set is NULL.

> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
> +{
> +	struct icc_node *node;
> +	struct icc_provider *p;
> +	size_t i;
> +	int ret = 0;

initialization is not necessary

> +struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
> +{
> +	struct icc_node *src, *dst;
> +	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
> +
> +	src = node_find(src_id);
> +	if (!src) {
> +		dev_err(dev, "%s: invalid src=%d\n", __func__, src_id);
> +		goto out;
> +	}
> +
> +	dst = node_find(dst_id);
> +	if (!dst) {
> +		dev_err(dev, "%s: invalid dst=%d\n", __func__, dst_id);
> +		goto out;
> +	}
> +
> +	mutex_lock(&icc_lock);
> +	path = path_find(dev, src, dst);
> +	mutex_unlock(&icc_lock);
> +	if (IS_ERR(path)) {
> +		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> +		goto out;

this goto isn't really needed

> +struct icc_node *icc_node_create(int id)
> +{
> +	struct icc_node *node;
> +
> +	/* check if node already exists */
> +	node = node_find(id);
> +	if (node)
> +		goto out;
> +
> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node) {
> +		node = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> +	mutex_lock(&icc_lock);
> +
> +	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
> +	if (WARN(id < 0, "couldn't get idr")) {

kfree(node);

> +int icc_node_add(struct icc_node *node, struct icc_provider *provider)
> +{
> +	mutex_lock(&icc_lock);
> +
> +	node->provider = provider;
> +	list_add(&node->node_list, &provider->nodes);
> +
> +	mutex_unlock(&icc_lock);
> +
> +	return 0;
> +}

The function returns always 0. Should probably be void so callers
don't add pointless checks of the return value.

> +int icc_provider_add(struct icc_provider *provider)
> +{
> +	if (WARN_ON(!provider->set))
> +		return -EINVAL;
> +
> +	mutex_init(&icc_lock);

Shouldn't this be mutex_lock()?

> +int icc_provider_del(struct icc_provider *provider)
> +{
> +	mutex_lock(&icc_lock);
> +	if (provider->users) {
> +		pr_warn("interconnect provider still has %d users\n",
> +			provider->users);
> +		mutex_unlock(&icc_lock);
> +		return -EBUSY;
> +	}
> +
> +	if (!list_empty_careful(&provider->nodes)) {
> +		pr_warn("interconnect provider still has nodes\n");
> +		mutex_unlock(&icc_lock);
> +		return -EEXIST;
> +	}

Could this be just list_empty()? If I didn't miss something icc_lock
is held in all paths that change p->nodes (assuming that all changes
should be done through the interfaces in this file).

Actually this check will always fail if icc_node_add() was called for
this provider, it doesn't seem nodes are ever removed.

Cheers

Matthias
