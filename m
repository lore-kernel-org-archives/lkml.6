Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985E9C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F1420839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F1420839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeLLLEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:04:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:46020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726856AbeLLLEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:04:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63DC2ACBA;
        Wed, 12 Dec 2018 11:04:31 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] use rwlock in order to reduce ep_poll_callback() contention
Date:   Wed, 12 Dec 2018 12:03:54 +0100
Message-Id: <20181212110357.25656-1-rpenyaev@suse.de>
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

This series is based on linux-next/akpm and differs from RFC in that
additional cleanup patches and explicit comments have been added.

[1] https://github.com/rouming/test-tools/blob/master/stress-epoll.c

Roman Penyaev (3):
  epoll: make sure all elements in ready list are in FIFO order
  epoll: loosen irq safety in ep_poll_callback()
  epoll: use rwlock in order to reduce ep_poll_callback() contention

 fs/eventpoll.c | 127 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 93 insertions(+), 34 deletions(-)

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

