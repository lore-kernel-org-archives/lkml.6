Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2234C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18AB2152F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18AB2152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeHBSHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:07:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:21928 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbeHBSHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:07:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 09:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,436,1526367600"; 
   d="scan'208";a="72044082"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.122]) ([10.24.14.122])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2018 09:14:10 -0700
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, fenghua.yu@intel.com,
        tony.luck@intel.com, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1533064851.git.reinette.chatre@intel.com>
 <20180802123923.GJ2530@hirez.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <1af731f8-b5d3-5aca-af02-575802a961b9@intel.com>
Date:   Thu, 2 Aug 2018 09:14:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180802123923.GJ2530@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/2/2018 5:39 AM, Peter Zijlstra wrote:
> On Tue, Jul 31, 2018 at 12:38:27PM -0700, Reinette Chatre wrote:
>> Dear Maintainers,
>>
>> The success of Cache Pseudo-Locking can be measured via the use of
>> performance events. Specifically, the number of cache hits and misses
>> reading a memory region after it has been pseudo-locked to cache. This
>> measurement is triggered via the resctrl debugfs interface.
>>
>> To ensure most accurate results the performance counters and their
>> configuration registers are accessed directly.
> 
> NAK on that.
> 

After data is locked to cache we need to measure the success of that.
There is no instruction that we can use to query if a memory address has
been cached but we can use performance monitoring events that are
especially valuable on the platforms where they are precise event capable.

To ensure that we are only measuring the presence of data that should be
locked to cache we need to tightly control how this measurement is done.

For example, on my test system I locked 256KB to the cache and with the
current implementation (tip.git on branch x86/cache) I am able to
accurately measure that this was successful as seen below (each cache
line within the 256KB is accessed while the performance monitoring
events are active):

pseudo_lock_mea-26090 [002] .... 61838.488027: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26097 [002] .... 61843.689381: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26100 [002] .... 61848.751411: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26108 [002] .... 61853.820361: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26111 [002] .... 61858.880364: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26118 [002] .... 61863.937343: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26121 [002] .... 61869.008341: pseudo_lock_l2: hits=4096
miss=0

The current implementation does not coordinate with perf and this is
what I am trying to fix in this series.

I do respect your NAK but it is not clear to me how to proceed after
obtaining it. Could you please elaborate on what you would prefer as a
solution to ensure accurate measurement of cache-locked data that is
better integrated?

Thank you very much

Reinette


