Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E9BC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523B6208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVEZ0j7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523B6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeLEP50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:57:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36260 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:57:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id a18so13487297wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 07:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=faGkLDyMcGFfUJVIL4oUvzg2nMJYII6/RwgTtnAEPJc=;
        b=LVEZ0j7IGiROwla90AvUgXNnnoI8tK4UCasXVee8pieewmTHGIY0mhwReS2mBVNqFJ
         j8WroFq3QYZuFpUezm+7OWvIYIYHS64enOuH5++0SBT3EXlI5QXElBlMLjK9aIhDt9IS
         346NtAPdPgjnH0maYZuRtmM2ey2JCwZjB3BQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=faGkLDyMcGFfUJVIL4oUvzg2nMJYII6/RwgTtnAEPJc=;
        b=jj9W5p0Cg10MqBbp8jJNC7I7CZKAdeL4Vh2LH1xA5CRuezfZfeBx4nvkn3ovQDUC9k
         NHubZsaHaexRhIbdgOXiDl25I9RMfb7q3FZ98cgDpTp403jttiJxqAe36iYPYoX2mTGZ
         i8jEOSuwFEZUb7CLhYr6ziOE34WPwnySv+Xu0/yUdjJ/QsyNGbxtqJR2wZt98YXaq2y0
         a8EwM5aJIQumE0Dyx4+6cpqUiAtDCZbRhWp2k4q/1B1RWZkOQvLylqWOHa8UaYq7lVfM
         PIbPCYIP07b9YDu6xv9UDvZovcXqMdNhz7cwJaK2HDpkmCoZhyUE7SIcNvzqGqCbkWRd
         kYyg==
X-Gm-Message-State: AA+aEWZ4/6C+SC5vIvBo60thzJ/noorXVtcYoDrdcBzh0OihRW3KcEB0
        g7GxyRliL4OIg9idtLIbmRhsGg==
X-Google-Smtp-Source: AFSGD/Uzr1VP9dvO2+Mzd0gwHaGQ6HGAoZImWiX2TTrvACNh9oE/+b7ALIjMzgeH+tSFYyn02MN2xQ==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr10564650wmd.36.1544025443504;
        Wed, 05 Dec 2018 07:57:23 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x76sm25186790wmd.27.2018.12.05.07.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:57:22 -0800 (PST)
Subject: Re: [PATCH v10 1/7] interconnect: Add generic on-chip interconnect
 API
To:     Evan Green <evgreen@chromium.org>
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
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-2-georgi.djakov@linaro.org>
 <CAE=gft5jWZgzRTNB4m0ES+g=rpjACYWVissmEQ+pgPGKEffgog@mail.gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <c2dc1f5c-46ab-b5aa-0069-b5b50e7e2182@linaro.org>
Date:   Wed, 5 Dec 2018 17:57:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAE=gft5jWZgzRTNB4m0ES+g=rpjACYWVissmEQ+pgPGKEffgog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On 12/1/18 02:38, Evan Green wrote:
> On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
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
> 
> Strange word ordering. Consider something like: "Then the providers
> configure each node participating in the topology"
> 
> ...Or a slightly different flavor: "Then the providers configure each
> node along the path to support a bandwidth that satisfies all
> bandwidth requests that cross through that node".
> 

This sounds better!

>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> Reviewed-by: Evan Green <evgreen@chromium.org>
> 
> This already has my reviewed by, and I still stand by it, but I
> couldn't help finding some nits anyway. Sorry :)

Thanks for finding them!

