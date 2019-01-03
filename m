Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6979120815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbfACPBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:01:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:33102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727066AbfACPBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:01:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 563A6AC8D;
        Thu,  3 Jan 2019 15:01:12 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] use rwlock in order to reduce ep_poll_callback() contention
Date:   Thu,  3 Jan 2019 16:01:00 +0100
Message-Id: <20190103150104.17128-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last patch targets the contention problem in ep_poll_callback(), which
can be very well reproduced by generating events (write to pipe or eventfd)
from many threads, while consumer thread does polling.

The following are some microbenchmark results based on the test [1] which
starts threads which generate N events each.  The test ends when all events
are successfully fetched by the poller thread:

 spinlock
 ========

 threads  events/ms  run-time ms
       8       6402        12495
      16       7045        22709
      32       7395        43268

 rwlock + xchg
 =============

 threads  events/ms  run-time ms
       8      10038         7969
      16      12178        13138
      32      13223        24199


According to the results bandwidth of delivered events is significantly
increased, thus execution time is reduced.

This series is based on linux-next/akpm.

v2:
 o I was wrong saying that ep_poll_callback() can't be called 
   concurrently for the same epi: several wait queues can be
   attached to the single epoll item, thus several event sources
   can signal in parallel.  To cover this case lockless element
   addition has to detect that the same @epi is not yet in the
   list.  This is done by extra cmpxchg() operation.

 o unify awaking of wakeup source calling ep_pm_stay_awake_rcu(epi)
   in all the cases from ep_poll_callback() path.

 o more explicit comments

[1] https://github.com/rouming/test-tools/blob/master/stress-epoll.c

Roman Penyaev (4):
  epoll: make sure all elements in ready list are in FIFO order
  epoll: loosen irq safety in ep_poll_callback()
  epoll: unify awaking of wakeup source on ep_poll_callback() path
  epoll: use rwlock in order to reduce ep_poll_callback() contention

 fs/eventpoll.c | 178 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 133 insertions(+), 45 deletions(-)

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
-- 
2.19.1

