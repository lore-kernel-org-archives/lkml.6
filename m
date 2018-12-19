Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F4FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E972080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XJKZw0m1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbeLSMqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:46:52 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36021 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:46:52 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so22026471qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 04:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G1zBnh0azSyP/WUoznkADLSWXlA2LNoLlefCB66C45A=;
        b=XJKZw0m13xNpZFF1RM2f0GEwghbuCymERHn2GWDD9xEHJnuajWThwt2u7UnAhD3r1W
         4ig0s8bK5U/mnjzBMmYIA3xCt2mo7KMXql32oTjWoZFowmRdWPRGFrw3/2clcg6g86iN
         r4BLKOmFJa+bS79fI5lRPTszakIko4Y39AHtmNsDDVx/Qxdv17erzNV9NNuycjh6TpQ4
         d+ygxk1UavnSWHYPW9NoxcpHv3fkDNLQ5vEd7tl+knI95j75V/gdUJvvyweFTWMmwER6
         ltP5AWaXl1/um9MXKxSU8rZAV4MRU+5P8XrhKbIHVWJfMUt9UI/sVHHcQOJcuQ5SLMZn
         4waQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G1zBnh0azSyP/WUoznkADLSWXlA2LNoLlefCB66C45A=;
        b=lAPRAaYbQa1JnEsr+XZ1Fa1qwXYaQlOnp7BM91FbR4lf5cLLUJVoIGOTUY7qtWAcyU
         moJXB7siDsJ6/7LxqTWiBptgFHNV31LLrQMG3b6D0xpXDHRR4iXHy1deZYNjQZIS3HL2
         +OaCPhmhQESMbF4QkgvT8bWlAGfysnqtAcp4EKhSh382/UnabehMzYoLk3aOCW+KFXgM
         AIbNFGeEllbzjfgGIfFnobKD7VAKdUCOFwf93kbtDDNeKuVABZTLrDosqUjJ7JX4dyOa
         gDO9tLBwx3brFVUKozmLV7nVYcnby9vpCzaRYMSM1f3Sfi2AVml9nXLW2W19xTAp1cuN
         jB6A==
X-Gm-Message-State: AA+aEWa4oTS179NkcRlbb3HAzZQCNhvK74I9DtP4muMB+k/hRZUaJ6Ye
        6WREM/ZU+dxaEY1bLVq3G4G/6BMZT5c=
X-Google-Smtp-Source: AFSGD/W0KZ+ZEY+19s1o94XLsnru5c2aMVvBF3vaxEgSE4pgq26dMXqIzgL6Pyh+z4TeVqQEIN+QgQ==
X-Received: by 2002:a0c:e84f:: with SMTP id l15mr20943487qvo.124.1545223610848;
        Wed, 19 Dec 2018 04:46:50 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o42sm2055182qtc.90.2018.12.19.04.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 04:46:50 -0800 (PST)
Subject: Re: [PATCH] mm: skip checking poison pattern for page_to_nid()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        mgorman@techsingularity.net, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1545172285.18411.26.camel@lca.pw>
 <20181219015732.26179-1-cai@lca.pw> <20181219102010.GF5758@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <cbfacb4b-dbfd-f68f-3d1e-05e137feca18@lca.pw>
Date:   Wed, 19 Dec 2018 07:46:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219102010.GF5758@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 5:20 AM, Michal Hocko wrote:
> On Tue 18-12-18 20:57:32, Qian Cai wrote:
> [...]
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 5411de93a363..f083f366ea90 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -985,9 +985,7 @@ extern int page_to_nid(const struct page *page);
>>  #else
>>  static inline int page_to_nid(const struct page *page)
>>  {
>> -	struct page *p = (struct page *)page;
>> -
>> -	return (PF_POISONED_CHECK(p)->flags >> NODES_PGSHIFT) & NODES_MASK;
>> +	return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
>>  }
>>  #endif
> 
> I didn't get to think about a proper fix but this is clearly worng. If
> the page is still poisoned then flags are clearly bogus and the node you
> get is a garbage as well. Have you actually tested this patch?
> 

Yes, I did notice that after running for a while triggering some UBSAN
out-of-bounds access warnings. I am still trying to figure out how those
uninitialized page flags survived though after

mm_init
  mem_init
    memblock_free_all
      init_single_page()
