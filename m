Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2E9C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FFD23FDF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfrr42Jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FFD23FDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeGALG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 07:06:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36066 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeGALGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 07:06:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so12754383wrm.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CLP/KKVFFp2FTMGRhrgcns4AGOYTBWZfsdsyTXwXp1o=;
        b=kfrr42JxpMbR+IwbHVpQM9ofqErwGhMQs7qKkQSkkV35tYDAB9X4mU+JFX7r5dui9X
         ykPE7shsVSWFftJJU9GvBLKMIR6guvB+v0K+wm4bfS3nXf6Ij8lHP8h2ZxIv97NZNh+6
         R1vitoVAkFELI0PF1NrXy+bPDyLoSbLwb/vwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CLP/KKVFFp2FTMGRhrgcns4AGOYTBWZfsdsyTXwXp1o=;
        b=SajlP19aK4WT7r9FxdV6rPEuSls2pdnEg59D/oS9WgXs2A2AxBYc4Df3FYZFA4JDQS
         52MebzUx7LW5ulWp/0zFIaHo3x6t+jAcC4tvyiBqTKkLOV0pfGzLyKj5aAVw2T9rRwVo
         UO0JlHmGygp3Ibv9OwuW7Jz+8qx53h0QDV6dW4lQtG0e5UXq+JGZKfXYVnpUDtFNa+MV
         a6jIOMQiAPEh55LUEt8k9ZrocNERP8WTWLKcicEg9bxXVhGZf4aUZITdDEvcyCh5nsvL
         dhKpWCdhLnNRIAH2lBc54K8cHCvxw1fVfWZdq/Ta5ve2jQYK2AP9yIDDttPsQkdmKF7c
         jdOw==
X-Gm-Message-State: APt69E1uJsOyDwu2MD00C34AvIxbppQJ/0Sx+sDSP6wk4NcVQC/ypbWB
        i0e4+67OmEh8wAZrsYx26qH/uQ==
X-Google-Smtp-Source: AAOMgpdsggB2CdmpGZFL55nVknVfHPCxnKMGXpRW468/VYCeArjhvAXktsq/1GPEwSU1NqqbYdimFA==
X-Received: by 2002:adf:9736:: with SMTP id r51-v6mr16424536wrb.5.1530443182547;
        Sun, 01 Jul 2018 04:06:22 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y13-v6sm9148278wrc.55.2018.07.01.04.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 04:06:21 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org>
 <20180626233427.GR129942@google.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <d52877d2-359f-6c79-01b9-739d0b2733ef@linaro.org>
Date:   Sun, 1 Jul 2018 14:06:21 +0300
MIME-Version: 1.0
In-Reply-To: <20180626233427.GR129942@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thanks for reviewing!

On 06/27/2018 02:34 AM, Matthias Kaehlcke wrote:
> Hi Georgi,
> 
> On Wed, Jun 20, 2018 at 03:11:34PM +0300, Georgi Djakov wrote:
>> This patch introduce a new API to get requirements and configure the
> 
> nit: s/introduce/introduces/

Thanks!

[..]

