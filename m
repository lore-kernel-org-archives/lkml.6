Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ySebAxEuHlsbVAAAmS7hNA
	; Mon, 11 Jun 2018 08:08:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EF08D607E4; Mon, 11 Jun 2018 08:08:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 78707606FA;
	Mon, 11 Jun 2018 08:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78707606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932435AbeFKIIq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:08:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:27925 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932109AbeFKIId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:08:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 01:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,501,1520924400";
   d="scan'208";a="236106138"
Received: from msjoblom-mobl.ger.corp.intel.com (HELO [10.252.25.78]) ([10.252.25.78])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2018 01:08:29 -0700
Subject: Re: [RFC] perf: Allow fine-grained PMU access control
To: Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Message-ID: <a2cb4e93-95c0-4a9f-db4d-69d6748c292e@linux.intel.com>
Date: Mon, 11 Jun 2018 09:08:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180522171925.GL4486@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 22/05/2018 18:19, Andi Kleen wrote:
>> IMHO, it is unsafe for CBOX pmu but could IMC, UPI pmus be an exception here?
>> Because currently perf stat -I from IMC, UPI counters is only allowed when
>> system wide monitoring is permitted and this prevents joint perf record and
>> perf stat -I in cluster environments where users usually lack ability to
>> modify paranoid. Adding Andi who may have more ideas regarding all that.
> 
> PMU isolation is about not making side channels worse. There are normally
> already side channels from timing, but it has a degree of noise.
> 
> PMU isolation is just to prevent opening side channels with less noise.
> But reducing noise is always a trade off, it can never be perfect
> and at some point there are dimishing returns.
> 
> In general the farther you are from the origin of the noise there
> is already more noise. The PMU can reduce the noise, but if it's far
> enough away it may not make much difference.
> 
> So there are always trade offs with shades of grey, not a black
> and white situation. Depending on your security requirements
> it may be totally reasonable e.g. to allow the PMU
> on the memory controller (which is already very noisy in any case),
> but not on the caches.
> 
> Or allow it only on the graphics which is already fairly isolated.
> 
> So per pmu paranoid settings are a useful concept.

So it seems there is some positive feedback and fine-grained controls 
would be useful for other PMU's in cluster environments.

If we have agreement on that, question is how to drive this forward? 
Would someone be able to review the patch I've sent, or suggest more 
people to look at it before it could be queued up for merge?

Regards,

Tvrtko
