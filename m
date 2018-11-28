Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78842C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E5F2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E5F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeK1VIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:08:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbeK1VIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:08:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20308316468F;
        Wed, 28 Nov 2018 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.32.181.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8B0770121;
        Wed, 28 Nov 2018 10:07:10 +0000 (UTC)
Message-ID: <35b45d85f2c5072d921b555df43bcc4e5a9feb64.camel@redhat.com>
Subject: Re: net/sched/act_police.c:232 tcf_police_init() warn: possible
 memory leak of 'new'
From:   Davide Caratti <dcaratti@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>
In-Reply-To: <20181128092822.GK3073@unbuntlaptop>
References: <20181128092822.GK3073@unbuntlaptop>
Organization: red hat
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 28 Nov 2018 11:07:10 +0100
Mime-Version: 1.0
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 28 Nov 2018 10:07:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-28 at 12:28 +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ef78e5ec9214376c5cb989f5da70b02d0c117b66
> commit: f2cbd485282014132851bf37cb2ca624a456275d net/sched: act_police: fix race condition on state variables

hello,

> smatch warnings:
> net/sched/act_police.c:232 tcf_police_init() warn: possible memory leak of 'new'
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f2cbd485282014132851bf37cb2ca624a456275d
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout f2cbd485282014132851bf37cb2ca624a456275d
> vim +/new +232 net/sched/act_police.c

<...>

> a883bf564 net/sched/act_police.c Jarek Poplawski   2009-03-04  155  	} else if (tb[TCA_POLICE_AVRATE] &&
> a883bf564 net/sched/act_police.c Jarek Poplawski   2009-03-04  156  		   (ret == ACT_P_CREATED ||
> 1c0d32fde net/sched/act_police.c Eric Dumazet      2016-12-04  157  		    !gen_estimator_active(&police->tcf_rate_est))) {
> a883bf564 net/sched/act_police.c Jarek Poplawski   2009-03-04  158  		err = -EINVAL;
> 74030603d net/sched/act_police.c WANG Cong         2017-06-13  159  		goto failure;
> ^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  160  	}
> 71bcb09a5 net/sched/act_police.c Stephen Hemminger 2008-11-25  161  
> 2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  162  	new = kzalloc(sizeof(*new), GFP_KERNEL);
> 2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  163  	if (unlikely(!new)) {
> 2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  164  		err = -ENOMEM;
> 2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  165  		goto failure;
> 2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  166  	}
> 2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  167  
> ^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  168  	/* No failure allowed after this point */

in commit c08f5ed5d ("net/sched: act_police: disallow 'goto chain' on
fallback control action"), I didn't notice the above comment,

<...>

> ^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  197  
> c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  198  	if (tb[TCA_POLICE_RESULT]) {
> c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  199  		new->tcfp_result = nla_get_u32(tb[TCA_POLICE_RESULT]);
> c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  200  		if (TC_ACT_EXT_CMP(new->tcfp_result, TC_ACT_GOTO_CHAIN)) {
> c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  201  			NL_SET_ERR_MSG(extack,
> c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  202  				       "goto chain not allowed on fallback");
> c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  203  			err = -EINVAL;
> c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  204  			goto failure;
>                                                                                         ^^^^^^^^^^^^
> kfree_rcu(new, rcu); ?

... and I introduced a 'goto failure', to avoid the NULL pointer
dereference in the traffic path. I think it's correct to call
kfree_rcu(new, rcu), or (maybe better) reject invalid values of
TCA_POLICE_RESULT before allocating 'new', so we avoid kzalloc() +
kfree_rcu() if we already know that the control action is not valid.

I will send a patch in the next hours.
thanks!
-- 
davide


