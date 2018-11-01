Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B19C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72AE2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72AE2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeKAUTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:19:11 -0400
Received: from foss.arm.com ([217.140.101.70]:55026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbeKAUTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:19:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98861A78;
        Thu,  1 Nov 2018 04:16:41 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AA0D3F71D;
        Thu,  1 Nov 2018 04:16:39 -0700 (PDT)
Subject: Re: [PATCH 07/10] sched/fair: Provide can_migrate_task_llc
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-8-git-send-email-steven.sistare@oracle.com>
 <f75ddcd5-f9a0-30c5-94e4-c4077e17ffb0@arm.com>
 <b9915490-661b-0d0e-ae60-d5803357e1ec@oracle.com>
 <b7d91b1d-5da1-5d70-f266-93b108379b64@arm.com>
 <20181031191459.GA3141@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <10491016-9eec-846f-9632-f6de965508b6@arm.com>
Date:   Thu, 1 Nov 2018 11:16:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181031191459.GA3141@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2018 19:14, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 07:34:50PM +0000, Valentin Schneider wrote:
>> On a sidenote, I find it a bit odd that the exec_start threshold depends on
>> sysctl_sched_migration_cost, which to me is more about idle_balance() cost
>> than "how long does it take for a previously run task to go cache cold".
> 
> A long long (think 2.6.20 long ago) there was code that did boot-time
> measurement of the various cache topology costs and that threshold was
> related to that.
> 
> That code got killed because of boot to boot variance and dubious
> benefits.
> 
> The migration cost is what it was replaced with as a single measure.
> 
> migration cost was then later abused in the newidle balance because it
> was over eager.


Thanks! I tried following the blame rabbit hole but got a bit lost along
the way.

> Ideally we'd get rid of it there, because we've now got
> that much more elaborate accounting, but Rohit tried and found some
> regression because of that.
> 
> Maybe we should remove it from newidle anyway.
> 

Well, if we ditch idle_balance() in favor of stealing, that would "solve"
it...
