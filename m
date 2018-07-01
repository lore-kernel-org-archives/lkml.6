Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88908C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F934224BE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3l4isAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F934224BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeGALDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 07:03:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56256 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeGALDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 07:03:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so6215359wmv.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 04:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wNO1iYcC3jHlCRNPYU+bxs5qdUvnsEO2PB3LDglSrsA=;
        b=G3l4isAlN8eaV7JCvwKx+6CWyoLuBP2NufpQlVJywGNuUZ5UMj2YJLMKngjlp9qRVy
         kNIQBLioEtjjGzp9sKGI7KxLhnh33vD+x5qMEs3z41LoTrRH2HDXk5V24pTqqGARJtKu
         X4jusX6xOnLhwAB2al1EcPrmK3h62HvJ8mxIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wNO1iYcC3jHlCRNPYU+bxs5qdUvnsEO2PB3LDglSrsA=;
        b=sL/JZ3nGPNlWGjF50Iv08uPIEKB+fGe55Ak2ixLLDAeyB4xF32tNfGHZnuqC2kQbN5
         +Ko3QC6g4dPSPN6V+REANuSNDAmr2GsBcZuzj+ag7vb25X4g8RzN4Lw+WjuoJeMjpxZY
         JOCb/WbY5euHx0aZNDnJN+VXIaNkz/E5Xq02MqW5QFnLfHKdYUJC9S+CEhxB4XZXYZh+
         J6fH3SVEHucBKOFi3ratJdLNuUo7TH8KXjXn4uuvyIUDwraPJfxpfasujC7ECfQUwTM1
         Kl4UBeh+SIu+E5ENr+7xalEQgJDhyCpqdO9vvkJCXVFwUSnUlEigCdZH2qSHcAMgMFD4
         WGHw==
X-Gm-Message-State: APt69E0s8Z0M0DFT/re/R4/wMs9tc3RmKMUyA+bCv1jP2S2OeGzSHkhl
        wCpA7iUmYNrMwfkTEI/BsRnm1WLdlFo=
X-Google-Smtp-Source: AAOMgpesxt6nXtqMCpScqtQXwkwO8GAuPdyvLjZMxUizFGJ9zMld0MI+H6pxZOjhq1iw8QJi7mYmpQ==
X-Received: by 2002:a1c:5cd:: with SMTP id 196-v6mr1091698wmf.114.1530443014096;
        Sun, 01 Jul 2018 04:03:34 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id c7-v6sm11514269wre.73.2018.07.01.04.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 04:03:33 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org>
 <CAE=gft4sSdFL7J27WdTuYCtfLPAyv8xOAizYhmtfK5UkTbP5-A@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <891a2332-8744-bd64-4a0b-047e8a71ab38@linaro.org>
Date:   Sun, 1 Jul 2018 14:03:32 +0300
MIME-Version: 1.0
In-Reply-To: <CAE=gft4sSdFL7J27WdTuYCtfLPAyv8xOAizYhmtfK5UkTbP5-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Thanks for reviewing!

On 06/26/2018 11:57 PM, Evan Green wrote:
> Hi Georgi. Thanks for the new spin of this.
> 
> On Wed, Jun 20, 2018 at 5:11 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> This patch introduce a new API to get requirements and configure the
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

[..]

