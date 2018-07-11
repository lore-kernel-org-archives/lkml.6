Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3DAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ABF2083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8ABF2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbeGKJqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:46:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60334 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeGKJqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:46:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7535E1682;
        Wed, 11 Jul 2018 02:42:57 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 466CD3F318;
        Wed, 11 Jul 2018 02:42:57 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4F4891AE3828; Wed, 11 Jul 2018 10:43:39 +0100 (BST)
Date:   Wed, 11 Jul 2018 10:43:39 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180711094338.GD13963@arm.com>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
 <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
 <20180710093637.GF2476@hirez.programming.kicks-ass.net>
 <20180710105437.GT2512@hirez.programming.kicks-ass.net>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_26F8B9E004D4512B2225FCE1@qq.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

On Tue, Jul 10, 2018 at 07:45:22PM +0800, 陈华才 wrote:
> I don't think this is a hardware bug, in design, SFB will flushed to L1
> cache in three cases:
> 1, data in SFB is full (be a complete cache line);
> 2, there is a subsequent read access in the same cache line;
> 3, a 'sync' instruction is executed.

I'd expect successful LL/SC, cache maintenance (and potentially TLB)
operations to flush your SFB as well, not that I think that provides a
better workaround than throwing a 'sync' into cpu_relax(). I assume the
SFB is all physically addressed?

Generally, CPU architectures guarantee that store buffers drain "in finite
time" which is a pretty crappy guarantee, but one which tends to be
sufficient in practice and therefore relied upon by software.

Will
