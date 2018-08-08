Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA70C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2588221A32
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2588221A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeHHTM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:12:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:5547 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbeHHTM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:12:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 09:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,458,1531810800"; 
   d="scan'208";a="60884020"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.134]) ([10.24.14.134])
  by fmsmga007.fm.intel.com with ESMTP; 08 Aug 2018 09:51:47 -0700
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
To:     Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "Hindman, Gavin" <gavin.hindman@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
 <57c011e1-113d-c38f-c318-defbad085843@intel.com>
 <20180806221225.GO2458@hirez.programming.kicks-ass.net>
 <08d51131-7802-5bfe-2cae-d116807183d1@intel.com>
 <20180807093615.GY2494@hirez.programming.kicks-ass.net>
 <ace0bebb-91ab-5d40-e7d7-d72d48302fa8@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7D3A10EF@ORSMSX110.amr.corp.intel.com>
 <413c3b6f-770d-9549-4249-c2407267b63c@intel.com>
 <20180808074111.GM2494@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7D3A1B83@ORSMSX110.amr.corp.intel.com>
 <20180808164722.GR2494@hirez.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <8592e828-5a71-7331-ad2f-cc59abc8ba94@intel.com>
Date:   Wed, 8 Aug 2018 09:51:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180808164722.GR2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2018 9:47 AM, Peter Zijlstra wrote:
> On Wed, Aug 08, 2018 at 03:55:54PM +0000, Luck, Tony wrote:
>>> So _why_ doesn't this work? As said by Tony, that first call should
>>> prime the caches, so the second and third calls should not generate any
>>> misses.
>>
>> How much code/data is involved? If there is a lot, then you may be unlucky
>> with cache coloring and the later parts of the "prime the caches" code path
>> may evict some lines loaded in the early parts.
> 
> Well, Reinette used perf_event_read_local() which is unfortunately quite
> a bit. But the inline I proposed is a single load and depending on
> rdpmcl() or native_read_pmc() a call to or just a single inline asm
> rdpmc instruction.
> 
> That should certainly work I think.

I am in the process of testing this variation.

Reinette


