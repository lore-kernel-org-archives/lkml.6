Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41266C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A2324737
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A2324737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeGCUyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:54:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeGCUyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:54:08 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 277A0D06;
        Tue,  3 Jul 2018 20:54:07 +0000 (UTC)
Date:   Tue, 3 Jul 2018 13:54:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
Subject: Re: [PATCH v8 13/17] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
Message-Id: <20180703135406.a5408dd14c31ddfa96894ada@linux-foundation.org>
In-Reply-To: <153063065671.1818.15914674956134687268.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
        <153063065671.1818.15914674956134687268.stgit@localhost.localdomain>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jul 2018 18:10:56 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> Introduce set_shrinker_bit() function to set shrinker-related
> bit in memcg shrinker bitmap, and set the bit after the first
> item is added and in case of reparenting destroyed memcg's items.
> 
> This will allow next patch to make shrinkers be called only,
> in case of they have charged objects at the moment, and
> to improve shrink_slab() performance.
> 
> ...
>
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1308,6 +1308,18 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
>  
>  extern int memcg_expand_shrinker_maps(int new_id);
>  
> +static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> +					  int nid, int shrinker_id)
> +{
> +	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
> +		struct memcg_shrinker_map *map;
> +
> +		rcu_read_lock();
> +		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
> +		set_bit(shrinker_id, map->map);
> +		rcu_read_unlock();
> +	}
> +}

Three callsites, this seem rather large for inlining.
