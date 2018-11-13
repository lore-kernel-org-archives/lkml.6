Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44960C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EDD22506
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EDD22506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbeKMMyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:54:16 -0500
Received: from foss.arm.com ([217.140.101.70]:46346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbeKMMyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:54:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A69FFA78;
        Mon, 12 Nov 2018 18:58:14 -0800 (PST)
Received: from [192.168.33.175] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8DE73F5CF;
        Mon, 12 Nov 2018 18:58:13 -0800 (PST)
Subject: Re: [PATCH v6 0/2] sched/fair: update scale invariance of PELT
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Morten.Rasmussen@arm.com,
        patrick.bellasi@arm.com, pjt@google.com, bsegall@google.com,
        thara.gopinath@linaro.org, pkondeti@codeaurora.org,
        quentin.perret@arm.com
References: <1541780454-9934-1-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e873dfbb-d13e-93c7-251e-dea90c3b40b5@arm.com>
Date:   Mon, 12 Nov 2018 18:58:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541780454-9934-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 8:20 AM, Vincent Guittot wrote:
> This new version of the scale invariance patchset adds an important change
> compare to v3 and before. It still scales the time to reflect the
> amount of work that has been done during the elapsed running time but this is
> now done at rq level instead of per entity and rt/dl/cfs_rq. The main
> advantage is that it is done once per clock update and we don't need to
> maintain per sched_avg's stolen_idle_time anymore. This also ensures that
> all pelt signals will be always synced for a rq.
> 
> The 1st patch makes available rq_of() helper function for pelt.c file and
> the 2nd patch implements the new scaling algorithm
> 
> Changes since v5:
> - Fix running_sum scaling in update_tg_cfs_runnable() raised by Dietmar
> - Remove unused cpu parameters raised by Dietmar

I just re-discovered ... the comment for the definition of struct 
sched_avg in include/linux/sched.h also mentioned the different ways how 
we do invariance for load_avg and util_avg.

[...]