>> ---
>>  Documentation/interconnect/interconnect.rst |  94 ++++
>>  drivers/Kconfig                             |   2 +
>>  drivers/Makefile                            |   1 +
>>  drivers/interconnect/Kconfig                |  10 +
>>  drivers/interconnect/Makefile               |   5 +
>>  drivers/interconnect/core.c                 | 569 ++++++++++++++++++++
>>  include/linux/interconnect-provider.h       | 125 +++++
>>  include/linux/interconnect.h                |  51 ++
>>  8 files changed, 857 insertions(+)
>>  create mode 100644 Documentation/interconnect/interconnect.rst
>>  create mode 100644 drivers/interconnect/Kconfig
>>  create mode 100644 drivers/interconnect/Makefile
>>  create mode 100644 drivers/interconnect/core.c
>>  create mode 100644 include/linux/interconnect-provider.h
>>  create mode 100644 include/linux/interconnect.h
>>
[..]
>> +/*
>> + * We want the path to honor all bandwidth requests, so the average and peak
>> + * bandwidth requirements from each consumer are aggregated at each node.
>> + * The aggregation is platform specific, so each platform can customize it by
>> + * implementing it's own aggregate() function.
> 
> Grammar police: remove the apostrophe in its.
> 

Oops.

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
>> +
>> +static int apply_constraints(struct icc_path *path)
>> +{
>> +       struct icc_node *next, *prev = NULL;
>> +       int ret = -EINVAL;
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
> 
> I wonder if we should explicitly ban paths where we bounce through an
> odd number of nodes within one provider. Otherwise, set() won't be
> called on all nodes in the path. Or, if we wanted to support those
> kinds of topologies, you could call set with one of the nodes set to
> NULL to represent either the ingress or egress bandwidth to this NoC.
> This doesn't necessarily need to be addressed in this series, but is
> something that other providers might bump into when implementing their
> topologies.
> 

Yes, we can do something like this. But i prefer that we first add
support for more platforms and then according to the requirements we can
work out something.

[..]

>> +       new = krealloc(src->links,
>> +                      (src->num_links) * sizeof(*src->links),
> 
> These parentheses aren't needed.

Sure!

>> +                      GFP_KERNEL);
>> +       if (new)
>> +               src->links = new;
>> +

[..]

>> +
>> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
> 
> This is missing the closing >

Thanks!

>> +MODULE_DESCRIPTION("Interconnect Driver Core");
>> +MODULE_LICENSE("GPL v2");
> ...
>> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
>> new file mode 100644
>> index 000000000000..04b2966ded9f
>> --- /dev/null
>> +++ b/include/linux/interconnect.h
>> @@ -0,0 +1,51 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2018, Linaro Ltd.
>> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
>> + */
>> +
>> +#ifndef __LINUX_INTERCONNECT_H
>> +#define __LINUX_INTERCONNECT_H
>> +
>> +#include <linux/mutex.h>
>> +#include <linux/types.h>
>> +
>> +/* macros for converting to icc units */
>> +#define bps_to_icc(x)  (1)
>> +#define kBps_to_icc(x) (x)
>> +#define MBps_to_icc(x) (x * 1000)
>> +#define GBps_to_icc(x) (x * 1000 * 1000)
>> +#define kbps_to_icc(x) (x / 8 + ((x) % 8 ? 1 : 0))
>> +#define Mbps_to_icc(x) (x * 1000 / 8 )
> 
> Remove extra space before )

Done.

>> +#define Gbps_to_icc(x) (x * 1000 * 1000 / 8)
>> +
>> +struct icc_path;
>> +struct device;
>> +
>> +#if IS_ENABLED(CONFIG_INTERCONNECT)
>> +
>> +struct icc_path *icc_get(struct device *dev, const int src_id,
>> +                        const int dst_id);
>> +void icc_put(struct icc_path *path);
>> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>> +
>> +#else
>> +
>> +static inline struct icc_path *icc_get(struct device *dev, const int src_id,
>> +                                      const int dst_id)
>> +{
>> +       return NULL;
>> +}
>> +
>> +static inline void icc_put(struct icc_path *path)
>> +{
>> +}
>> +
>> +static inline int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>> +{
>> +       return 0;
> 
> Should this really succeed?

Yes, it should succeed if the framework is not enabled. The drivers
should handle the case of whether the framework is enabled or not when
icc_get() or of_icc_get() returns NULL. Based on that they should decide
if can continue without interconnect support or not.

BR,
Georgi
