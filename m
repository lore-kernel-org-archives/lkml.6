Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C56C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35B520840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35B520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbeHAVNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:13:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727608AbeHAVNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:13:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37C759BA9A;
        Wed,  1 Aug 2018 19:26:31 +0000 (UTC)
Received: from bistromath.localdomain (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F03C215670D;
        Wed,  1 Aug 2018 19:26:27 +0000 (UTC)
Date:   Wed, 1 Aug 2018 21:26:39 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     David Miller <davem@davemloft.net>
Cc:     xiyou.wangcong@gmail.com, eric.dumazet@gmail.com,
        syzbot+41f9c04b50ef70c66947@syzkaller.appspotmail.com,
        christian.brauner@ubuntu.com, dsahern@gmail.com, fw@strlen.de,
        jbenc@redhat.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, lucien.xin@gmail.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in rtnetlink_put_metrics
Message-ID: <20180801192639.GA30287@bistromath.localdomain>
References: <c8ffd001-8c67-19b9-7223-34ca8d436db2@gmail.com>
 <20180731134014.GA32114@bistromath.localdomain>
 <CAM_iQpURKOMAaPfs9v7FzhqqQPzj71sQD2LS0eU8cuqTML-YoA@mail.gmail.com>
 <20180801.114636.279269263935333136.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180801.114636.279269263935333136.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 01 Aug 2018 19:26:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 01 Aug 2018 19:26:31 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sd@queasysnail.net' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-01, 11:46:36 -0700, David Miller wrote:
> From: Cong Wang <xiyou.wangcong@gmail.com>
> Date: Tue, 31 Jul 2018 16:03:13 -0700
> 
> > Looks like this commit is completely unnecessary,
> > fib6_drop_pcpu_from() calls fib6_info_release()
> > which calls fib6_info_destroy_rcu(), so this metrics
> > will be released twice...
> 
> And even if there was a leak here, it's illegal to free this
> metrics memory synchronously since it is RCU protected.

Yeah, I noticed that today, but I don't think that's the problem we're
seeing here.

> That's why it normally goes through fib6_info_destroy_rcu().
> 
> Sabrina, I'm going to revert your changes unless I see some
> progress here by the end of today.

Yeah, I'm fine with a revert, we can fix the leak later.


syzbot hasn't found a reproducer so I'm not sure it's the same issue,
but I ran into this: we can create a route, start using it, and then
give it some metrics. In that case, we'll hit rt6_set_from() with the
default metrics, so we don't refcount them. Then fib6_metric_set()
will assign the new metrics to the parent route.
Then fib6_drop_pcpu_from will see that the parent route has
non-default metrics, and try to release this, but the percpu copy
doesn't actually hold a reference. Bandaid would be to put a
DST_METRICS_REFCOUNTED check in fib6_drop_pcpu_from().

Looking at rt6_set_from(), it seems we can also do dst_init_metrics
with the old metrics, then refcount the new metrics.

And I'm not sure whether the refcount_set in fib6_metric_set() can't
be reordered so that rt6_set_from() might see the new metrics pointer,
increment the refcount, then fib6_metric_set() would do its
refcount_set, stepping over the previous increment.

-- 
Sabrina
