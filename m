Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BDFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BDC2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BDC2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeIYUtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:49:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11589 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbeIYUtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:49:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4FD0368E7;
        Tue, 25 Sep 2018 14:41:30 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A554D60BF6;
        Tue, 25 Sep 2018 14:41:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, chuhu@redhat.com,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] debugobjects: Fix potential hard lockup by disabling lockdep
Date:   Tue, 25 Sep 2018 10:41:07 -0400
Message-Id: <1537886469-18227-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 25 Sep 2018 14:41:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v2:
  - Add a lockdep patch to fix a dmesg warning message due to the use
    of the novalidate class.

The only locking used by the debugobjects code is just 2 sets of raw
spinlocks for synchronization purpose. When lockdep is enabled, the
locking operation itself will become much more expensive especially
if a number of locks have already been acquired previously. In some
extreme cases, it may lead to hard lockup.

As there isn't much value in debugging the debugobjects internal locks,
lockdep checking is now disabled for those internal locks. That will
speed up system operation without compromising the lock checking
operation of production code.

Waiman Long (2):
  locking/lockdep: Don't warn class/lock name mismatch for novalidate
    class
  debugobjects: Disable lockdep tracking of debugobjects internal locks

 kernel/locking/lockdep.c | 7 +++++--
 lib/debugobjects.c       | 9 ++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.18.0

