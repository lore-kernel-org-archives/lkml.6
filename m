Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F40C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8043820839
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8043820839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbeHGMcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:32:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:19911 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbeHGMcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:32:48 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w77AJA15065140;
        Tue, 7 Aug 2018 19:19:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Tue, 07 Aug 2018 19:19:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w77AJAna065134
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 7 Aug 2018 19:19:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: WARNING in try_charge
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
References: <fc6e173e-8bda-269f-d44f-1c5f5215beac@I-love.SAKURA.ne.jp>
 <0000000000006350880572c61e62@google.com>
 <20180806174410.GB10003@dhcp22.suse.cz>
 <20180806175627.GC10003@dhcp22.suse.cz>
 <078bde8d-b1b5-f5ad-ed23-0cd94b579f9e@i-love.sakura.ne.jp>
 <20180806203437.GK10003@dhcp22.suse.cz>
 <3cf8f630-73b7-20d4-8ad1-bb1c657ee30d@i-love.sakura.ne.jp>
 <20180806205519.GO10003@dhcp22.suse.cz>
 <9c03213f-c099-378b-e9fd-ed6f2a2afdc3@i-love.sakura.ne.jp>
Message-ID: <c1658a69-e6a6-6a0d-0bde-7251f81aa78d@i-love.sakura.ne.jp>
Date:   Tue, 7 Aug 2018 19:19:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9c03213f-c099-378b-e9fd-ed6f2a2afdc3@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/07 6:50, Tetsuo Handa wrote:
>  	list_for_each_entry_safe(p, tmp, &oom_victim_list, oom_victim_list) {
>  		struct mm_struct *mm = p->signal->oom_mm;
>  
>  		if (oom_unkillable_task(p, oc->memcg, oc->nodemask))
>  			continue;
>  		ret = true;
> +		/*
> +		 * Since memcg OOM allows forced charge, we can safely wait
> +		 * until __mmput() completes.
> +		 */
> +		if (is_memcg_oom(oc))
> +			return true;

Oops. If this OOM victim was blocked on some lock which current thread is
holding, waiting forever unconditionally is not safe.

>  #ifdef CONFIG_MMU
>  		/*
>  		 * Since the OOM reaper exists, we can safely wait until
>  		 * MMF_OOM_SKIP is set.
>  		 */
>  		if (!test_bit(MMF_OOM_SKIP, &mm->flags)) {
>  			if (!oom_reap_target) {
>  				get_task_struct(p);
>  				oom_reap_target = p;
>  				trace_wake_reaper(p->pid);
>  				wake_up(&oom_reaper_wait);
>  			}
>  #endif
>  			continue;
>  		}
>  #endif
>  		/* We can wait as long as OOM score is decreasing over time. */
>  		if (!victim_mm_stalling(p, mm))
>  			continue;
>  		gaveup = true;
>  		list_del(&p->oom_victim_list);
>  		/* Drop a reference taken by mark_oom_victim(). */
>  		put_task_struct(p);
>  	}
>  	if (gaveup)
>  		debug_show_all_locks();
>  
>  	return ret;
>  }
> 
