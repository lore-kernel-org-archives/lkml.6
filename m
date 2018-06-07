Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id a+uqNYtrGVvzRgAAmS7hNA
	; Thu, 07 Jun 2018 17:29:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 62BE1608BA; Thu,  7 Jun 2018 17:29:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F2149605A2;
	Thu,  7 Jun 2018 17:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2149605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933851AbeFGR3w (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:29:52 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6989 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932648AbeFGR3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:29:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b196b990000>; Thu, 07 Jun 2018 10:30:01 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Jun 2018 10:29:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 07 Jun 2018 10:29:50 -0700
Received: from rcampbell-dev.nvidia.com (10.110.48.66) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 7 Jun
 2018 17:29:50 +0000
Subject: Re: [PATCH 6/6] Convert intel uncore to struct_size
To: Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>
CC: Matthew Wilcox <mawilcox@microsoft.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <kernel-hardening@lists.openwall.com>
References: <20180607145720.22590-1-willy@infradead.org>
 <20180607145720.22590-7-willy@infradead.org>
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <03d9addb-9c68-c6e5-d7db-57468fc3950c@nvidia.com>
Date: Thu, 7 Jun 2018 10:29:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607145720.22590-7-willy@infradead.org>
X-Originating-IP: [10.110.48.66]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2018 07:57 AM, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Need to do a bit of rearranging to make this work.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>   arch/x86/events/intel/uncore.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 15b07379e72d..e15cfad4f89b 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -865,8 +865,6 @@ static void uncore_types_exit(struct intel_uncore_type **types)
>   static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>   {
>   	struct intel_uncore_pmu *pmus;
> -	struct attribute_group *attr_group;
> -	struct attribute **attrs;
>   	size_t size;
>   	int i, j;
>   
> @@ -891,21 +889,24 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>   				0, type->num_counters, 0, 0);
>   
>   	if (type->event_descs) {
> +		struct {
> +			struct attribute_group group;
> +			struct attribute *attrs[];
> +		} *attr_group;
>   		for (i = 0; type->event_descs[i].attr.attr.name; i++);

What does this for loop do?
Looks like nothing given the semicolon at the end.

> -		attr_group = kzalloc(sizeof(struct attribute *) * (i + 1) +
> -					sizeof(*attr_group), GFP_KERNEL);
> +		attr_group = kzalloc(struct_size(attr_group, attrs, i + 1),
> +								GFP_KERNEL);
>   		if (!attr_group)
>   			goto err;
>   
> -		attrs = (struct attribute **)(attr_group + 1);
> -		attr_group->name = "events";
> -		attr_group->attrs = attrs;
> +		attr_group->group.name = "events";
> +		attr_group->group.attrs = attr_group->attrs;
>   
>   		for (j = 0; j < i; j++)
> -			attrs[j] = &type->event_descs[j].attr.attr;
> +			attr_group->attrs[j] = &type->event_descs[j].attr.attr;
>   
> -		type->events_group = attr_group;
> +		type->events_group = &attr_group->group;
>   	}
>   
>   	type->pmu_group = &uncore_pmu_attr_group;
> 
