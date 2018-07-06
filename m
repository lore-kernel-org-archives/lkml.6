Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EFBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E2E23FCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E2E23FCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933664AbeGFNW2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:22:28 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43104 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753616AbeGFNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:22:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1106483|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.CN6-5tf_1530883335;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CN6-5tf_1530883335)
          by smtp.aliyun-inc.com(10.147.41.231);
          Fri, 06 Jul 2018 21:22:15 +0800
Date:   Fri, 6 Jul 2018 21:22:15 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180706132215.GB30265@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180705180503.GH2530@hirez.programming.kicks-ass.net>
 <20180706060740.GB8707@guoren>
 <20180706093932.GT2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706093932.GT2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:39:32AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 06, 2018 at 02:07:40PM +0800, Guo Ren wrote:
> 
> > > Please explain those mb()'s... I'm thinking you meant to use smp_mb().
> > Yes, smp_mb(). Current smp_mb()&mb() is the same: sync.is.
> > 
> > In next version patch, I'll seperate smp_mb() and mb() and use ld/st.barrier
> > instead of sync.is. Sync.is is expensive that it flush cpu's pipeline.
> 
> I'll second my own call for documentation, because now there's three
> memory ordering instructions:
> 
>  "SYNC", "SYNC.IS" and "LD/ST.BARRIER"
> 
> None of which have yet been explained.
In C-SKY there are:

sync:        completion barrier
sync.s:      completion barrier and shareable to other cores
sync.i:      completion barrier with flush cpu pipeline
sync.is:     completion barrier with flush cpu pipeline and shareable to other cores 

bar.brwarw:  ordering barrier for all load/store instructions before it
bar.brwarws: ordering barrier for all load/store instructions before it and shareable to other cores
bar.brar:    ordering barrier for all load       instructions before it
bar.brars:   ordering barrier for all load       instructions before it and shareable to other cores
bar.bwaw:    ordering barrier for all store      instructions before it
bar.bwaws:   ordering barrier for all store      instructions before it and shareable to other cores

