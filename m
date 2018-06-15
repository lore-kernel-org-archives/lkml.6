Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7ED01C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3A7208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3A7208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755993AbeFOIBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:01:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:39290 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755792AbeFOIBt (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:01:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 01:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,226,1526367600"; 
   d="scan'208";a="237378104"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.161.30]) ([10.239.161.30])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2018 01:01:46 -0700
Subject: Re: [PATCH v1 0/2] perf: Drop leaked kernel samples
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, me@kylehuey.com,
        Linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        will.deacon@arm.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <20180615074504.GA2458@hirez.programming.kicks-ass.net>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <11958be5-dc05-611b-6839-f1f6903c7ca8@linux.intel.com>
Date:   Fri, 15 Jun 2018 16:01:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615074504.GA2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2018 3:45 PM, Peter Zijlstra wrote:
> On Fri, Jun 15, 2018 at 06:03:21PM +0800, Jin Yao wrote:
>> On workloads that do a lot of kernel entry/exits we see kernel
>> samples, even though :u is specified. This is due to skid existing.
>>
>> This might be a security issue because it can leak kernel addresses even
>> though kernel sampling support is disabled.
>>
>> One patch "perf/core: Drop kernel samples even though :u is specified"
>> was posted in last year but it was reverted because it introduced a
>> regression issue that broke the rr-project.
>>
>> Now this patch set uses sysctl to control the dropping of leaked
>> kernel samples.
> 
> So what happened to the suggestion of keeping the samples but 0-stuffing
> all the tricky bits?
> 

Bring more overhead to kernel if we zero the bits considering the number 
of leaked samples may be not too small?

And the skid information may be interesting (see example of hitting on 
page_fault in previous mail). If we zero it, we will not know.

Thanks
Jin Yao
