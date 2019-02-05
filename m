Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5773BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D2E217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfBENE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:04:27 -0500
Received: from foss.arm.com ([217.140.101.70]:41082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfBENE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:04:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B30180D;
        Tue,  5 Feb 2019 05:04:26 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22BDB3F675;
        Tue,  5 Feb 2019 05:04:24 -0800 (PST)
Subject: Re: [PATCH 5/5] perf/arm_dsu: Fix CPU hotplug races
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, will.deacon@arm.com,
        mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, tglx@linutronix.de, bigeasy@linutronix.de
References: <cover.1549299188.git.robin.murphy@arm.com>
 <d376f6bbd5804616b38145780789785b19a37543.1549299188.git.robin.murphy@arm.com>
 <9fcf862c-0d07-cece-852f-6c09128aa0c5@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <84bdba44-9ce1-906c-0575-f931435de886@arm.com>
Date:   Tue, 5 Feb 2019 13:04:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9fcf862c-0d07-cece-852f-6c09128aa0c5@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 05/02/2019 11:40, Suzuki K Poulose wrote:
> On 04/02/2019 17:09, Robin Murphy wrote:
>> Like other system PMUs which associate themselves with an arbitrary CPU
>> for housekeeping purposes, arm_dsu has a race between registering the
>> hotplug notifier and registering the PMU device, such that the hotplug
>> niotifier can potentially fire and attempt to migrate the PMU context
>> before the latter is valid. This is easily resolved by inhibiting
>> hotplug until both the notifier and PMU device are successfully set up.
>>
>> For the same reason, also suppress any synchronous notifier calls in the
>> cleanup path if PMU registration fails.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Should we add :
> 
> Fixes: commit 7520fa99246dade7ab6 ("perf: ARM DynamIQ Shared Unit PMU 
> support")
> 
> Either way:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks for the reviews! I think this patch is worthwhile for cleanliness 
and consistency, but since it's neither self-contained (with the 
dependency on #4) nor "fix[ing] a real bug that bothers people" I'm not 
convinced it really deserves backporting - unlike the preemption issue, 
actually getting a crash from this race in practice is unlikely enough 
that it would probably require some determined, deliberate effort to 
trigger it with just the right conditions.

Cheers,
Robin.
