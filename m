Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB621C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C8120874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C8120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeFRIHA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:07:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:37585 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932792AbeFRIG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:06:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 01:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="65439436"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2018 01:06:58 -0700
Received: from [10.125.252.150] (unknown [10.125.252.150])
        by linux.intel.com (Postfix) with ESMTP id A138E580146;
        Mon, 18 Jun 2018 01:06:55 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] perf: Allow fine-grained PMU access control
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rogozhkin, Dmitry V" <dmitry.v.rogozhkin@intel.com>
References: <20180521092549.5349-1-tvrtko.ursulin@linux.intel.com>
 <20180522090527.GP12198@hirez.programming.kicks-ass.net>
 <017c4a20-b597-9c0e-4cf3-c0fd1d7bf3d7@ursulin.net>
 <20180522123213.GR12198@hirez.programming.kicks-ass.net>
 <88a005e3-e090-33c1-0107-5c04a4d8f97f@linux.intel.com>
 <20180522171925.GL4486@tassilo.jf.intel.com>
 <a2cb4e93-95c0-4a9f-db4d-69d6748c292e@linux.intel.com>
Message-ID: <4856977a-a2f8-7872-cac6-b99e1b66a68b@linux.intel.com>
Date:   Mon, 18 Jun 2018 11:06:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a2cb4e93-95c0-4a9f-db4d-69d6748c292e@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tvrtko,

On 11.06.2018 11:08, Tvrtko Ursulin wrote:
> 
> Hi,
> 
> On 22/05/2018 18:19, Andi Kleen wrote:
>>> IMHO, it is unsafe for CBOX pmu but could IMC, UPI pmus be an exception here?
>>> Because currently perf stat -I from IMC, UPI counters is only allowed when
>>> system wide monitoring is permitted and this prevents joint perf record and
>>> perf stat -I in cluster environments where users usually lack ability to
>>> modify paranoid. Adding Andi who may have more ideas regarding all that.
>>
>> PMU isolation is about not making side channels worse. There are normally
>> already side channels from timing, but it has a degree of noise.
>>
>> PMU isolation is just to prevent opening side channels with less noise.
>> But reducing noise is always a trade off, it can never be perfect
>> and at some point there are dimishing returns.
>>
>> In general the farther you are from the origin of the noise there
>> is already more noise. The PMU can reduce the noise, but if it's far
>> enough away it may not make much difference.
>>
>> So there are always trade offs with shades of grey, not a black
>> and white situation. Depending on your security requirements
>> it may be totally reasonable e.g. to allow the PMU
>> on the memory controller (which is already very noisy in any case),
>> but not on the caches.
>>
>> Or allow it only on the graphics which is already fairly isolated.
>>
>> So per pmu paranoid settings are a useful concept.
> 
> So it seems there is some positive feedback and fine-grained controls would be useful for other PMU's in cluster environments.
> 
> If we have agreement on that, question is how to drive this forward? Would someone be able to review the patch I've sent, or suggest more people to look at it before it could be queued up for merge?

It makes sense to split this RFC into series of patches and resend. 
The series could be shaped up something similar to this:

[PATCH v1 0/4]: perf: enable per-pmu paranoid setting for Intel GPU pmu

    [PATCH v1 1/1]: perf/core: introduce pmu specific paranoid settings
        - extend pmu kernel object in the headers with the new settings
	- adjust code to adopt this new settings

    [PATCH v1 1/2]: perf/core: enable pmu specific paranoid setting thru fs
	- introduce code interfacing the setting thru fs from userspace
	- may be introduce code applying some policies around 
          global/per-pmu relationship

    [PATCH v1 1/3]: perf/core: enable i915 GPU pmu specifics features
	- implement your specific task related to GPU pmu on top of 
          this new whole concept

    [PATCH v1 1/4]: perf/docs: document Intel GPU pmu paranoid specific changes
	- some may be regression testing and README or other docs 
          updates related to the changes

Also when sending the patches The Linux kernel security team (security@kernel.org)
needs to be in TO or CC to let the folks know of the changes and possibly 
explicitly ask support from them.

Regards,
Alexey

> 
> Regards,
> 
> Tvrtko
> 
