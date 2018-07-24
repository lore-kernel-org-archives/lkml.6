Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C195AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B10B20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B10B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbeGXTd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:33:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388427AbeGXTd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:33:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5EAA81663C3;
        Tue, 24 Jul 2018 18:26:14 +0000 (UTC)
Received: from llong.com (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6191111AF17;
        Tue, 24 Jul 2018 18:26:12 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] cpufreq: Fix a circular lock dependency problem
Date:   Tue, 24 Jul 2018 14:26:03 -0400
Message-Id: <1532456765-17576-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 24 Jul 2018 18:26:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 24 Jul 2018 18:26:15 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v2:
  - Remove the retry loop in the store method.

This patchset works around a circular lock dependency issue in the
cpufreq driver reported by lockdep. The two locks involved are the
cpu_hotplup_lock and the reference count of a sysfs file.

The cpufreq_register_driver() function uses the lock sequence:

  cpus_read_lock --> kn->count

Whereas the cpufreq sysfs store method uses the sequence:

  kn->count --> cpus_read_lock

This is not really an issue as a shared lock is used on the
cpu_hotplup_lock. However, the lockdep code isn't able to handle
shared locking. So one way to work around this is to define a
cpus_read_trylock() function and uses it in the store method instead.

Waiman Long (2):
  cpu/hotplug: Add a cpus_read_trylock() function
  cpufreq: Fix a circular lock dependency problem

 drivers/cpufreq/cpufreq.c | 7 ++++++-
 include/linux/cpu.h       | 2 ++
 kernel/cpu.c              | 6 ++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

-- 
1.8.3.1

