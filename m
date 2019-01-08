Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E4C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BBA206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CfvhbkS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfAHCGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:06:41 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36874 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfAHCGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:06:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id g125so1506621qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 18:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5fmYsoaQ4U9SrC9qHn578jaxNdiAKWttsqBynXUSr6k=;
        b=CfvhbkS9379MT9Ahb3GstWL9K9YRNXZeXqr6XjTv8CGkeEbQOKD4gTc5Hewqc2uqMU
         uzaF4jxSPpweDp5a9RSoQodf/zep1KAi3D6ZR0gYbjTL6R69U0SwgxsVC/GdgzKhUmoL
         BmQsAqDUEHMoG3VL9nyYV3tT2IcUVinNQ233B+lAdlH7LEqIH4KNfCIT7oE9mG2/9qwA
         inVs2r0OPF172TKwqhFXtfDTykmhDGbzPiey1FJ8SAM3JE0D0yybptt6w4B4jlhtpxYG
         bzgAWFUhap2TbUuiv/1LFFRSMcEw6AUOZ5zggaBSyNPxcyAk97V3DHrw9GzqdyLMny2k
         ZdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5fmYsoaQ4U9SrC9qHn578jaxNdiAKWttsqBynXUSr6k=;
        b=ScDcmxpVXINcIj7DynUv0eK5goMVNY1hNkl06kaNJHdnkSI8A4HPxYX8B7TQ6MjLiB
         Xc92om8A0QeoBdqs/AJBapXW+tFqpBRI6tpF2NLr8YP7Qzri5FG4txqkNZNfcXXgYG9C
         RD8jGZLYVk4Qpq+eR1mJ4Q/iGs0P3xMBSQo8JtgrWPZ2zSUnTbCW79H6Hui5KAzIP2P2
         xpdIe0glGcpMNLCg5dTfdtJQ2+CuBMorJXMyW2YmSIOskg5Tq2ZqnvjAaOeoLJJWMXl9
         FeDx96GtRillMP2/C/FtOpQN0RxwkIw0zLYwpVv2AxY3wjmaGejNfsA9J7TzI9NYT/BI
         IFFw==
X-Gm-Message-State: AJcUukd+8n/v6M8GNtseBD/KTrhlUaT+I8U60U90z2OCnih96rJIepGV
        9QW60/HCjBvB9/xzLMJcp7BNDzG9KVJyNA==
X-Google-Smtp-Source: ALg8bN5gyEvLNcveQRIi+iPnBb311G5EXytQ/62liYnrsGw2KU7kaWodFSG165yGUsmXaynRoGPtdg==
X-Received: by 2002:a37:945:: with SMTP id 66mr42856131qkj.123.1546913199410;
        Mon, 07 Jan 2019 18:06:39 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t33sm32775491qtj.76.2019.01.07.18.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 18:06:39 -0800 (PST)
Subject: Re: [PATCH v2] kmemleak: survive in a low-memory situation
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190102165931.GB6584@arrakis.emea.arm.com>
 <20190102180619.12392-1-cai@lca.pw> <20190103093201.GB31793@dhcp22.suse.cz>
 <9197d86b-a684-c7f4-245b-63c890f1104f@lca.pw>
 <20190103170735.GV31793@dhcp22.suse.cz> <20190107104314.uugftsqcjsi5j6g2@mbp>
From:   Qian Cai <cai@lca.pw>
Message-ID: <47dbc0fc-5322-10fb-a8c4-698a4b17e3b3@lca.pw>
Date:   Mon, 7 Jan 2019 21:06:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190107104314.uugftsqcjsi5j6g2@mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/19 5:43 AM, Catalin Marinas wrote:
> On Thu, Jan 03, 2019 at 06:07:35PM +0100, Michal Hocko wrote:
>>>> On Wed 02-01-19 13:06:19, Qian Cai wrote:
>>>> [...]
>>>>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>>>>> index f9d9dc250428..9e1aa3b7df75 100644
>>>>> --- a/mm/kmemleak.c
>>>>> +++ b/mm/kmemleak.c
>>>>> @@ -576,6 +576,16 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>>>>>  	struct rb_node **link, *rb_parent;
>>>>>  
>>>>>  	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
>>>>> +#ifdef CONFIG_PREEMPT_COUNT
>>>>> +	if (!object) {
>>>>> +		/* last-ditch effort in a low-memory situation */
>>>>> +		if (irqs_disabled() || is_idle_task(current) || in_atomic())
>>>>> +			gfp = GFP_ATOMIC;
>>>>> +		else
>>>>> +			gfp = gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
>>>>> +		object = kmem_cache_alloc(object_cache, gfp);
>>>>> +	}
>>>>> +#endif
> [...]
>> I will not object to this workaround but I strongly believe that
>> kmemleak should rethink the metadata allocation strategy to be really
>> robust.
> 
> This would be nice indeed and it was discussed last year. I just haven't
> got around to trying anything yet:
> 
> https://marc.info/?l=linux-mm&m=152812489819532
> 

It could be helpful to apply this 10-line patch first if has no fundamental
issue, as it survives probably 50 times running LTP oom* workloads without a
single kmemleak allocation failure.

Of course, if someone is going to embed kmemleak metadata into slab objects
itself soon, this workaround is not needed.
