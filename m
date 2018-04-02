Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeDBL6l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 07:58:41 -0400
Received: from mx-fe5-210.meituan.com ([103.37.138.210]:34964 "EHLO
        mx02.meituan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeDBL6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 07:58:39 -0400
DKIM-Filter: OpenDKIM Filter v2.9.2 dx-it-mx02.dx.sankuai.com 90B052976048
Subject: [RFC] Is it correctly that the usage for spin_{lock|unlock}_irq in
 clear_page_dirty_for_io
References: <157ed606-4a61-508b-d26a-2f5d638f39bb@meituan.com>
To: tj@kernel.org, hannes@cmpxchg.org
Cc: gthelen@google.com, npiggin@suse.de, akpm@osdl.org,
        linux-kernel@vger.kernel.org, wanglong19@meituan.com
From: Wang Long <wanglong19@meituan.com>
X-Forwarded-Message-Id: <157ed606-4a61-508b-d26a-2f5d638f39bb@meituan.com>
Message-ID: <d5f73e91-6fd5-12ab-d005-93a72e146464@meituan.com>
Date: Mon, 2 Apr 2018 19:50:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <157ed606-4a61-508b-d26a-2f5d638f39bb@meituan.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w32BwoRs030867


Hi,  Johannes Weiner and Tejun Heo

I use linux-4.4.y to test the new cgroup controller io and the current
stable kernel linux-4.4.y has the follow logic


int clear_page_dirty_for_io(struct page *page){
...
...
                 memcg = mem_cgroup_begin_page_stat(page); ----------(a)
                 wb = unlocked_inode_to_wb_begin(inode, &locked); ---------(b)
                 if (TestClearPageDirty(page)) {
                         mem_cgroup_dec_page_stat(memcg, MEM_CGROUP_STAT_DIRTY);
                         dec_zone_page_state(page, NR_FILE_DIRTY);
                         dec_wb_stat(wb, WB_RECLAIMABLE);
                         ret =1;
                 }
                 unlocked_inode_to_wb_end(inode, locked); -----------(c)
                 mem_cgroup_end_page_stat(memcg); -------------(d)
                 return ret;
...
...
}


when memcg is moving, and I_WB_SWITCH flags for inode is set. the logic
is the following:


spin_lock_irqsave(&memcg->move_lock, flags); -------------(a)
         spin_lock_irq(&inode->i_mapping->tree_lock); ------------(b)
         spin_unlock_irq(&inode->i_mapping->tree_lock); -----------(c)
spin_unlock_irqrestore(&memcg->move_lock, flags); -----------(d)


after (c) , the local irq is enabled. I think it is not correct.

We get a deadlock backtrace after (c), the cpu get an softirq and in the
irq it also call mem_cgroup_begin_page_stat to lock the same
memcg->move_lock.

Since the conditions are too harsh, this scenario is difficult to
reproduce.  But it really exists.

So how about change (b) (c) to spin_lock_irqsave/spin_lock_irqrestore?

Thanks:-)
