Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06EEECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB2C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB2C2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeGRTbO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:31:14 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53688 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeGRTbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:31:14 -0400
Received: from [2620:10d:c091:200::1:ca15] (helo=[IPv6:2620:10d:c0a3:10fb:4c:7ee9:b6e2:d1d5])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ffrYC-0008I7-Fu; Wed, 18 Jul 2018 14:51:48 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [tip:x86/mm] x86/mm/tlb: Make lazy TLB mode lazier
From:   Rik van Riel <riel@surriel.com>
In-Reply-To: <20180718182359.GW2494@hirez.programming.kicks-ass.net>
Date:   Wed, 18 Jul 2018 14:51:45 -0400
Cc:     songliubraving@fb.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-tip-commits@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <477353D9-BA10-4AAB-ACC4-DDFDAE63895B@surriel.com>
References: <20180716190337.26133-5-riel@surriel.com>
 <tip-ac0315896970d8589291e9d8a1569fc65967b7f1@git.kernel.org>
 <20180717113330.GU2476@hirez.programming.kicks-ass.net>
 <08AC2AF2-17DE-4416-BBBD-B6B950D20906@surriel.com>
 <20180718160007.GS2494@hirez.programming.kicks-ass.net>
 <081E558D-DB34-4A18-A35C-896BC47F6EBA@surriel.com>
 <20180718182359.GW2494@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 18, 2018, at 2:23 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Wed, Jul 18, 2018 at 01:22:19PM -0400, Rik van Riel wrote:
>>> On Jul 18, 2018, at 12:00 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
>>> Also, I don't suppose you've looked at the paravirt instances of
>>> flush_tlb_other() ? They don't elide the flushes because of lazy.
>> 
>> Let me look at those now :)
> 
> <snip xen>
> 
>> kvm_flush_tlb_other takes out preempted VCPUs from the flush mask, 
>> before calling native_flush_tlb_others, so it should get the optimization 
>> automatically.
> 
> Ah, ok. I wasn't entirely sure the new lazy was purely for the idle
> case. But yes, the KVM paravirt thing should get the idle case right.
> 
Not just idle, but also running in kernel threads like ksoftirqd,
kworker, kswapd, etc. However, kvm_flush_tlb_other calls
native_flush_tlb_other, so it should get that optimization automatically
from my patch series.