>> +	if (found) {
>> +		struct icc_path *path = path_allocate(dst, depth);
>> +
>> +		if (IS_ERR(path))
>> +			return path;
>> +
>> +		/* initialize the path */
>> +		for (i = 0; i < path->num_nodes; i++) {
>> +			node = path->reqs[i].node;
>> +			path->reqs[i].dev = dev;
>> +			node->provider->users++;
> 
> nit: doing the assignment of path->reqs[i].dev before assiging 'node'
> or after incrementing the 'users' would slightly improve readability.

Ok, will re-factor this a bit.

>> +static int apply_constraints(struct icc_path *path)
>> +{
>> +	struct icc_node *next, *prev = NULL;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	for (i = 0; i < path->num_nodes; i++, prev = next) {
>> +		struct icc_provider *p;
>> +
>> +		next = path->reqs[i].node;
>> +		/*
>> +		 * Both endpoints should be valid master-slave pairs of the
>> +		 * same interconnect provider that will be configured.
>> +		 */
>> +		if (!prev || next->provider != prev->provider)
>> +			continue;
>> +
>> +		p = next->provider;
>> +
>> +		aggregate_provider(p);
>> +
>> +		if (p->set) {
>> +			/* set the constraints */
>> +			ret = p->set(prev, next, p->avg_bw, p->peak_bw);
>> +		}
> 
> remove curly brackets
> 
> EDIT: actually the condition can be removed, icc_provider_add() fails
> when p->set is NULL.

Agree!

> 
>> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>> +{
>> +	struct icc_node *node;
>> +	struct icc_provider *p;
>> +	size_t i;
>> +	int ret = 0;
> 
> initialization is not necessary
> 

Ok.

>> +struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
>> +{
>> +	struct icc_node *src, *dst;
>> +	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>> +
>> +	src = node_find(src_id);
>> +	if (!src) {
>> +		dev_err(dev, "%s: invalid src=%d\n", __func__, src_id);
>> +		goto out;
>> +	}
>> +
>> +	dst = node_find(dst_id);
>> +	if (!dst) {
>> +		dev_err(dev, "%s: invalid dst=%d\n", __func__, dst_id);
>> +		goto out;
>> +	}
>> +
>> +	mutex_lock(&icc_lock);
>> +	path = path_find(dev, src, dst);
>> +	mutex_unlock(&icc_lock);
>> +	if (IS_ERR(path)) {
>> +		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
>> +		goto out;
> 
> this goto isn't really needed

Ok.

>> +struct icc_node *icc_node_create(int id)
>> +{
>> +	struct icc_node *node;
>> +
>> +	/* check if node already exists */
>> +	node = node_find(id);
>> +	if (node)
>> +		goto out;
>> +
>> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +	if (!node) {
>> +		node = ERR_PTR(-ENOMEM);
>> +		goto out;
>> +	}
>> +
>> +	mutex_lock(&icc_lock);
>> +
>> +	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
>> +	if (WARN(id < 0, "couldn't get idr")) {
> 
> kfree(node);

Thanks!

>> +int icc_node_add(struct icc_node *node, struct icc_provider *provider)
>> +{
>> +	mutex_lock(&icc_lock);
>> +
>> +	node->provider = provider;
>> +	list_add(&node->node_list, &provider->nodes);
>> +
>> +	mutex_unlock(&icc_lock);
>> +
>> +	return 0;
>> +}
> 
> The function returns always 0. Should probably be void so callers
> don't add pointless checks of the return value.

Agree, will change it!

>> +int icc_provider_add(struct icc_provider *provider)
>> +{
>> +	if (WARN_ON(!provider->set))
>> +		return -EINVAL;
>> +
>> +	mutex_init(&icc_lock);
> 
> Shouldn't this be mutex_lock()?

Yes, right!

>> +int icc_provider_del(struct icc_provider *provider)
>> +{
>> +	mutex_lock(&icc_lock);
>> +	if (provider->users) {
>> +		pr_warn("interconnect provider still has %d users\n",
>> +			provider->users);
>> +		mutex_unlock(&icc_lock);
>> +		return -EBUSY;
>> +	}
>> +
>> +	if (!list_empty_careful(&provider->nodes)) {
>> +		pr_warn("interconnect provider still has nodes\n");
>> +		mutex_unlock(&icc_lock);
>> +		return -EEXIST;
>> +	}
> 
> Could this be just list_empty()? If I didn't miss something icc_lock
> is held in all paths that change p->nodes (assuming that all changes
> should be done through the interfaces in this file).

It could be. Will update it. I just always want to be careful!

> Actually this check will always fail if icc_node_add() was called for
> this provider, it doesn't seem nodes are ever removed.
> 

The provider driver is responsible for the node removal.

Thanks,
Georgi
