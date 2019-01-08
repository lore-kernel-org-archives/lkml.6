Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C84C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFA020850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VZF3BisZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfAHDtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:49:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41281 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfAHDtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:49:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so1588186qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 19:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g3kvm8LKerN2EuWSNQkFLEia5e8Kr7TjBCuMbx/WN2U=;
        b=VZF3BisZLmlLeI5FObSlVEhPdeiF4naaiMjV2xSIuLQ3sQ+r3kp+l517CZsB7ShJqA
         lkdl0MDJHTpbaMqQrRJjmDYPgZAkiTQa6o0b011DIAzNqmzCEF10CNAd+Hm2NcEnORM1
         ooKK4KP0EIBu3oHDWAi9KrCxz/bbP5LmWWknkAhU4TKLVy5jX5wl3C4qgVrblBpxubOl
         +6wy1FbjvNVppe8Qd2qpXFMS/f6CqMkmhouDH/Say75JWwMR2cbR7oev31h5hO47qdX/
         Z3GqlmIDnStTfs57X0B59zpzZS7fWW/np7XDdmPwV6XGlrGa61dM8/80ddY+5fgyFY5d
         5cHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g3kvm8LKerN2EuWSNQkFLEia5e8Kr7TjBCuMbx/WN2U=;
        b=nIbXyGhq8HHc6kekDRNtXhtawv3NVnTYmRtUbUvNrG8MuO8mbvsIujmKbu86y+9tnV
         KZYBBm11ZJzsAtfZInfDh6LrvpU00QqCivL5zf2lR0zZf063xjedNuO8FYYUI9n4aOHw
         +Stjy8O5NASBSVFgUi9Fwni3mcG2L42JsSeFnLO70hkqxZxSO7jKaSh7SLKJfACtiqy+
         nkZj96YRrR3WsuTuh5uaqUvI73fze5jkRkw3C+MnqsHw4uxWgGAKYKfrGNyan4cgBat/
         jb0V0y8O2QzBqBv1cawWz3sCXi3N3MSgGa8Vv7fuowKoeQVZua1eg2i03psPQ+4h/Zp6
         rVWQ==
X-Gm-Message-State: AJcUukdAR7L1ks8JC91Gs6P3ecHHVwbcvjZ1RWo9obTHx6utvQR2vBEf
        0gfeDwLiuv5/0McOz9N1DFhM8IJZPgy35w==
X-Google-Smtp-Source: ALg8bN6Xw8O7axmuRJs2dl44rfIzJAdg2yRg29ooq39yPgoQZ8GqQ2drCY6gGaAG2Ge8wlmKPDAq5g==
X-Received: by 2002:a37:c00e:: with SMTP id o14mr109201qki.319.1546919385568;
        Mon, 07 Jan 2019 19:49:45 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o49sm37183144qtf.60.2019.01.07.19.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 19:49:45 -0800 (PST)
Subject: Re: [PATCH v2] kmemleak: survive in a low-memory situation
From:   Qian Cai <cai@lca.pw>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190102165931.GB6584@arrakis.emea.arm.com>
 <20190102180619.12392-1-cai@lca.pw> <20190103093201.GB31793@dhcp22.suse.cz>
 <9197d86b-a684-c7f4-245b-63c890f1104f@lca.pw>
 <20190103170735.GV31793@dhcp22.suse.cz> <20190107104314.uugftsqcjsi5j6g2@mbp>
 <47dbc0fc-5322-10fb-a8c4-698a4b17e3b3@lca.pw>
Message-ID: <ecb5d958-1e86-7725-e271-def315265537@lca.pw>
Date:   Mon, 7 Jan 2019 22:49:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <47dbc0fc-5322-10fb-a8c4-698a4b17e3b3@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/19 9:06 PM, Qian Cai wrote:
> 
> 
> On 1/7/19 5:43 AM, Catalin Marinas wrote:
>> On Thu, Jan 03, 2019 at 06:07:35PM +0100, Michal Hocko wrote:
>>>>> On Wed 02-01-19 13:06:19, Qian Cai wrote:
>>>>> [...]
>>>>>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>>>>>> index f9d9dc250428..9e1aa3b7df75 100644
>>>>>> --- a/mm/kmemleak.c
>>>>>> +++ b/mm/kmemleak.c
>>>>>> @@ -576,6 +576,16 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>>>>>>  	struct rb_node **link, *rb_parent;
>>>>>>  
>>>>>>  	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
>>>>>> +#ifdef CONFIG_PREEMPT_COUNT
>>>>>> +	if (!object) {
>>>>>> +		/* last-ditch effort in a low-memory situation */
>>>>>> +		if (irqs_disabled() || is_idle_task(current) || in_atomic())
>>>>>> +			gfp = GFP_ATOMIC;
>>>>>> +		else
>>>>>> +			gfp = gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
>>>>>> +		object = kmem_cache_alloc(object_cache, gfp);
>>>>>> +	}
>>>>>> +#endif
>> [...]
>>> I will not object to this workaround but I strongly believe that
>>> kmemleak should rethink the metadata allocation strategy to be really
>>> robust.
>>
>> This would be nice indeed and it was discussed last year. I just haven't
>> got around to trying anything yet:
>>
>> https://marc.info/?l=linux-mm&m=152812489819532
>>
> 
> It could be helpful to apply this 10-line patch first if has no fundamental
> issue, as it survives probably 50 times running LTP oom* workloads without a
> single kmemleak allocation failure.
> 
> Of course, if someone is going to embed kmemleak metadata into slab objects
> itself soon, this workaround is not needed.
> 

Well, it is really hard to tell even if someone get eventually redesign kmemleak
to embed the metadata into slab objects alone would survive LTP oom* workloads,
because it seems still use separate metadata for non-slab objects where kmemleak
allocation could fail like it right now and disable itself again.
