Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DB6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3B820894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3B820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbeGaNSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:18:06 -0400
Received: from foss.arm.com ([217.140.101.70]:52712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731912AbeGaNSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:18:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 049E880D;
        Tue, 31 Jul 2018 04:38:11 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D06EB3F5D0;
        Tue, 31 Jul 2018 04:38:09 -0700 (PDT)
Subject: Re: [PATCH 1/1] sched/debug: fix potential deadlock when write to
 sched_features
To:     Peter Zijlstra <peterz@infradead.org>, jiada_wang@mentor.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20180731092219.28908-1-jiada_wang@mentor.com>
 <20180731103404.GV2494@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a0f03f69-ec5f-c667-c440-173c7d363c7f@arm.com>
Date:   Tue, 31 Jul 2018 13:38:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731103404.GV2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 12:34 PM, Peter Zijlstra wrote:
> 
> Leaving a lot of quoted crud for Viresh..
> 
> On Tue, Jul 31, 2018 at 06:22:19PM +0900, jiada_wang@mentor.com wrote:
>> From: Jiada Wang <jiada_wang@mentor.com>
>>
>> Following lockdep report can be triggered by write to
>> /sys/kernel/debug/sched_features
> 
> Only if you're using this dt_cpufreq thing of course.. I wonder why this
> hasn't been reported before.
> 

[...]

> 
> I don't much care for all the _cpuslocked renaming done, but otherwise I
> suppose this is the easiest fix.
> 
> Note however that this doesn't apply, you're missing that match_string()
> patch. Please use tip/sched/core or something.

With the patch tweaked onto tip/sched/core.

w/o the patch:

root@h960:~# echo NO_LB_BIAS > /sys/kernel/debug/sched_features
[  293.052451]
[  293.053978] ======================================================   
[  293.060166] WARNING: possible circular locking dependency detected   
[  293.066358] 4.18.0-rc5-00064-gae48698275b3 #1 Tainted: G S
[  293.073153] ------------------------------------------------------   
[  293.079340] bash/3490 is trying to acquire lock:
[  293.083966] 00000000155b9437 (cpu_hotplug_lock.rw_sem){++++}, at: static_key_disable+0x1c/0x38
[  293.092620]
[  293.092620] but task is already holding lock:
[  293.098459] 0000000084a95e1c (&sb->s_type->i_mutex_key#3){+.+.}, at: sched_feat_write+0xc4/0x1e0
[  293.107277]
[  293.107277] which lock already depends on the new lock.
...

w/ the patch:

root@h960:~# echo NO_LB_BIAS > /sys/kernel/debug/sched_features
root@h960:~#

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>