>> +
>> +static struct icc_node *node_find(const int id)
>> +{
>> +       struct icc_node *node;
>> +
>> +       mutex_lock(&icc_lock);
>> +       node = idr_find(&icc_idr, id);
>> +       mutex_unlock(&icc_lock);
> 
> I wonder if this is too low of a level to be dealing with the lock. I
> notice that everywhere you use this function, you afterwards
> immediately grab the lock and do more stuff. Maybe this function
> should have a comment saying it assumes the lock is already held, and
> then you can grab the lock in the callers, since you're doing that
> anyway.

Ok, will try to do better next time.

>> +
>> +       return node;
>> +}
>> +
>> +static struct icc_path *path_allocate(struct icc_node *dst, ssize_t num_nodes)
>> +{
>> +       struct icc_node *node = dst;
>> +       struct icc_path *path;
>> +       size_t i;
>> +
>> +       path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),
>> +                      GFP_KERNEL);
>> +       if (!path)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       path->num_nodes = num_nodes;
>> +
>> +       for (i = 0; i < num_nodes; i++) {
>> +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
>> +
>> +               path->reqs[i].node = node;
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
> 
> I personally prefer a comment somewhere indicating that this function
> assumes icc_lock is already held. Not sure if that's conventional or
> not.
> 

Right, Rob and Matthias have also provided useful feedback on this! Thanks!

[..]

>> +       /* reset the traversed state */
>> +       list_for_each_entry(provider, &icc_provider_list, provider_list) {
>> +               list_for_each_entry(n, &provider->nodes, node_list)
>> +                       if (n->is_traversed)
>> +                               n->is_traversed = false;
> 
> Remove the conditional, just set is_traversed to false.
> 

Agree.

>> +       }
>> +
>> +       if (found) {
>> +               struct icc_path *path = path_allocate(dst, depth);
> 
> Is the path supposed to include the source? For instance, if the dst
> were a neighbor, depth would be one, so only dst would be in the path.
> It seems like it might be worthwhile to have the source in there too.

Agree that it would be logical to include the complete path. Will fix
the depth.

>> +
>> +               if (IS_ERR(path))
>> +                       return path;
>> +
>> +               /* initialize the path */
>> +               for (i = 0; i < path->num_nodes; i++) {
>> +                       node = path->reqs[i].node;
>> +                       path->reqs[i].dev = dev;
>> +                       node->provider->users++;
> 
> Should this loop live inside path_allocate? I'm unsure, but maybe at
> least path->reqs[i].dev = dev, since it feels like standard
> initialization of the path.
> 

Ok, will move it and also change the function name from path_allocate()
to path_init().

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
>> +       if (!path || WARN_ON_ONCE(IS_ERR(path)))
> 
> Why only once?
> 

Will change to WARN_ON.

[..]

>> +void icc_node_remove(int id)
>> +{
>> +       struct icc_node *node;
>> +
>> +       node = node_find(id);
>> +       if (node) {
>> +               mutex_lock(&icc_lock);
>> +               idr_remove(&icc_idr, node->id);
> 
> Should we throw a warning if there are any paths that go through this
> node (ie req_list is non-empty)?
> 

Sounds good, will do it.
>> +               mutex_unlock(&icc_lock);
>> +       }
>> +
>> +       kfree(node);
>> +}
>> +EXPORT_SYMBOL_GPL(icc_node_remove);

[..]

>> +/**
>> + * icc_link_remove() - remove a link between two nodes
>> + * @src: pointer to source node
>> + * @dst: pointer to destination node
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_link_remove(struct icc_node *src, struct icc_node *dst)
>> +{
>> +       struct icc_node **new;
>> +       int ret = 0;
>> +       int i, j;
>> +
>> +       if (IS_ERR_OR_NULL(src))
>> +               return PTR_ERR(src);
>> +
>> +       if (IS_ERR_OR_NULL(dst))
>> +               return PTR_ERR(dst);
> 
> I wonder if we should return a fixed error in these cases like
> -EINVAL, rather than handing through whatever crazy value is in
> src/dst.

Ok, agree.

>> +
>> +       mutex_lock(&icc_lock);
>> +
>> +       new = krealloc(src->links,
>> +                      (src->num_links - 1) * sizeof(*src->links),
>> +                      GFP_KERNEL);
>> +       if (!new) {
>> +               ret = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       for (i = 0, j = 0; j < src->num_links; j++) {
>> +               if (src->links[j] == dst)
>> +                       continue;
>> +
>> +               new[i++] = src->links[j];
>> +       }
>> +
>> +       src->links = new;
>> +       src->num_links--;
> 
> My understanding is that once you call realloc and it succeeds, you
> must assume your old memory is gone and your new memory is only as big
> as the new size you request. So you shouldn't call krealloc until
> you've fixed the array up. Is the order of the links array important?
> If not, you could just take the element at the end and stick it in the
> slot that's being deleted. Then decrease the size and do your realloc.

Sorry, this was obviously untested. Your suggestions is good.

[..]

>> +
>> +/**
>> + * icc_provider_del() - delete previously added interconnect provider
>> + * @icc_provider: the interconnect provider that will be removed from topology
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_provider_del(struct icc_provider *provider)
>> +{
>> +       mutex_lock(&icc_lock);
>> +       if (provider->users) {
>> +               pr_warn("interconnect provider still has %d users\n",
>> +                       provider->users);
>> +               mutex_unlock(&icc_lock);
>> +               return -EBUSY;
>> +       }
>> +
>> +       if (!list_empty_careful(&provider->nodes)) {
>> +               pr_warn("interconnect provider still has nodes\n");
>> +               mutex_unlock(&icc_lock);
>> +               return -EEXIST;
> 
> How come you're returning different error codes for these two cases?
> The error in both cases is effectively "you failed to clean up after
> yourself", so maybe EBUSY makes sense for both of them. The pr_warn
> helps to differentiate between the two for debugging.

Ok.

>> +       }
>> +
>> +       list_del(&provider->provider_list);
>> +       mutex_unlock(&icc_lock);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_provider_del);
>> +

[..]

>> +struct icc_node {
>> +       int                     id;
>> +       const char              *name;
>> +       struct icc_node         **links;
>> +       size_t                  num_links;
>> +
>> +       struct icc_provider     *provider;
>> +       struct list_head        node_list;
>> +       struct list_head        orphan_list;
> 
> Is this used?

Ah, I thought I had already removed it!

>> +       struct list_head        search_list;
>> +       struct icc_node         *reverse;
>> +       bool                    is_traversed;
>> +       struct hlist_head       req_list;
>> +       u32                     avg_bw;
>> +       u32                     peak_bw;
>> +       void                    *data;
>> +};
>> +

[..]

>> +static inline int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>> +{
>> +       return 0;
> 
> I was originally going to suggest that this should return a failure.
> Then I talked myself out of it, saying that if the interconnect
> framework is not compiled in, then clients should assume all their bus
> needs are already met. I guess this is the correct assumption?

Yes, exactly!

Thanks,
Georgi
