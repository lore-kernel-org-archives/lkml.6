Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6866FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A0321571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A0321571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbeHBWga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:36:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:9154 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbeHBWg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:36:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 13:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,436,1526367600"; 
   d="scan'208";a="245525126"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.241.229.198]) ([10.241.229.198])
  by orsmga005.jf.intel.com with ESMTP; 02 Aug 2018 13:43:42 -0700
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
To:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, fenghua.yu@intel.com,
        tony.luck@intel.com, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1533064851.git.reinette.chatre@intel.com>
 <20180802123923.GJ2530@hirez.programming.kicks-ass.net>
 <1af731f8-b5d3-5aca-af02-575802a961b9@intel.com>
 <20180802161823.GJ2458@hirez.programming.kicks-ass.net>
 <f990df31-ab75-974e-b142-47af07a33a08@intel.com>
 <20180802173727.GP2494@hirez.programming.kicks-ass.net>
 <653e874f-5e77-a9b5-996a-ed9daa3c6d43@intel.com>
 <20180802195410.GR2494@hirez.programming.kicks-ass.net>
 <d64f85e8-98ca-a81d-bf2d-13dd72fc411e@intel.com>
 <20180802201312.GS2494@hirez.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
Date:   Thu, 2 Aug 2018 13:43:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180802201312.GS2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/2/2018 1:13 PM, Peter Zijlstra wrote:
> On Thu, Aug 02, 2018 at 01:06:19PM -0700, Dave Hansen wrote:
>> On 08/02/2018 12:54 PM, Peter Zijlstra wrote:
>>>> I totally understand not wanting to fill the tree with code hijacking
>>>> the raw PMU.  Is your reaction to this really around not wanting to
>>>> start down the slippery slope that ends up with lots of raw PMU "owners"?
>>> That and the fact that multiple owner directly contradicts what perf set
>>> out to do, provide resource arbitration for the PMU.
>>>
>>> Not being able to use both perf and this resctl thing at the same time
>>> is utter crap. You will not get special dispensation.

The goal of this work is to use the existing PMU hardware coordination
mechanism to ensure that perf and resctrl will not interfere with each
other. The resctrl debugging is short-lived - it reserves the PMU
hardware while interrupts are disabled and releases the PMU hardware
before re-enabling interrupts. If a perf session is running at that time
then this reservation will ensure it is not interfered with. If a perf
session is not running at the time then it will not even get the
opportunity to attempt to start one.

>> Is there something we could do in the middle, like have perf itself be
>> in charge of doing all the programming, but the psuedo-locking could
>> still _read_ the counters?
> 
> perf has all of that.

At the time the counters are read the damage has already been done by
all the extra instructions and data accessed during the enable and
disable of the events.

Reinette
