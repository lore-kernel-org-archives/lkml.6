Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7E9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2E22073F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qggCaO0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfACD1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:27:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35797 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfACD1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:27:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so35665075qtc.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 19:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fC6zZwwkZFDhotViCDXx6OKAdwNRRqxuNgHWv0kuoD4=;
        b=qggCaO0xleTaFzqcx8RrXZZAhj9x3MS3amTq7vuT9//SwTU83ANwIJ917h1asxUVal
         rIGnKI7r/L+FJXQLpozgc88uDd7t6vomEVmKQ+Fr0Ies7un5gwNUxtTt5HqfGOhk0Tsg
         H2nCdK9qy5sTDZ8Lk1c5uwaAY07MbzIFRPKIGf/kNuz1EyblqHNoqq307JENEhSk1Uen
         Rwhr9F86rn4aRpedMfu8yYMQs4R/7Hg0s/qCPX172lbSpyTpImTejmOUx3GYsJbsoRwk
         CWuRADcrRV+K5OQwEkub+OK/gcUW/w5XKObduJiEwz3rWXTZizzA8C+RWJl2yJGzQ2/h
         0+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fC6zZwwkZFDhotViCDXx6OKAdwNRRqxuNgHWv0kuoD4=;
        b=K+ABettODLA6eXfrnpxDhKTJEAGvbYqFKxzCdAsyeS1yP6OqyJalHJXxv/oO6AmBOD
         gsB4d3GNk5JWDFiEEA9MuvDFnulGLVvAT12jXySdMFhM6TNVM3EPJU/IqJAlUOV57qjh
         sa1KYlXbd85Jcnxj8mGHKovsMY8WDtbpTDsSuV5orNcc2iuF8yfEYUfx2QPcDVY1si2b
         E1Lx5hUi1UzvUe9z66Rwojd4fUEi9ZatI82HIrw9kuxLkbDTOn4nRt68S/Z8XdYuR21e
         aVMMaScSbLTaWsHFbpamL5XQx18LsQzK/W/P6euQ1txrP/B2Np0veOidrjT41vDcIS+B
         BOkA==
X-Gm-Message-State: AA+aEWZJMeeEPkz/bZG0Vit+hLulchSGNl/eDyhZb2aykIUGmyKyFBo9
        bSe50Sw3H9b7lvuWSKB/3lPezA==
X-Google-Smtp-Source: ALg8bN798HeIPK9Cy6qiRh5NjT130Go2BR9+xwrB1xfkOo9OGu2KKh7Rb4KoYMWwpppjmPtI35UeQg==
X-Received: by 2002:ac8:5314:: with SMTP id t20mr43855892qtn.328.1546486063301;
        Wed, 02 Jan 2019 19:27:43 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s24sm6283886qkl.48.2019.01.02.19.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 19:27:42 -0800 (PST)
Subject: Re: possible deadlock in __wake_up_common_lock
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@dominikbrodowski.net, mhocko@suse.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        xieyisheng1@huawei.com, zhongjiang@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <000000000000f67ca2057e75bec3@google.com>
 <1194004c-f176-6253-a5fd-682472dccacc@suse.cz>
 <20190102180611.GE31517@techsingularity.net>
 <73c41960-e282-e2ec-4edd-788a1f49f06a@lca.pw>
 <530f88a1-3aa1-c36f-f487-7e5e33402fb0@I-love.SAKURA.ne.jp>
From:   Qian Cai <cai@lca.pw>
Message-ID: <afbbf914-4f76-7c6a-c286-599b97c0f005@lca.pw>
Date:   Wed, 2 Jan 2019 22:27:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <530f88a1-3aa1-c36f-f487-7e5e33402fb0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/19 8:28 PM, Tetsuo Handa wrote:
> On 2019/01/03 3:19, Qian Cai wrote:
>> On 1/2/19 1:06 PM, Mel Gorman wrote:
>>
>>> While I recognise there is no test case available, how often does this
>>> trigger in syzbot as it would be nice to have some confirmation any
>>> patch is really fixing the problem.
>>
>> I think I did manage to trigger this every time running a mmap() workload
>> causing swapping and a low-memory situation [1].
>>
>> [1]
>> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c
> 
> wakeup_kswapd() is called because tlb_next_batch() is doing GFP_NOWAIT
> allocation. But since tlb_next_batch() can tolerate allocation failure,
> does below change in tlb_next_batch() help?
> 
> #define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM)
> 
> -	batch = (void *)__get_free_pages(GFP_NOWAIT | __GFP_NOWARN, 0);
> +	batch = (void *)__get_free_pages(__GFP_NOWARN, 0);

No. In oom01 case, it is from,

do_anonymous_page
  __alloc_zeroed_user_highpage
    alloc_page_vma(GFP_HIGHUSER ...

GFP_HIGHUSER -> GFP_USER -> __GFP_RECLAIM -> ___GFP_KSWAPD_RECLAIM


Then, it has this new code in steal_suitable_fallback() via 1c30844d2df (mm:
reclaim small amounts of memory when an external fragmentation event occurs)

 /*
  * Boost watermarks to increase reclaim pressure to reduce
  * the likelihood of future fallbacks. Wake kswapd now as
  * the node may be balanced overall and kswapd will not
  * wake naturally.
  */
  boost_watermark(zone);
  if (alloc_flags & ALLOC_KSWAPD)
  	wakeup_kswapd(zone, 0, 0, zone_idx(zone));
