Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79026C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE0A208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+q5hTER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE0A208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeGaMdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:33:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54772 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbeGaMdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FcdI9rjTkKiuULTOFsgzi5GJs4af8bJ2DcdC90ZF9Bk=; b=j+q5hTERlzwtXNVSD689DJaDQ
        2azz4Bu/o9bQ/6mj979RK8q/p2Ko3zuUU+MsqzVe87ifQSBmq2rKuFXa3eUVJFvqdaPf091dqKjY/
        e8na4t0hoqDcqx/gweqBF7E+tOfkAPVVyng5p/cw10ulEUM44xx3m3FiC7DsDdEXEA2RZ1H1/3IMq
        1ov7NGkxf41eIVq5GXpCPPyQzVL7wf2yzC8OrZDq5u9n6j/P61I2u2zPpU8HdQ8WGuED+69Cb3FcS
        oczBf43yEFvK2BMIBHoXh/X8LIbEE94oyClXfo0nDYnngIdUSGyzZqDEmvFG3Tv/ZxAcVntEyyL+n
        LS2A+Na/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkSHo-0005Kp-K6; Tue, 31 Jul 2018 10:53:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 012522026833B; Tue, 31 Jul 2018 12:53:49 +0200 (CEST)
Date:   Tue, 31 Jul 2018 12:53:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] sched/topology: Set SD_ASYM_CPUCAPACITY flag
 automatically
Message-ID: <20180731105349.GQ2476@hirez.programming.kicks-ass.net>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 02:32:30PM +0100, Morten Rasmussen wrote:
> The SD_ASYM_CPUCAPACITY flag has been around for some time now with no code to
> actually set it. Android has carried patches to do this out-of-tree in the
> meantime. The flag is meant to indicate cpu capacity asymmetry and is set at
> the topology level where the sched_domain spans all available cpu capacity in
> the system, i.e. all core types are visible, for any cpu in the system.
> 
> The flag was merged as being a topology flag meaning that architecture had to
> provide the flag explicitly, however when mixed with cpusets splitting the
> system into multiple root_domains the flag can't be set without knowledge about
> the cpusets. Rather than exposing cpusets to architecture code this patch set
> moves the responsibility for setting the flag to generic topology code which is
> simpler and make the code architecture agnostic.
> 
> Morten Rasmussen (4):
>   sched/topology: SD_ASYM_CPUCAPACITY flag detection
>   drivers/base/arch_topology: Rebuild sched_domain hierarchy when
>     capacities change
>   arch/arm64: Rebuild sched_domain hierarchy when cpu capacity changes
>   arch/arm: Rebuild sched_domain hierarchy when cpu capacity changes
> 
>  arch/arm/include/asm/topology.h   |  3 ++
>  arch/arm64/include/asm/topology.h |  3 ++
>  drivers/base/arch_topology.c      | 26 +++++++++++++
>  include/linux/arch_topology.h     |  1 +
>  include/linux/sched/topology.h    |  2 +-
>  kernel/sched/topology.c           | 81 ++++++++++++++++++++++++++++++++++++---
>  6 files changed, 109 insertions(+), 7 deletions(-)

I've picked up the lot; Thanks!
