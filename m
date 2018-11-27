Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE00C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0242A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0242A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbeK1FeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:34:10 -0500
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:41472 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725758AbeK1FeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:34:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6110540C5;
        Tue, 27 Nov 2018 18:35:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: yard44_685a1daadab1f
X-Filterd-Recvd-Size: 4167
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 27 Nov 2018 18:35:16 +0000 (UTC)
Message-ID: <5d16a4a57ed5529299d7b73e13a249add00b1afe.camel@perches.com>
Subject: Re: [PATCH v10 1/7] interconnect: Add generic on-chip interconnect
 API
From:   Joe Perches <joe@perches.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Date:   Tue, 27 Nov 2018 10:35:15 -0800
In-Reply-To: <20181127180349.29997-2-georgi.djakov@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
         <20181127180349.29997-2-georgi.djakov@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-27 at 20:03 +0200, Georgi Djakov wrote:
> This patch introduces a new API to get requirements and configure the
> interconnect buses across the entire chipset to fit with the current
> demand.

trivial notes:

> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
[]
> +static int apply_constraints(struct icc_path *path)
> +{
> +	struct icc_node *next, *prev = NULL;
> +	int ret = -EINVAL;
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
> +		/* set the constraints */
> +		ret = p->set(prev, next);
> +		if (ret)
> +			goto out;
> +	}
> +out:
> +	return ret;
> +}

The use of ", prev = next" appears somewhat tricky code.
Perhaps move the assignment of prev to the bottom of the loop.
Perhaps the temporary p assignment isn't useful either.

> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
> +{
[]
> +	ret = apply_constraints(path);
> +	if (ret)
> +		pr_debug("interconnect: error applying constraints (%d)", ret);

Ideally all pr_<foo> formats should end in '\n'

> +static struct icc_node *icc_node_create_nolock(int id)
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

Generally, this code appears to overly rely on goto when
direct returns could be more readable.

> +	}
> +
> +	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
> +	if (WARN(id < 0, "couldn't get idr")) {

This seems to unnecessarily hide the id < 0 test in a WARN

Why is this a WARN and not a simpler
	if (id < 0) {
		[ pr_err(...); or WARN(1, ...); ]

> +		kfree(node);
> +		node = ERR_PTR(id);
> +		goto out;
> +	}
> +
> +	node->id = id;
> +
> +out:
> +	return node;
> +}
[]
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
[]
> +/* macros for converting to icc units */
> +#define bps_to_icc(x)	(1)
> +#define kBps_to_icc(x)	(x)
[]
> +#define MBps_to_icc(x)	(x * 1000)
> +#define GBps_to_icc(x)	(x * 1000 * 1000)
> +#define kbps_to_icc(x)	(x / 8 + ((x) % 8 ? 1 : 0))
> +#define Mbps_to_icc(x)	(x * 1000 / 8 )
> +#define Gbps_to_icc(x)	(x * 1000 * 1000 / 8)

The last 5 macros should parenthesize x


