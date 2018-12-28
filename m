Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F9AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D003820879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeL1Cas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 21:30:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727253AbeL1Cas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 21:30:48 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 83BADE006AE0D;
        Fri, 28 Dec 2018 10:30:42 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.210) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Fri, 28 Dec 2018
 10:30:35 +0800
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
To:     Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181227102107.GA21156@linaro.org>
 <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
 <20181228011524.GF2509588@devbig004.ftw2.facebook.com>
 <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
 <20181228015352.GG2509588@devbig004.ftw2.facebook.com>
 <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <xiezhipeng1@huawei.com>, <huawei.libin@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Rik van Riel <riel@surriel.com>
From:   Xie XiuQi <xiexiuqi@huawei.com>
Message-ID: <5ed559eb-f169-ecd0-0f1a-65786422b9ac@huawei.com>
Date:   Fri, 28 Dec 2018 10:30:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.210]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On 2018/12/28 10:02, Tejun Heo wrote:
> On Thu, Dec 27, 2018 at 05:53:52PM -0800, Tejun Heo wrote:
>> Vincent knows that part way better than me but I think the safest way
>> would be doing the optimization removal iff tmp_alone_branch is
>> already pointing to leaf_cfs_rq_list.  IIUC, it's pointing to
>> something else only while a branch is being built and deferring
>> optimization removal by an avg update cycle isn't gonna make any
>> difference anyway.
> 
> So, something like the following.  Xie, can you see whether the
> following patch resolves the problem?

Zhipeng is preparing to test it, thanks.

> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d1907506318a..88b9118b5191 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7698,7 +7698,8 @@ static void update_blocked_averages(int cpu)
>  		 * There can be a lot of idle CPU cgroups.  Don't let fully
>  		 * decayed cfs_rqs linger on the list.
>  		 */
> -		if (cfs_rq_is_decayed(cfs_rq))
> +		if (cfs_rq_is_decayed(cfs_rq) &&
> +		    rq->tmp_alone_branch == &rq->leaf_cfs_rq_list)
>  			list_del_leaf_cfs_rq(cfs_rq);
>  
>  		/* Don't need periodic decay once load/util_avg are null */
> 
> .
> 

-- 
Thanks,
Xie XiuQi

