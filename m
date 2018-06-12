Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 11F3DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB5B208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="vwyJL/yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB5B208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934384AbeFLPub (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:50:31 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:54262 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933137AbeFLPua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XGFA4u88S9/eagEXpICkjHR3Y7OszNKgAfVQPcDRimI=; b=vwyJL/yys8tmDpsj2y19G8tCfJ
        i5h6DJ0T5bzrcqOJjdeZo4Uu22WJmAYarx+aBfDg5pmCyfnXYC8yZGhjvH+HhLJ8gqsKgN6F4T76M
        Th4naIZS6A+bwSrX083lezUZICWXGn4vR0L1hWDgupfpN8soLHsAs3hZfFOYQ/+LJ9x8=;
Date:   Tue, 12 Jun 2018 11:52:42 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] mm, memcg: propagate memory effective protection
 on setting memory.min/low
Message-ID: <20180612155242.GA6300@cmpxchg.org>
References: <20180611175418.7007-1-guro@fb.com>
 <20180611175418.7007-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611175418.7007-3-guro@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 10:54:17AM -0700, Roman Gushchin wrote:
> Explicitly propagate effective memory min/low values down by the tree.
> 
> If there is the global memory pressure, it's not really necessary.
> Effective memory guarantees will be propagated automatically as we
> traverse memory cgroup tree in the reclaim path.
> 
> But if there is no global memory pressure, effective memory protection
> still matters for local (memcg-scoped) memory pressure.  So, we have to
> update effective limits in the subtree, if a user changes memory.min and
> memory.low values.
> 
> Link: http://lkml.kernel.org/r/20180522132528.23769-1-guro@fb.com
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linuxfoundation.org>
> ---
>  mm/memcontrol.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5a3873e9d657..485df6f63d26 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5084,7 +5084,7 @@ static int memory_min_show(struct seq_file *m, void *v)
>  static ssize_t memory_min_write(struct kernfs_open_file *of,
>  				char *buf, size_t nbytes, loff_t off)
>  {
> -	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	struct mem_cgroup *iter, *memcg = mem_cgroup_from_css(of_css(of));
>  	unsigned long min;
>  	int err;
>  
> @@ -5095,6 +5095,11 @@ static ssize_t memory_min_write(struct kernfs_open_file *of,
>  
>  	page_counter_set_min(&memcg->memory, min);
>  
> +	rcu_read_lock();
> +	for_each_mem_cgroup_tree(iter, memcg)
> +		mem_cgroup_protected(NULL, iter);
> +	rcu_read_unlock();

I'm not quite following. mem_cgroup_protected() is a just-in-time
query that depends on the groups' usage. How does it make sense to run
this at the time the limit is set?

Also, why is target reclaim different from global reclaim here? We
have all the information we need, even if we don't start at the
root_mem_cgroup. If we enter target reclaim against a specific cgroup,
yes, we don't know the elow it receives from its parents. What we *do*
know, though, is that it hit its own hard limit. What is happening
higher up that group doesn't matter for the purpose of protection.

I.e. it seems to me that instead of this patch we should be treating
the reclaim root and its first-level children the same way we treat
root_mem_cgroup and top-level cgroups: no protection for the root,
first children use their low setting as the elow, all descendants get
the proportional low-usage distribution.
