Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BB421523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BB421523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389511AbeIUOpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:45:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:45037 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389010AbeIUOpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:45:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 01:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,284,1534834800"; 
   d="scan'208";a="265498600"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by fmsmga006.fm.intel.com with ESMTP; 21 Sep 2018 01:57:12 -0700
Subject: Re: RFC/error: Re: [PATCH 3/6] perf tools: Improve
 thread_stack__event() for trace begin / end
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20180919112338.20347-1-adrian.hunter@intel.com>
 <20180919112338.20347-4-adrian.hunter@intel.com>
 <20180920181352.GA9919@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f553b246-c512-3641-5387-81cdbbed2920@intel.com>
Date:   Fri, 21 Sep 2018 11:55:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920181352.GA9919@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/18 21:13, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 19, 2018 at 02:23:35PM +0300, Adrian Hunter escreveu:
>> +		return thread_stack__push(thread->ts, ret_addr,
>> +					  flags && PERF_IP_FLAG_TRACE_END);
>> +	} else if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
> 
> Some of the build containers caught this:
> 
> util/thread-stack.c:274:14: error: use of logical '&&' with constant operand [-Werror,-Wconstant-logical-operand]
>                                           flags && PERF_IP_FLAG_TRACE_END);
>                                                 ^  ~~~~~~~~~~~~~~~~~~~~~~
> util/thread-stack.c:274:14: note: use '&' for a bitwise operation
>                                           flags && PERF_IP_FLAG_TRACE_END);
>                                                 ^~
>                                                 &
> util/thread-stack.c:274:14: note: remove constant to silence this warning
>                                           flags && PERF_IP_FLAG_TRACE_END);
>                                                ~^~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> 
> 
> --------------------------
> 
> Should be a '&' as suggested by: 
> 
>   16   146.45 debian:9                      : FAIL gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
>   17   138.35 debian:experimental           : FAIL gcc (Debian 8.2.0-4) 8.2.0
> 
> 
> I'm changing this here, please Ack.

Yes, thank you!
