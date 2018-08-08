Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADC6C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF60F219E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF60F219E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeHHO4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:56:02 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55927 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeHHO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:56:01 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w78CaN8k030668;
        Wed, 8 Aug 2018 21:36:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Wed, 08 Aug 2018 21:36:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w78CaJr4030649
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 8 Aug 2018 21:36:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH RFC 02/10] mm: Make shrink_slab() lockless
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365626605.19074.16202958374930777592.stgit@localhost.localdomain>
 <591d2063-0511-103d-bef6-dd35f55afe32@virtuozzo.com>
Cc:     mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e6489e38-6f73-2f5d-61b6-ffd1f6462aab@i-love.sakura.ne.jp>
Date:   Wed, 8 Aug 2018 21:36:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <591d2063-0511-103d-bef6-dd35f55afe32@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/08 20:51, Kirill Tkhai wrote:
> @@ -192,7 +193,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  	int id, ret = -ENOMEM;
>  
>  	down_write(&shrinker_rwsem);
> -	/* This may call shrinker, so it must use down_read_trylock() */
>  	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
>  	if (id < 0)
>  		goto unlock;

I don't know why perf reports down_read_trylock(&shrinker_rwsem). But
above code is already bad. GFP_KERNEL allocation involves shrinkers and
the OOM killer would be invoked because shrinkers are defunctional due to
this down_write(&shrinker_rwsem). Please avoid blocking memory allocation
with shrinker_rwsem held.
