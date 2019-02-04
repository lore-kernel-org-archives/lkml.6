Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7ADC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFD120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfBDPjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:39:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:13298 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfBDPjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:39:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 07:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="141450247"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 04 Feb 2019 07:39:11 -0800
Received: from [10.254.84.37] (kliang2-mobl1.ccr.corp.intel.com [10.254.84.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EE05858044E;
        Mon,  4 Feb 2019 07:39:10 -0800 (PST)
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204150623.GF17528@hirez.programming.kicks-ass.net>
 <20190204151741.GB17582@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d199d280-bf3c-dbe1-d184-8aaa6a8bb95c@linux.intel.com>
Date:   Mon, 4 Feb 2019 10:39:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204151741.GB17582@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2019 10:17 AM, Peter Zijlstra wrote:
> On Mon, Feb 04, 2019 at 04:06:23PM +0100, Peter Zijlstra wrote:
>> On Mon, Jan 21, 2019 at 01:42:28PM -0800, kan.liang@linux.intel.com wrote:
>>
>> So what's wrong with the below?
>>
>> Installing a quirk for
> 
> (typing hard..)
> 
> but what I was going to say is that it seems overkill to sprinkle all
> that stuff around.
> 

The microcode patch for PEBS has been applied for Icelake and future 
platforms.
   - For the platforms before Haswell, there is no microcode patch 
applied. The x86_pmu.pebs_no_isolation should always be 1.
   - Between Haswell and Kabylake, x86_pmu.pebs_no_isolation is decided 
by quirk table.
   - For Icelake and future platforms, the x86_pmu.pebs_no_isolation 
should always be 0.

The patch you proposed in previous Email can work well for the existing 
platforms. But it will be a problem when adding new support. We have to 
always add INTEL_CPU_DESC(INTEL_FAM6_XXX,	X, 0x00000000) for each CPU ID 
and each stepping. That will be a disaster for maintenance.

Thanks,
Kan
