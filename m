Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755262AbeDCIaC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:30:02 -0400
Received: from mx23.baidu.com ([61.135.165.120]:39504 "EHLO baidu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754969AbeDCI35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:29:57 -0400
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: [PATCH] mm: avoid the unnecessary waiting when force empty a
 cgroup
Thread-Topic: [PATCH] mm: avoid the unnecessary waiting when force empty a
 cgroup
Thread-Index: AdPLJMHeeMKUHXBDROio5VQy2ewJrQ==
Date: Tue, 3 Apr 2018 08:29:39 +0000
Message-ID: <2AD939572F25A448A3AE3CAEA61328C23756E4F1@BC-MAIL-M28.internal.baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.62.16]
x-baidu-bdmsfe-datecheck: 1_BC-MAIL-HUB02_2018-04-03 16:29:46:750
x-baidu-bdmsfe-viruscheck: BC-MAIL-HUB02_GRAY_Inside_WithoutAtta_2018-04-03
 16:29:45:362
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w338U7tS011504



> -----邮件原件-----
> 发件人: Michal Hocko [mailto:mhocko@kernel.org]
> 发送时间: 2018年4月3日 16:05
> 收件人: Li,Rongqing <lirongqing@baidu.com>
> 抄送: hannes@cmpxchg.org; vdavydov.dev@gmail.com;
> cgroups@vger.kernel.org; linux-mm@kvack.org;
> linux-kernel@vger.kernel.org
> 主题: Re: [PATCH] mm: avoid the unnecessary waiting when force empty a
> cgroup
> 
> On Tue 03-04-18 15:12:09, Li RongQing wrote:
> > The number of writeback and dirty page can be read out from memcg, the
> > unnecessary waiting can be avoided by these counts
> 
> This changelog doesn't explain the problem and how the patch fixes it.

If a process in a memory cgroup takes some RSS, when force empty this memory cgroup, congestion_wait will be called unconditionally, there is 0.5 seconds delay

If use this patch, nearly no delay.


> Why do wee another throttling when we do already throttle in the reclaim
> path?

Do you mean we should remove congestion_wait(BLK_RW_ASYNC, HZ/10) from mem_cgroup_force_empty, since try_to_free_mem_cgroup_pages [shrink_inactive_list] has called congestion_wait


-RongQing

> 
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >  mm/memcontrol.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c index
> > 9ec024b862ac..5258651bd4ec 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2613,9 +2613,13 @@ static int mem_cgroup_force_empty(struct
> mem_cgroup *memcg)
> >  		progress = try_to_free_mem_cgroup_pages(memcg, 1,
> >  							GFP_KERNEL, true);
> >  		if (!progress) {
> > +			unsigned long num;
> > +
> > +			num = memcg_page_state(memcg, NR_WRITEBACK) +
> > +					memcg_page_state(memcg, NR_FILE_DIRTY);
> >  			nr_retries--;
> > -			/* maybe some writeback is necessary */
> > -			congestion_wait(BLK_RW_ASYNC, HZ/10);
> > +			if (num)
> > +				congestion_wait(BLK_RW_ASYNC, HZ/10);
> >  		}
> >
> >  	}
> > --
> > 2.11.0
> 
> --
> Michal Hocko
> SUSE Labs
