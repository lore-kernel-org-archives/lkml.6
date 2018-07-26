Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5894FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C02820846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C02820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeGZKYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:24:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61576 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeGZKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:24:41 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 897923879fbdd0d1; Thu, 26 Jul 2018 11:08:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2 0/2] cpufreq: Fix a circular lock dependency problem
Date:   Thu, 26 Jul 2018 11:06:58 +0200
Message-ID: <11110536.k4alKVjaiY@aspire.rjw.lan>
In-Reply-To: <1532456765-17576-1-git-send-email-longman@redhat.com>
References: <1532456765-17576-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 24, 2018 8:26:03 PM CEST Waiman Long wrote:
>  v2:
>   - Remove the retry loop in the store method.
> 
> This patchset works around a circular lock dependency issue in the
> cpufreq driver reported by lockdep. The two locks involved are the
> cpu_hotplup_lock and the reference count of a sysfs file.
> 
> The cpufreq_register_driver() function uses the lock sequence:
> 
>   cpus_read_lock --> kn->count
> 
> Whereas the cpufreq sysfs store method uses the sequence:
> 
>   kn->count --> cpus_read_lock
> 
> This is not really an issue as a shared lock is used on the
> cpu_hotplup_lock. However, the lockdep code isn't able to handle
> shared locking. So one way to work around this is to define a
> cpus_read_trylock() function and uses it in the store method instead.
> 
> Waiman Long (2):
>   cpu/hotplug: Add a cpus_read_trylock() function
>   cpufreq: Fix a circular lock dependency problem
> 
>  drivers/cpufreq/cpufreq.c | 7 ++++++-
>  include/linux/cpu.h       | 2 ++
>  kernel/cpu.c              | 6 ++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> 

I'm queuing up this series for 4.19.

If anyone has any concerns regarding it, please let me know.

Thanks,
Rafael


