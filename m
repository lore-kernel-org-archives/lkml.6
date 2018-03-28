Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeC1IAs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:00:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:34798 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752305AbeC1IAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:00:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,370,1517904000";
   d="scan'208";a="28697909"
Date: Wed, 28 Mar 2018 15:59:48 +0800
From: kbuild test robot <lkp@intel.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/list_lru: replace spinlock with RCU in
 __list_lru_count_one
Message-ID: <201803281454.4QSlrPKy%fengguang.wu@intel.com>
References: <1522137544-27496-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522137544-27496-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc7]
[cannot apply to next-20180327]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Li-RongQing/mm-list_lru-replace-spinlock-with-RCU-in-__list_lru_count_one/20180328-042620
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> mm/list_lru.c:59:15: sparse: incompatible types in comparison expression (different address spaces)
   mm/list_lru.c:61:24: sparse: incompatible types in comparison expression (different address spaces)
>> mm/list_lru.c:59:15: sparse: incompatible types in comparison expression (different address spaces)
   mm/list_lru.c:61:24: sparse: incompatible types in comparison expression (different address spaces)
>> mm/list_lru.c:59:15: sparse: incompatible types in comparison expression (different address spaces)
   mm/list_lru.c:61:24: sparse: incompatible types in comparison expression (different address spaces)
>> mm/list_lru.c:59:15: sparse: incompatible types in comparison expression (different address spaces)
   mm/list_lru.c:61:24: sparse: incompatible types in comparison expression (different address spaces)
>> mm/list_lru.c:59:15: sparse: incompatible types in comparison expression (different address spaces)
   mm/list_lru.c:61:24: sparse: incompatible types in comparison expression (different address spaces)
>> mm/list_lru.c:59:15: sparse: incompatible types in comparison expression (different address spaces)
   mm/list_lru.c:61:24: sparse: incompatible types in comparison expression (different address spaces)

vim +59 mm/list_lru.c

    51	
    52	static inline struct list_lru_one *
    53	list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
    54	{
    55		struct list_lru_memcg *tmp;
    56	
    57		WARN_ON_ONCE(!rcu_read_lock_held());
    58	
  > 59		tmp = rcu_dereference(nlru->memcg_lrus);
    60		if (tmp && idx >= 0)
    61			return rcu_dereference(tmp->lru[idx]);
    62	
    63		return &nlru->lru;
    64	}
    65	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
