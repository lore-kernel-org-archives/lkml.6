Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17B8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF5B2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfAIDto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:49:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbfAIDtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:49:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DCDA81F10;
        Wed,  9 Jan 2019 03:49:43 +0000 (UTC)
Received: from sky.random (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F03A35C1B4;
        Wed,  9 Jan 2019 03:49:42 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] RFC: sched/fair: skip select_idle_sibling() in presence of sync wakeups
Date:   Tue,  8 Jan 2019 22:49:40 -0500
Message-Id: <20190109034941.28759-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 09 Jan 2019 03:49:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we noticed some unexpected performance regressions in the scheduler by
switching the guest CPU topology from "-smp 2,sockets=2,cores=1" to
"-smp 2,sockets=1,cores=2".

With sockets=2,cores=1 localhost message passing (pipes, AF_UNIX etc..)
runs serially at 100% CPU load of a single vcpu with optimal
performance. With sockets=1,cores=2 the load is spread across both
vcpus and performance is reduced.

With SCHED_MC=n on older kernels the problem goes away (but that's far
from ideal for heavily multithreaded workloads which then regress)
because that basically disables the last part of select_idle_sibling().

On bare metal with SCHED_MC=y on any recent multicore CPU the
scheduler (as expected) behaves like sockets=1,cores=2, so it won't
run the tasks serially.

The reason is that select_idle_sibling() can disregard the "sync" hint
and all decisions done up to that point and at the last minute it can
decide to move the waken task to an arbitrary idle core.

To test the above theory I implemented this patch which seems to
confirm the reason the tasks won't run serially anymore with
sockets=1,cores=2 is select_idle_sibling() overriding the "sync" hint.

You worked on the wake_affine() before so you may want to review this
issue, if you agree these sync workloads should run serially even in
presence of idle cores in the system. I don't know if the current
behavior is on purpose but if it is, it'd be interesting to know
why. This is just a RFC.

To test I used this trivial program.

/*
 *  pipe-loop.c
 *
 *  Copyright (C) 2019 Red Hat, Inc.
 *
 *  This work is licensed under the terms of the GNU GPL, version 2.
 */

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char ** argv)
{
	char buf[1];
	int n = 1000000;

	int pipe1[2], pipe2[2];

	pipe(pipe1);
	pipe(pipe2);

	if (fork()) {
		while (n--) {
			read(pipe1[0], buf, 1);
			write(pipe2[1], buf, 1);
		}
		wait(NULL);
	} else {
		while (n--) {
			write(pipe1[1], buf, 1);
			read(pipe2[0], buf, 1);
		}
	}

	return 0;
}

Andrea Arcangeli (1):
  sched/fair: skip select_idle_sibling() in presence of sync wakeups

 kernel/sched/fair.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)
