Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E319AC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87252147D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87252147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeK3Js7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:48:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeK3Js7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:48:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD2D330041CE;
        Thu, 29 Nov 2018 22:41:55 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3980260123;
        Thu, 29 Nov 2018 22:41:53 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] locking/lockdep: Track number of zapped classes & report abuse
Date:   Thu, 29 Nov 2018 17:41:35 -0500
Message-Id: <1543531297-18349-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 29 Nov 2018 22:41:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a kernel module is repeatedly load and unload, it will eventually
exhaust the lockdep entries resulting in a bug message. This is a use
case that the current lockdep code cannot support.

This patchset tracks the number of zapped classes and print a warning if
too many lockdep entries are wasted because of too many module unloading.
For example,

[ 2490.651531] BUG: MAX_LOCKDEP_KEYS too low!
[ 2490.669925] turning off the locking correctness validator.
[ 2490.669925] Please attach the output of /proc/lock_stat to the bug report
[ 2490.669926] ========================================================
[ 2490.669927] WARNING: 6499 out of 8191 locks have been destroyed
[ 2490.669927] through kernel module unload operations.
[ 2490.669928] The corresponding lockdep entries are not reusable.
[ 2490.669928] The system might have run out of lockdep entries because
[ 2490.669929] of repeated kernel module load and unload operations.
[ 2490.669929] Lockdep cannot support this particular use case.
[ 2490.669930] --------------------------------------------------------

Waiman Long (2):
  locking/lockdep: Annotate #else/#endif's that are far from #if
  locking/lockdep: Track number of zapped classes & report abuse

 kernel/locking/lockdep.c           | 42 ++++++++++++++++++++++++++++++--------
 kernel/locking/lockdep_internals.h |  1 +
 kernel/locking/lockdep_proc.c      |  2 ++
 3 files changed, 37 insertions(+), 8 deletions(-)

-- 
1.8.3.1

