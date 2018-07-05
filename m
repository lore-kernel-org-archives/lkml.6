Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5831C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782B62403B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782B62403B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeGEJw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:52:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46834 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753070AbeGEJwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:52:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AE707A9;
        Thu,  5 Jul 2018 02:52:25 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EF163F2EA;
        Thu,  5 Jul 2018 02:52:23 -0700 (PDT)
Subject: Re: [lkp-robot] [sched/fair] fbd5188493:
 WARNING:inconsistent_lock_state
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     kernel test robot <xiaolong.ye@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>, lkp@01.org
References: <20180705080227.GH23907@yexl-desktop>
 <0ac4845e-cf6b-c5e3-a16c-f2fc457c5ef5@arm.com>
Message-ID: <7c3d20fa-4997-e6ed-3750-e054ce1bd610@arm.com>
Date:   Thu, 5 Jul 2018 11:52:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0ac4845e-cf6b-c5e3-a16c-f2fc457c5ef5@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 10:58 AM, Dietmar Eggemann wrote:
> Hi,
> 
> On 07/05/2018 10:02 AM, kernel test robot wrote:
>>
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: fbd51884933192c9cada60628892024495942482 ("[PATCH] sched/fair: Avoid divide by zero when rebalancing domains")
>> url: https://github.com/0day-ci/linux/commits/Matt-Fleming/sched-fair-Avoid-divide-by-zero-when-rebalancing-domains/20180705-024633
>>
>>
>> in testcase: trinity
>> with following parameters:
>>
>> 	runtime: 300s
>>
>> test-description: Trinity is a linux system call fuzz tester.
>> test-url: http://codemonkey.org.uk/projects/trinity/
>>
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 1G
> 
> [...]
> 
>> [    0.335612] WARNING: inconsistent lock state
> 
> I get the same on arm64 (juno r0) during boot consistently:

Moving the code from _nohz_idle_balance to nohz_idle_balance let it disappear:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02be51c9dcc1..070924f07c68 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9596,16 +9596,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
         */
        smp_mb();
 
-       /*
-        * Ensure this_rq's clock and load are up-to-date before we
-        * rebalance since it's possible that they haven't been
-        * updated for multiple schedule periods, i.e. many seconds.
-        */
-       raw_spin_lock_irq(&this_rq->lock);
-       update_rq_clock(this_rq);
-       cpu_load_update_idle(this_rq);
-       raw_spin_unlock_irq(&this_rq->lock);
-
        for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
                if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
                        continue;
@@ -9701,6 +9691,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
        if (!(flags & NOHZ_KICK_MASK))
                return false;
 
+       /*
+        * Ensure this_rq's clock and load are up-to-date before we
+        * rebalance since it's possible that they haven't been
+        * updated for multiple schedule periods, i.e. many seconds.
+        */
+       raw_spin_lock_irq(&this_rq->lock);
+       update_rq_clock(this_rq);
+       cpu_load_update_idle(this_rq);
+       raw_spin_unlock_irq(&this_rq->lock);
+
        _nohz_idle_balance(this_rq, flags, idle);
 
        return true;

