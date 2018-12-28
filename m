Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D79C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36AE2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbeL1KZL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:25:11 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:55215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730344AbeL1KZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:25:11 -0500
Received: from DGGEMA401-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 1402D43E7378B;
        Fri, 28 Dec 2018 18:25:08 +0800 (CST)
Received: from DGGEMA423-HUB.china.huawei.com (10.1.198.156) by
 DGGEMA401-HUB.china.huawei.com (10.3.20.42) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 28 Dec 2018 18:25:09 +0800
Received: from DGGEMA523-MBX.china.huawei.com ([169.254.5.180]) by
 dggema423-hub.china.huawei.com ([10.1.198.156]) with mapi id 14.03.0415.000;
 Fri, 28 Dec 2018 18:25:03 +0800
From:   "Xiezhipeng (EulerOS)" <xiezhipeng1@huawei.com>
To:     Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Xiexiuqi <xiexiuqi@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Libin (Huawei)" <huawei.libin@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
Thread-Topic: [PATCH] sched: fix infinity loop in update_blocked_averages
Thread-Index: AQHUnY/m/dpwfh+CH0uUxv44BLG9KqWRyfmAgAAQjYCAAAC8gIAAaQmAgAAGKwCAABSLgIAAdWEAgAAF+YCAAATGAIAAAnmAgAERSYA=
Date:   Fri, 28 Dec 2018 10:25:03 +0000
Message-ID: <48288652705F324A84AF3075655DB966011B80E3@dggema523-mbx.china.huawei.com>
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
In-Reply-To: <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.217.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Fri, Dec 28, 2018 10:03 AM, Tejun Heo wrote:
> 
> On Thu, Dec 27, 2018 at 05:53:52PM -0800, Tejun Heo wrote:
> > Vincent knows that part way better than me but I think the safest way
> > would be doing the optimization removal iff tmp_alone_branch is
> > already pointing to leaf_cfs_rq_list.  IIUC, it's pointing to
> > something else only while a branch is being built and deferring
> > optimization removal by an avg update cycle isn't gonna make any
> > difference anyway.
> 
> So, something like the following.  Xie, can you see whether the
> following patch resolves the problem?
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
Tested-by: Zhipeng Xie <xiezhipeng1@huawei.com>

This patch fixes things for me, we haven't seen a crash yet.

--
Thanks,
Zhipeng Xie
