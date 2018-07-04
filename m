Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2B9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F5243E1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2F5243E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeGDKda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:33:30 -0400
Received: from foss.arm.com ([217.140.101.70]:35230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753478AbeGDKd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:33:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B034F18A;
        Wed,  4 Jul 2018 03:33:28 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A3C23F5AD;
        Wed,  4 Jul 2018 03:33:27 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:33:24 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Gaku Inami <gaku.inami.xh@renesas.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 0/9] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Message-ID: <20180704103324.GC8596@e105550-lin.cambridge.arm.com>
References: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
 <OSBPR01MB1800D74A13DD2B4E69491D09A2420@OSBPR01MB1800.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB1800D74A13DD2B4E69491D09A2420@OSBPR01MB1800.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 03, 2018 at 02:28:28AM +0000, Gaku Inami wrote:
> Hi,
> 
> > -----Original Message-----
> > From: Morten Rasmussen <morten.rasmussen@arm.com>
> > Sent: Wednesday, June 20, 2018 6:06 PM
> > To: peterz@infradead.org; mingo@redhat.com
> > Cc: valentin.schneider@arm.com; dietmar.eggemann@arm.com; vincent.guittot@linaro.org; Gaku Inami
> > <gaku.inami.xh@renesas.com>; linux-kernel@vger.kernel.org; Morten Rasmussen <morten.rasmussen@arm.com>
> > Subject: [PATCHv3 0/9] sched/fair: Migrate 'misfit' tasks on asymmetric capacity systems
> [snip]
> > 
> > The patches have been tested on:
> >    1. Arm Juno (r0): 2+4 Cortex A57/A53
> >    2. Hikey960: 4+4 Cortex A73/A53
> > 
> > Test case:
> > Big cpus are always kept busy. Pin a shorter running sysbench tasks to
> > big cpus, while creating a longer running set of unpinned sysbench
> > tasks.
> 
> I have tested v3 patches on Renesas SoC again. It looks fine.
> 
> You can add:
> 
> Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>
> 
> The patches have been tested on:
>    3. Renesas R-Car H3 : 4+4 Cortex A57/A53
> 
> Results:
> Single runs with completion time of each task
> R-Car H3 (tip)
>     total time:                          0.9391s
>     total time:                          0.9865s
>     total time:                          1.3691s
>     total time:                          1.6740s
> 
> R-Car H3 (misfit)
>     total time:                          0.9368s
>     total time:                          0.9475s
>     total time:                          0.9471s
>     total time:                          0.9505s
> 
> 10 run summary (tracking longest running task for each run)
> 	R-Car H3
> 	avg	max
> tip     1.6742  1.6750
> misfit  0.9784  0.9905

Thanks for testing again. I have just posted v4 with some minor changes.
Behaviour for the test-cases should be the same.

Morten
