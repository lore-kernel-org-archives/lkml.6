Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79DAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FF52184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kEFC3x9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfACWWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:22:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46670 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbfACWWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:22:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so20541332qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 14:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ThXu5yLunt/aWVc28ZYL3Bdf91UeqmxCsWKr479Qomo=;
        b=kEFC3x9YnVpvqInL3IzpIs1z/nhMjpJEGk44CY0MaisifdlSPlYyNrVfb3ddK+PZzo
         zvwlVxEyXiXpQUyx6zRYOp67v2BDksSuG2nOvvMRyK2huMnyv8i1iniGBq9s/QdSAosM
         Phyu8p+O/pCjMZz69g6NcnP9uVCZk/qj8V77cvxSLYAUP7yNT5XFAPAkgAEQiXbaaiXC
         THwACyF3pbsOGyDiQA5p6TZz3kIp2QrVpJowaKyBQzJZGIXvKcOIplgDBpuaYZLeDYLA
         EaRPC5MZuZzZQew+fcZNXuPBxDF6gBBj16zY/JudU1znGKP+6lDmkkCQn7VS4IrYzdkD
         B8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ThXu5yLunt/aWVc28ZYL3Bdf91UeqmxCsWKr479Qomo=;
        b=TcD4aotG3nm/ofbNPObs+9oMnTiTgOQOwBAxre+n6PnYP3hBa9V3KQJdzKGpS3KBPV
         S6KvzYFjzosH+HcDlKLppz3dDRkfrBWcHQ9hXoXQroaTqW0jzfra1GHzHHZLTMs0sMv1
         4z4wu7YMeeNqB0ZwWf5+/o5H6lBQE9au058XTzz72Xut7PSUROd1Mb6RK4Cp6pMQeN8D
         dB/gCCAlCfE1NnsSwsEQ2iINC1tCA8AEMY2KIUYAeb/LaXqsZxelL4xMe9cvVeiidijp
         sSy1FzEi7+AH7BZtawSgFvcUNCzH7prNyGCDZoahfrDfprNvb/h4qRVuaN1+qPOOJwQC
         qioA==
X-Gm-Message-State: AJcUukfLFwLnp3uyam9xjkpTKNXuqjlsbtcTOeF82hLcrgVH9QRXIOas
        Ukka23WMXBQv+UJVshH9R/LCXZSsAiiPbA==
X-Google-Smtp-Source: ALg8bN55Xw4d2dCVdmR7hPTd1nmKd/oZso4HjTac8kLFb1GEAYdSa/4LLKq1z85ASWW6mIX1T0VBdw==
X-Received: by 2002:ae9:dcc4:: with SMTP id q187mr45598735qkf.97.1546554151220;
        Thu, 03 Jan 2019 14:22:31 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n3sm30066096qtc.81.2019.01.03.14.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 14:22:30 -0800 (PST)
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181220185031.43146-1-cai@lca.pw>
 <20181220203156.43441-1-cai@lca.pw> <20190103115114.GL31793@dhcp22.suse.cz>
 <e3ff1455-06cc-063e-24f0-3b525c345b84@lca.pw>
 <20190103165927.GU31793@dhcp22.suse.cz>
 <5d8f3a98-a954-c8ab-83d9-2f94c614f268@lca.pw>
 <20190103190715.GZ31793@dhcp22.suse.cz>
 <62e96e34-7ea9-491a-b5b6-4828da980d48@lca.pw>
 <20190103202235.GE31793@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <a5666d82-b7ad-4b90-5f4e-fd22afc3e1dc@lca.pw>
Date:   Thu, 3 Jan 2019 17:22:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190103202235.GE31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/19 3:22 PM, Michal Hocko wrote:
> On Thu 03-01-19 14:53:47, Qian Cai wrote:
>> On 1/3/19 2:07 PM, Michal Hocko wrote> So can we make the revert with an
>> explanation that the patch was wrong?
>>> If we want to make hacks to catch more objects to be tracked then it
>>> would be great to have some numbers in hands.
>>
>> Well, those numbers are subject to change depends on future start_kernel()
>> order. Right now, there are many functions could be caught earlier by page owner.
>>
>> 	kmemleak_init();
> [...]
>> 	sched_init_smp();
> 
> The kernel source dump will not tell us much of course. A ball park
> number whether we are talking about dozen, hundreds or thousands of
> allocations would tell us something at least, doesn't it.
> 
> Handwaving that it might help us some is not particurarly useful. We are
> already losing some allocations already. Does it matter? Well, that
> depends, sometimes we do want to catch an owner of particular page and
> it is sad to find nothing. But how many times have you or somebody else
> encountered that in practice. That is exactly a useful information to
> judge an ugly ifdefery in the code. See my point?

Here is the number without DEFERRED_STRUCT_PAGE_INIT.

== page_ext_init() after page_alloc_init_late() ==
Node 0, zone DMA: page owner found early allocated 0 pages
Node 0, zone DMA32: page owner found early allocated 7009 pages
Node 0, zone Normal: page owner found early allocated 85827 pages
Node 4, zone Normal: page owner found early allocated 75063 pages

== page_ext_init() before kmemleak_init() ==
Node 0, zone DMA: page owner found early allocated 0 pages
Node 0, zone DMA32: page owner found early allocated 6654 pages
Node 0, zone Normal: page owner found early allocated 41907 pages
Node 4, zone Normal: page owner found early allocated 41356 pages

So, it told us that it will miss tens of thousands of early page allocation call
sites.
