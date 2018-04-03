Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755172AbeDCIk2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:40:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:32998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754965AbeDCIk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:40:27 -0400
Date: Tue, 3 Apr 2018 10:40:24 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: avoid the unnecessary waiting when force empty a
 cgroup
Message-ID: <20180403084024.GH5501@dhcp22.suse.cz>
References: <2AD939572F25A448A3AE3CAEA61328C23756E4F1@BC-MAIL-M28.internal.baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2AD939572F25A448A3AE3CAEA61328C23756E4F1@BC-MAIL-M28.internal.baidu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-04-18 08:29:39, Li,Rongqing wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: Michal Hocko [mailto:mhocko@kernel.org]
> > 发送时间: 2018年4月3日 16:05
> > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > 抄送: hannes@cmpxchg.org; vdavydov.dev@gmail.com;
> > cgroups@vger.kernel.org; linux-mm@kvack.org;
> > linux-kernel@vger.kernel.org
> > 主题: Re: [PATCH] mm: avoid the unnecessary waiting when force empty a
> > cgroup
> > 
> > On Tue 03-04-18 15:12:09, Li RongQing wrote:
> > > The number of writeback and dirty page can be read out from memcg, the
> > > unnecessary waiting can be avoided by these counts
> > 
> > This changelog doesn't explain the problem and how the patch fixes it.
> 
> If a process in a memory cgroup takes some RSS, when force empty this
> memory cgroup, congestion_wait will be called unconditionally, there
> is 0.5 seconds delay

OK, so the problem is that force_empty hits congestion_wait too much?
Why do we have no progress from try_to_free_mem_cgroup_pages?
 
> If use this patch, nearly no delay.
> 
> 
> > Why do wee another throttling when we do already throttle in the reclaim
> > path?
> 
> Do you mean we should remove congestion_wait(BLK_RW_ASYNC, HZ/10)
> from mem_cgroup_force_empty, since try_to_free_mem_cgroup_pages
> [shrink_inactive_list] has called congestion_wait

If it turns unnecessary, which is quite possible then yes. As I've said
we already throttle when seeing pages under writeback. If that is not
sufficient then we should investigate why.

Please also note that force_empty is considered deprecated. Do you have
any usecase which led you to fixing it?
-- 
Michal Hocko
SUSE Labs
