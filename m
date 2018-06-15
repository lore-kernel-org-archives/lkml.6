Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C72F4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8342320864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8342320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbeFOFLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 01:11:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:13287 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755294AbeFOFLu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 01:11:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 22:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="237346632"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.161.30]) ([10.239.161.30])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2018 22:11:46 -0700
Subject: Re: [PATCH v1 0/2] perf: Drop leaked kernel samples
To:     Kyle Huey <me@kylehuey.com>
Cc:     acme@kernel.org, jolsa@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        open list <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Robert O'Callahan <robert@ocallahan.org>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <CAP045Aq_FEc_pEeRL86uXbOLBeW7aPvTqtnaq+Mbi-2=vp2BNA@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1a442b37-7a97-86f0-11e3-58d940ecfbc9@linux.intel.com>
Date:   Fri, 15 Jun 2018 13:11:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAP045Aq_FEc_pEeRL86uXbOLBeW7aPvTqtnaq+Mbi-2=vp2BNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2018 11:35 AM, Kyle Huey wrote:
> I strongly object to this patch as written. As I said when I
> originally reported[0] the regression introduced by the previous
> version of this patch a year ago.
> 
> "It seems like this change should, at a bare minimum, be limited to
> counters that actually perform sampling of register state when the
> interrupt fires.  In our case, with the retired conditional branches
> counter restricted to counting userspace events only, it makes no
> difference that the PMU interrupt happened to be delivered in the
> kernel."
> 
> This means identifying which values of `perf_event_attr::sample_type`
> are security concerns (presumably PERF_SAMPLE_IP is, and
> PERF_SAMPLE_TIME is not, and someone needs to go through and decide on
> all of them) and filtering on those values for this new behavior.
> 
> And because rr sets its sample_type to 0, once you do that, the sysctl
> will not be necessary.
> 
> - Kyle
> 

Since rr sets sample_type to 0, the easiest way is to add checking like:

if (event->attr.sample_type) {
	if (event->attr.exclude_kernel && !user_mode(regs))
		return false;
}

So the rr doesn't need to be changed and for other use cases the leaked 
kernel samples will be dropped.

But I don't like this is because:

1. It's too specific for rr case.

2. If we create a new sample_type, e.g. PERF_SAMPLE_ALLOW_LEAKAGE, the 
code will be:

if !(event->attr.sample_type & PERF_SAMPLE_ALLOW_LEAKAGE) {
	if (event->attr.exclude_kernel && !user_mode(regs))
		return false;
}

But rr needs to add PERF_SAMPLE_ALLOW_LEAKAGE to sample_type since by 
default the bit is not set.

3. Sysctl is a more flexible way. It provides us with an option when we 
want to see if skid is existing, we can use sysctl to turn on that.

Thanks
Jin Yao

