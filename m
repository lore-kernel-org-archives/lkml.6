Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F96026D98
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F96026D98
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeFZQRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:17:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50505 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeFZQRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:17:04 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=somnus.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1fXqeL-00057G-LI; Tue, 26 Jun 2018 18:17:01 +0200
Date:   Tue, 26 Jun 2018 18:16:04 +0200 (CEST)
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: sched/core warning triggers on rcu torture test
Message-ID: <alpine.DEB.2.21.1806261709001.19188@somnus>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

during rcu torture tests (TREE04 and TREE07) I noticed, that a
WARN_ON_ONCE() in sched core triggers on a recent 4.18-rc2 based
kernel (6f0d349d922b ("Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")) as well as
on a 4.17.3.

I'm running the tests on a machine with 144 cores:

  tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "9*TREE07"
  tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "18*TREE04"


The warning was introduced by commit d84b31313ef8 ("sched/isolation:
Offload residual 1Hz scheduler tick").


Output looks similar for all tests I did (this one is the output of
the 4.18-rc2 based kernel):

WARNING: CPU: 11 PID: 906 at kernel/sched/core.c:3138 sched_tick_remote+0xb6/0xc0
Modules linked in:
CPU: 11 PID: 906 Comm: kworker/u32:3 Not tainted 4.18.0-rc2+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Workqueue: events_unbound sched_tick_remote
RIP: 0010:sched_tick_remote+0xb6/0xc0
Code: e8 0f 06 b8 00 c6 03 00 fb eb 9d 8b 43 04 85 c0 75 8d 48 8b 83 e0 0a 00 00 48 85 c0 75 81 eb 88 48 89 df e8 bc fe ff ff eb aa <0f> 0b eb c5 66 0f 1f 44 00 00 bf 17 00 00 00 e8 b6 2e fe ff 0f b6
Call Trace:
 process_one_work+0x1df/0x3b0
 worker_thread+0x44/0x3d0
 kthread+0xf3/0x130
 ? set_worker_desc+0xb0/0xb0
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x35/0x40
---[ end trace 7c99b83eb0ec64e8 ]---


Do you need some more information?


Thanks,

	Anna-Maria
